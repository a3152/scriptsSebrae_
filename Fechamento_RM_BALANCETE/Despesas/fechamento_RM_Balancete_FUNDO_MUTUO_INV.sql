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
        ,FECHAMENTO = 'FUNDO MUTUO INV. EMPRESAS EMERG.'        
        FROM [BALANCETE] A   
        WHERE CONTA LIKE '5.2.5.2.01.001')


select MONTH(dataOrcamento) AS MES ,fechamento, format(sum(movimento),'c','pt-br') as Soma from CREDITO group by FECHAMENTO,dataOrcamento

