# Zomato Dummy SQL Data Analysis

## Overview
This project contains a collection of SQL scripts for setting up a dummy dataset resembling Zomato's restaurant data. The dataset includes various tables related to users, restaurant information, and order details. The primary goal of this project is to perform data analysis and generate insights using SQL queries.

## Table of Contents
- [Getting Started](#getting-started)
- [Database Schema](#database-schema)
- [SQL Queries](#sql-queries)
- [Usage](#usage)

## Getting Started
To get started with this project, you'll need a SQL database management system such as PostgreSQL, MySQL, or SQLite. Follow the steps below to set up the database.

### Prerequisites
- SQL Database Management System (e.g., PostgreSQL, MySQL, SQLite)
- Basic understanding of SQL syntax and commands

### Installation
1. **Clone the Repository**
   ```bash
   git clone https://github.com/Rachit2527/Zomato-Dummy-SQL-Data-Analysis.git
   cd Zomato-Dummy-SQL-Data-Analysis

2. Set Up the Database Execute the SQL scripts in the table_creation.sql file to create the necessary tables and populate them with dummy data.
3. Database Schema:
4. 
The schema is defined in the table_creation.sql file and includes the following tables:

users: Contains user details including user IDs, names, and registration dates.

restaurants: Stores information about restaurants, such as restaurant IDs, names, locations, and cuisines.

orders: Records details about orders placed by users, including order IDs, user IDs, restaurant IDs, and order dates.

## SQL Queries

The query.sql file contains a collection of SQL queries designed for data analysis. Some example queries include:

Top Restaurants: Retrieve the top restaurants based on the number of orders.

User Insights: Analyze user behavior, such as the average number of orders per user.

Cuisine Popularity: Identify the most popular cuisines based on order volume.

Each query demonstrates different SQL techniques, such as joins, aggregations, and filtering.

## Usage
To run the queries:

Open your SQL client (e.g., MySQL Workbench, pgAdmin).

Execute the queries from the query.sql file against the database you created.

Review the results and make any necessary modifications to explore further insights.
