WITH PLANOCONTAS AS (SELECT * FROM [FINANCA].[dbo].[planoContas])
    , BALANCETE AS (SELECT * FROM [FINANCA].[dbo].[_rmBALANCETE]   WHERE LEN(CONTA)>10)
    -- CRIAR CTES (COMMOM TABLE EXPRESSION) CONTABEIS --
    , CSO AS ( SELECT --     CSO RECEITAS
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
    , CSN AS ( SELECT -- CSN RECEITAS
        A.CONTA
        ,A.Descricao
        ,A.Anterior
        ,A.DEBITOS
        ,A.CREDITOS
        ,A.MOVIMENTO
        ,A.SALDOATUAL
        ,A.dataOrcamento
        ,FECHAMENTO = 'CSN - CONTR. SOCIAL NACIONAL'        
        FROM [BALANCETE] A      
        where Conta like '4.1.1.2%' 
        )
    , CONVENIO AS ( SELECT -- CONVENIOS
        A.CONTA
        ,A.Descricao
        ,A.Anterior
        ,A.DEBITOS
        ,A.CREDITOS
        ,A.MOVIMENTO
        ,A.SALDOATUAL
        ,A.dataOrcamento
        ,FECHAMENTO = 'CONVÊNIOS, SUBV. E AUXÍLIOS'        
        FROM [BALANCETE] A      
        where  CONTA LIKE '4.1.3.1%' 
        )
    , INTERNO AS ( SELECT -- CONTRATO INTERNO
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
    , ALIENACAO AS ( SELECT -- ALIENACAO
        A.CONTA
        ,A.Descricao
        ,A.Anterior
        ,A.DEBITOS
        ,A.CREDITOS
        ,A.MOVIMENTO
        ,A.SALDOATUAL
        ,A.dataOrcamento
        ,FECHAMENTO = 'ALIENAÇÃO DE BENS'   
        FROM [BALANCETE] A      
        where  CONTA LIKE '4.1.5.4.02.001'
        )
    , EMPRESAS AS ( SELECT -- EMPRESAS BENEFICIADAS
        A.CONTA
        ,A.Descricao
        ,A.Anterior
        ,A.DEBITOS
        ,A.CREDITOS
        ,A.MOVIMENTO
        ,A.SALDOATUAL
        ,A.dataOrcamento
        ,FECHAMENTO = 'EMPRESAS BENEFICIADAS'        
        FROM [BALANCETE] A      
        where Conta like '4.1.2%' 
        )
    , OUTRAS AS ( SELECT -- OUTRAS RECEITAS --
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
    , CREDITO AS ( SELECT   -- DESPESAS CREDITO
        A.CONTA
        ,A.Descricao
        ,A.Anterior
        ,A.DEBITOS
        ,A.CREDITOS
        ,A.MOVIMENTO
        ,A.SALDOATUAL
        ,A.dataOrcamento
        ,FECHAMENTO = 'PROGRAMA DE CRÉDITO ORIENTADO'        
        FROM [BALANCETE] A   
        WHERE CONTA LIKE '5.2.5.3%')
    , CUSTOS AS ( SELECT -- CUSTOS E DESPESAS
        A.CONTA
        ,A.Descricao
        ,A.Anterior
        ,A.DEBITOS
        ,A.CREDITOS
        ,A.MOVIMENTO
        ,A.SALDOATUAL
        ,A.dataOrcamento
        ,FECHAMENTO = 'CUSTO/DESP.OPERACIONALIZAÇÃO'        
        FROM [BALANCETE] A      
        WHERE CONTA like '3.1.3%' )
    , DEPOSITOS AS ( SELECT -- DEPOSITOS JUDICIAIS
        A.CONTA
        ,A.Descricao
        ,A.Anterior
        ,A.DEBITOS
        ,A.CREDITOS
        ,A.MOVIMENTO
        ,A.SALDOATUAL
        ,A.dataOrcamento
        ,FECHAMENTO = 'DEPÓSITOS JUDICIAIS'        
        FROM [BALANCETE] A   
        WHERE CONTA like '5.2.4.1.01%' )
    , ENCARGOS AS ( SELECT -- ENCARGOS DIVERSOS
        A.CONTA
        ,A.Descricao
        ,A.Anterior
        ,A.DEBITOS
        ,A.CREDITOS
        ,A.MOVIMENTO
        ,A.SALDOATUAL
        ,A.dataOrcamento
        ,FECHAMENTO = 'ENCARGOS DIVERSOS'        
        FROM [BALANCETE] A   
        WHERE CONTA like '3.1.4.1%' or CONTA like '3.1.4.2%')
    , FUNDO AS ( SELECT -- FUNDO MUTUO EMPRESAS EMERGENTES
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
    , IMOBILIZADO AS ( SELECT -- IMOBILIZADO
        A.CONTA
        ,A.Descricao
        ,A.Anterior
        ,A.DEBITOS
        ,A.CREDITOS
        ,A.MOVIMENTO
        ,A.SALDOATUAL
        ,A.dataOrcamento
        ,FECHAMENTO = 'IMOBILIZADO'        
        FROM [BALANCETE] A   
        WHERE CONTA LIKE '5.2.2.2%')
    , BENS AS ( SELECT -- INVESTIMENTO - BENS IMÓVEIS
        A.CONTA
        ,A.Descricao
        ,A.Anterior
        ,A.DEBITOS
        ,A.CREDITOS
        ,A.MOVIMENTO
        ,A.SALDOATUAL
        ,A.dataOrcamento
        ,FECHAMENTO = 'INVESTIMENTO - BENS IMÓVEIS'        
        FROM [BALANCETE] A   
        WHERE CONTA LIKE '5.2.2.1%')
    , LIBERA AS ( SELECT -- LIBERAÇÕES DE CONVENIOS
        A.CONTA
        ,A.Descricao
        ,A.Anterior
        ,A.DEBITOS
        ,A.CREDITOS
        ,A.MOVIMENTO
        ,A.SALDOATUAL
        ,A.dataOrcamento
        ,FECHAMENTO = 'LIBERACOES DE CONVENIOS'        
        FROM [BALANCETE] A   
        WHERE CONTA LIKE '5.1.1.2%')
    , PESSOAL AS ( SELECT -- PESSOAL, ENCARGOS E BENEFICIOS
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
    , SERV AS ( SELECT -- SERVICOS PROFISSIONAIS E CONTRATADOS
        A.CONTA
        ,A.Descricao
        ,A.Anterior
        ,A.DEBITOS
        ,A.CREDITOS
        ,A.MOVIMENTO
        ,A.SALDOATUAL
        ,A.dataOrcamento
        ,FECHAMENTO = 'SERVIÇOS PROFISSIONAIS E CONTRATADOS'        
        FROM [BALANCETE] A   
        WHERE CONTA LIKE '3.1.2%')

   SELECT FECHAMENTO -- COMPILADO _RMBALANCETE
    ,Conta AS NVL6
    ,Descricao AS CONTA
    ,dataOrcamento
    ,CASE  -- CLASSIFICA RECEITAS E DESPESAS
        WHEN FECHAMENTO IN ('CSO - CONTR. SOCIAL ORDINÁRIA','CSN - CONTR. SOCIAL NACIONAL','CONVÊNIOS, SUBV. E AUXÍLIOS','CONTRATO INTERNO','ALIENAÇÃO DE BENS','EMPRESAS BENEFICIADAS','OUTRAS RECEITAS') THEN  'RECEITAS'
            WHEN  FECHAMENTO IN ('PROGRAMA DE CRÉDITO ORIENTADO','CUSTO/DESP.OPERACIONALIZAÇÃO','DEPÓSITOS JUDICIAIS','ENCARGOS DIVERSOS','FUNDO MUTUO INV. EMPRESAS EMERG.','IMOBILIZADO','INVESTIMENTO - BENS IMÓVEIS','LIBERACOES DE CONVENIOS','PESSOAL, ENC. E BEN.SOCIAIS','SERVIÇOS PROFISSIONAIS E CONTRATADOS' ) THEN 'DESPESAS'
            ELSE NULL END AS 'RECEITAS/DESPESAS'

    ,SUM(MOVIMENTO) AS VALOR FROM (SELECT * FROM CSO -- UNION ALL
            UNION ALL -- RECEITAS
            SELECT * FROM CSN
            UNION ALL
            SELECT * FROM CONVENIO
            UNION ALL
            SELECT * FROM INTERNO
            UNION ALL 
            SELECT * FROM ALIENACAO
            UNION ALL 
            SELECT * FROM EMPRESAS
            UNION ALL
            SELECT * FROM OUTRAS
            UNION ALL
            SELECT * FROM CREDITO -- DESPESAS
            UNION ALL
            SELECT * FROM CUSTOS
            UNION ALL
            SELECT * FROM DEPOSITOS
            UNION ALL
            SELECT * FROM ENCARGOS
            UNION ALL
            SELECT * FROM FUNDO
            UNION ALL
            SELECT * FROM IMOBILIZADO
            UNION ALL
            SELECT * FROM BENS
            UNION ALL
            SELECT * FROM LIBERA
            UNION ALL
            SELECT * FROM PESSOAL
            UNION ALL
            SELECT * FROM SERV

        )A

    GROUP BY conta, descricao,FECHAMENTO,dataOrcamento
    order by FECHAMENTO, dataOrcamento