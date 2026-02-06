SELECT
    p.parcel_id
    , pp.model_name
    , p.parcel_tracking
    , p.transporter
    , p.priority
    , p.date_purchase
    , p.date_shipping
    , p.date_delivery
    , p.date_cancelled
    , p.status
    , p.qty
FROM {{ ref("int_cc_parcel")}} as p
JOIN {{ ref("stg_parcel_product")}} as pp
    on p.parcel_id = pp.parcel_id