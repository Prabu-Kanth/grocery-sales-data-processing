WITH oil_prices AS (
    SELECT DISTINCT
        date,
        oil_price
    FROM {{ ref('stg_oil') }}
    WHERE date IS NOT NULL
)

SELECT
    ROW_NUMBER() OVER (
        ORDER BY date
    ) AS oil_key,
    date AS oil_date,
    oil_price
FROM oil_prices
