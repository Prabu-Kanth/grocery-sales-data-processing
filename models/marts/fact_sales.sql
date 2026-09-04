SELECT
    s.id AS sales_key,

    d.date_key,
    st.store_key,
    p.product_family_key,
    h.holiday_key,
    o.oil_key,
    tc.transaction_context_key,

    s.sales,
    s.onpromotion

FROM {{ ref('int_sales_complete') }} s

LEFT JOIN {{ ref('dim_date') }} d
    ON s.sales_date = d.date

LEFT JOIN {{ ref('dim_store') }} st
    ON s.store_nbr = st.store_nbr

LEFT JOIN {{ ref('dim_product_family') }} p
    ON s.family = p.product_family

LEFT JOIN {{ ref('dim_holiday') }} h
    ON s.sales_date = h.holiday_date

LEFT JOIN {{ ref('dim_oil_price') }} o
    ON s.sales_date = o.oil_date

LEFT JOIN {{ ref('dim_transaction_context') }} tc
    ON s.sales_date = tc.transaction_date
    AND s.store_nbr = tc.store_nbr
