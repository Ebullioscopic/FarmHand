from django.db import models

# User-related models
class User(models.Model):
    user_name = models.CharField(max_length=255)
    user_password = models.CharField(max_length=255)
    user_mobile = models.CharField(max_length=15)
    user_email = models.EmailField(null=True, blank=True)  # Optional field
    user_remark = models.TextField(null=True, blank=True)

    def __str__(self):
        return self.user_name

class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    GENDER_CHOICES = [
        ('M', 'Male'),
        ('F', 'Female')
    ]
    user_gender = models.CharField(max_length=1, choices=GENDER_CHOICES)
    user_image = models.ImageField(upload_to='profile_images/', null=True, blank=True)
    user_aadhaar = models.CharField(max_length=12)
    user_address = models.TextField()
    user_area = models.CharField(max_length=255)
    user_city = models.CharField(max_length=255)
    user_country = models.CharField(max_length=255)
    user_pincode = models.CharField(max_length=10)

    def __str__(self):
        return f"Profile of {self.user.user_name}"

class Role(models.Model):
    role_name = models.CharField(max_length=255)
    role_remark = models.TextField(null=True, blank=True)

    def __str__(self):
        return self.role_name

class UserRole(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    role = models.ForeignKey(Role, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.user.user_name} - {self.role.role_name}"


# Product-related models
class Category(models.Model):
    category_name = models.CharField(max_length=255)
    category_remark = models.TextField(null=True, blank=True)
    category_status = models.BooleanField(default=True)

    def __str__(self):
        return self.category_name

class Unit(models.Model):
    unit_name = models.CharField(max_length=255)
    unit_remark = models.TextField(null=True, blank=True)

    def __str__(self):
        return self.unit_name

class Product(models.Model):
    product_name = models.CharField(max_length=255)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    unit = models.ForeignKey(Unit, on_delete=models.CASCADE)
    product_image = models.ImageField(upload_to='product_images/', null=True, blank=True)
    product_remark = models.TextField(null=True, blank=True)

    def __str__(self):
        return self.product_name

class ProductRate(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    timestamp = models.DateTimeField(auto_now_add=True)
    product_wholesale_rate = models.DecimalField(max_digits=10, decimal_places=2)
    product_retail_rate = models.DecimalField(max_digits=10, decimal_places=2)
    product_stock = models.IntegerField()

    def __str__(self):
        return f"Rate for {self.product.product_name} by {self.user.user_name}"


# Shopping and order models
class ShoppingSession(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    total = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f"Session for {self.user.user_name}"

class Cart(models.Model):
    session = models.ForeignKey(ShoppingSession, on_delete=models.CASCADE)
    product_rate = models.ForeignKey(ProductRate, on_delete=models.CASCADE)
    product_qty = models.IntegerField()

    def __str__(self):
        return f"Cart for session {self.session.id}"

class Order(models.Model):
    ORDER_STATUS_CHOICES = [
        ('ordered', 'Ordered'),
        ('partially_fulfilled', 'Partially Fulfilled'),
        ('fulfilled', 'Fulfilled'),
        ('cancelled', 'Cancelled')
    ]
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    payment_id = models.CharField(max_length=255)
    order_total = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=20, choices=ORDER_STATUS_CHOICES, default='ordered')

    def __str__(self):
        return f"Order {self.id} by {self.user.user_name}"

class OrderItem(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    product_rate = models.ForeignKey(ProductRate, on_delete=models.CASCADE)
    product_qty = models.IntegerField()
    status = models.CharField(max_length=20, choices=Order.ORDER_STATUS_CHOICES, default='ordered')

    def __str__(self):
        return f"Item for order {self.order.id}"


# Payment-related models
class Payment(models.Model):
    PAYMENT_STATUS_CHOICES = [
        ('unpaid', 'Unpaid'),
        ('paid', 'Paid'),
        ('failed', 'Failed')
    ]
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_provider = models.CharField(max_length=255)
    payment_status = models.CharField(max_length=10, choices=PAYMENT_STATUS_CHOICES, default='unpaid')

    def __str__(self):
        return f"Payment {self.id} for order {self.order.id}"


# User Location
class UserLocation(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    lat = models.FloatField()
    long = models.FloatField()

    def __str__(self):
        return f"Location for {self.user.user_name}"
