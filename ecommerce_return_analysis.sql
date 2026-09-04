CREATE TABLE ecommerce_returns (
    Order_ID VARCHAR(50),
    Product_ID VARCHAR(50),
    Product_Category VARCHAR(50),
    User_Location VARCHAR(50),
    Return_Status VARCHAR(30),
    Return_Reason VARCHAR(50),
    Discount_Applied DECIMAL(10,2),
    Order_Value DECIMAL(12,2),
    Order_Quantity INT,
    Shipping_Method VARCHAR(50),
    Payment_Method VARCHAR(50),
    Return_Cost DECIMAL(10,2),
    Profit_Loss DECIMAL(12,2),
    CO2_Emissions DECIMAL(10,2),
    CO2_Saved DECIMAL(10,2),
    Packaging_Waste DECIMAL(10,2),
    Waste_Avoided DECIMAL(10,2)
);

SELECT *
FROM ecommerce_returns;

SELECT COUNT(*) AS total_rows
FROM ecommerce_returns;

SELECT *
FROM ecommerce_returns
LIMIT 10;

COPY ecommerce_returns (
    Order_ID,
    Product_ID,
    Product_Category,
    User_Location,
    Return_Status,
    Return_Reason,
    Discount_Applied,
    Order_Value,
    Order_Quantity,
    Shipping_Method,
    Payment_Method,
    Return_Cost,
    Profit_Loss,
    CO2_Emissions,
    CO2_Saved,
    Packaging_Waste,
    Waste_Avoided
)
FROM 'C:/Users/devad/Desktop/DA Int/Ecommerce_Return_Analysis/ecommerce_returns_cleaned.csv'
DELIMITER ','
CSV HEADER;

SELECT
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE return_status = 'Returned') AS returned_orders,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE return_status = 'Returned')
        / COUNT(*),
        2
    ) AS return_rate
FROM ecommerce_returns;

SELECT
    product_category,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE return_status = 'Returned') AS returned_orders,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE return_status = 'Returned')
        / COUNT(*),
        2
    ) AS return_rate
FROM ecommerce_returns
GROUP BY product_category
ORDER BY return_rate DESC;

SELECT
    product_category,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE return_status = 'Returned') AS returned_orders,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE return_status = 'Returned')
        / COUNT(*),
        2
    ) AS return_rate
FROM ecommerce_returns
GROUP BY product_category
ORDER BY return_rate DESC;

SELECT
    return_reason,
    COUNT(*) AS returned_orders
FROM ecommerce_returns
WHERE return_status = 'Returned'
GROUP BY return_reason
ORDER BY returned_orders DESC;

SELECT
    product_category,
    return_reason,
    COUNT(*) AS returned_orders
FROM ecommerce_returns
WHERE return_status = 'Returned'
GROUP BY
    product_category,
    return_reason
ORDER BY
    product_category,
    returned_orders DESC;

SELECT
    product_id,
    product_category,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE return_status = 'Returned') AS returned_orders,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE return_status = 'Returned')
        / COUNT(*),
        2
    ) AS return_rate
FROM ecommerce_returns
GROUP BY
    product_id,
    product_category
HAVING COUNT(*) >= 10
ORDER BY return_rate DESC;





SELECT
    product_id,
    product_category,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE return_status = 'Returned') AS returned_orders,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE return_status = 'Returned')
        / COUNT(*),
        2
    ) AS return_rate
FROM ecommerce_returns
GROUP BY
    product_id,
    product_category
HAVING COUNT(*) >= 10
ORDER BY return_rate DESC
LIMIT 10;

SELECT
    user_location,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE return_status = 'Returned') AS returned_orders,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE return_status = 'Returned')
        / COUNT(*),
        2
    ) AS return_rate
FROM ecommerce_returns
GROUP BY user_location
ORDER BY return_rate DESC
LIMIT 10;



SELECT
    CASE
        WHEN discount_applied < 10 THEN '0-10%'
        WHEN discount_applied < 20 THEN '10-20%'
        WHEN discount_applied < 30 THEN '20-30%'
        WHEN discount_applied < 40 THEN '30-40%'
        ELSE '40-50%'
    END AS discount_group,

    COUNT(*) AS total_orders,

    COUNT(*) FILTER (
        WHERE return_status = 'Returned'
    ) AS returned_orders,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE return_status = 'Returned'
        ) / COUNT(*),
        2
    ) AS return_rate

FROM ecommerce_returns

GROUP BY
    CASE
        WHEN discount_applied < 10 THEN '0-10%'
        WHEN discount_applied < 20 THEN '10-20%'
        WHEN discount_applied < 30 THEN '20-30%'
        WHEN discount_applied < 40 THEN '30-40%'
        ELSE '40-50%'
    END

ORDER BY
    MIN(discount_applied);

SELECT
    ROUND(AVG(discount_applied), 2) AS average_discount,
    ROUND(MIN(discount_applied), 2) AS minimum_discount,
    ROUND(MAX(discount_applied), 2) AS maximum_discount
FROM ecommerce_returns;


SELECT
    CASE
        WHEN order_value < 1000 THEN '0-1000'
        WHEN order_value < 2000 THEN '1000-2000'
        WHEN order_value < 3000 THEN '2000-3000'
        WHEN order_value < 5000 THEN '3000-5000'
        ELSE '5000+'
    END AS order_value_group,

    COUNT(*) AS total_orders,

    COUNT(*) FILTER (
        WHERE return_status = 'Returned'
    ) AS returned_orders,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE return_status = 'Returned'
        ) / COUNT(*),
        2
    ) AS return_rate

FROM ecommerce_returns

GROUP BY
    CASE
        WHEN order_value < 1000 THEN '0-1000'
        WHEN order_value < 2000 THEN '1000-2000'
        WHEN order_value < 3000 THEN '2000-3000'
        WHEN order_value < 5000 THEN '3000-5000'
        ELSE '5000+'
    END

ORDER BY
    MIN(order_value);

SELECT
    ROUND(AVG(order_value), 2) AS average_order_value,
    ROUND(MIN(order_value), 2) AS minimum_order_value,
    ROUND(MAX(order_value), 2) AS maximum_order_value
FROM ecommerce_returns;


SELECT
    payment_method,
    COUNT(*) AS total_orders,

    COUNT(*) FILTER (
        WHERE return_status = 'Returned'
    ) AS returned_orders,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE return_status = 'Returned'
        ) / COUNT(*),
        2
    ) AS return_rate

FROM ecommerce_returns

GROUP BY payment_method

ORDER BY return_rate DESC;


SELECT
    shipping_method,
    COUNT(*) AS total_orders,

    COUNT(*) FILTER (
        WHERE return_status = 'Returned'
    ) AS returned_orders,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE return_status = 'Returned'
        ) / COUNT(*),
        2
    ) AS return_rate

FROM ecommerce_returns

GROUP BY shipping_method

ORDER BY return_rate DESC;

SELECT
    COUNT(*) AS returned_orders,
    ROUND(SUM(return_cost), 2) AS total_return_cost,
    ROUND(AVG(return_cost), 2) AS average_return_cost,
    ROUND(SUM(profit_loss), 2) AS total_profit_loss,
    ROUND(AVG(profit_loss), 2) AS average_profit_loss
FROM ecommerce_returns
WHERE return_status = 'Returned';

SELECT
    product_category,

    COUNT(*) AS returned_orders,

    ROUND(SUM(return_cost), 2) AS total_return_cost,

    ROUND(AVG(return_cost), 2) AS average_return_cost,

    ROUND(SUM(profit_loss), 2) AS total_profit_loss,

    ROUND(AVG(profit_loss), 2) AS average_profit_loss

FROM ecommerce_returns

WHERE return_status = 'Returned'

GROUP BY product_category

ORDER BY total_return_cost DESC;


SELECT
    return_reason,

    COUNT(*) AS returned_orders,

    ROUND(SUM(return_cost), 2) AS total_return_cost,

    ROUND(AVG(return_cost), 2) AS average_return_cost,

    ROUND(SUM(profit_loss), 2) AS total_profit_loss

FROM ecommerce_returns

WHERE return_status = 'Returned'

GROUP BY return_reason

ORDER BY total_return_cost DESC;




SELECT
    COUNT(*) AS returned_orders,
    ROUND(SUM(co2_emissions), 2) AS total_co2_emissions,
    ROUND(SUM(packaging_waste), 2) AS total_packaging_waste,
    ROUND(SUM(co2_saved), 2) AS total_co2_saved,
    ROUND(SUM(waste_avoided), 2) AS total_waste_avoided
FROM ecommerce_returns
WHERE return_status = 'Returned';



SELECT
    return_status,
    COUNT(*) AS total_orders,
    ROUND(AVG(co2_emissions), 2) AS avg_co2_emissions,
    ROUND(AVG(packaging_waste), 2) AS avg_packaging_waste,
    ROUND(AVG(co2_saved), 2) AS avg_co2_saved,
    ROUND(AVG(waste_avoided), 2) AS avg_waste_avoided
FROM ecommerce_returns
GROUP BY return_status
ORDER BY return_status;



SELECT
    product_category,
    COUNT(*) AS total_orders,
    ROUND(SUM(co2_emissions), 2) AS total_co2_emissions,
    ROUND(SUM(co2_saved), 2) AS total_co2_saved,
    ROUND(SUM(packaging_waste), 2) AS total_packaging_waste,
    ROUND(SUM(waste_avoided), 2) AS total_waste_avoided
FROM ecommerce_returns
GROUP BY product_category
ORDER BY total_co2_emissions DESC;