variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "AWS region "
}
variable "devops_vpc" {
  default = "vpc-0d8dc549b8e3cd79b"
}

variable "public_subnet_id_2a" {
  type    = string
  default = "subnet-0837dbcd3e40fa9fe"
}
variable "private_subnet_id_2a" {
  type    = string
  default = "subnet-0a8cc0ae87778adb3"
}
variable "public_subnet_id_2c" {
  type    = string
  default = "subnet-095384cad2c0751f4"
}
variable "private_subnet_id_2c" {
  type    = string
  default = "subnet-0d5ba879a0efc802a"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "key_name" {
  type        = string
  default     = "devops-project"
  description = "The .pem file name"
}
variable "project_tag" {
  type        = string
  default     = "devops-project"
  description = "This is the TAG"
}
variable "devops_ami_id" {
  default = "ami-0443305dabd4be2bc"
}

variable "az_subnet_2a" {
  default = "us-east-2a"
}

variable "az_subnet_2c" {
  default = "us-east-2c"
}

variable "map_public_ip_subnets" {
  default = true
}
//SG
variable "sg_instance" {
  type    = string
  default = "Security group for the instance"
}

variable "sg_in_ssh_descrption" {
  type        = string
  default     = "Allowed SSH from anywhere"
  description = "This is the description for the inbound rule that allowed SSH to the instance"
}

variable "sg_in_ssh_port" {
  type        = number
  default     = 22
  description = "This is the port for the inbound rule that allowed SSH to the instance"
}

variable "sg_in_ssh_protocol" {
  type        = string
  default     = "tcp"
  description = "This is the protocol for the inbound rule that allowed SSH to the instance"
}

variable "sg_in_ssh_cidr" {
  type        = list(string)
  default     = ["181.58.18.38/32"]
  description = "This is the list of CIDR"
}

variable "sg_in_app_descrption" {
  type        = string
  default     = "Allow traffic trough port 5000 from anywhere"
  description = "This is the description for the inbound rule that allowed traffic through the port 5000 from the internet to the instance"
}

variable "sg_in_app_port" {
  type        = number
  default     = 5000
  description = "This is the port for the inbound rule that allowed traffic through the port 5000 from the internet to the instance"
}

variable "sg_in_app_protocol" {
  type        = string
  default     = "tcp"
  description = "This is the protocol for the inbound rule that allowed traffic through the port 5000 from the internet to the instance"
}

variable "sg_in_app_cidr" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "This is the list of CIDR"
}

variable "front_sg_out_description" {
  type        = string
  default     = ""
  description = "This is the description for the outbound rule"
}

variable "front_sg_out_port" {
  type        = number
  default     = 0
  description = "This is the port for the outbound rule"
}

variable "front_sg_out_protocol" {
  type        = string
  default     = "-1"
  description = "This is the protocol for the outbound rule"
}

variable "front_sg_out_cidr" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "This is list of cird for the outbound rule"
}

variable "lb_sg_description" {
  type        = string
  default     = "load balancer security group"
  description = "This is the description for the security group for the load balancer"
}

variable "lb_sg_in_traffic_description" {
  type        = string
  default     = "Allowed traffic from anywhere"
  description = "This is the description for the inbound rule that allowed traffic to the load balancer"
}

variable "lb_sg_in_traffic_port" {
  type        = number
  default     = 5000
  description = "This is the port for the inbound rule that allowed traffic to the load balancer"
}

variable "lb_sg_in_traffic_protocol" {
  type        = string
  default     = "tcp"
  description = "This is the protocol for the inbound rule that allowed traffic to the load balancer"
}

variable "lb_sg_in_traffic_cird" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "This is the list of CIDR"
}

variable "lb_sg_out_description" {
  type        = string
  default     = ""
  description = "This is the description for the outbound rule"
}

variable "lb_sg_out_port" {
  type        = number
  default     = 0
  description = "This is the port for the outbound rule"
}

variable "lb_sg_out_protocol" {
  type        = string
  default     = "-1"
  description = "This is the protocol for the outbound rule"
}

variable "lb_sg_out_cird" {
  type        = list (string)
  default     = ["0.0.0.0/0"]
  description = "This is list of cird for the outbound rule"
}
//Launch Template
variable "iam_instance_profile" {
  type        = string
  default     = "EC2-cloudwatch"
  description = "The IAM Role with cloudwatch policies attached"
}
variable "lt_version" {
  type        = string
  default     = "$Latest"
  description = "This is the launch template version that is going to be used"
}
variable "lt_name_db" {
  type        = string
  default     = "tf-launch-template-up-db"
  description = "This is the name that the launch template is going to have"
}
variable "lt_name_back" {
  type        = string
  default     = "tf-launch-template-up-back"
  description = "This is the name that the launch template is going to have"
}
variable "lt_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "This is the instance type that is goint to be created with the launch template"
}

variable "lt_resource_type_instance" {
  type        = string
  default     = "instance"
  description = "This is one of the resource type that the launch template needs to have (instance)"
}

variable "lt_resource_type_volume" {
  type        = string
  default     = "volume"
  description = "This is one of the resource type that the launch template needs to have (volume)"
}

variable "lt_instance_name" {
  default = "tf-instance-devops"
}
//ASG
variable "asg_max_size" {
  type        = number
  default     = 2
  description = "This is the maximun size that the ASG can use"
}

variable "asg_min_size" {
  type        = number
  default     = 0
  description = "This is the minimun size that the ASG can use"
}

variable "asg_desired_capacity" {
  type        = number
  default     = 2
  description = "This is the desired size that the ASG need to use (instances created at the beginning)"
}
//LB
variable "lb_name" {
  type        = string
  default     = "tf-ALB"
  description = "This is the name for the load balancer used by the app"
}

variable "lb_type" {
  type        = string
  default     = "application"
  description = "This is the type of load balancer"
}
variable "lbl_port" {
  type        = number
  default     = 5000
  description = "This is the port that the load balancer is going to listen"
}

variable "lbl_protocol" {
  type        = string
  default     = "HTTP"
  description = "This is the protocol for connection from client to the load balancer"
}

variable "lbl_action_type" {
  type        = string
  default     = "forward"
  description = "This is default action"
}
variable "tg_target_type" {
  type        = string
  default     = "instance"
  description = "This is the type target that needs to be specify when registering targets with this target group"
}

variable "tg_protocol" {
  type        = string
  default     = "HTTP"
  description = "This is the protocol used for routing traffic to the targets"
}

variable "tg_port" {
  type        = number
  default     = 5000
  description = "This is the port on which targets receive traffic"
}

variable "tg_hc_protocol" {
  type        = string
  default     = "HTTP"
  description = "This is the protocol used to connect with the target"
}

variable "tg_hc_path" {
  type        = string
  default     = "/"
  description = "This is the destination for the health check request"
}

variable "tg_hc_matcher" {
  type        = string
  default     = "200"
  description = "The HTTP code use when checking for a successful response form a target"
}

variable "tg_hc_interval" {
  type        = number
  default     = 30
  description = "This is the amount of time between health checks of an individual target"
}

variable "tg_hc_timeout" {
  type        = number
  default     = 5
  description = "This the the amount of time during which no response menas a failed health check"
}

variable "tg_hc_healthy_threshold" {
  type        = number
  default     = 5
  description = "This is the number of consecutive health checks successes required before considering an unhealthy target healthy"
}

variable "tg_hc_unhealthy_threshold" {
  type        = number
  default     = 2
  description = "This is the number of consecutive health checks failures required before considering the target unhealthy"
}


