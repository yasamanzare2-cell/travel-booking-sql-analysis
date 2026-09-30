# Travel Booking Cancellation & Customer Experience Analysis

## Project Overview

This project analyses travel booking data to understand cancellation patterns, booking value and customer experience.

The analysis explores which booking characteristics are associated with higher cancellation rates and how customer ratings vary across different aspects of a booking. SQL was used to clean, explore and analyse the data, while Tableau was used to create an interactive dashboard presenting the key findings.

The aim of the project is to demonstrate how data analysis can be used to identify business patterns and generate practical insights for a travel booking company.

## Business Problem

A travel booking company wants to understand why some bookings are cancelled and whether booking characteristics are associated with different customer experiences.

The analysis focuses on:

- How frequently bookings are cancelled
- The main reasons for cancellations
- Whether cancellation rates vary by destination, transportation, lead time and trip value
- The financial value associated with cancelled bookings
- How customer ratings vary across transportation, hotel rating, meal plan and trip length

The findings can help the business identify patterns in cancellations and customer experience that may support better booking management and customer-focused decisions.

## Dataset

The dataset contains **1,000 travel booking records** with information relating to bookings, travel dates, destinations, transportation, trip costs, discounts, cancellation status and customer experience.

Key fields used in the analysis include:

- Booking ID
- Booking Date
- Travel Date
- Destination City
- Transportation
- Total Trip Cost
- Discount
- Cancellation Status
- Cancellation Reason
- Customer Rating
- Hotel Rating
- Meal Plan
- Number of Nights

The dataset was analysed using SQL in PostgreSQL/Supabase and the results were visualised using Tableau.

## Methodology

The project followed a structured data analysis process:

1. **Data Exploration** – Checked the dataset structure, record count and potential duplicate booking IDs.
2. **Data Validation** – Reviewed key fields and checked for potential data quality issues.
3. **Descriptive Analysis** – Calculated booking counts, cancellation rates, booking values and customer rating averages.
4. **Segmentation** – Compared cancellation patterns across destinations, transportation, booking lead time, trip value and discount levels.
5. **Customer Experience Analysis** – Examined customer ratings across transportation, hotel rating, meal plan and trip length.
6. **Financial Analysis** – Calculated the total booking value and the value associated with cancelled bookings.
7. **Visualisation** – Created a Tableau dashboard to present the main findings and make the results easier to interpret.

### SQL Techniques Used

- `COUNT()` and `SUM()`
- `AVG()`
- `GROUP BY`
- `WHERE`
- `CASE WHEN`
- Common Table Expressions (CTEs)
- Filtering and sorting
- Percentage calculations
- Comparative analysis
