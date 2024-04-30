    
WITH PLANOCONTAS AS (SELECT * FROM [FINANCA].[dbo].[planoContas])

,BALANCETE AS (SELECT * FROM [FINANCA].[dbo].[_rmBALANCETE]   WHERE LEN(CONTA)>10)
  
, PESSOAL AS ( SELECT
        A.CONTA
        ,A.Descricao
        ,A.Anterior
        ,A.DEBITOS
        ,A.CREDITOS
        ,A.MOVIMENTO
        ,A.SALDOATUAL
        ,A.dataOrcamento
        ,FECHAMENTO = 'PESSOAL, ENC. E BEN.SOCIAIS'        
        FROM [BALANCETE] A   
        WHERE CONTA LIKE '3.1.1%')


select MONTH(dataOrcamento) AS MES ,fechamento, format(sum(movimento),'c','pt-br') as Soma from PESSOAL group by FECHAMENTO,dataOrcamento

