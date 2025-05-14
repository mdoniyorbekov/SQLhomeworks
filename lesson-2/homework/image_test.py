import pyodbc

con_str = "DRIVER={SQL Server}; SERVER=WIN-4Q7FKOLMBJ7\SQLEXPRESS; DATABASE=Assignment2; Trusted_Connection=yes;"
con = pyodbc.connect(con_str)
cursor = con.cursor()

cursor.execute("SELECT * FROM photos")
row = cursor.fetchone()
id, image = row

with open(f"{id}.png", 'wb') as f:
    f.write(image)
