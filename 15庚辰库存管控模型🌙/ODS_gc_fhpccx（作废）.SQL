SELECT
	ddh,
	fhdh,
	ddlx,
	fhdsxsj,
	khmc,
	zzkh,
	wlbm,
	CAST ( SL AS FLOAT ) sl,
	CAST ( XSJG AS FLOAT ) xsjg,
	CAST ( yf AS FLOAT ) yf,
	CAST ( xsje AS FLOAT ) xsje,
	bm,
	ywy,
	sheng,
	shi,
	qx,
	ckbj,
	pcbj,
	ckrq,
	qy,
	khfl,
	cyfs,
	jjyf,
	jjje,
	qtjj,
	zhtwhsj,
	real_transport_area 
FROM
	OPENQUERY ( imsprod, 'select * from gc_fhpccx where 2>1 and ckrq>=''25.07.23'' and ckrq<=''25.07.24''  and pcbj=''Y''  and CKbj=''Y''  ' ) m 
WHERE
	2 > 1