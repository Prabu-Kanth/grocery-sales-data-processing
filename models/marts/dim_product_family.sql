WITH products AS (
    SELECT DISTINCT
        family AS product_family
    FROM {{ ref('int_train_sales') }}
    WHERE family IS NOT NULL
)

SELECT
    ROW_NUMBER() OVER (
        ORDER BY product_family
    ) AS product_family_key,
    product_family
FROM products
