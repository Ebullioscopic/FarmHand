from django.shortcuts import render

# Create your views here.
from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, logout
from django.contrib.auth import login as signin
from django.contrib.auth.decorators import login_required
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from django.contrib.auth.models import User

@login_required
def index(request):
    context = {}
    return render(request,"users/index.html",context)

def signout(request):
    logout(request)
    return redirect("login")

def register(request):
    context = None
    if request.method == "POST":
        print(request.POST)
        username = request.POST["signup_username"]
        email = request.POST["signup_email"]
        password = request.POST["signup_password"]
        user = User.objects.create_user(username,email,password)
        signin(request,user)
        return redirect("index")
    return render(request,"users/register.html",context)

def login(request):
    context = None
    err = None
    if request.method == "POST":
        print(request.POST)
        username = request.POST["login_username"]
        password = request.POST["login_password"]
        user = authenticate(request,username=username,password=password)
        if user is not None:
            signin(request,user)
            return redirect("index")
        else:
            err = "Invalid Credentials"
    context = {"error" : err}
    return render(request,"users/login.html",context)