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
        ,FECHAMENTO = 'OUTRAS RECEITAS'        
        FROM [BALANCETE] A      
        where Conta like '4.1.5.3%'
        or Conta like '4.1.4.1%' 
        or Conta like '4.1.5.1%' 
        or Conta like '2.9.6%' 
        or Conta like '6.2.2.1%'
        or Conta like '4.1.4.6%'    
        )


select MONTH(dataOrcamento) AS MES ,fechamento, format(sum(movimento)*-1,'c','pt-br') as Soma from CREDITO group by FECHAMENTO,dataOrcamento

