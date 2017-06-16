--PSDEVDB001\DBDEVODS001
USE CampanhaDb
go
--Deleta todos os banners da himidia - click on
delete from BannerExibicao where bannerId in (select id from banner where campanhaId = 1)
delete from banner where campanhaId = 1

-- Insere as novas campanhas
insert into campanha values (  'Dada.net M�xico' , 1 , 1 )
insert into campanha values (  'Editora Europa' , 1 , 1 )
insert into campanha values (  'Dada.net M�xico' , 1 , 1 )
insert into campanha values (  'Empregos.com.br' , 1 , 1 )
insert into campanha values (  'Glamour' , 1 , 1 )
insert into campanha values (  'Google Adwords' , 1 , 1 )
insert into campanha values (  'PoliShop CPV' , 1 , 1 )
insert into campanha values (  'Sacks Perfumaria' , 1 , 1 )
insert into campanha values (  'Safari Shop - e-Commerce' , 1 , 1 )
insert into campanha values (  'Dafti' , 1 , 1 )
insert into campanha values (  'KingLotto' , 1 , 1 )

-- Insere os novos banners
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=14560&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=14560&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=14561&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=14561&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=14562&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=14562&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=14563&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=14563&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=14564&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=14564&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=14565&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=14565&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=14566&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=14566&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=14567&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=14567&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=14568&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=14568&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=14571&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=14571&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=15352&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=15352&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=15353&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=15353&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=15354&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=15354&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=15376&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=15376&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=15377&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=15377&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=15378&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=15378&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=15379&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=15379&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=15380&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=15380&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=15381&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=15381&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=15399&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=15399&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=15400&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=15400&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=15401&campid=16370;368&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=15401&campid=16370;368&siteid=19229"/></a>' from campanha where nome = 'Click On'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=9338&campid=16370;288&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=9338&campid=16370;288&siteid=19229"/></a>' from campanha where nome = 'Editora Europa'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=10399&campid=16370;343&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=10399&campid=16370;343&siteid=19229"/></a>' from campanha where nome = 'Empregos.com.br'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=8842&campid=16370;289&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=8842&campid=16370;289&siteid=19229"/></a>' from campanha where nome = 'Glamour'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=16003&campid=16370;289&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=16003&campid=16370;289&siteid=19229"/></a>' from campanha where nome = 'Glamour'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=16882&campid=16370;289&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=16882&campid=16370;289&siteid=19229"/></a>' from campanha where nome = 'Glamour'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=17105&campid=16370;289&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=17105&campid=16370;289&siteid=19229"/></a>' from campanha where nome = 'Glamour'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=17429&campid=16370;289&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=17429&campid=16370;289&siteid=19229"/></a>' from campanha where nome = 'Glamour'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=16929&campid=16370;475&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=16929&campid=16370;475&siteid=19229"/></a>' from campanha where nome = 'Google Adwords'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=17159&campid=16370;484&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=17159&campid=16370;484&siteid=19229"/></a>' from campanha where nome = 'NovoFAX'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=17160&campid=16370;484&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=17160&campid=16370;484&siteid=19229"/></a>' from campanha where nome = 'NovoFAX'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=17274&campid=16370;484&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=17274&campid=16370;484&siteid=19229"/></a>' from campanha where nome = 'NovoFAX'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=17275&campid=16370;484&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=17275&campid=16370;484&siteid=19229"/></a>' from campanha where nome = 'NovoFAX'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=17283&campid=16370;484&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=17283&campid=16370;484&siteid=19229"/></a>' from campanha where nome = 'NovoFAX'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=15444&campid=16370;378&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=15444&campid=16370;378&siteid=19229"/></a>' from campanha where nome = 'Sacks Perfumaria'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=11743&campid=16370;219&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=11743&campid=16370;219&siteid=19229"/></a>' from campanha where nome = 'Safari Shop - e-Commerce'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=11744&campid=16370;219&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=11744&campid=16370;219&siteid=19229"/></a>' from campanha where nome = 'Safari Shop - e-Commerce'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=11745&campid=16370;219&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=11745&campid=16370;219&siteid=19229"/></a>' from campanha where nome = 'Safari Shop - e-Commerce'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=11746&campid=16370;219&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=11746&campid=16370;219&siteid=19229"/></a>' from campanha where nome = 'Safari Shop - e-Commerce'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=11747&campid=16370;219&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=11747&campid=16370;219&siteid=19229"/></a>' from campanha where nome = 'Safari Shop - e-Commerce'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=11748&campid=16370;219&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=11748&campid=16370;219&siteid=19229"/></a>' from campanha where nome = 'Safari Shop - e-Commerce'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=11749&campid=16370;219&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=11749&campid=16370;219&siteid=19229"/></a>' from campanha where nome = 'Safari Shop - e-Commerce'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=11750&campid=16370;219&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=11750&campid=16370;219&siteid=19229"/></a>' from campanha where nome = 'Safari Shop - e-Commerce'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=11751&campid=16370;219&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=11751&campid=16370;219&siteid=19229"/></a>' from campanha where nome = 'Safari Shop - e-Commerce'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=11752&campid=16370;219&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=11752&campid=16370;219&siteid=19229"/></a>' from campanha where nome = 'Safari Shop - e-Commerce'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=11753&campid=16370;219&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=11753&campid=16370;219&siteid=19229"/></a>' from campanha where nome = 'Safari Shop - e-Commerce'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=11754&campid=16370;219&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=11754&campid=16370;219&siteid=19229"/></a>' from campanha where nome = 'Safari Shop - e-Commerce'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=11755&campid=16370;219&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=11755&campid=16370;219&siteid=19229"/></a>' from campanha where nome = 'Safari Shop - e-Commerce'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=11756&campid=16370;219&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=11756&campid=16370;219&siteid=19229"/></a>' from campanha where nome = 'Safari Shop - e-Commerce'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=11757&campid=16370;219&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=11757&campid=16370;219&siteid=19229"/></a>' from campanha where nome = 'Safari Shop - e-Commerce'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=17232&campid=16370;415&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=17232&campid=16370;415&siteid=19229"/></a>' from campanha where nome = 'Dafti'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=17245&campid=16370;415&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=17245&campid=16370;415&siteid=19229"/></a>' from campanha where nome = 'Dafti'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=17247&campid=16370;415&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=17247&campid=16370;415&siteid=19229"/></a>' from campanha where nome = 'Dafti'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=17248&campid=16370;415&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=17248&campid=16370;415&siteid=19229"/></a>' from campanha where nome = 'Dafti'
insert into banner select 1,Id,'<a href="http://v2.afilio.com.br/tracker.php?banid=17342&campid=16370;476&siteid=19229" target="_blank"> <img src="http://v2.afilio.com.br/banner.php?banid=17342&campid=16370;476&siteid=19229"/></a>' from campanha where nome = 'KingLotto'