import tkinter as tk
from tkinter import messagebox
from pymongo import MongoClient

class MongoDBApplication:
    def __init__(self, master):
        self.master = master
        self.master.title("MongoDB CRUD Application")
        
        # MongoDB connection
        self.client = MongoClient('localhost', 27017)
        self.db = self.client['ADS_Assign9']  # Connect to the database
        self.collection = self.db['CURD_Application']  # Connect to the collection

        # Labels and Entry widgets for editing
        tk.Label(master, text="PRN:").grid(row=0, column=0, padx=5, pady=5)
        self.prn_entry = tk.Entry(master)
        self.prn_entry.grid(row=0, column=1, padx=5, pady=5)

        tk.Label(master, text="Name:").grid(row=1, column=0, padx=5, pady=5)
        self.name_entry = tk.Entry(master)
        self.name_entry.grid(row=1, column=1, padx=5, pady=5)

        tk.Label(master, text="Branch:").grid(row=2, column=0, padx=5, pady=5)
        self.branch_entry = tk.Entry(master)
        self.branch_entry.grid(row=2, column=1, padx=5, pady=5)

        tk.Label(master, text="Email:").grid(row=3, column=0, padx=5, pady=5)
        self.email_entry = tk.Entry(master)
        self.email_entry.grid(row=3, column=1, padx=5, pady=5)

        tk.Label(master, text="CGPA:").grid(row=4, column=0, padx=5, pady=5)
        self.cgpa_entry = tk.Entry(master)
        self.cgpa_entry.grid(row=4, column=1, padx=5, pady=5)

        tk.Label(master, text="Phone Number:").grid(row=5, column=0, padx=5, pady=5)
        self.phone_entry = tk.Entry(master)
        self.phone_entry.grid(row=5, column=1, padx=5, pady=5)

        # Buttons for CRUD operations
        self.add_button = tk.Button(master, text="Add Record", command=self.add_record, bg="green", fg="white", width=10)
        self.add_button.grid(row=6, column=0, padx=5, pady=5)

        self.update_button = tk.Button(master, text="Update", command=self.update_document, bg="orange", fg="black", width=10)
        self.update_button.grid(row=6, column=1, padx=5, pady=5)

        self.delete_button = tk.Button(master, text="Delete", command=self.delete_record, bg="red", fg="white", width=10)
        self.delete_button.grid(row=6, column=2, padx=5, pady=5)

        # Search and display record section
        tk.Label(master, text="Search by PRN/Name/Email/Phone:").grid(row=7, column=0, padx=5, pady=5)
        self.search_entry = tk.Entry(master)
        self.search_entry.grid(row=7, column=1, padx=5, pady=5)

        self.search_button = tk.Button(master, text="Search", command=self.search_document, bg="blue", fg="white", width=10)
        self.search_button.grid(row=7, column=2, padx=5, pady=5)

        self.search_results = tk.Listbox(master, width=50)
        self.search_results.grid(row=8, columnspan=3, padx=5, pady=5)

        self.search_results.bind("<Double-Button-1>", self.on_double_click)

    def search_document(self):
        self.search_results.delete(0, tk.END)
        search_key = self.search_entry.get()
        results = self.collection.find({
            "$or": [
                {"prn": {"$regex": search_key, "$options": "i"}},
                {"name": {"$regex": search_key, "$options": "i"}},
                {"email": {"$regex": search_key, "$options": "i"}},
                {"phone_number": {"$regex": search_key, "$options": "i"}}
            ]
        })
        for result in results:
            self.search_results.insert(tk.END, result["name"])

    def on_double_click(self, event):
        # Get the selected item from the listbox
        index = self.search_results.curselection()[0]
        selected_name = self.search_results.get(index)
        
        # Retrieve the document from the database
        result = self.collection.find_one({"name": selected_name})
        if result:
            # Populate entry fields with document data
            self.prn_entry.delete(0, tk.END)
            self.prn_entry.insert(tk.END, result.get("prn", ""))
            self.name_entry.delete(0, tk.END)
            self.name_entry.insert(tk.END, result.get("name", ""))
            self.branch_entry.delete(0, tk.END)
            self.branch_entry.insert(tk.END, result.get("branch", ""))
            self.email_entry.delete(0, tk.END)
            self.email_entry.insert(tk.END, result.get("email", ""))
            self.cgpa_entry.delete(0, tk.END)
            self.cgpa_entry.insert(tk.END, result.get("cgpa", ""))
            self.phone_entry.delete(0, tk.END)
            self.phone_entry.insert(tk.END, result.get("phone_number", ""))

    def add_record(self):
        data = {
            "prn": self.prn_entry.get(),
            "name": self.name_entry.get(),
            "branch": self.branch_entry.get(),
            "email": self.email_entry.get(),
            "cgpa": self.cgpa_entry.get(),
            "phone_number": self.phone_entry.get()
        }
        result = self.collection.insert_one(data)
        if result.inserted_id:
            messagebox.showinfo("Success", "Record added successfully.")
            # Clear entry fields after adding
            self.prn_entry.delete(0, tk.END)
            self.name_entry.delete(0, tk.END)
            self.branch_entry.delete(0, tk.END)
            self.email_entry.delete(0, tk.END)
            self.cgpa_entry.delete(0, tk.END)
            self.phone_entry.delete(0, tk.END)
            # Update search results
            self.search_document()
        else:
            messagebox.showerror("Error", "Failed to add record.")

    def update_document(self):
        # Get the selected item from the listbox
        index = self.search_results.curselection()[0]
        selected_name = self.search_results.get(index)

        query = {"name": selected_name}
        new_values = {
            "$set": {
                "prn": self.prn_entry.get(),
                "name": self.name_entry.get(),
                "branch": self.branch_entry.get(),
                "email": self.email_entry.get(),
                "cgpa": self.cgpa_entry.get(),
                "phone_number": self.phone_entry.get()
            }
        }
        result = self.collection.update_one(query, new_values)
        if result.modified_count > 0:
            messagebox.showinfo("Success", "Document updated successfully.")
        elif result.matched_count > 0:
            messagebox.showinfo("Info", "No changes were made to the document.")
        else:
            messagebox.showinfo("Info", "Document not found.")

    def delete_record(self):
        prn = self.prn_entry.get()
        result = self.collection.delete_one({"prn": prn})
        if result.deleted_count > 0:
            messagebox.showinfo("Success", "Record deleted successfully.")
            # Clear entry fields after deletion
            self.prn_entry.delete(0, tk.END)
            self.name_entry.delete(0, tk.END)
            self.branch_entry.delete(0, tk.END)
            self.email_entry.delete(0, tk.END)
            self.cgpa_entry.delete(0, tk.END)
            self.phone_entry.delete(0, tk.END)
            # Remove the deleted item from the listbox
            self.search_results.delete(tk.ACTIVE)
        else:
            messagebox.showwarning("Warning", "Record not found or already deleted.")

def main():
    root = tk.Tk()
    app = MongoDBApplication(root)
    root.mainloop()

if __name__ == "__main__":
    main()
