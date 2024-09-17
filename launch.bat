dir
call venv\Scripts\activate
cd FarmHand
cd farmhandweb
start python manage.py runserver
timeout /t /3 /nobreak
start http://localhost:8000