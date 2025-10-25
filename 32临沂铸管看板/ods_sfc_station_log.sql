CREATE TABLE ods_sfc_station_log (
    ID CHAR(32),
    WORK_CENTER VARCHAR2(2000),
    PRODUCTION_PROCESS VARCHAR2(2000),
    WORK_STATION VARCHAR2(2000),
    ENGRAVING_NUMBER VARCHAR2(2000),
    TUBE_NUMBER VARCHAR2(2000),
    PRODUCTION_PARAM VARCHAR2(2000),
    PARAM_VALUE VARCHAR2(2000),
    PARAM_TYPE VARCHAR2(2000),
    UNIT VARCHAR2(2000),
    COLLECTION_TIME DATE,
    EXCEPTION_RESON CLOB,
    CREATE_USER VARCHAR2(2000),
    CREATE_TIME DATE,
    UPDATE_USER VARCHAR2(2000),
    UPDATE_TIME DATE,
    IS_DELETE CHAR(1),
    ACCOUNTINGSET_NAME VARCHAR2(2000),
    ACCOUNTINGSET_CODE VARCHAR2(2000),
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);


COMMENT ON COLUMN ods_sfc_station_log.ID IS '主键ID';
COMMENT ON COLUMN ods_sfc_station_log.WORK_CENTER IS '工作中心，来源于工站基本信息的工作中心';
COMMENT ON COLUMN ods_sfc_station_log.PRODUCTION_PROCESS IS '生产工序，来源于工站基本信息的生产工序';
COMMENT ON COLUMN ods_sfc_station_log.WORK_STATION IS '工站，与设备号保持一致';
COMMENT ON COLUMN ods_sfc_station_log.ENGRAVING_NUMBER IS '刻录号，产品唯一标识';
COMMENT ON COLUMN ods_sfc_station_log.TUBE_NUMBER IS '管号';
COMMENT ON COLUMN ods_sfc_station_log.PRODUCTION_PARAM IS '生产参数，来源于采集参数配置表';
COMMENT ON COLUMN ods_sfc_station_log.PARAM_VALUE IS '生产参数值，IOT采集数据值';
COMMENT ON COLUMN ods_sfc_station_log.PARAM_TYPE IS '参数类型，来源于采集参数配置表';
COMMENT ON COLUMN ods_sfc_station_log.UNIT IS '单位，来源于采集参数配置表';
COMMENT ON COLUMN ods_sfc_station_log.COLLECTION_TIME IS '采集时间，IOT时间';
COMMENT ON COLUMN ods_sfc_station_log.EXCEPTION_RESON IS '异常详细原因';
COMMENT ON COLUMN ods_sfc_station_log.CREATE_USER IS '创建人';
COMMENT ON COLUMN ods_sfc_station_log.CREATE_TIME IS '创建时间';
COMMENT ON COLUMN ods_sfc_station_log.UPDATE_USER IS '修改人';
COMMENT ON COLUMN ods_sfc_station_log.UPDATE_TIME IS '修改时间';
COMMENT ON COLUMN ods_sfc_station_log.IS_DELETE IS '是否删除';
COMMENT ON COLUMN ods_sfc_station_log.ACCOUNTINGSET_NAME IS '账套名称';
COMMENT ON COLUMN ods_sfc_station_log.ACCOUNTINGSET_CODE IS '账套编号';
COMMENT ON COLUMN ods_sfc_station_log.etl_crt_dt IS '';
COMMENT ON COLUMN ods_sfc_station_log.etl_upd_dt IS '';





SELECT 
    t1.ENGRAVING_NUMBER,
    t1.PARAM_VALUE AS x_val,
    t2.PARAM_VALUE AS y_val,
    GREATEST(t1.CREATE_TIME, t2.CREATE_TIME) AS latest_collection_time
FROM 
    ODS_SFC_STATION_LOG t1
JOIN 
    ODS_SFC_STATION_LOG t2 ON t1.ENGRAVING_NUMBER = t2.ENGRAVING_NUMBER 
                          AND t1.TUBE_NUMBER = t2.TUBE_NUMBER
                          AND t1.CREATE_TIME = t2.CREATE_TIME
WHERE 
    t1.PARAM_TYPE = 'realTimeLength' 
    AND t2.PARAM_TYPE = 'realTimeThickness'




-----------------------------------------------------
WITH latest_records AS (
    SELECT 
        ENGRAVING_NUMBER,
        TUBE_NUMBER,
        CREATE_TIME,
        PARAM_TYPE,
        PARAM_VALUE,
        ROW_NUMBER() OVER (
            PARTITION BY ENGRAVING_NUMBER ,PARAM_TYPE
            ORDER BY CREATE_TIME DESC
        ) AS rn
    FROM 
        ODS_SFC_STATION_LOG
    WHERE 
        PARAM_TYPE IN ('realTimeLength', 'realTimeThickness')
),
filtered_data AS (
    SELECT * FROM latest_records WHERE rn = 1
)
,tmp_dwd as (
SELECT 
    t1.ENGRAVING_NUMBER,
    t1.PARAM_VALUE AS x_val,
    t2.PARAM_VALUE AS y_val,
    GREATEST(t1.CREATE_TIME, t2.CREATE_TIME) AS latest_collection_time
FROM 
    filtered_data t1
JOIN 
    filtered_data t2 ON t1.ENGRAVING_NUMBER = t2.ENGRAVING_NUMBER 
                  --  AND t1.TUBE_NUMBER = t2.TUBE_NUMBER
                    AND t1.CREATE_TIME = t2.CREATE_TIME
WHERE 
    t1.PARAM_TYPE = 'realTimeLength' 
    AND t2.PARAM_TYPE = 'realTimeThickness';

)
parsed_data AS (
    SELECT 
        d.ENGRAVING_NUMBER,
        LEVEL AS position,
        TO_NUMBER(TRIM(REGEXP_SUBSTR(REPLACE(REPLACE(d.x_val, '[', ''), ']', ''), '[^,]+', 1, LEVEL))) AS x_value,
        TO_NUMBER(TRIM(REGEXP_SUBSTR(REPLACE(REPLACE(d.y_val, '[', ''), ']', ''), '[^,]+', 1, LEVEL))) AS y_value
    FROM ENGRAVING_NUMBER d
    CONNECT BY 
        PRIOR ENGRAVING_NUMBER = ENGRAVING_NUMBER AND
        LEVEL <= LEAST(
            REGEXP_COUNT(REPLACE(REPLACE(d.x_val, '[', ''), ']', ''), '[^,]+'),
            REGEXP_COUNT(REPLACE(REPLACE(d.y_val, '[', ''), ']', ''), '[^,]+')
        ) AND
        PRIOR SYS_GUID() IS NOT NULL
)
SELECT 
    ENGRAVING_NUMBER,
    position,
    x_value,
    y_value
FROM parsed_data
