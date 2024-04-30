with TESTE_2214 as (
  SELECT A.*,B.NOME,B.CGCCFO FROM HUBDADOS.CORPORERM.TMOV A
  INNER JOIN HubDados.CorporeRM.FCFO B
  ON A.CODCFO = B.CODCFO
  WHERE CODTMV LIKE '2.2.14' AND [STATUS] <> 'C' AND YEAR(DATAEMISSAO) >= 2022
  )

, TESTE_2123 AS (
  SELECT A.*,B.NOME FROM HUBDADOS.CORPORERM.TMOV A
  INNER JOIN HubDados.CorporeRM.FCFO B
  ON A.CODCFO = B.CODCFO
  WHERE CODTMV LIKE '2.1.23' AND [STATUS] <> 'C' AND YEAR(DATAEMISSAO) >= 2022
  )

,B2B AS (

    SELECT  a.[Cod.Contrato],
        a.Processo,
        a.Objeto,
        a.CNPJ,
        Fornecedor,
        A.[Status],
        Modalidade,
        Gerente,
        Gestor,
        [Gestor UAPO],
        A.Departamento,
        [R$ Total Contrato] as 'R$ Total Contrato',
        [Data Inicio] as 'Data Inicio',
        [Data Fim] as 'Data Fim',
        [Data Contrato] as 'Data Contrato',
        DATEDIFF(DAY, GETDATE(), [Data Fim]) as 'Dias Vencimento',
        sum(ZUTICONTRATOSANALITICO.VALORPAGO) as 'R$ Pago',
        sum(ZUTICONTRATOSANALITICO.VALORCOMPROMETIDO) as 'R$ Comprometido',
        sum(ZUTICONTRATOSANALITICO.VALORREALIZADO) as 'R$ Realizado',
        [R$ Total Contrato] - SUM(ISNULL(ZUTICONTRATOSANALITICO.VALORPAGO,0) + ISNULL(ZUTICONTRATOSANALITICO.VALORREALIZADO,0) + ISNULL(ZUTICONTRATOSANALITICO.VALORCOMPROMETIDO,0)) as 'Saldo do Contrato' FROM (
        SELECT distinct
          TCNT.CODIGOCONTRATO as 'Cod.Contrato',
          PAINEL.PROCESSO as 'Processo',
          PAINEL.OBJETO as 'Objeto',
          PAINEL.CNPJ as 'CNPJ',
          TRIM(PAINEL.FORNECEDOR) as 'Fornecedor',
          PAINEL.DEPARTAMENTO as 'Departamento',
          PAINEL.MODALIDADE as 'Modalidade', 
          TVEN.NOME as 'Gerente',
          TVEN2.NOME as 'Gestor',
          TCNTCOMPL.GESTOR_SUP as 'Gestor UAPO',
          TCNT.VALORCONTRATO as 'R$ Total Contrato',  
          tcnt.DATAINICIO as 'Data Inicio',
          tcnt.DATAFIM as 'Data Fim',
          tcnt.DATACONTRATO as 'Data Contrato',
          TCNT.CODSTACNT as 'Status', 
          TSTACNT.DESCRICAO
          FROM [HubDados].[CorporeRM].[TCNT] TCNT      

          INNER JOIN [HubDados].[CorporeRM].[TSTACNT] TSTACNT
          ON TCNT.CODSTACNT COLLATE LATIN1_GENERAL_CS_AI = TSTACNT.CODSTACNT      
          INNER JOIN [HubDados].[PainelContrato].[Detalhe] PAINEL
          on TCNT.CODIGOCONTRATO COLLATE LATIN1_GENERAL_CS_AI = Painel.NRO_CONTRATO     
          INNER JOIN [HubDados].[CorporeRM].[TVEN] TVEN
          on TVEN.CODVEN COLLATE LATIN1_GENERAL_CS_AI  = TCNT.CODVEN      
          INNER JOIN [HubDados].[CorporeRM].[TVEN] TVEN2
          on TVEN2.CODVEN COLLATE LATIN1_GENERAL_CS_AI  = TCNT.CODVEN2
          INNER JOIN [HubDados].[CorporeRM].[TCNTCOMPL] TCNTCOMPL
          ON TCNTCOMPL.IDCNT = TCNT.IDCNT
          ) A

          INNER JOIN [HubDados].[CorporeRM].[ZUTICONTRATOSANALITICO] ZUTICONTRATOSANALITICO
          on a.[Cod.Contrato] COLLATE LATIN1_GENERAL_CS_AI = ZUTICONTRATOSANALITICO.CODIGOCONTRATO 


          WHERE MODALIDADE LIKE 'CONTRATOS B2B'

      group by 
          a.[Cod.Contrato],
          a.Processo,
          a.Objeto,
          a.CNPJ,
          Fornecedor,
          Departamento,
          Modalidade,
          Gerente,
          Gestor,
          [Gestor UAPO],
          [R$ Total Contrato],
          [Data Inicio],
          [Data Fim],
          a.[data Contrato],
          a.[Status],
          DESCRICAO
    )

SELECT *  FROM TESTE_2214