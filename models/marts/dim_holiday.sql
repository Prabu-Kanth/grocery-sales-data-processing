WITH holiday_clean AS (
    SELECT
        date,
        CONCAT_WS(
            ' | ',
            SORT_ARRAY(COLLECT_SET(TRIM(type)))
        ) AS holiday_type,
        CONCAT_WS(
            ' | ',
            SORT_ARRAY(COLLECT_SET(TRIM(locale)))
        ) AS holiday_locale,
        CONCAT_WS(
            ' | ',
            SORT_ARRAY(COLLECT_SET(TRIM(locale_name)))
        ) AS holiday_locale_name,
        CONCAT_WS(
            ' | ',
            SORT_ARRAY(COLLECT_SET(TRIM(description)))
        ) AS holiday_description,
        MAX(
            CASE
                WHEN transferred = TRUE THEN TRUE
                ELSE FALSE
            END
        ) AS holiday_transferred
    FROM {{ ref('stg_holidays_events') }}
    GROUP BY date
)

SELECT
    ROW_NUMBER() OVER (
        ORDER BY date
    ) AS holiday_key,
    date AS holiday_date,
    holiday_type,
    holiday_locale,
    holiday_locale_name,
    holiday_description,
    holiday_transferred
FROM holiday_clean
