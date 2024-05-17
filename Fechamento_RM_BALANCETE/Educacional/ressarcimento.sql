
  DECLARE @dt date = getdate();
  use HubDados;
    WITH TMOV AS (
      SELECT *
      FROM CORPORERM.TMOV
          WHERE CODTMV LIKE '1.2.17'
          AND YEAR(DATAEMISSAO) = YEAR(@DT)
          AND [STATUS] NOT IN ('C', 'R')
          )
        ,
        TVEN AS (
          SELECT CODVEN,NOME FROM CorporeRM.TVEN
        )
        ,
        ITM AS (
          SELECT a.*
          ,C.NOMEFANTASIA
          ,D.NOME AS VEN1
          ,B.CODVEN2
          ,B.Historico
          ,B.[STATUS] AS ST_MOV
          ,B.DATACRIACAO
            FROM CorporeRM.TITMMOV A
            INNER JOIN TMOV B
            ON A.IDMOV = B.IDMOV
            INNER JOIN CorporeRM.TPRD c
            ON A.IDPRD = C.IDPRD
            LEFT JOIN TVEN D
            ON B.CODVEN1 = D.CODVEN
            

        )


    SELECT * FROM ITM WHERE NOMEFANTASIA NOT IN ('VIAGENS NACIONAIS - FUNCIONÁRIOS', 'SERVIÇO DE FRETE E CARRETO - FUNCIONÁRIOS')
