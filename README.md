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
