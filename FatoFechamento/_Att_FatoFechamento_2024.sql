DECLARE @dt date = getdate();

DELETE from [FINANCA].[dbo].[FatoFechamento] where  YEAR([DATA]) = YEAR(@dt);

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --SERVIÇOS PROFISSIONAIS E CONTRATADOS

		select * from (SELECT distinct 
			a.IDRATEIO
			,a.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,b.CREDITO	
			,c.descContaNvl3 as CREDITONVL3
			,c.descContaNvl6 as CREDITONVL6
			,b.DEBITO
			,d.descContaNvl3 as DEBITONVL3
			,d.descContaNvl6 as DEBITONVL6
			,iif(CREDITO like '3.1.2%', c.desccontanvl1, d.desccontanvl1) as DESCNVL1
			,iif(CREDITO like '3.1.2%', c.desccontanvl2, d.desccontanvl2) as DESCNVL2
			,iif(CREDITO like '3.1.2%', c.desccontanvl3, d.desccontanvl3) as DESCNVL3
			,iif(CREDITO like '3.1.2%', c.desccontanvl4, d.desccontanvl4) as DESCNVL4
			,iif(CREDITO like '3.1.2%', c.desccontanvl5, d.desccontanvl5) as DESCNVL5
			,iif(CREDITO like '3.1.2%', c.desccontanvl6, d.desccontanvl6) as DESCNVL6
			,iif(CREDITO like '3.1.2%', b.CREDITO, b.DEBITO) as COD_CONTA
			,a.CODGERENCIAL
			,e.PROJETO
			,e.ACAO
			,b.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR
			,h.NOME as 'UNIDADE'
			,CONTA_FECHAMENTO = 'SERVIÇOS PROFISSIONAIS E CONTRATADOS'
			,'Despesa' as TIPO 
			,b.DATA
			,VLRCREDITO
			,VLRDEBITO
			,vlrdebito - vlrcredito as UNIFICAVALOR

		FROM [HubDados].[CorporeRM].[CRATEIOLC] a

			left join [HubDados].[CorporeRM].[CLANCA] b
		on a.LCTREF = b.LCTREF
			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on b.CREDITO collate Latin1_General_CI_AS = c.cdgContaNvl6
			left join [FINANCA].[dbo].[PlanoDeContasFull] d
		on b.DEBITO collate Latin1_General_CI_AS = d.cdgContaNvl6
			left join [FINANCA].[dbo].[CENTROCUSTO_DESCRICAO] e
		on SUBSTRING(a.CODGERENCIAL,3,16) COLLATE SQL_Latin1_General_CP1_CI_AI = e.CENTROCUSTO
			left join [HubDados].[CorporeRM].[TMOV] f
		on b.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO
			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on b.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and b.CODFILIAL = h.CODFILIAL
		
		) a

		where  YEAR([DATA]) = YEAR(@dt) and
				(DEBITO not like '2.4.1.1.01%' or DEBITO is null) and
				(CREDITO like '3.1.2%' or DEBITO like '3.1.2%') and 
				COMPLEMENTO is not null

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --PESSOAL, ENC. E BEN.SOCIAIS

		select * from (SELECT distinct 
			a.IDRATEIO
			,a.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,b.CREDITO
			,c.descContaNvl3 as CREDITONVL3	
			,c.descContaNvl6 as CREDITONVL6
			,b.DEBITO
			,d.descContaNvl3 as DEBITONVL3
			,d.descContaNvl6 as DEBITONVL6
			,iif(Credito like '3.1.1%', c.descContaNvl1, d.descContaNvl1) as DESCNVL1
			,iif(Credito like '3.1.1%', c.descContaNvl2, d.descContaNvl2) as DESCNVL2
			,iif(Credito like '3.1.1%', c.descContaNvl3, d.descContaNvl3) as DESCNVL3
			,iif(Credito like '3.1.1%', c.descContaNvl4, d.descContaNvl4) as DESCNVL4	
			,iif(Credito like '3.1.1%', c.descContaNvl5, d.descContaNvl5) as DESCNVL5
			,iif(Credito like '3.1.1%', c.descContaNvl6, d.descContaNvl6) as DESCNVL6
			,iif(CREDITO like '3.1.1%', b.CREDITO, b.DEBITO) as COD_CONTA
			,a.CODGERENCIAL
			,e.PROJETO
			,e.ACAO
			,b.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR
			,h.NOME as 'UNIDADE'
			,CONTA_FECHAMENTO = 'PESSOAL, ENC. E BEN.SOCIAIS'
			,'Despesa' as TIPO 
			,b.DATA
			,VLRCREDITO
			,VLRDEBITO
			,vlrdebito - vlrcredito as UNIFICAVALOR


		FROM [HubDados].[CorporeRM].[CRATEIOLC] a

			left join [HubDados].[CorporeRM].[CLANCA] b
		on a.LCTREF = b.LCTREF

			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on b.CREDITO collate Latin1_General_CI_AS = c.cdgContaNvl6

			left join [FINANCA].[dbo].[PlanoDeContasFull] d
		on b.DEBITO collate Latin1_General_CI_AS = d.cdgContaNvl6

			left join [FINANCA].[dbo].[CENTROCUSTO_DESCRICAO] e
		on SUBSTRING(a.CODGERENCIAL,3,16) COLLATE SQL_Latin1_General_CP1_CI_AI = e.CENTROCUSTO

			left join [HubDados].[CorporeRM].[TMOV] f
		on b.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO
			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on b.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and b.CODFILIAL = h.CODFILIAL

		
		) a

			where   YEAR([DATA]) = YEAR(@dt) and
				(DEBITO not like '2.4.1.1.01%' or DEBITO is null) and
				(Debito like '3.1.1%' or Credito like '3.1.1%') and 
				COMPLEMENTO is not null and COMPLEMENTO not like 'Custo Serviço e financeiro referente ao ano de 2018'

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --Programa de Crédito Orientado

		select * from (SELECT distinct 
			a.IDRATEIO
			,a.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,b.CREDITO
			,c.descContaNvl3 as CREDITONVL3
			,c.descContaNvl6 as CREDITONVL6
			,b.DEBITO
			,d.descContaNvl3 as DEBITONVL3
			,d.descContaNvl6 as DEBITONVL6
			,iif(Debito like '5.1.1.2%', d.descContaNvl1, c.descContaNvl1) as DESCNVL1
			,iif(Debito like '5.1.1.2%', d.descContaNvl2, c.descContaNvl2) as DESCNVL2
			,iif(Debito like '5.1.1.2%', d.descContaNvl3, c.descContaNvl3) as DESCNVL3
			,iif(Debito like '5.1.1.2%', d.descContaNvl4, c.descContaNvl4) as DESCNVL4
			,iif(Debito like '5.1.1.2%', d.descContaNvl5, c.descContaNvl5) as DESCNVL5
			,iif(Debito like '5.1.1.2%', d.descContaNvl6, c.descContaNvl6) as DESCNVL6
			,iif(Debito like '5.1.1.2%', b.debito, b.credito) as COD_CONTA
			,a.CODGERENCIAL
			,e.PROJETO
			,e.ACAO
			,b.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR
			,h.NOME as 'UNIDADE'
			,'Programa de Crédito Orientado' as CONTA_FECHAMENTO 
			,'Despesa' as TIPO 
			,b.DATA
			,VLRCREDITO
			,VLRDEBITO
			,iif(vlrcredito = 0, vlrdebito, vlrdebito - vlrcredito) as UNIFICAVALOR
		FROM [HubDados].[CorporeRM].[CRATEIOLC] a

			left join [HubDados].[CorporeRM].[CLANCA] b
		on a.LCTREF = b.LCTREF

			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on b.CREDITO collate Latin1_General_CI_AS = c.cdgContaNvl6

			left join [FINANCA].[dbo].[PlanoDeContasFull] d
		on b.DEBITO collate Latin1_General_CI_AS = d.cdgContaNvl6

			left join [FINANCA].[dbo].[CENTROCUSTO_DESCRICAO] e
		on SUBSTRING(a.CODGERENCIAL,3,16) COLLATE SQL_Latin1_General_CP1_CI_AI = e.CENTROCUSTO

			left join [HubDados].[CorporeRM].[TMOV] f
		on b.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO
			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on b.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and b.CODFILIAL = h.CODFILIAL

		
		) a

		where   YEAR([DATA]) = YEAR(@dt) and 
				(DEBITO not like '2.4.1.1.01%' or DEBITO is null) and
				COMPLEMENTO is not null and Debito like '5.2.5.3%'

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --Liberações de Convênios

		select * from (SELECT distinct 
			a.IDRATEIO
			,a.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,b.CREDITO
			,c.descContaNvl3 as CREDITONVL3
			,c.descContaNvl6 as CREDITONVL6
			,b.DEBITO
			,d.descContaNvl3 as DEBITONVL3
			,d.descContaNvl6 as DEBITONVL6
			,iif(Debito like '5.1.1.2%' or Debito like '1.9.5.7.01.001',d.descContaNvl1, c.descContaNvl1) as DESCNVL1
			,iif(Debito like '5.1.1.2%' or Debito like '1.9.5.7.01.001',d.descContaNvl2, c.descContaNvl2) as DESCNVL2
			,iif(Debito like '5.1.1.2%' or Debito like '1.9.5.7.01.001',d.descContaNvl3, c.descContaNvl3) as DESCNVL3
			,iif(Debito like '5.1.1.2%' or Debito like '1.9.5.7.01.001',d.descContaNvl4, c.descContaNvl4) as DESCNVL4
			,iif(Debito like '5.1.1.2%' or Debito like '1.9.5.7.01.001',d.descContaNvl5, c.descContaNvl5) as DESCNVL5	
			,iif(Debito like '5.1.1.2%' or Debito like '1.9.5.7.01.001',d.descContaNvl6, c.descContaNvl6) as DESCNVL6
			,iif(Debito like '5.1.1.2%' or Debito like '1.9.5.7.01.001',b.debito, b.credito) as COD_CONTA
			,a.CODGERENCIAL
			,e.PROJETO
			,e.ACAO
			,b.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR
			,h.NOME as 'UNIDADE'
			,'Liberações de Convênios' as CONTA_FECHAMENTO 
			,'Despesa' as TIPO 
			,b.DATA
			,VLRCREDITO
			,VLRDEBITO
			,iif(vlrcredito = 0, vlrdebito, vlrdebito - vlrcredito) as UNIFICAVALOR
		FROM [HubDados].[CorporeRM].[CRATEIOLC] a

			left join [HubDados].[CorporeRM].[CLANCA] b
		on a.LCTREF = b.LCTREF

			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on b.CREDITO collate Latin1_General_CI_AS = c.cdgContaNvl6

			left join [FINANCA].[dbo].[PlanoDeContasFull] d
		on b.DEBITO collate Latin1_General_CI_AS = d.cdgContaNvl6

			left join [FINANCA].[dbo].[CENTROCUSTO_DESCRICAO] e
		on SUBSTRING(a.CODGERENCIAL,3,16) COLLATE SQL_Latin1_General_CP1_CI_AI = e.CENTROCUSTO

			left join [HubDados].[CorporeRM].[TMOV] f
		on b.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO
			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on b.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and b.CODFILIAL = h.CODFILIAL

		
		) a

		where  YEAR([DATA]) = YEAR(@dt) and 
				(DEBITO not like '2.4.1.1.01%' or DEBITO is null) and
				COMPLEMENTO is not null and
				Debito like '5.1.1.2%'

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --Imobilizado

		select * from (SELECT distinct 
			a.IDRATEIO
			,a.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,b.CREDITO
			,c.descContaNvl3 as CREDITONVL3
			,c.descContaNvl6 as CREDITONVL6
			,b.DEBITO
			,d.descContaNvl3 as DEBITONVL3
			,d.descContaNvl6 as DEBITONVL6
			,iif((Debito like '5.2.2.2%' or Debito like '5.2.3.1%' or Debito like '1.9.5.2.03%' or Debito like '1.9.5.2.04%' or Debito like '1.9.5.2.03.004') and d.descContaNvl3 not like null, d.descContaNvl1, c.descContaNvl1) as DESCNVL1	
			,iif((Debito like '5.2.2.2%' or Debito like '5.2.3.1%' or Debito like '1.9.5.2.03%' or Debito like '1.9.5.2.04%' or Debito like '1.9.5.2.03.004') and d.descContaNvl3 not like null, d.descContaNvl2, c.descContaNvl2) as DESCNVL2	
			,iif((Debito like '5.2.2.2%' or Debito like '5.2.3.1%' or Debito like '1.9.5.2.03%' or Debito like '1.9.5.2.04%' or Debito like '1.9.5.2.03.004') and d.descContaNvl3 not like null, d.descContaNvl3, c.descContaNvl3) as DESCNVL3
			,iif((Debito like '5.2.2.2%' or Debito like '5.2.3.1%' or Debito like '1.9.5.2.03%' or Debito like '1.9.5.2.04%' or Debito like '1.9.5.2.03.004') and d.descContaNvl3 not like null, d.descContaNvl4, c.descContaNvl4) as DESCNVL4
			,iif((Debito like '5.2.2.2%' or Debito like '5.2.3.1%' or Debito like '1.9.5.2.03%' or Debito like '1.9.5.2.04%' or Debito like '1.9.5.2.03.004') and d.descContaNvl3 not like null, d.descContaNvl5, c.descContaNvl5) as DESCNVL5
			,iif((Debito like '5.2.2.2%' or Debito like '5.2.3.1%' or Debito like '1.9.5.2.03%' or Debito like '1.9.5.2.04%' or Debito like '1.9.5.2.03.004') and d.descContaNvl3 not like null, d.descContaNvl6, c.descContaNvl6) as DESCNVL6
			,iif((Debito like '5.2.2.2%' or Debito like '5.2.3.1%' or Debito like '1.9.5.2.03%' or Debito like '1.9.5.2.04%' or Debito like '1.9.5.2.03.004') and d.descContaNvl3 not like null, b.debito, b.credito) as COD_CONTA
			,a.CODGERENCIAL
			,e.PROJETO
			,e.ACAO
			,b.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR
			,h.nome as 'UNIDADE'
			,'Imobilizado' as CONTA_FECHAMENTO 
			,'Despesa' as TIPO
			,b.DATA
			,VLRCREDITO
			,VLRDEBITO
			,iif(vlrcredito = 0, vlrdebito, vlrdebito - vlrcredito) as UNIFICAVALOR
		FROM [HubDados].[CorporeRM].[CRATEIOLC] a

			left join [HubDados].[CorporeRM].[CLANCA] b
		on a.LCTREF = b.LCTREF

			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on b.CREDITO collate Latin1_General_CI_AS = c.cdgContaNvl6

			left join [FINANCA].[dbo].[PlanoDeContasFull] d
		on b.DEBITO collate Latin1_General_CI_AS = d.cdgContaNvl6

			left join [FINANCA].[dbo].[CENTROCUSTO_DESCRICAO] e
		on SUBSTRING(a.CODGERENCIAL,3,16) COLLATE SQL_Latin1_General_CP1_CI_AI = e.CENTROCUSTO

			left join [HubDados].[CorporeRM].[TMOV] f
		on b.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO
			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on b.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and b.CODFILIAL = h.CODFILIAL

		
		) a
		
		where   YEAR([DATA]) = YEAR(@dt) and
				((DEBITO not like '7.2.3.1.01%' and DEBITO not like '7.2.2.2.01%') or DEBITO is null) and
				COMPLEMENTO is not null and
				(Debito like '5.2.2.2%' or Credito like '5.2.2.2%' or Debito like '5.2.3.1%' or Credito like '5.2.3.1%')

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --Investimentos - Bens Imóveis

		select * from (SELECT distinct 
			a.IDRATEIO
			,a.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,b.CREDITO
			,c.descContaNvl3 as CREDITONVL3
			,c.descContaNvl6 as CREDITONVL6
			,b.DEBITO
			,d.descContaNvl3 as DEBITONVL3
			,d.descContaNvl6 as DEBITONVL6
			,iif(Debito like '5.2.2.1%' or Debito like '1.9.5.2.02%', d.descContaNvl1, c.descContaNvl1) as DESCNVL1
			,iif(Debito like '5.2.2.1%' or Debito like '1.9.5.2.02%', d.descContaNvl2, c.descContaNvl2) as DESCNVL2
			,iif(Debito like '5.2.2.1%' or Debito like '1.9.5.2.02%', d.descContaNvl3, c.descContaNvl3) as DESCNVL3
			,iif(Debito like '5.2.2.1%' or Debito like '1.9.5.2.02%', d.descContaNvl4, c.descContaNvl4) as DESCNVL4
			,iif(Debito like '5.2.2.1%' or Debito like '1.9.5.2.02%', d.descContaNvl5, c.descContaNvl5) as DESCNVL5
			,iif(Debito like '5.2.2.1%' or Debito like '1.9.5.2.02%', d.descContaNvl6, c.descContaNvl6) as DESCNVL6
			,iif(Debito like '5.2.2.1%' or Debito like '1.9.5.2.02%', b.debito, b.credito) as COD_CONTA
			,a.CODGERENCIAL
			,e.PROJETO
			,e.ACAO
			,b.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR
			,h.nome as 'UNIDADE'
			,'Investimentos - Bens Imóveis' as CONTA_FECHAMENTO
			,'Despesa' as TIPO
			,b.DATA
			,VLRCREDITO
			,VLRDEBITO
			,iif(vlrcredito = 0, vlrdebito, vlrdebito - vlrcredito) as UNIFICAVALOR
		FROM [HubDados].[CorporeRM].[CRATEIOLC] a

			left join [HubDados].[CorporeRM].[CLANCA] b
		on a.LCTREF = b.LCTREF

			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on b.CREDITO collate Latin1_General_CI_AS = c.cdgContaNvl6

			left join [FINANCA].[dbo].[PlanoDeContasFull] d
		on b.DEBITO collate Latin1_General_CI_AS = d.cdgContaNvl6

			left join [FINANCA].[dbo].[CENTROCUSTO_DESCRICAO] e
		on SUBSTRING(a.CODGERENCIAL,3,16) COLLATE SQL_Latin1_General_CP1_CI_AI = e.CENTROCUSTO

			left join [HubDados].[CorporeRM].[TMOV] f
		on b.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO
			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on b.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and b.CODFILIAL = h.CODFILIAL

		
		) a

		where  YEAR([DATA]) = YEAR(@dt) and 
				(DEBITO not like '2.4.1.1.01%' or DEBITO is null) and
				COMPLEMENTO is not null and
				(Debito like '5.2.2.1%' or Credito like '5.2.2.1%') and IDRATEIO not like '1929077' 

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --Fundo Mútuo Inv. Empresas Emerg.

		select * from (SELECT distinct a.IDRATEIO
			,a.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,b.CREDITO
			,c.descContaNvl3 as CREDITONVL3
			,c.descContaNvl6 as CREDITONVL6
			,b.DEBITO
			,d.descContaNvl3 as DEBITONVL3	
			,d.descContaNvl6 as DEBITONVL6
			,iif(b.DEBITO like '5.2.5.2.01.001' or b.Debito like '1.9.5.1.01.003', d.descContaNvl1, c.descContaNvl1) as DESCNVL1	
			,iif(b.DEBITO like '5.2.5.2.01.001' or b.Debito like '1.9.5.1.01.003', d.descContaNvl2, c.descContaNvl2) as DESCNVL2
			,iif(b.DEBITO like '5.2.5.2.01.001' or b.Debito like '1.9.5.1.01.003', d.descContaNvl3, c.descContaNvl3) as DESCNVL3
			,iif(b.DEBITO like '5.2.5.2.01.001' or b.Debito like '1.9.5.1.01.003', d.descContaNvl4, c.descContaNvl4) as DESCNVL4
			,iif(b.DEBITO like '5.2.5.2.01.001' or b.Debito like '1.9.5.1.01.003', d.descContaNvl5, c.descContaNvl5) as DESCNVL5
			,iif(b.DEBITO like '5.2.5.2.01.001' or b.Debito like '1.9.5.1.01.003', d.descContaNvl6, c.descContaNvl6) as DESCNVL6
			,iif(b.DEBITO like '5.2.5.2.01.001' or b.Debito like '1.9.5.1.01.003', b.debito, b.credito) as COD_CONTA
			,a.CODGERENCIAL
			,e.PROJETO
			,e.ACAO
			,b.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR
			,h.nome as 'UNIDADE'
			,CONTA_FECHAMENTO  = 'Fundo Mútuo Inv. Empresas Emerg.'
			,'Despesa' as TIPO
			,b.DATA
			,VLRCREDITO
			,VLRDEBITO
			,iif(vlrcredito = 0, vlrdebito, vlrdebito - vlrcredito) as UNIFICAVALOR
		FROM [HubDados].[CorporeRM].[CRATEIOLC] a

			left join [HubDados].[CorporeRM].[CLANCA] b
		on a.LCTREF = b.LCTREF

			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on b.CREDITO collate Latin1_General_CI_AS = c.cdgContaNvl6

			left join [FINANCA].[dbo].[PlanoDeContasFull] d
		on b.DEBITO collate Latin1_General_CI_AS = d.cdgContaNvl6

			left join [FINANCA].[dbo].[CENTROCUSTO_DESCRICAO] e
		on SUBSTRING(a.CODGERENCIAL,3,16) COLLATE SQL_Latin1_General_CP1_CI_AI = e.CENTROCUSTO

			left join [HubDados].[CorporeRM].[TMOV] f
		on b.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO
			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on b.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and b.CODFILIAL = h.CODFILIAL

		
		) a

		where   YEAR([DATA]) = YEAR(@dt) and 
				(DEBITO not like '2.4.1.1.01%' or DEBITO is null) and
				COMPLEMENTO is not null and
				DEBITO like '5.2.5.2.01.001'

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --ENCARGOS DIVERSOS

		select * from (SELECT distinct 
			a.IDRATEIO
			,a.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,b.CREDITO
			,c.descContaNvl3 as CREDITONVL3
			,c.descContaNvl6 as CREDITONVL6
			,b.DEBITO
			,d.descContaNvl3 as DEBITONVL3
			,d.descContaNvl6 as DEBITONVL6
			,iif(Credito like '3.1.4%', c.descContaNvl1, d.descContaNvl1) as DESCNVL1
			,iif(Credito like '3.1.4%', c.descContaNvl2, d.descContaNvl2) as DESCNVL2
			,iif(Credito like '3.1.4%', c.descContaNvl3, d.descContaNvl3) as DESCNVL3
			,iif(Credito like '3.1.4%', c.descContaNvl4, d.descContaNvl4) as DESCNVL4
			,iif(Credito like '3.1.4%', c.descContaNvl5, d.descContaNvl5) as DESCNVL5
			,iif(Credito like '3.1.4%', c.descContaNvl6, d.descContaNvl6) as DESCNVL6
			,iif(Credito like '3.1.4%', b.credito, b.debito) as COD_CONTA
			,a.CODGERENCIAL
			,e.PROJETO
			,e.ACAO
			,b.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR	
			,h.nome as 'UNIDADE'
			,CONTA_FECHAMENTO  = 'ENCARGOS DIVERSOS'
			,'Despesa' as TIPO 
			,b.DATA
			,VLRCREDITO
			,VLRDEBITO
			,UNIFICAVALOR = vlrdebito - vlrcredito

		FROM [HubDados].[CorporeRM].[CRATEIOLC] a

			left join [HubDados].[CorporeRM].[CLANCA] b
		on a.LCTREF = b.LCTREF

			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on b.CREDITO collate Latin1_General_CI_AS = c.cdgContaNvl6

			left join [FINANCA].[dbo].[PlanoDeContasFull] d
		on b.DEBITO collate Latin1_General_CI_AS = d.cdgContaNvl6

			left join [FINANCA].[dbo].[CENTROCUSTO_DESCRICAO] e
		on SUBSTRING(a.CODGERENCIAL,3,16) COLLATE SQL_Latin1_General_CP1_CI_AI = e.CENTROCUSTO

			left join [HubDados].[CorporeRM].[TMOV] f
		on b.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO
			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on b.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and b.CODFILIAL = h.CODFILIAL

		
		) a

			where  YEAR([DATA]) = YEAR(@dt) and
				(DEBITO not like '2.4.1.1.01%' or DEBITO is null) and
				(Debito like '3.1.4.1%' or Credito like '3.1.4.1%' or Debito like '3.1.4.2%' or Credito like '3.1.4.2%') and 
				COMPLEMENTO is not null and IDRATEIO not in ('1537384', '1911286') and 
				DESCNVL6 not like 'Resultado Programa de Crédito Orientado' and DESCNVL6 not like 'Fundo Invest. Direitos Creditórios MPE'

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --DEPÓSITOS JUDICIAIS

		select * from (SELECT distinct 
			a.IDRATEIO
			,a.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,b.CREDITO
			,c.descContaNvl3 as CREDITONVL3
			,c.descContaNvl6 as CREDITONVL6
			,b.DEBITO
			,d.descContaNvl3 as DEBITONVL3
			,d.descContaNvl6 as DEBITONVL6
			,iif(b.DEBITO like '5.2.4.1.01%' or b.Debito like '1.9.5.1.01.001', d.descContaNvl1, c.descContaNvl1) as DESCNVL1
			,iif(b.DEBITO like '5.2.4.1.01%' or b.Debito like '1.9.5.1.01.001', d.descContaNvl2, c.descContaNvl2) as DESCNVL2
			,iif(b.DEBITO like '5.2.4.1.01%' or b.Debito like '1.9.5.1.01.001', d.descContaNvl3, c.descContaNvl3) as DESCNVL3
			,iif(b.DEBITO like '5.2.4.1.01%' or b.Debito like '1.9.5.1.01.001', d.descContaNvl4, c.descContaNvl4) as DESCNVL4
			,iif(b.DEBITO like '5.2.4.1.01%' or b.Debito like '1.9.5.1.01.001', d.descContaNvl5, c.descContaNvl5) as DESCNVL5
			,iif(b.DEBITO like '5.2.4.1.01%' or b.Debito like '1.9.5.1.01.001', d.descContaNvl6, c.descContaNvl6) as DESCNVL6
			,iif(b.DEBITO like '5.2.4.1.01%' or b.Debito like '1.9.5.1.01.001', b.debito, b.credito) as COD_CONTA
			,a.CODGERENCIAL
			,e.PROJETO
			,e.ACAO
			,b.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR
			,h.nome as 'UNIDADE'
			,CONTA_FECHAMENTO = 'DEPÓSITOS JUDICIAIS'
			,'Despesa' as TIPO  
			,b.DATA
			,VLRCREDITO
			,VLRDEBITO
			,iif(vlrcredito = 0, vlrdebito, vlrdebito - vlrcredito) as UNIFICAVALOR
		FROM [HubDados].[CorporeRM].[CRATEIOLC] a

			left join [HubDados].[CorporeRM].[CLANCA] b
		on a.LCTREF = b.LCTREF

			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on b.CREDITO collate Latin1_General_CI_AS = c.cdgContaNvl6

			left join [FINANCA].[dbo].[PlanoDeContasFull] d
		on b.DEBITO collate Latin1_General_CI_AS = d.cdgContaNvl6

			left join [FINANCA].[dbo].[CENTROCUSTO_DESCRICAO] e
		on SUBSTRING(a.CODGERENCIAL,3,16) COLLATE SQL_Latin1_General_CP1_CI_AI = e.CENTROCUSTO

			left join [HubDados].[CorporeRM].[TMOV] f
		on b.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO

			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on b.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and b.CODFILIAL = h.CODFILIAL

		
		) a

		where  YEAR([DATA]) = YEAR(@dt) and 
				(DEBITO not like '2.4.1.1.01%' or DEBITO is null)  and
				(Debito like '5.2.4.1.01%' or CREDITO like '5.2.4.1.01%') and 
				COMPLEMENTO not like 'ENCERRAMENTO CONTAS EXCLUSIVAS DE ORÇAMENTO'

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --CUSTO/DESP.OPERACIONALIZAÇÃO

		select * from (SELECT distinct 
			a.IDRATEIO
			,a.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,b.CREDITO
			,c.descContaNvl3 as CREDITONVL3
			,c.descContaNvl6 as CREDITONVL6
			,b.DEBITO
			,d.descContaNvl3 as DEBITONVL3
			,d.descContaNvl6 as DEBITONVL6
			,iif(Credito like '3.1.3%', c.descContaNvl1, d.descContaNvl1) as DESCNVL1
			,iif(Credito like '3.1.3%', c.descContaNvl2, d.descContaNvl2) as DESCNVL2
			,iif(Credito like '3.1.3%', c.descContaNvl3, d.descContaNvl3) as DESCNVL3
			,iif(Credito like '3.1.3%', c.descContaNvl4, d.descContaNvl4) as DESCNVL4	
			,iif(Credito like '3.1.3%', c.descContaNvl5, d.descContaNvl5) as DESCNVL5
			,iif(Credito like '3.1.3%', c.descContaNvl6, d.descContaNvl6) as DESCNVL6
			,iif(Credito like '3.1.3%', b.credito, b.debito) as COD_CONTA
			,a.CODGERENCIAL
			,e.PROJETO
			,e.ACAO
			,b.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR	
			,h.nome as 'UNIDADE'
			,CONTA_FECHAMENTO  = 'CUSTO/DESP.OPERACIONALIZAÇÃO'
			,'Despesa' as TIPO 
			,b.DATA
			,VLRCREDITO
			,VLRDEBITO
			,UNIFICAVALOR = vlrdebito - vlrcredito
		FROM [HubDados].[CorporeRM].[CRATEIOLC] a

			left join [HubDados].[CorporeRM].[CLANCA] b
		on a.LCTREF = b.LCTREF

			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on b.CREDITO collate Latin1_General_CI_AS = c.cdgContaNvl6

			left join [FINANCA].[dbo].[PlanoDeContasFull] d
		on b.DEBITO collate Latin1_General_CI_AS = d.cdgContaNvl6

			left join [FINANCA].[dbo].[CENTROCUSTO_DESCRICAO] e
		on SUBSTRING(a.CODGERENCIAL,3,16) COLLATE SQL_Latin1_General_CP1_CI_AI = e.CENTROCUSTO

			left join [HubDados].[CorporeRM].[TMOV] f
		on b.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO
			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on b.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and b.CODFILIAL = h.CODFILIAL

		
		) a

			where   YEAR([DATA]) = YEAR(@dt) and
				(DEBITO not like '2.4.1.1.01%' or DEBITO is null) and
				(Debito like '3.1.3%' or Credito like '3.1.3%') and 
				COMPLEMENTO is not null and IDRATEIO not like '1537388'

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --OUTRAS RECEITAS

		select * from (SELECT distinct 
			IDRATEIO = null 
			,a.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,a.CREDITO
			,c.descContaNvl3 as CREDITONVL3
			,c.descContaNvl6 as CREDITONVL6
			,a.DEBITO
			,d.descContaNvl3 as DEBITONVL3
			,d.descContaNvl6 as DEBITONVL6
			,iif(debito like ('6.2.2.1%') or debito like ('4.1.4.6%') or debito like ('4.1.5.3%') or debito like ('4.1.4.1%') or debito like ('4.1.5.1%') or debito like ('2.9.6%') or credito is null, d.descContaNvl1, c.descContaNvl1) as DESCNVL1
			,iif(debito like ('6.2.2.1%') or debito like ('4.1.4.6%') or debito like ('4.1.5.3%') or debito like ('4.1.4.1%') or debito like ('4.1.5.1%') or debito like ('2.9.6%') or credito is null, d.descContaNvl2, c.descContaNvl2) as DESCNVL2
			,iif(debito like ('6.2.2.1%') or debito like ('4.1.4.6%') or debito like ('4.1.5.3%') or debito like ('4.1.4.1%') or debito like ('4.1.5.1%') or debito like ('2.9.6%') or credito is null, d.descContaNvl3, c.descContaNvl3) as DESCNVL3
			,iif(debito like ('6.2.2.1%') or debito like ('4.1.4.6%') or debito like ('4.1.5.3%') or debito like ('4.1.4.1%') or debito like ('4.1.5.1%') or debito like ('2.9.6%') or credito is null, d.descContaNvl4, c.descContaNvl4) as DESCNVL4
			,iif(debito like ('6.2.2.1%') or debito like ('4.1.4.6%') or debito like ('4.1.5.3%') or debito like ('4.1.4.1%') or debito like ('4.1.5.1%') or debito like ('2.9.6%') or credito is null, d.descContaNvl5, c.descContaNvl5) as DESCNVL5
			,iif(debito like ('6.2.2.1%') or debito like ('4.1.4.6%') or debito like ('4.1.5.3%') or debito like ('4.1.4.1%') or debito like ('4.1.5.1%') or debito like ('2.9.6%') or credito is null, d.descContaNvl6, c.descContaNvl6) as DESCNVL6
			,iif(debito like ('6.2.2.1%') or debito like ('4.1.4.6%') or debito like ('4.1.5.3%') or debito like ('4.1.4.1%') or debito like ('4.1.5.1%') or debito like ('2.9.6%') or credito is null, a.debito, a.credito) as COD_CONTA
			,CODGERENCIAL = null 
			,PROJETO = null 
			,ACAO = null 
			,a.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR
			,h.nome as 'UNIDADE'
			,CONTA_FECHAMENTO  = 'OUTRAS RECEITAS'
			,'Receita' as TIPO
			,a.DATA
			,VLRCREDITO = null 
			,VLRDEBITO = null 
			,iif(debito like ('6.2.2.1%') or debito like ('4.1.4.6%') or debito like ('4.1.5.3%') or debito like ('4.1.4.1%') or debito like ('4.1.5.1%') or debito like ('2.9.6%') or credito is null ,a.valor *-1, a.valor) as UNIFICAVALOR
		FROM [HubDados].[CorporeRM].[CLANCA] a

			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on a.CREDITO collate Latin1_General_CI_AS = c.cdgContaNvl6

			left join [FINANCA].[dbo].[PlanoDeContasFull] d 
		on a.DEBITO collate Latin1_General_CI_AS = d.cdgContaNvl6 

			left join [HubDados].[CorporeRM].[TMOV] f
		on a.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO
			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on a.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and a.CODFILIAL = h.CODFILIAL

		
		) a

		where  (YEAR([DATA]) = YEAR(@dt)  and 
		(DEBITO not like '2.4.1.1.01%' or DEBITO is null) and (CREDITO not like '2.4.1.1.01%' or CREDITO is null) and COMPLEMENTO is not null and
		(Credito like '6.2.2.1%' or Credito like '4.1.4.6%' or Debito like '4.1.4.6%' or Credito like '4.1.5.3%' or Debito like '4.1.5.3%' or Credito like '4.1.4.1%' or Debito like '4.1.4.1%' or Credito like '4.1.5.1%' or Debito like '4.1.5.1%' or Credito like '2.9.6%' or Credito like '6.2.4.1%' or Debito like '6.2.4.1%' ))

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --EMPRESAS BENEFICIADAS
		
		select * from (SELECT distinct 
			a.IDRATEIO
			,b.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,b.CREDITO
			,c.descContaNvl3 as CREDITONVL3
			,c.descContaNvl6 as CREDITONVL6
			,b.DEBITO
			,d.descContaNvl3 as DEBITONVL3
			,d.descContaNvl6 as DEBITONVL6
			,iif(Credito like '4.1.2%', c.descContaNvl1, d.descContaNvl1) as DESCNVL1
			,iif(Credito like '4.1.2%', c.descContaNvl2, d.descContaNvl2) as DESCNVL2
			,iif(Credito like '4.1.2%', c.descContaNvl3, d.descContaNvl3) as DESCNVL3
			,iif(Credito like '4.1.2%', c.descContaNvl4, d.descContaNvl4) as DESCNVL4
			,iif(Credito like '4.1.2%', c.descContaNvl5, d.descContaNvl5) as DESCNVL5
			,iif(Credito like '4.1.2%', c.descContaNvl6, d.descContaNvl6) as DESCNVL6
			,iif(Credito like '4.1.2%', b.credito, b.debito) as COD_CONTA
			,a.CODGERENCIAL
			,e.PROJETO
			,e.ACAO
			,b.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR
			,h.nome as 'UNIDADE'
			,CONTA_FECHAMENTO  = 'EMPRESAS BENEFICIADAS'
			,'Receita' as TIPO 
			,b.DATA
			,VLRCREDITO
			,VLRDEBITO
			,iif(vlrcredito = 0, vlrdebito * -1, vlrcredito - vlrdebito) as UNIFICAVALOR
		FROM [HubDados].[CorporeRM].[CRATEIOLC] a

			left join [HubDados].[CorporeRM].[CLANCA] b
		on a.LCTREF = b.LCTREF

			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on b.CREDITO collate Latin1_General_CI_AS = c.cdgContaNvl6

			left join [FINANCA].[dbo].[PlanoDeContasFull] d
		on b.DEBITO collate Latin1_General_CI_AS = d.cdgContaNvl6

			left join [FINANCA].[dbo].[CENTROCUSTO_DESCRICAO] e
		on SUBSTRING(a.CODGERENCIAL,3,16) COLLATE SQL_Latin1_General_CP1_CI_AI = e.CENTROCUSTO

			left join [HubDados].[CorporeRM].[TMOV] f
		on b.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO
			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on b.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and b.CODFILIAL = h.CODFILIAL

		
		) a

		where  YEAR([DATA]) = YEAR(@dt) and (Credito like '4.1.2%' or Debito like '4.1.2%') and 
				(DEBITO not like '2.4.1.1.01%' or DEBITO is null) and
				COMPLEMENTO is not null

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --CSO - CONTR. SOCIAL ORDINÁRIA

		select * from (SELECT distinct IDRATEIO = null 
			,a.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,a.CREDITO		
			,c.descContaNvl3 as CREDITONVL3
			,c.descContaNvl6 as CREDITONVL6
			,a.DEBITO
			,d.descContaNvl3 as DEBITONVL3
			,d.descContaNvl6 as DEBITONVL6
			,iif(c.desccontanvl3 = 'CONTRIBUIÇÃO SOCIAL', c.descContaNvl1, d.descContaNvl1) as DESCNVL1
			,iif(c.desccontanvl3 = 'CONTRIBUIÇÃO SOCIAL', c.descContaNvl2, d.descContaNvl2) as DESCNVL2
			,iif(c.desccontanvl3 = 'CONTRIBUIÇÃO SOCIAL', c.descContaNvl3, d.descContaNvl3) as DESCNVL3
			,iif(c.desccontanvl3 = 'CONTRIBUIÇÃO SOCIAL', c.descContaNvl4, d.descContaNvl4) as DESCNVL4
			,iif(c.desccontanvl3 = 'CONTRIBUIÇÃO SOCIAL', c.descContaNvl5, d.descContaNvl5) as DESCNVL5
			,iif(c.desccontanvl3 = 'CONTRIBUIÇÃO SOCIAL', c.descContaNvl6, d.descContaNvl6) as DESCNVL6
			,iif(c.desccontanvl3 = 'CONTRIBUIÇÃO SOCIAL',  a.credito, a.debito) as COD_CONTA
			,CODGERENCIAL = null 
			,PROJETO = null 
			,ACAO = null 
			,a.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR
			,h.nome as 'UNIDADE'	
			,'CSO - CONTR. SOCIAL ORDINÁRIA' as CONTA_FECHAMENTO 
			,'Receita' as TIPO 
			,a.DATA
			,VLRCREDITO = null 
			,VLRDEBITO = null 
			,iif(c.desccontanvl3 = '' or a.LCTREF like '4535627', a.valor * -1, a.valor) as UNIFICAVALOR
		FROM [HubDados].[CorporeRM].[CLANCA] a

			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on a.CREDITO collate Latin1_General_CI_AS = c.cdgContaNvl6

			left join [FINANCA].[dbo].[PlanoDeContasFull] d
		on a.DEBITO collate Latin1_General_CI_AS = d.cdgContaNvl6 

			left join [HubDados].[CorporeRM].[TMOV] f
		on a.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO
			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on a.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and a.CODFILIAL = h.CODFILIAL

		
		) a

		where   (YEAR([DATA]) = YEAR(@dt) and (Credito like '4.1.1.1.01%'))
		or (YEAR([DATA]) = YEAR(@dt) AND (Credito like '4.1.1.6%' or Debito like '4.1.1.6%'))

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --CSN - CONTR. SOCIAL NACIONAL

		select * from (SELECT distinct a.IDRATEIO
			,b.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,b.CREDITO
			,c.descContaNvl3 as CREDITONVL3
			,c.descContaNvl6 as CREDITONVL6
			,b.DEBITO
			,d.descContaNvl3 as DEBITONVL3
			,d.descContaNvl6 as DEBITONVL6
			,iif(Credito like '4.1.1.2%', c.descContaNvl1, d.descContaNvl1) as DESCNVL1
			,iif(Credito like '4.1.1.2%', c.descContaNvl2, d.descContaNvl2) as DESCNVL2
			,iif(Credito like '4.1.1.2%', c.descContaNvl3, d.descContaNvl3) as DESCNVL3
			,iif(Credito like '4.1.1.2%', c.descContaNvl4, d.descContaNvl4) as DESCNVL4
			,iif(Credito like '4.1.1.2%', c.descContaNvl5, d.descContaNvl5) as DESCNVL5
			,iif(Credito like '4.1.1.2%', c.descContaNvl6, d.descContaNvl6) as DESCNVL6
			,iif(Credito like '4.1.1.2%', b.credito, b.debito) as Cod_Conta
			,a.CODGERENCIAL
			,e.PROJETO
			,e.ACAO
			,b.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR
			,h.nome as 'UNIDADE'
			,CONTA_FECHAMENTO  = 'CSN - CONTR. SOCIAL NACIONAL'
			,'Receita' as Tipo
			,b.DATA
			,VLRCREDITO
			,VLRDEBITO
			,UNIFICAVALOR = vlrcredito - vlrdebito
		FROM [HubDados].[CorporeRM].[CRATEIOLC] a

			left join [HubDados].[CorporeRM].[CLANCA] b
		on a.LCTREF = b.LCTREF

			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on b.CREDITO collate Latin1_General_CI_AS = c.cdgContaNvl6

			left join [FINANCA].[dbo].[PlanoDeContasFull] d
		on b.DEBITO collate Latin1_General_CI_AS = d.cdgContaNvl6

			left join [FINANCA].[dbo].[CENTROCUSTO_DESCRICAO] e
		on SUBSTRING(a.CODGERENCIAL,3,16) COLLATE SQL_Latin1_General_CP1_CI_AI = e.CENTROCUSTO

			left join [HubDados].[CorporeRM].[TMOV] f
		on b.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO
			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on b.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and b.CODFILIAL = h.CODFILIAL

		
		) a
		where  YEAR([DATA]) = YEAR(@dt) and (Credito like '4.1.1.2%' or Debito like '4.1.1.2%') and 		
				(DEBITO not like '2.4.1.1.01%' or DEBITO is null) and COMPLEMENTO is not null

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --CONVÊNIOS, SUBV. E AUXÍLIOS

		select * from (SELECT distinct 
			a.IDRATEIO
			,b.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,b.CREDITO
			,c.descContaNvl3 as CREDITONVL3
			,c.descContaNvl6 as CREDITONVL6
			,b.DEBITO
			,d.descContaNvl3 as DEBITONVL3
			,d.descContaNvl6 as DEBITONVL6
			,iif(Credito like '5.1.1.2%' or Credito like '4.1.3.1%' or Credito like '1.9.6.1.01.005', c.descContaNvl1, d.descContaNvl1) as DESCNVL1
			,iif(Credito like '5.1.1.2%' or Credito like '4.1.3.1%' or Credito like '1.9.6.1.01.005', c.descContaNvl2, d.descContaNvl2) as DESCNVL2
			,iif(Credito like '5.1.1.2%' or Credito like '4.1.3.1%' or Credito like '1.9.6.1.01.005', c.descContaNvl3, d.descContaNvl3) as DESCNVL3
			,iif(Credito like '5.1.1.2%' or Credito like '4.1.3.1%' or Credito like '1.9.6.1.01.005', c.descContaNvl4, d.descContaNvl4) as DESCNVL4
			,iif(Credito like '5.1.1.2%' or Credito like '4.1.3.1%' or Credito like '1.9.6.1.01.005', c.descContaNvl5, d.descContaNvl5) as DESCNVL5
			,iif(Credito like '5.1.1.2%' or Credito like '4.1.3.1%' or Credito like '1.9.6.1.01.005', c.descContaNvl6, d.descContaNvl6) as DESCNVL6
			,iif(Credito like '5.1.1.2%' or Credito like '4.1.3.1%' or Credito like '1.9.6.1.01.005', b.credito, b.debito) as COD_CONTA
			,a.CODGERENCIAL
			,e.PROJETO
			,e.ACAO
			,b.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR
			,h.nome as 'UNIDADE'
			,'CONVÊNIOS, SUBV. E AUXÍLIOS' as CONTA_FECHAMENTO
			,'Receita' as TIPO
			,b.DATA
			,VLRCREDITO
			,VLRDEBITO
			,IIF( b.credito like '4.1.3.1%' or b.debito like '4.1.3.1%', vlrcredito - vlrdebito, vlrdebito-vlrcredito) as UNIFICAVALOR
		FROM [HubDados].[CorporeRM].[CRATEIOLC] a

			left join [HubDados].[CorporeRM].[CLANCA] b
		on a.LCTREF = b.LCTREF

			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on b.CREDITO collate Latin1_General_CI_AS = c.cdgContaNvl6

			left join [FINANCA].[dbo].[PlanoDeContasFull] d
		on b.DEBITO collate Latin1_General_CI_AS = d.cdgContaNvl6

			left join [FINANCA].[dbo].[CENTROCUSTO_DESCRICAO] e
		on SUBSTRING(a.CODGERENCIAL,3,16) COLLATE SQL_Latin1_General_CP1_CI_AI = e.CENTROCUSTO

			left join [HubDados].[CorporeRM].[TMOV] f
		on b.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO
			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on b.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and b.CODFILIAL = h.CODFILIAL

		
		) a

		where   YEAR([DATA]) = YEAR(@dt) and (Debito like '5.1.1.2%' or Credito like '5.1.1.2%' or Debito like '4.1.3.1%' or Credito like '4.1.3.1%') and IDRATEIO not in ('1929076', '1884747','2161963','2184729')

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --ALIENAÇÃO DE BENS

		select * from (SELECT distinct 
			IDRATEIO = null 
			,a.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,a.CREDITO
			,c.descContaNvl3 as CREDITONVL3
			,c.descContaNvl6 as CREDITONVL6
			,a.DEBITO
			,d.descContaNvl3 as DEBITONVL3
			,d.descContaNvl6 as DEBITONVL6
			,iif(CREDITO like '4.1.5.4.02.001', c.desccontanvl1, d.desccontanvl1) as DESCNVL1
			,iif(CREDITO like '4.1.5.4.02.001', c.desccontanvl2, d.desccontanvl2) as DESCNVL2
			,iif(CREDITO like '4.1.5.4.02.001', c.desccontanvl3, d.desccontanvl3) as DESCNVL3
			,iif(CREDITO like '4.1.5.4.02.001', c.desccontanvl4, d.desccontanvl4) as DESCNVL4
			,iif(CREDITO like '4.1.5.4.02.001', c.desccontanvl5, d.desccontanvl5) as DESCNVL5
			,iif(CREDITO like '4.1.5.4.02.001', c.desccontanvl6, d.desccontanvl6) as DESCNVL6	
			,iif(CREDITO like '4.1.5.4.02.001',  a.credito, a.debito) as COD_CONTA
			,CODGERENCIAL = null 
			,PROJETO = null 
			,ACAO = null 
			,a.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR	
			,h.nome as 'UNIDADE'
			,CONTA_FECHAMENTO  = 'ALIENAÇÃO DE BENS'
			,'Receita' as TIPO	
			,a.DATA
			,VLRCREDITO = null 
			,VLRDEBITO = null 
			,iif(c.desccontanvl3 = '', a.valor * -1, a.valor) as UNIFICAVALOR
		FROM [HubDados].[CorporeRM].[CLANCA] a

			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on a.CREDITO collate Latin1_General_CI_AS = c.cdgContaNvl6

			left join [FINANCA].[dbo].[PlanoDeContasFull] d
		on a.DEBITO collate Latin1_General_CI_AS = d.cdgContaNvl6 

			left join [HubDados].[CorporeRM].[TMOV] f
		on a.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO
			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on a.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and a.CODFILIAL = h.CODFILIAL

		
		) a

		where   YEAR([DATA]) = YEAR(@dt) and
				(CREDITO like '4.1.5.4.02.001' or DEBITO like '4.1.5.4.02.001')

INSERT INTO [FINANCA].[dbo].[FatoFechamento] --CONTRATO INTERNO EXECUTADO

		select * from (SELECT distinct IDRATEIO = null 
			,a.LCTREF
			,f.IDMOV
			,a.IDPARTIDA
			,a.CREDITO
			,c.descContaNvl3 as CREDITONVL3
			,c.descContaNvl6 as CREDITONVL6
			,a.DEBITO
			,d.descContaNvl3 as DEBITONVL3
			,d.descContaNvl6 as DEBITONVL6
			,iif(Credito like '4.1.3.2.02%' , c.descContaNvl1, d.descContaNvl1) as DESCNVL1
			,iif(Credito like '4.1.3.2.02%' , c.descContaNvl2, d.descContaNvl2) as DESCNVL2
			,iif(Credito like '4.1.3.2.02%' , c.descContaNvl3, d.descContaNvl3) as DESCNVL3
			,iif(Credito like '4.1.3.2.02%' , c.descContaNvl4, d.descContaNvl4) as DESCNVL4
			,iif(Credito like '4.1.3.2.02%' , c.descContaNvl5, d.descContaNvl5) as DESCNVL5
			,iif(Credito like '4.1.3.2.02%' , c.descContaNvl6, d.descContaNvl6) as DESCNVL6
			,iif(Credito like '4.1.3.2.02%' , a.credito, a.debito) as COD_CONTA
			,CODGERENCIAL = null 
			,PROJETO = null 
			,ACAO = null 
			,a.COMPLEMENTO
			,f.CODCFO
			,g.NOME as FORNECEDOR
			,h.nome as 'UNIDADE'
			,CONTA_FECHAMENTO = 'CONTRATO INTERNO'
			,'Receita' as TIPO 
			,a.DATA
			,VLRCREDITO = null 
			,VLRDEBITO = null 
			,iif(Credito like '4.1.3.2.02%', a.valor, a.valor *-1) as UNIFICAVALOR
		FROM [HubDados].[CorporeRM].[CLANCA] a

			left join [FINANCA].[dbo].[PlanoDeContasFull] c
		on a.CREDITO = c.cdgContaNvl6

			left join [FINANCA].[dbo].[PlanoDeContasFull] d
		on a.DEBITO = d.cdgContaNvl6 

			left join [HubDados].[CorporeRM].[TMOV] f
		on a.INTEGRACHAVE = CONVERT(VARCHAR(25),f.IDMOV)
			
			left join [HubDados].[CorporeRM].[FCFO] g
		on f.CODCFO = g.CODCFO

			LEFT JOIN [HubDados].[CorporeRM].[GDEPTO] h
		on a.CODDEPARTAMENTO collate Latin1_General_CI_AS = h.CODDEPARTAMENTO and a.CODFILIAL = h.CODFILIAL
		LEFT JOIN [FINANCA].[dbo].[descricao_CODTMV] i
		on f.CODTMV = i.CODTMV
		
		) a

		where (YEAR([DATA]) = YEAR(@dt) and (Credito like '4.1.3.2.02%' or Debito like '4.1.3.2.02%')) and 
				(DEBITO not like '2.4.1.1.01%' or DEBITO is null) and
				COMPLEMENTO is not null