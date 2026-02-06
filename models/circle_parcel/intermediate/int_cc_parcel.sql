WITH parcel_product AS (
    SELECT
        parcel_id
        , SUM(quantity) as qty
        , COUNT(*) as nb_model
    FROM {{ ref("stg_parcel_product")}}
    GROUP BY parcel_id
)

SELECT
    p.*
    , EXTRACT(MONTH from date_purchase) as month_purchase
    , CASE
        WHEN date_cancelled is not null THEN 'Cancelled' --deliver, shipped, in progress
        WHEN date_delivery is not null THEN 'Delivered' --shipped, in progress
        WHEN date_shipping is not null THEN 'In transit' --in progress
        ELSE 'In progress'
      END as status 
    , DATE_DIFF(date_shipping, date_purchase, DAY) as expedition_time
    , DATE_DIFF(date_delivery, date_shipping, DAY) as transport_time
    , DATE_DIFF(date_delivery, date_purchase, DAY) as delivery_time
    , IF(DATE_DIFF(date_delivery, date_purchase, DAY)>5, 1, 0) as delay
    , qty
    , nb_model
FROM {{ ref("stg_parcel")}} as p
JOIN parcel_product as pp
    on p.parcel_id = pp.parcel_id
