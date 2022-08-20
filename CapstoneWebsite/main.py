import streamlit as st 
import pandas as pd 

header = st.container()
dataset = st.container()
features = st.container()
model_training = st.container()

with header: 
    st.title("Welcome to my awesome data science project!")
    st.text("In this project we look into what factors contribute to EV sales in California")




with dataset:
    st.header("California EV Demographics, Sales, and Incentives datasets")
    st.text("We found multiple datasets that provide data for us to analyze. We used various websites")
    



    sales_data = pd.read_csv("data/sales_db_copy.csv")
    st.write(sales_data.head())

    number_of_vehicles_dist = pd.DataFrame(sales_data["number_of_vehicles"].value_counts())
    st.bar_chart(number_of_vehicles_dist)


with features:
    st.header("The features I created")







with model_training:
    st.header("Time to train the model")
    st.text("Here you get to choose the hyperparamters of the model and see how the performance changes")
