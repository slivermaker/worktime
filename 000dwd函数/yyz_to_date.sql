CREATE OR REPLACE FUNCTION yyz_to_date(p_date_str IN VARCHAR2, p_format IN VARCHAR2) 
RETURN DATE
IS
  v_date DATE;
BEGIN
  -- 尝试转换日期
  v_date := TO_DATE(p_date_str, p_format);
  RETURN v_date;
EXCEPTION
  WHEN OTHERS THEN
    -- 发生任何错误都返回NULL
    RETURN NULL;
END yyz_to_date;
/