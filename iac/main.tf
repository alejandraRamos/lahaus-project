terraform {
  required_providers {
    aws = {
      source  = "aws"
      version = "3.23.0"
    }
  }
}
provider "aws" {
  region = var.aws_region
}
data "aws_vpc" "devops-vpc" {
  id = var.devops_vpc
}
data "aws_subnet" "devops-subnet-public-2a" {
  id = var.public_subnet_id_2a
}
data "aws_subnet" "devops-subnet-private-2a"{
  id = var.private_subnet_id_2a
}
data "aws_subnet" "devops-subnet-public-2c" {
  id = var.public_subnet_id_2c
}
data "aws_subnet" "devops-subnet-private-2c"{
  id = var.private_subnet_id_2c
}
//creo que falta el sg
resource "aws_launch_template" "launch-template-db" {
  image_id               = var.devops_ami_id
  name                   = var.lt_name_db
  instance_type          = var.lt_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sg-instance.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "DB instance"
    }
  }

  user_data = base64encode(templatefile("../app/scripts/psql.sh", {}))
}
resource "aws_autoscaling_group" "tf-devops-asg-db" {
	max_size 						= 1
	min_size 						= 1
	desired_capacity 		= 1
	vpc_zone_identifier = [ data.aws_subnet.devops-subnet-private-2a.id, data.aws_subnet.devops-subnet-private-2c.id]
  
	launch_template {
		id			= aws_launch_template.launch-template-db.id
		version = var.lt_version
	}
}
resource "aws_launch_template" "launch-template-back" {
  image_id               = var.devops_ami_id
  name                   = var.lt_name_back
  instance_type          = var.lt_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sg-instance.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "back"
    }
  }

  user_data = base64encode(templatefile("./user_data.sh", { ansible = var.lt_instance_name}))

}
resource "aws_autoscaling_group" "tf-devops-asg-back" {
	max_size 						= var.asg_max_size
	min_size 						= var.asg_min_size
	desired_capacity 		= var.asg_desired_capacity
	vpc_zone_identifier = [ data.aws_subnet.devops-subnet-private-2a.id, data.aws_subnet.devops-subnet-private-2c.id ]
    target_group_arns = [ aws_lb_target_group.devops-target-group.arn ]  

  depends_on = [aws_autoscaling_group.tf-devops-asg-db]
    
	launch_template {
		id			= aws_launch_template.launch-template-back.id
		version = var.lt_version
	}
}

//IGW
data "aws_internet_gateway" "devops-igw" {
  internet_gateway_id = "igw-047246abee53f83f1"
 }

//SG
resource "aws_security_group" "sg-instance" {
  description = var.sg_instance
  vpc_id      = var.devops_vpc

  ingress {
      description = var.sg_in_ssh_descrption
      from_port = var.sg_in_ssh_port
      to_port = var.sg_in_ssh_port
      protocol = var.sg_in_ssh_protocol
      cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
      description = var.sg_in_app_descrption
      from_port   = var.sg_in_app_port
			  to_port			= var.sg_in_app_port
			  protocol		= var.sg_in_app_protocol
			  cidr_blocks  = var.sg_in_app_cidr
  }

	egress {
	  description = var.front_sg_out_description
    from_port   = var.front_sg_out_port
        to_port     = var.front_sg_out_port
        protocol    = var.front_sg_out_protocol
        cidr_blocks = var.front_sg_out_cidr
	}
	
}

resource "aws_security_group" "sg-lb-back" {
  description = var.lb_sg_description
  vpc_id      = var.devops_vpc

  ingress {
    description = var.lb_sg_in_traffic_description
    from_port   = var.lb_sg_in_traffic_port
        to_port     = var.lb_sg_in_traffic_port
        protocol    = var.lb_sg_in_traffic_protocol
        cidr_blocks = var.lb_sg_in_traffic_cird
  }

   egress {
    description = var.lb_sg_out_description
    from_port   = var.lb_sg_out_port
        to_port     = var.lb_sg_out_port
        protocol    = var.lb_sg_out_protocol
        cidr_blocks = var.lb_sg_out_cird
  }
}
resource "aws_lb" "tf-alb" {
	name 			   = var.lb_name
  internal           = false
	load_balancer_type = var.lb_type
	subnets 		   = [ data.aws_subnet.devops-subnet-private-2a.id, data.aws_subnet.devops-subnet-private-2c.id ]
	security_groups    = [ aws_security_group.sg-lb-back.id ]
}

resource "aws_lb_listener" "http" {
	load_balancer_arn = aws_lb.tf-alb.arn
	protocol 		  = var.lbl_protocol
	port 			  = var.lbl_port

	default_action {
		type 						 = var.lbl_action_type
		target_group_arn = aws_lb_target_group.devops-target-group.arn
	}
}
resource "aws_lb_target_group" "devops-target-group" {
	target_type = var.tg_target_type
	protocol 		= var.tg_protocol
	port 			  = var.tg_port
	vpc_id 			= var.devops_vpc

	health_check {
		path 							= var.tg_hc_path
		protocol 						= var.tg_hc_protocol
		matcher 						= var.tg_hc_matcher
		interval 						= var.tg_hc_interval
		timeout 						= var.tg_hc_timeout
		healthy_threshold 	= var.tg_hc_healthy_threshold
		unhealthy_threshold = var.tg_hc_unhealthy_threshold
	}
}