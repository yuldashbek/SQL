import pandas as pd

data = {
    'First Name': ['Alice', 'Bob', 'Charlie', 'David'],
    'Age': [25, 30, 35, 40],
    'City': ['New York', 'San Francisco', 'Los Angeles', 'Chicago']
}
df = pd.DataFrame(data)

df.colums = df.columns.str.lower().str.replace(' ','_')
print(df)

print(df.head(3))

mean_age = df['age'].mean()
print("Mean age:", mean_age)

print(df[['first_name', 'city']])

import numpy as np

# Add a new 'salary' column with random integers between 50000 and 100000
df['salary'] = np.random.randint(50000, 100001, size=len(df))

print(df)

print(df.describe())

import pandas as pd

# Create the DataFrame
data = {
    'Month': ['Jan', 'Feb', 'Mar', 'Apr'],
    'Sales': [5000, 6000, 7500, 8000],
    'Expenses': [3000, 3500, 4000, 4500]
}

sales_and_expenses = pd.DataFrame(data)

# Display the DataFrame
print("Sales and Expenses Data:")
print(sales_and_expenses)

# Calculate and display maximum sales and expenses
max_sales = sales_and_expenses['Sales'].max()
max_expenses = sales_and_expenses['Expenses'].max()
print("\nMaximum Sales:", max_sales)
print("Maximum Expenses:", max_expenses)

# Calculate and display minimum sales and expenses
min_sales = sales_and_expenses['Sales'].min()
min_expenses = sales_and_expenses['Expenses'].min()
print("\nMinimum Sales:", min_sales)
print("Minimum Expenses:", min_expenses)

# Calculate and display average (mean) sales and expenses
avg_sales = sales_and_expenses['Sales'].mean()
avg_expenses = sales_and_expenses['Expenses'].mean()
print("\nAverage Sales:", avg_sales)
print("Average Expenses:", avg_expenses)





