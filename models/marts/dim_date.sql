WITH dates AS (
    SELECT DISTINCT
        sales_date
    FROM {{ ref('int_sales_complete') }}
    WHERE sales_date IS NOT NULL
)

SELECT
    ROW_NUMBER() OVER (
        ORDER BY sales_date
    ) AS date_key,
    sales_date AS date,
    YEAR(sales_date) AS year,
    MONTH(sales_date) AS month,
    DAY(sales_date) AS day,
    WEEKOFYEAR(sales_date) AS week_of_year,
    DAYOFWEEK(sales_date) AS day_of_week
FROM dates
