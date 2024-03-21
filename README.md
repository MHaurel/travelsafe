# travelsafe

**/!\ Always pull the commits from GitHub before coding**

## Installing & Running the backend

Need to create an environment **(only needed the first time)**

```
python -m venv venv
```

Activate the environment 

> Sur mac/linux:
```
source ./venv/bin/activate
```

> Sur windows
```
.\venv\Scripts\activate
```

Install the dependencies **(only needed the first time)**
```
pip install Django djangorestframework django-extensions django-cors-headers djangorestframework-simplejwt
```

Run the server

```
python api/manage.py runserver
```

**The server is running** !

## Installing and running the frontend
In another terminal:
> Before running: always run (inside the flutter_frontend directory):
```
flutter pub get
```

Run the app on Chrome
```
flutter run -d chrome
```

**The app is running**

## Structure of the Flutter app

* Assets are placed in the assets folder at the root of the app (images, fonts, videos, ...)
* Components/widgets are placed in the lib/widgets folder
* Pages are placed in the lib/pages folder
* Only 1 file should be at the root of the lib folder: main.dart