use FidelidadeDb;

--select * from Recompensa

update Recompensa set nome='Cofre Contador',descricao='Cofre contador de moedas, ao inserir as moedas o cofre contabiliza o valor (em reais) depositado nele.',pontos=63080,dataInclusao=getdate(),qtdEstoque=100 where id = 1
update Recompensa set nome='Bola de Futebol',descricao='Bola de futebol de campo em EVA, 68cm de circunfer�ncia, 6 gomos.',pontos=50920,dataInclusao=getdate(),qtdEstoque=200 where id = 2
update Recompensa set nome='Bolsa de Gin�stica',descricao='Bolsa de meia viagem com um bolso externo e um interno medindo: 45x26x21cm.',pontos=37600,dataInclusao=getdate(),qtdEstoque=50 where id = 3
update Recompensa set nome='Cooleer',descricao='Cooler t�rmico de polipropileno (parede dupla) - 10 latas m�x.',pontos=111100,dataInclusao=getdate(),qtdEstoque=20 where id = 4
update Recompensa set nome='Guarda Sol',descricao='Guarda sol com haste central em alum�nio frisado, varetas em a�o bicromatizadas, revestimento em lona emborrachada (PVC) com trama em poli�ster.',pontos=124.760,dataInclusao=getdate(),qtdEstoque=50 where id = 5
update Recompensa set nome='Toalha de Praia',descricao='Toalha de praia 76 x 152 cm j� estampada (estampas de pontos tur�sticos do RJ, peixes e p�ssaros.',pontos=59000,dataInclusao=getdate(),qtdEstoque=100 where id = 6
update Recompensa set nome='Jogo de copos de shot',descricao='Copos de tequila de vidro 60ml.',pontos=12540,dataInclusao=getdate(),qtdEstoque=120 where id = 7
update Recompensa set nome='Massageador El�trico',descricao='Super massageador el�trico anat�mico com 04 pontas.',pontos=31900,dataInclusao=getdate(),qtdEstoque=100 where id = 8
update Recompensa set nome='Bolsa de Ombro',descricao='Sacola em duratran medindo:41x27x08 cm, al�as de ombro e bolso interno.',pontos=21700,dataInclusao=getdate(),qtdEstoque=50 where id = 9
update Recompensa set nome='Squeeze Inox 400 ml',descricao='Garrafa esportiva em a�o inoxid�vel com bico e capacidade para 400 ml.',pontos=	21220,dataInclusao=getdate(),qtdEstoque=100 where id = 10
update Recompensa set nome='Cadeira de Praia',descricao='Cadeira em inox com 5 posi��es.',pontos=163900	,dataInclusao=getdate(),qtdEstoque=100 where id = 11
update Recompensa set nome='Bon� PSafe',descricao='Bon� em microfibra com regulador de pl�stico.',pontos=17600,dataInclusao=getdate(),qtdEstoque=0,ativo=0 where id = 12
update Recompensa set nome='Hud USB',descricao='USB Hub com 04 sa�das, velocidade 2.0. Medindo aproximadamente 62 x 52 x 75mm.',pontos=36700,dataInclusao=getdate(),qtdEstoque=100 where id = 13


set identity_insert.recompensa on
insert Recompensa (id,nome,ativo,pontos,dataInclusao,nomeImagem,descricao,qtdEstoque)
select 12,'Bon� PSafe',1,17600,getdate(),'brinde_012.png','Bon� em microfibra com regulador de pl�stico.',0

insert Recompensa (id,nome,ativo,pontos,dataInclusao,nomeImagem,descricao,qtdEstoque)
select 13,'Hud USB',1,36700,getdate(),'brinde_013.png','USB Hub com 04 sa�das, velocidade 2.0. Medindo aproximadamente 62 x 52 x 75mm.',100