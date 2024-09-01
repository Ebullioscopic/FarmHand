from flask import Flask, request, jsonify
import pandas as pd
from sqlalchemy import create_engine

app = Flask(__name__)

def calculate_dynamic_price(current_day_price, num_farmers_selling, produced_quantity, farmer_rating, farmer_reviews):
    base_price = current_day_price
    demand_influence = (1 / num_farmers_selling) * produced_quantity
    rating_influence = farmer_rating / 5.0
    review_influence = (farmer_reviews / 100) if farmer_reviews < 100 else 1
    
    # Calculate the dynamic price
    dynamic_price = base_price + (base_price * demand_influence * 0.1) * rating_influence * review_influence
    
    return round(dynamic_price, 2)

def update_prices(df, update_in_db=True, db_engine=None):
    for index, row in df.iterrows():
        dynamic_price = calculate_dynamic_price(
            row['current_day_price'], 
            row['num_farmers_selling'], 
            row['produced_quantity'], 
            row['farmer_rating'], 
            row['farmer_reviews']
        )
        df.at[index, 'dynamic_price'] = dynamic_price
    
    if update_in_db and db_engine:
        # Update in database
        df.to_sql(name="farmer_prices", con=db_engine, index=False, if_exists="replace", chunksize=1000)
    else:
        # Save to CSV
        df.to_csv("updated_prices.csv", index=False)

@app.route('/calculate_dynamic_price', methods=['POST'])
def api_calculate_dynamic_price():
    data = request.json
    dynamic_price = calculate_dynamic_price(
        data['current_day_price'], 
        data['num_farmers_selling'], 
        data['produced_quantity'], 
        data['farmer_rating'], 
        data['farmer_reviews']
    )
    return jsonify({'dynamic_price': dynamic_price})

@app.route('/update_prices', methods=['POST'])
def api_update_prices():
    data = request.json
    df = pd.DataFrame(data['prices'])
    
    if data.get('db_credentials'):
        # Database update
        db_credentials = data['db_credentials']
        engine = create_engine("mysql+mysqlconnector://{user}:{password}@{host}/{dbname}".format(
            user=db_credentials['username'], 
            password=db_credentials['password'], 
            host=db_credentials['host'], 
            dbname=db_credentials['dbname']
        ))
        update_prices(df, update_in_db=True, db_engine=engine)
    else:
        # CSV update
        update_prices(df, update_in_db=False)
    
    return jsonify({'status': 'success'})

if __name__ == '__main__':
    app.run(debug=True)
