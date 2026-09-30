# Travel Booking Cancellation & Customer Experience Analysis

## Executive Summary

This project analyses travel booking data to understand cancellation behaviour and customer experience.

Using SQL, I explored 1,000 travel bookings to investigate booking patterns, cancellation behaviour, booking value, discounts and customer ratings. The analysis was designed to identify patterns that could support better booking management and customer experience decisions.

The analysis was then visualised in Tableau to communicate the findings clearly to business stakeholders.

## Business Problem

A travel booking company wants to understand why some bookings are cancelled and whether booking characteristics are associated with different customer experiences.

The company wants to use its booking data to identify patterns that could support better booking management and customer experience decisions.

### Key Business Questions

1. What does overall booking performance look like?
2. Which destinations and travel characteristics are associated with higher cancellation rates?
3. Is booking value associated with cancellation behaviour?
4. How does cancellation behaviour vary across different discount levels?
5. Which travel characteristics are associated with different customer ratings?


## Dataset

The dataset contains **1,000 travel booking records** across **29 variables**.

The data includes information relating to:

| Category | Example Variables |
|---|---|
| Customer | Age, gender, country |
| Booking | Booking date, travel date, booking status |
| Destination | Destination city, destination country |
| Accommodation | Hotel, hotel rating, rooms |
| Trip | Number of travellers, number of nights, meal plan |
| Financial | Discount amount, total trip cost |
| Customer Experience | Customer rating, review |
| Cancellation | Cancellation status, cancellation reason |
| Transportation | Transportation type |

The dataset was used to investigate booking performance, cancellation behaviour, financial impact and customer experience.


## Data Exploration

Before carrying out the business analysis, the dataset was explored to understand its structure and check for potential data quality issues.

The initial exploration focused on:

- Confirming the total number of bookings
- Checking for duplicate Booking IDs
- Reviewing cancellation status
- Reviewing key booking and customer experience fields
- Validating the data before carrying out further analysis

### Initial Checks

| Check | Result |
|---|---:|
| Total bookings | 1,000 |
| Duplicate Booking IDs | 0 |

These checks confirmed that the dataset contained 1,000 booking records and no duplicate Booking IDs were identified.


## Methodology

The analysis followed a structured process using SQL to explore the booking data and Tableau to visualise the findings.

### Analysis Process

1. **Data validation** – Checked the dataset structure, record count and duplicate Booking IDs.
2. **Data exploration** – Reviewed booking, cancellation, financial and customer experience variables.
3. **Descriptive analysis** – Calculated counts, averages, totals and cancellation rates.
4. **Grouping and segmentation** – Compared results across destinations, transportation, lead time, trip value, discounts and customer experience factors.
5. **Comparative analysis** – Compared cancellation rates and customer ratings across different booking characteristics.
6. **SQL analysis** – Used PostgreSQL/Supabase to answer the key business questions and identify patterns in the data.
7. **Tableau visualisation** – Created charts and a dashboard to communicate the key findings clearly.
8. **Business interpretation** – Considered what the findings could mean for booking management and customer experience.

### SQL Techniques Used

- `COUNT()`
- `SUM()`
- `AVG()`
- `GROUP BY`
- `WHERE`
- `CASE WHEN`
- Common Table Expressions (CTEs)
- Conditional aggregation
- Percentage calculations
- Filtering and sorting

### Tools

- **PostgreSQL / Supabase** – Data analysis and SQL queries
- **Tableau** – Data visualisation and dashboard development


## SQL Business Analysis

### Analysis 1 — Booking Overview

#### Business Question

What does the overall booking performance look like?

This analysis establishes the basic scale of the dataset and provides a starting point for understanding booking and cancellation behaviour.


#### SQL Query

```sql
SELECT
    COUNT(*) AS total_bookings,
    ROUND(AVG("Total_Trip_Cost"), 2) AS average_trip_cost,
    ROUND(AVG("Customer_Rating"), 2) AS average_customer_rating,
    ROUND(AVG("Number_of_Nights"), 2) AS average_nights
FROM travel_bookings;

#### Result

The query provides an overview of the booking dataset by calculating the total number of bookings, average trip cost, average customer rating and average number of nights.
