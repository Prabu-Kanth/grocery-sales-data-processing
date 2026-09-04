WITH transaction_context AS (
    SELECT DISTINCT
        transaction_date,
        store_nbr,
        transactions
    FROM {{ ref('int_sales') }}
    WHERE transaction_date IS NOT NULL
      AND store_nbr IS NOT NULL
)

SELECT
    ROW_NUMBER() OVER (
        ORDER BY transaction_date, store_nbr
    ) AS transaction_context_key,
    transaction_date,
    store_nbr,
    transactions
FROM transaction_context
