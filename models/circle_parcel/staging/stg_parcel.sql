with source as (
    SELECT
        *
    FROM {{ source("circle", "parcel")}}
)
, renamed as (
    SELECT
        Parcel_id as parcel_id,
        Parcel_tracking as parcel_tracking,
        Transporter as transporter,
        Priority as priority,
        Date_purCHase as date_purchase,
        Date_sHIpping as date_shipping,
        DATE_delivery as date_delivery,
        DaTeCANcelled as date_cancelled
    FROM source
)

SELECT
    *
FROM renamed