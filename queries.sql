-- ============================================
-- E-COMMERCE SQL ANALYSIS QUERIES
-- ============================================


-- ============================================
-- 1. BASIC ANALYSIS
-- ============================================

-- Total number of records
SELECT COUNT(*) FROM user_events;

-- Total unique users
SELECT COUNT(DISTINCT user_id) FROM user_events;


-- ============================================
-- 2. EVENT ANALYSIS
-- ============================================

-- Count of each event type
SELECT event_type, COUNT(*) 
FROM user_events
GROUP BY event_type;


-- ============================================
-- 3. FUNNEL ANALYSIS
-- ============================================

-- User conversion funnel
SELECT 
    COUNT(DISTINCT CASE WHEN event_type='page_view' THEN user_id END) AS views,
    COUNT(DISTINCT CASE WHEN event_type='add_to_cart' THEN user_id END) AS carts,
    COUNT(DISTINCT CASE WHEN event_type='checkout_start' THEN user_id END) AS checkout,
    COUNT(DISTINCT CASE WHEN event_type='purchase' THEN user_id END) AS buyers
FROM user_events;


-- ============================================
-- 4. REVENUE ANALYSIS
-- ============================================

-- Total revenue
SELECT SUM(amount) AS total_revenue
FROM user_events
WHERE event_type = 'purchase';

-- Revenue by traffic source
SELECT traffic_source, SUM(amount) AS revenue
FROM user_events
WHERE event_type = 'purchase'
GROUP BY traffic_source;


-- ============================================
-- 5. PRODUCT ANALYSIS
-- ============================================

-- Top 5 selling products
SELECT product_id, COUNT(*) AS total_sales
FROM user_events
WHERE event_type = 'purchase'
GROUP BY product_id
ORDER BY total_sales DESC
LIMIT 5;


-- ============================================
-- 6. TIME-BASED ANALYSIS
-- ============================================

-- Daily revenue
SELECT DATE(event_date) AS day, SUM(amount) AS revenue
FROM user_events
WHERE event_type='purchase'
GROUP BY day
ORDER BY day;


-- ============================================
-- 7. USER BEHAVIOR ANALYSIS
-- ============================================

-- User activity tracking
SELECT user_id,
       MAX(CASE WHEN event_type='page_view' THEN 1 ELSE 0 END) AS viewed,
       MAX(CASE WHEN event_type='add_to_cart' THEN 1 ELSE 0 END) AS carted,
       MAX(CASE WHEN event_type='purchase' THEN 1 ELSE 0 END) AS purchased
FROM user_events
GROUP BY user_id;