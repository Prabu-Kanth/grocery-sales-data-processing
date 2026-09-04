WITH stores AS (
    SELECT DISTINCT
        store_nbr,
        city,
        state,
        type AS store_type,
        cluster
    FROM {{ ref('stg_stores') }}
    WHERE store_nbr IS NOT NULL
)

SELECT
    ROW_NUMBER() OVER (
        ORDER BY store_nbr
    ) AS store_key,
    store_nbr,
    city,
    state,
    store_type,
    cluster
FROM stores
