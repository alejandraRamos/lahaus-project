# Infrastructura
Para el montaje y despliegue de la insfraestructura hice uso de Terraform y AWS.

Para el diseño de esta tuve en cuenta la aplicación que fue entregada y la manera en como debia presentar la solución, en la siguiente imagen puede encontrar la insfraestructura diseñada y que posteriormente fue implementada.

![image](https://drive.google.com/uc?export=view&id=1VdXXbF10wZZFriU_AmJ8PJ3R1zwDN0vU)


Esta infraestructura cuenta con el entorno de desarrollo conocido como VPC y esta tiene asociada dos Zonas de disponibilidad que aseguran una aṕlicación más estable. Como la aplicación no maneja un Front decidi dejar la subnet publica unicamente con un servidor Bastion, quien es el punto de acceso principal desde Internet y actúa como un proxy para otras instancias Ec2, que en este caso se encuentran en la subnet privada. El ASG implementa la aplicación usando una intancia (Launch Template) que a través de ansible para implementar un contenedor con la aplicación, la base de datos es implementada en una RDS; el Load Balancer distribuye el tráfico entre los ASG y finalmente una instancia de Jenkins que supervisa CI/CD. 

## Oportunidades de mejora

- Crear un codigo un poco más desacoplado para facilitar el segumiento.
- Desarrollar el Frontend de la app.
- Acceder a través de una conexión más segura (HTTPS).
- Tener la instancia Jenkins en la subnet privada para evitar la exposición de esta con una IP pública.