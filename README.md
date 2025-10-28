# Salon Appointment Project
License: MIT PostgreSQL

🚀 Overview  
This project is a PostgreSQL database for managing a fictional salon.  
It includes customers, services, and appointments, allowing users to schedule appointments and track customer information.  
Built as a practice exercise in database design, normalization, and SQL queries, along with Bash scripting for interaction.

🗂️ Database Structure  
The database contains three main tables:

- **customers** – Stores information about customers (name, phone).  
- **services** – Stores available services offered by the salon.  
- **appointments** – Stores scheduled appointments, linking customers and services with a time.

🔗 Relationships  
- Customer → Appointment: One-to-many  
- Service → Appointment: One-to-many  


⚙️ Installation  
Clone the repository:  
```bash
git clone https://github.com/<your-username>/salon-appointment.git
cd salon-appointment
Import the database:

psql -U <your-username> -d salon -f salon.sql
🛒 Usage
Run the Bash script to interact with the salon:

./salon.sh
```
Once running, you can:

View available services

Enter your phone number to check if you’re an existing customer

Register as a new customer if needed

Schedule an appointment at a chosen time

🗂️ Files

salon.sql – Contains schema and initial data for the database.

salon.sh – Bash script for interacting with the database.

README.md – Project description.

🧻 License
This project is released under the MIT License.