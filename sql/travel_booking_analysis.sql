-- Travel Booking Cancellation & Customer Experience Analysis
-- SQL Analysis
-- Dataset: Travel & Tourism
-- Records: 1,000
--
-- Business Objective:
-- Investigate booking behaviour, cancellation patterns,
-- booking value and customer experience to identify
-- potential business insights and recommendations.


-- ==========================================
-- 1. DATA EXPLORATION
-- ==========================================

-- 1.1 Check total number of bookings

SELECT COUNT(*) AS total_bookings
FROM travel_bookings;


-- 1.2 Check for duplicate Booking IDs

SELECT
    "Booking_ID",
    COUNT(*) AS booking_count
FROM travel_bookings
GROUP BY "Booking_ID"
HAVING COUNT(*) > 1;
