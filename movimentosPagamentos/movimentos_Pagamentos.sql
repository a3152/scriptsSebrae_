
	WITH DEPTO AS (SELECT * FROM HubDados.CorporeRM.GDEPTO WHERE CODFILIAL = 1)
    
        SELECT 
            CAMPOLIVRE1 as 'Código do Contrato'
            ,C.CAMPOLIVRE AS 'Nº Processo'
            ,D.MODALIDADE
            ,E.DESCRICAO AS 'MODALIDADE_DESC'
            ,C.VALORCONTRATO
            ,CLASSIFICA = NULL
            ,F.NOMEFANTASIA
            ,F.CGCCFO AS 'CNPJ'
            ,A.NUMEROMOV AS 'Nº NOTA FISCAL'
            ,A.VALORBRUTO
            ,A.CODDEPARTAMENTO
            ,H.NOME AS 'DEPARTAMENTO'
            ,A.CODVEN1
            ,G.NOME AS 'GESTOR'
            ,A.CODVEN3
            ,I.NOME AS 'GERENTE'
            ,IDMOV
            ,a.CODTMV
            ,b.DESCMOV
            ,A.DATACRIACAO
            ,A.DATAEMISSAO
            ,A.DATAMOVIMENTO
            ,A.DATAEXTRA1
            ,A.DATAEXTRA2
            ,A.DATAPROCESSAMENTO
            ,A.DATASAIDA
            ,A.DATACANCELAMENTOMOV
            ,a.STATUS
        FROM CorporeRM.TMOV a
            left JOIN FINANCA.DBO.descricao_CODTMV B
            ON A.CODTMV = B.CODTMV

            LEFT JOIN HubDados.CorporeRM.TCNT C
            ON A.CAMPOLIVRE1 COLLATE Latin1_General_CI_AI = C.CODIGOCONTRATO

            LEFT JOIN HubDados.CorporeRM.TCNTCOMPL D	
            ON C.IDCNT  =  D.IDCNT

            LEFT JOIN FINANCA.DBO.Modalidade$ E
            ON D.MODALIDADE COLLATE Latin1_General_CI_AI = E.CODINTERNO

            LEFT JOIN HubDados.CorporeRM.FCFO F
            ON A.CODCFO = F.CODCFO

            LEFT JOIN HubDados.CorporeRM.TVEN G
            ON A.CODVEN1 = G.CODVEN

            LEFT JOIN DEPTO H
            ON A.CODDEPARTAMENTO COLLATE Latin1_General_CI_AI = H.CODDEPARTAMENTO

            LEFT JOIN HubDados.CorporeRM.TVEN i
            ON A.CODVEN3 = I.CODVEN
        WHERE
            a.CODTMV in ('1.2.05','1.2.08','1.2.10','1.2.11','1.2.14', '1.2.21', '1.2.23')
            
            and A.DATACRIACAO BETWEEN '2023-01-01 00:00:00.000' AND '2024-04-30 00:00:00.000';
        

