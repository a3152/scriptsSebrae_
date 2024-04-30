USE FINANCA

select conta
, descricao
,format(sum(Anterior),'c', 'pt-br') AS ANTERIOR
,format(sum(movimento),'c', 'pt-br') as MOVIMENTO
,format(sum(Debitos),'c', 'pt-br') AS DEBITOS

from _rmBALANCETE 
WHERE len(conta) <2 
and month(dataOrcamento) ='3'
and day(dataOrcamento) = '1'
and year(dataOrcamento)='2024'
GROUP by conta, descricao
order by conta asc 

SELECT * FROM _rmBALANCETE  
ORDER BY dataOrcamento DESC