# Infrastructura
Para el montaje y despliegue de la insfraestructura hice uso de Terraform y AWS.

Para el diseño de esta tuve en cuenta la aplicación que fue entregada y la manera en como debia presentar la solución, en la siguiente imagen puede encontrar la insfraestructura diseñada y que posteriormente fue implementada.

![image](https://drive.google.com/uc?export=view&id=1YwEHM_BVakFdM_al7gU9hqp8v80RzW4s)


Esta infraestructura cuenta con el entorno de desarrollo conocido como VPC y esta tiene asociada dos Zonas de disponibilidad que aseguran una aṕlicación más estable. Como la aplicación no maneja un Front decidi dejar la subnet publica unicamente con un servidor Bastion, quien es el punto de acceso principal desde Internet y actúa como un proxy para otras instancias Ec2, que en este caso se encuentran en la subnet privada. El ASG implementa la aplicación usando una intancia (Launch Template) que a través de ansible para implementar un contenedor con la aplicación, la base de datos es implementada en otra instancia (Launch Template) para facilitar el la creación y migración de esta; el Load Balancer distribuye el tráfico entre los ASG y finalmente una instancia de Jenkins que supervisa CI / CD. 

## Oportunidades de mejora

- Crear una RDS en lugar de una instancia ec2.
- 