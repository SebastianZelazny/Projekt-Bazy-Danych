create database projekt1;
use projekt1;


########################Tworzenie Bazy oraz Tabel###############################

create table Zgloszenia(
ID_Z int primary key auto_increment,
Tytul varchar(100) not null,
Opis varchar(1000) not null,
Zglaszajacy int not null,
Serwisant int not null,
Status int not null,
Data date not null,
Priorytet int default 2,
foreign key (Priorytet) references priorytety(ID_P),
foreign key (Status) references statusy(ID_S),
foreign key (Serwisant) references Serwisanci(ID_ser),
foreign key (Zglaszajacy) references zglaszajacy(ID_Zg)
);

drop table Zgloszenia;

create table zglaszajacy( 
ID_Zg int primary key auto_increment,
ID_Login int not null,
Imie varchar(50) not null,
Nazwisko varchar(50) not null,
E_mail varchar(50) not null,
foreign key (ID_Login) references Logowanie(ID_L) 
);

drop table zglaszajacy;

create table Serwisanci( 
ID_ser int primary key auto_increment,
ID_Login int not null,
Imie varchar(50) not null,
Nazwisko varchar(50) not null,
E_mail varchar(50) not null,
Obsluga_dzialu int not null,
foreign key (Obsluga_dzialu) references Dzialy(ID_d),
foreign key (ID_Login) references Logowanie(ID_L) 
);

drop table serwisanci;

create table Logowanie(
ID_L int primary key auto_increment,
Login varchar(50) unique not null,
Haslo varchar(50) not null
);

create table Dzialy(
ID_d int primary key auto_increment,
Typ_Dzialu varchar(50) not null
);

create table priorytety(
Id_P int auto_increment primary key,
Priorytet varchar(20) not null
);

create table Statusy(
Id_S int auto_increment primary key,
Status varchar(20) not null
);


############################ Wstawianie wartości do tabeli ###################################

insert into dzialy values (1,'CRM'),
						  (2,'Helpdesk'),
						  (3,'Develop'),
						  (4,'Poczta'),
						  (5,'Siec');

insert into statusy values  (1,'Oczekuje'),
							(2,'W Realizacji'),
							(3,'Zrealizowane');
                            
insert into priorytety (Priorytet) values ('Niski'),
										  ('Normalny'),
										  ('Wysoki'),
										  ('Krytyczny');

insert into logowanie (Login,Haslo) values  ('AdamK','AdamK123'),
											('JureB','JureB123'),
											('TomekZ','TomekZ123'),
											('AlaD','AlaD123'),
											('UlaR','UlaR123'),
											('KubaW','KubaW123'),
											('SzymonK','SzymonK123'),
											('KrzysiekF','KrzysiekF123'),
											('AdaT','AdaTk123'),
											('OlaO','OlaO123'),
											('FilipJ','FilipJ123'),
											('WitekH','WitekH123'),
											('BasiaB','BasiaB123');
                                            
insert into serwisanci (ID_Login,Imie,Nazwisko,E_mail,Obsluga_dzialu) values (1,"Adam","Kurek","adam.kurek@o2.pl",5),
																			 (2,"Jurek","Borys","Jurek.Borys@o2.pl",2),
																			 (6,"Kuba","Witkowski","Kuba.Witkowski@o2.pl",3),
																			 (7,"Krzysiek","Florek","Krzysiek.Florek@o2.pl",1),
																			 (9,"Ada","Tomaszek","Ada.Tomaszek@o2.pl",4),
																			 (11,"Filip","Janass","Filip.Janass@o2.pl",2),
																			 (13,"Basia","Barbara","Basia.Barbara@o2.pl",2);

drop table dzialy;
drop table logowanie;
drop table priorytety;
drop table serwisanci;
drop table statusy;
drop table zglaszajacy;
drop table zgloszenia;



																			
insert into zglaszajacy (ID_Login,Imie,Nazwisko,E_mail) values 	(3,"Tomek","Zachariasz","Tomek.Zachariasz@o2.pl"),
																(4,"Ala","Duda","Ala.Duda@o2.pl"),
																(5,"Ula","Radomiak","Ula.Radomiak@o2.pl"),
																(8,"Szymon","Kurzep","Szymon.Kurzep@o2.pl"),
																(10,"Ola","Olek","Ola.Olek@o2.pl"),
																(12,"Witek","Hanys","Witek.Hanys@o2.pl");
                                                                
insert into zgloszenia (Tytul,Opis,Zglaszajacy,Serwisant,Status,Data,Priorytet)  values ("Awaria Laptopa","Nie uruchamia się",3,2,1,"2017.03.20",2),
																						("Bląd w aplikacji","zly foramt daty w tescie.exe",5,3,1,"2017.03.23",3),
                                                                                        ("Dodanie uzytkownika do CRM","Dodanie uzytkownika do CRM",6,4,3,"2017.03.19",1),
                                                                                        ("Mysz do Laptopa","Nie działa mysz",4,7,2,"2017.03.24",2),
                                                                                        ("Nie mam dostępu do sieci","Mam ! na znaczku polaczenia ethernet",2,1,3,"2017.03.22",4),
                                                                                        ("Ponowna Awaria Laptopa","Znow sie nie uruchamia się",3,2,1,"2017.03.22",4);
                                                              
																			

############################ Tworzenie Widoków################################################
create view Liczba_zadan_dla_Poszczegolnego_serwisantaa as select ID_z, tytul, serwisanci.imie as imie , serwisanci.nazwisko as nazwisko from zgloszenia, serwisanci   where serwisant and serwisanci.id_ser=zgloszenia.serwisant;

drop view Liczba_zadan_dla_Poszczegolnego_serwisantaa;

create view Liczba_zadan_dla_Poszczegolnego_zglaszajacego as select ID_z, tytul ,Opis,zglaszajacy.imie as imie, zglaszajacy.nazwisko as nazwisko from zgloszenia,zglaszajacy where zglaszajacy and zglaszajacy.id_zg=zgloszenia.zglaszajacy;

drop view Liczba_zadan_dla_Poszczegolnego_serwisantaa;

create view Przedawnione as select ID_z,Tytul,Opis, zglaszajacy.Imie as imie_zgl, zglaszajacy.Nazwisko as nazwisko_zgl, serwisanci.Imie as imie_ser , serwisanci.nazwisko as nazwisko_ser,Data, now() as Bieżaca_Data from zgloszenia, zglaszajacy, serwisanci where (datediff(now(),Data))>30 and serwisanci.id_ser=zgloszenia.serwisant and zglaszajacy.id_zg=zgloszenia.zglaszajacy;

drop view Przedawnione;

create view Podzial_na_dzialy as select ID_Login,Imie,Nazwisko,dzialy.typ_dzialu from serwisanci, dzialy where Obsluga_dzialu and dzialy.id_d=serwisanci.obsluga_dzialu;

drop view Podzial_na_dzialy;


create view Liczba_zrealizowanych_na_serwisanta as select count(ID_Z) as liczbaZgloszen, serwisanci.imie as imie , serwisanci.nazwisko from zgloszenia,serwisanci where  Status="3" and serwisanci.id_ser=zgloszenia.serwisant group by Serwisant;

drop view Liczba_zrealizowanych_na_serwisanta;