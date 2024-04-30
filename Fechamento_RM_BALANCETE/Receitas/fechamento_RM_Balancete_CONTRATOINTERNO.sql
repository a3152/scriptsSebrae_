WITH PLANOCONTAS AS (SELECT * FROM [FINANCA].[dbo].[planoContas])
,BALANCETE AS (SELECT * FROM [FINANCA].[dbo].[_rmBALANCETE]   WHERE LEN(CONTA)>10)
,CONTRATO AS ( SELECT
        A.CONTA
        ,A.Descricao
        ,A.Anterior
        ,A.DEBITOS
        ,A.CREDITOS
        ,A.MOVIMENTO
        ,A.SALDOATUAL
        ,A.dataOrcamento
        ,FECHAMENTO = 'CONTRATO INTERNO'
        FROM [BALANCETE] A      
        where  CONTA LIKE '4.1.3.2.02%'
        )
    

SELECT MONTH(dataOrcamento) AS MES 
,fechamento
,format(sum(movimento)*-1,'c','pt-br') as Soma
from CONTRATO group by FECHAMENTO,dataOrcamento

