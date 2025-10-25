create table ADS_PRO_YEAR_MKFM_BIKB (
       period date,
       period_type varchar(50),
       weight_t number,
       etl_crt_dt DATE DEFAULT SYSDATE,
       etl_upd_dt DATE DEFAULT SYSDATE

)

SELECT 
    trunc(to_date(rq,'YY.MM.DD'),'MM') AS PERIOD ,
    'M' AS PERIOD_TYPE
    AVG(ZL)/1000 AS ZL
FROM production_table
GROUP BY 
    trunc(to_date(rq,'YY.MM.DD'),'MM')
