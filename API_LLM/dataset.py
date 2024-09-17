import csv
import random
from datetime import datetime, timedelta

# Vegetables list
vegetables = ["Tomato", "Potato", "Onion", "Carrot", "Cabbage", "Spinach", "Cauliflower", "Broccoli", "Eggplant",
              "Capsicum"]

# Locations list (including Potheri and other locations in Chennai)
locations = ["Potheri", "Tambaram", "Velachery", "Adyar", "T. Nagar", "Kodambakkam", "Anna Nagar", "Thiruvanmiyur",
             "Chromepet", "Guindy"]

# Farmer names list
farmers = ["Farmer A", "Farmer B", "Farmer C", "Farmer D", "Farmer E", "Farmer F", "Farmer G", "Farmer H", "Farmer I",
           "Farmer J"]

# Generate data for one year
start_date = datetime(2023, 1, 1)
end_date = datetime(2023, 12, 31)
date_range = (end_date - start_date).days + 1


# Function to generate a random price for a vegetable
def generate_price(vegetable):
    base_price = {
        "Tomato": 20, "Potato": 15, "Onion": 30, "Carrot": 25,
        "Cabbage": 18, "Spinach": 10, "Cauliflower": 22,
        "Broccoli": 35, "Eggplant": 28, "Capsicum": 40
    }
    fluctuation = random.uniform(-5, 5)
    return round(base_price[vegetable] + fluctuation, 2)


# Create CSV file
with open('vegetable_prices_with_farmers.csv', mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(["Date", "Vegetable", "Price", "Location", "Farmer"])

    for i in range(date_range):
        date = start_date + timedelta(days=i)
        for vegetable in vegetables:
            price = generate_price(vegetable)
            location = random.choice(locations)  # Randomly select a location
            farmer = random.choice(farmers)  # Randomly select a farmer
            writer.writerow([date.strftime("%Y-%m-%d"), vegetable, price, location, farmer])

print("CSV file 'vegetable_prices_with_farmers.csv' generated successfully!")
