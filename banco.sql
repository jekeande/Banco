--------------------Projeto SQL----------------------------------
--------------------******primer exercicio*****------------------
SELECT b.numero AS conta,
		c.nome AS cliente_pai,
        f.nome AS cliente_filho
from cliente_conta AS a
JOIN conta AS b on b.id=a.id_conta
JOIN cliente AS c on c.id=a.id_cliente
JOIN (	SELECT *
     	from cliente_conta AS d
        JOIN cliente AS e on e.id=d.id_cliente
		WHERE d.dependente=1
	) AS f on f.id_conta=a.id_conta  
WHERE a.dependente=0
-------------------*****segundo exercicio******------------------
------5 contAS com mais transacoes-------------------------------
SELECT c.numero AS conta,
	   COUNT(a.id_cliente_conta) AS transacoes
from transacao AS a
JOIN cliente_conta AS b on b.id=a.id_cliente_conta
JOIN conta AS c on c.id=b.id_conta   
GROUP by conta
ORDER by transacoes DESC
LIMIT 5
------5 contAS com menos transacoes-------------------------------
SELECT c.numero AS conta,
	   COUNT(a.id_cliente_conta) AS transacoes
from transacao AS a
JOIN cliente_conta AS b on b.id=a.id_cliente_conta
JOIN conta AS c on c.id=b.id_conta   
GROUP by conta
ORDER by transacoes ASC
LIMIT 5
----------------------****tercer exercicio****---------------------
--------------------saldo das contas---------------------
Select 
c.conta As Conta,
ROUND(c.entradas,2) AS Entradas,
ROUND(c.saidas,2) as Saidas,
ROUND((c.entradas-c.saidas),2) As Saldo
from (
SELECT c.numero AS conta,
SUM(CASE when a.id_tipo_transacao =1 then a.valor else 0 end) as entradas,
SUM(CASE when a.id_tipo_transacao !=1 then a.valor else 0 end) As saidas
from transacao AS a
JOIN cliente_conta As b ON a.id_cliente_conta=b.id
Join conta as c On b.id_conta=c.id
GROUP by conta) as c
 