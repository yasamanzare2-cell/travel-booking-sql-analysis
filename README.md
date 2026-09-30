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

### Analysis 1 — Cancellation Analysis

#### Business Question

How common are booking cancellations, what are the main reasons customers cancel, and what patterns can be identified in cancellation behaviour?

Understanding cancellation behaviour can help the business identify areas where booking processes, communication or customer support could potentially be improved.

### SQL Query — Overall Cancellation Rate

```sql
SELECT
    COUNT(*) AS total_bookings,
    SUM(
        CASE
            WHEN "Cancellation_Status" = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN "Cancellation_Status" = 'Cancelled' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        1
    ) AS cancellation_rate
FROM travel_bookings;
```

<img width="1512" height="410" alt="cancellation-rate-sql" src="https://github.com/user-attachments/assets/fa4d55c5-5a83-4266-b14b-b6fca7efd911" />


#### Result

The dataset contains 1,000 bookings, of which 141 were cancelled. This represents an overall cancellation rate of **14.1%**.

#### What does it tell us?

Approximately 1 in 7 bookings in the dataset were cancelled. This provides a baseline for comparing cancellation patterns across different booking characteristics.

#### Why does it matter to the business?

Cancellation volume represents a potential operational and financial concern. Monitoring the cancellation rate can help the business understand where cancellations are concentrated and identify areas for further investigation.

### SQL Query — Cancellation Reasons

```sql
SELECT
    "Cancellation_Reason",
    COUNT(*) AS cancelled_bookings
FROM travel_bookings
WHERE "Cancellation_Status" = 'Cancelled'
GROUP BY "Cancellation_Reason"
ORDER BY cancelled_bookings DESC;
```

<img width="712" height="636" alt="cancellation reasons " src="https://github.com/user-attachments/assets/d163b8e4-227a-4d56-87c9-5945665755da" />


#### Result

Family emergencies were the most common recorded cancellation reason, with **27 cancellations**, followed by transportation disruption (**24**), visa issues (**22**) and budget constraints (**21**).

#### What does it tell us?

The results show that cancellations were linked to a range of different circumstances. The four most common reasons accounted for **94 of the 141 cancellations (66.7%)**, with family emergencies being the largest individual category.

#### Why does it matter to the business?

Understanding the main recorded cancellation reasons can help the business identify areas where the booking process and customer communication could potentially be improved. For example, visa information, travel disruption guidance, pricing clarity and rebooking options could be reviewed where appropriate.


### SQL Query — Cancellation Rate by Transportation

```sql
SELECT
    "Transportation_Type",
    COUNT(*) AS total_bookings,
    SUM(
        CASE
            WHEN "Cancellation_Status" = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN "Cancellation_Status" = 'Cancelled' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        1
    ) AS cancellation_rate
FROM travel_bookings
GROUP BY "Transportation_Type"
ORDER BY cancellation_rate DESC;
```

<img width="1120" height="280" alt="transportation cancellation" src="https://github.com/user-attachments/assets/8c7adc9c-ecda-4370-9ffa-e384a8823c4f" />


#### Result

Train bookings had the highest cancellation rate at **15.1%**, followed by flights at **14.1%** and cars at **12.9%**.

#### What does it tell us?

Cancellation rates were relatively similar across the three transportation types, with only a **2.2 percentage-point difference** between the highest and lowest rates. This suggests that transportation type alone does not show a large difference in cancellation behaviour within this dataset.

#### Why does it matter to the business?

The results provide a useful comparison of cancellation behaviour across transportation types. Although the differences are relatively small, transportation can be considered alongside other booking characteristics when investigating why cancellations occur.


### SQL Query — Cancellation Rate by Destination

```sql
SELECT
    "Destination_City",
    COUNT(*) AS total_bookings,
    SUM(
        CASE
            WHEN "Cancellation_Status" = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN "Cancellation_Status" = 'Cancelled' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        1
    ) AS cancellation_rate
FROM travel_bookings
GROUP BY "Destination_City"
HAVING COUNT(*) >= 20
ORDER BY cancellation_rate DESC;
```

**Note:** Only destinations with at least **20 bookings** are included in this analysis. This threshold was applied to avoid drawing conclusions from destinations with very small booking volumes.

| Destination_City    | total_bookings | cancelled_bookings | cancellation_rate |
| ------------------- | -------------- | ------------------ | ----------------- |
| Kochi               | 30             | 8                  | 26.7              |
| Bali                | 44             | 11                 | 25.0              |
| Dubai               | 42             | 8                  | 19.0              |
| Leh                 | 42             | 8                  | 19.0              |
| Manali              | 42             | 8                  | 19.0              |
| Delhi               | 37             | 7                  | 18.9              |
| Andaman and Nicobar | 38             | 7                  | 18.4              |
| Shimla              | 49             | 9                  | 18.4              |
| Jaisalmer           | 40             | 7                  | 17.5              |
| London              | 41             | 7                  | 17.1              |
| Munnar              | 43             | 7                  | 16.3              |
| Varanasi            | 39             | 6                  | 15.4              |
| Goa                 | 39             | 6                  | 15.4              |
| Colombo             | 49             | 6                  | 12.2              |
| Bangkok             | 35             | 4                  | 11.4              |
| Jaipur              | 37             | 4                  | 10.8              |
| Agra                | 39             | 4                  | 10.3              |
| Paris               | 29             | 3                  | 10.3              |
| Mumbai              | 41             | 4                  | 9.8               |
| Darjeeling          | 41             | 4                  | 9.8               |
| Malé                | 32             | 3                  | 9.4               |
| Singapore           | 25             | 2                  | 8.0               |
| Rishikesh           | 45             | 3                  | 6.7               |
| Kathmandu           | 34             | 2                  | 5.9               |
| Udaipur             | 37             | 2                  | 5.4               |
| Srinagar            | 30             | 1                  | 3.3               |


#### Result

Cancellation rates varied considerably between destinations. **Kochi had the highest cancellation rate at 26.7%**, while **Srinagar had the lowest at 3.3%** among destinations with at least 20 bookings.

#### What does it tell us?

The results show that cancellation behaviour differed across destinations. This variation may indicate that destination-level factors are worth investigating further, although this analysis does not establish the reasons for the differences.

#### Why does it matter to the business?

Identifying destinations with higher cancellation rates can help the business focus further investigation on where cancellations may be more common. Factors such as travel requirements, transportation disruption, booking conditions and seasonality could be explored in more detail.


### SQL Query — Cancellation Rate by Booking Lead Time

```sql
WITH booking_data AS (
    SELECT
        "Booking_ID",
        "Booking_Date"::date AS booking_date,
        "Travel_Date"::date AS travel_date,
        "Cancellation_Status"
    FROM travel_bookings
),

lead_time_data AS (
    SELECT
        CASE
            WHEN (travel_date - booking_date) <= 30 THEN '0-30 days'
            WHEN (travel_date - booking_date) <= 60 THEN '31-60 days'
            WHEN (travel_date - booking_date) <= 90 THEN '61-90 days'
            ELSE '90+ days'
        END AS booking_lead_time,
        "Cancellation_Status"
    FROM booking_data
)

SELECT
    booking_lead_time,
    COUNT(*) AS total_bookings,
    SUM(
        CASE
            WHEN "Cancellation_Status" = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN "Cancellation_Status" = 'Cancelled' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        1
    ) AS cancellation_rate
FROM lead_time_data
GROUP BY booking_lead_time
ORDER BY
    CASE booking_lead_time
        WHEN '0-30 days' THEN 1
        WHEN '31-60 days' THEN 2
        WHEN '61-90 days' THEN 3
        WHEN '90+ days' THEN 4
    END;
```

<img width="1091" height="346" alt="image" src="https://github.com/user-attachments/assets/bf34c533-b389-41fc-875c-9c7320dff304" />

#### Result

The results show that cancellation rates varied across booking lead-time groups. The highest cancellation rate was recorded for bookings made 0–30 days before travel, at **16.8%**, while bookings made 61–90 days before travel had the lowest rate at **8.1%**. Bookings made more than 90 days in advance also had a relatively high cancellation rate of **15.5%**.

#### What does it tell us?

The results suggest that cancellation behaviour differed depending on how far in advance the booking was made. The 61–90 day group had the lowest cancellation rate, while both the shortest lead-time group and the 90+ day group had higher cancellation rates. However, this analysis shows an association rather than explaining the reasons behind these differences.

#### Why does it matter to the business?

Understanding how cancellation rates vary by booking lead time could help the business identify when customers may be more likely to cancel. This could support further investigation into booking conditions, customer circumstances and travel plans, and whether different cancellation policies or communication strategies could be considered for different booking periods.

<img width="946" height="692" alt="image" src="https://github.com/user-attachments/assets/0a5603bc-41ca-457d-8505-2b9885dfd45d" />



### SQL Query — Cancellation Rate by Booking Value

```sql
WITH trip_cost_quartiles AS (
    SELECT
        "Total_Trip_Cost",
        "Cancellation_Status",
        NTILE(4) OVER (ORDER BY "Total_Trip_Cost") AS cost_quartile
    FROM travel_bookings
)

SELECT
    CASE
        WHEN cost_quartile = 1 THEN 'Lowest 25%'
        WHEN cost_quartile = 2 THEN '25%–50%'
        WHEN cost_quartile = 3 THEN '50%–75%'
        WHEN cost_quartile = 4 THEN 'Highest 25%'
    END AS trip_cost_group,
    COUNT(*) AS total_bookings,
    SUM(
        CASE
            WHEN "Cancellation_Status" = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN "Cancellation_Status" = 'Cancelled' THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        1
    ) AS cancellation_rate
FROM trip_cost_quartiles
GROUP BY cost_quartile
ORDER BY cost_quartile;
```

<img width="1057" height="348" alt="image" src="https://github.com/user-attachments/assets/4149818f-1739-42d6-b45e-9acadedfdd89" />

#### Result

Cancellation rates varied across trip cost groups. The highest-cost 25% of bookings had the highest cancellation rate at **16.8%**, while the 25%–50% group had the lowest rate at **11.2%**.

#### What does it tell us?

The results show that cancellation rates were not consistent across trip cost groups. The highest-cost bookings had a higher cancellation rate than the other groups, although the difference between groups was relatively moderate.

#### Why does it matter to the business?

Higher-value bookings may represent greater financial exposure when cancelled. Understanding how cancellation behaviour varies across trip cost groups could help the business investigate whether booking conditions, customer circumstances or other factors are associated with cancellations.

### SQL Query — Customer Rating by Cancellation Status

```sql
SELECT
    "Cancellation_Status",
    COUNT(*) AS total_bookings,
    ROUND(AVG("Customer_Rating"), 2) AS average_customer_rating
FROM travel_bookings
GROUP BY "Cancellation_Status"
ORDER BY average_customer_rating DESC;
```

<img width="918" height="207" alt="image" src="https://github.com/user-attachments/assets/d4e25d77-243d-4d62-a50c-05c784bf750f" />

#### Result

The 859 non-cancelled bookings had an average customer rating of **2.69**, while the 141 cancelled bookings had an average rating of **0.00**.

#### What does it tell us?

The results show a clear difference in recorded customer ratings between cancelled and non-cancelled bookings. However, the **0.00 rating for cancelled bookings should be interpreted with caution**, as cancelled bookings may not have received a customer rating rather than representing genuine zero-star feedback.

#### Why does it matter to the business?

Understanding how customer ratings are recorded alongside booking outcomes can help the business identify gaps in the customer feedback process. Ensuring that ratings are only analysed where a customer has actually provided feedback would provide a more accurate view of customer satisfaction.


### SQL Query — Customer Rating by Transportation Type

```sql
SELECT
    "Transportation_Type",
    COUNT(*) AS rated_bookings,
    ROUND(AVG("Customer_Rating")::numeric, 2) AS average_customer_rating
FROM travel_bookings
WHERE "Cancellation_Status" = 'Not Cancelled'
  AND "Customer_Rating" > 0
GROUP BY "Transportation_Type"
ORDER BY average_customer_rating DESC;
```

<img width="922" height="279" alt="image" src="https://github.com/user-attachments/assets/404595a8-4440-4138-862d-8c4c2beaa1d2" />


#### Result

Average customer ratings varied slightly across transportation types. Car bookings had the highest average rating at **3.11**, followed by flights at **2.99** and trains at **2.95**.

#### What does it tell us?

The results show relatively small differences in average customer ratings between transportation types. Car bookings had the highest recorded average rating, while train bookings had the lowest. However, the differences were relatively small, suggesting that transportation type alone may not explain substantial differences in customer satisfaction.

#### Why does it matter to the business?

Comparing customer ratings across transportation types can help the business identify whether particular parts of the travel experience may be associated with customer satisfaction. These results can also be used alongside other factors, such as destination and booking characteristics, to investigate customer experience in more detail.


### Tableau Finding — Customer Ratings by Meal Plan

<img width="970" height="706" alt="image" src="https://github.com/user-attachments/assets/f3a1b1a9-ce8d-47e5-8ec2-892a34d45959" />

#### What does it tell us?

Customer ratings varied slightly across meal plans, with Half Board receiving the highest average rating at 3.14, while Full Board had the lowest at 2.83. This suggests that meal plan type may be associated with differences in customer satisfaction.

#### Why does it matter to the business?

Understanding differences in customer ratings across meal plans could help the business identify which meal options are associated with a better customer experience and investigate whether improvements could be made to lower-rated options.


## Tableau Dashboard

The Tableau dashboard brings together the key findings from the analysis into one interactive view. It highlights overall booking and cancellation metrics, cancellation rates by booking lead time and destination, customer ratings by meal plan, and the main recorded cancellation reasons.

The dashboard provides a visual summary of the analysis and makes it easier to identify patterns and areas that may require further investigation.

<img width="2598" height="1592" alt="image" src="https://github.com/user-attachments/assets/8a6f4eeb-719d-4303-83c0-7bd59955765c" />
