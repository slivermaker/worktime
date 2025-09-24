
CREATE TABLE ADS_REPORT_RANK (
    NAME VARCHAR2(2000),
    CNT NUMBER,
    TOTAL_AMOUNT NUMBER,
    RANK_ZS NUMBER,
    RANK_DS NUMBER,
    ETL_CRT_DT DATE DEFAULT SYSDATE,
    ETL_UPD_DT DATE DEFAULT SYSDATE
);

COMMENT ON COLUMN ADS_REPORT_RANK.NAME IS '姓名';
COMMENT ON COLUMN ADS_REPORT_RANK.CNT IS '次数';
COMMENT ON COLUMN ADS_REPORT_RANK.TOTAL_AMOUNT IS '总金额';
COMMENT ON COLUMN ADS_REPORT_RANK.RANK_ZS IS '正数排名';
COMMENT ON COLUMN ADS_REPORT_RANK.RANK_DS IS '倒数排名';
COMMENT ON COLUMN ADS_REPORT_RANK.ETL_CRT_DT IS 'ETL创建时间';
COMMENT ON COLUMN ADS_REPORT_RANK.ETL_UPD_DT IS 'ETL更新时间';


INSERT INTO ADS_REPORT_RANK (
    NAME,
    CNT,
    TOTAL_AMOUNT,
    RANK_ZS,
    RANK_DS
)

with new_date as(
     select  trunc(yyz_to_date(jbrq,'YY.MM.DD'),'MM') AS PERIOD,
             jbr AS NAME,
             ID,
             jlje,
             jbdw
             
             FROM ODS_ERP.ods_nbzlycb 
     WHERE trunc(yyz_to_date(jbrq,'YY.MM.DD'),'MM') >= TRUNC(SYSDATE-1,'MM')
)
,
DWS_TMP AS(
     select   name ,count(id) cnt,sum(jlje) total_amount
      from new_date
      where jbdw='蝶阀止回阀装配线' 
      group by NAME
)


SELECT NAME,--姓名
       CNT,--次数
       TOTAL_AMOUNT--总金额
       , RANK()OVER(ORDER BY CNT DESC,TOTAL_AMOUNT DESC) RANK_ZS--正数排名
       ,RANK() OVER (ORDER BY CNT,TOTAL_AMOUNT) AS rank_DS--倒数排名
       
FROM DWS_TMP