from django.urls import path
from . import views
app_name = "users"
urlpatterns = [
    path("",views.index,name="index"),
    path("dashboard", views.dashboard, name="dashboard"),
    path('register/', views.register, name='register'),
    path('login/', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
    path('cart/',views.cart,name="cart"),
    path('shop/',views.shop,name="shop"),
    path('shop-detail/',views.shop_detail,name="shop-detail"),
    path('checkout/',views.checkout,name="checkout"),
    path('testimonial/',views.testimonial,name="testimonial"),
    path('contact/',views.contact,name="contact"),
]