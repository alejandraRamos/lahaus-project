#!/bin/bash

python3 manage.py db init
python3 manage.py db migrate
python3 manage.py db upgrade

python3 manage.py runserver -h 0.0.0.0 -p 5000