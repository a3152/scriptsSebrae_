    WITH PLANOCONTAS AS (SELECT * FROM [FINANCA].[dbo].[planoContas])

,BALANCETE AS (SELECT * FROM [FINANCA].[dbo].[_rmBALANCETE]   WHERE LEN(CONTA)>10)
  
, CREDITO AS ( SELECT
        A.CONTA
        ,A.Descricao
        ,A.Anterior
        ,A.DEBITOS
        ,A.CREDITOS
        ,A.MOVIMENTO
        ,A.SALDOATUAL
        ,A.dataOrcamento
        ,FECHAMENTO = 'CSO - CONTR. SOCIAL ORDINÁRIA'        
        FROM [BALANCETE] A      
        where Conta like '4.1.1.1.01%' OR CONTA LIKE '4.1.1.6%'
        )


select MONTH(dataOrcamento) AS MES ,fechamento, format(sum(movimento)*-1,'c','pt-br') as Soma from CREDITO group by FECHAMENTO,dataOrcamento

        