# Django Demo Project

This is a demo django app for demonstrating connection to PostgreSQL via pgBouncer. This example consists of a django project named `scalingpostgres` and a django app called `api`. 

## Running the demo project

1. Setup a virtual environment as follows: 
```
python3 -m venv env 

source env/bin/activate
```

2. Install dependencies: 
```
pip install -r requirements.txt 
```

3. Setup pgBouncer connection details inside the `./scalingpostgres/setting.py` settings file under the `DATABASES` section. Set the `HOST` attribute to point to your pgBouncer pod. 

4. Run migrations: 
```
python manage.py migrate
```

5. Run the application: 
```
 python manage.py runserver 
```
