from Tkinter import *
from cassandra.cluster import Cluster
from cassandra.auth import PlainTextAuthProvider
# Set up authentication provider with default username and password
auth_provider = PlainTextAuthProvider(username='cassandra', password='cassandra')

# Connect to Cassandra cluster
cluster = Cluster(['localhost'], auth_provider=auth_provider)

# Connect to the keyspace
session = cluster.connect('mrunal_db')

# Define function to create a new friend
def create_friend():
    # Retrieve values from input fields
    name = name_entry.get()
    address = address_entry.get()
    phone_number = phone_number_entry.get()
    
    # Insert values into the friend table
    query = "INSERT INTO friend (name, address, phone_number) VALUES (%s, %s, %s)"
    session.execute(query, (name, address, phone_number))
    
    # Display success message
    print("Friend Added Successfully ....")
    
    # Clear input fields
    name_entry.delete(0, END)
    address_entry.delete(0, END)
    phone_number_entry.delete(0, END)


# Define function to retrieve friend data
def read_friend():
    # Retrieve value from input field
    name = name_entry.get()
    
    # Select values from the friend table
    query = "SELECT * FROM friend WHERE name = %s"
    rows = session.execute(query, (name,))
    
    # Display results
    result = ""
    for row in rows:
        result += "Name: {}\nAddress: {}\nPhone Number: {}\n\n".format(row.name, row.address, row.phone_number)
    if result:
       print("Friend Data :" )
       print(result)
    else:
        print("No such Friend Record ....")
    
    # Clear input field
    name_entry.delete(0, END)


# Define function to update friend data
def update_friend():
    # Retrieve values from input fields
    name = name_entry.get()
    address = address_entry.get()
    phone_number = phone_number_entry.get()
    
    # Update friend data in the friend table
    query = "UPDATE friend SET address = %s, phone_number = %s WHERE name = %s"
    session.execute(query, (address, phone_number, name))
    
    # Display success message
    print("Friend updated successfully.")
    
    # Clear input fields
    name_entry.delete(0, END)
    address_entry.delete(0, END)
    phone_number_entry.delete(0, END)


# Define function to delete a friend
def delete_friend():
    # Retrieve value from input field
    name = name_entry.get()
    
    # Delete friend data from the friend table
    query = "DELETE FROM friend WHERE name = %s"
    session.execute(query, (name,))
    
    # Display success message
    print("Friend deleted successfully.")
    
    # Clear input field
    name_entry.delete(0, END)
    

# Create main window
root = Tk()
root.title("Friends List")

# Create input fields and labels

name_label = Label(root, text="Name:")
name_label.grid(row=0, column=0)

name_entry = Entry(root)
name_entry.grid(row=0, column=1)

address_label = Label(root, text="Address:")
address_label.grid(row=1, column=0)

address_entry = Entry(root)
address_entry.grid(row=1, column=1)

phone_number_label = Label(root, text="Phone Number:")
phone_number_label.grid(row=2, column=0)

phone_number_entry = Entry(root)
phone_number_entry.grid(row=2, column=1)



















create_button = Button(root, text="Add  Friend", command=create_friend)
create_button.grid(row=3, column=0)

read_button = Button(root, text="View Friend ", command=read_friend)
read_button.grid(row=3, column=1)

update_button = Button(root, text="Update Friend ", command=update_friend)
update_button.grid(row=3, column=2)

delete_button = Button(root, text="Delete Friend", command=delete_friend)
delete_button.grid(row=3, column=3)



result_label = Label(root, text="")
result_label.grid(row=3, column=0, columnspan=4)



root.mainloop()
