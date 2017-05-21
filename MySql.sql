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
																			
insert into zglaszajacy (ID_Login,Imie,Nazwisko,E_mail) values 	(3,"Tomek","Zachariasz","Tomek.Zachariasz@o2.pl"),
																(4,"Ala","Duda","Ala.Duda@o2.pl"),
																(5,"Ula","Radomiak","Ula.Radomiak@o2.pl"),
																(8,"Szymon","Kurzep","Szymon.Kurzep@o2.pl"),
																(10,"Ola","Olek","Ola.Olek@o2.pl"),
																(12,"Witek","Hanys","Witek.Hanys@o2.pl");
                                                                
insert into zgloszenia (Tytul,Opis,Zglaszajacy,Serwisant,Status,Data,Priorytet)  values ()                                                              
																			

############################ Tworzenie Widoków################################################
create view Liczba_zadan_dla_Poszczegolnego_serwisantaa as select ID_z, tytul,Serwisant from zgloszenia where Serwisant;

create view Liczba_zadan_dla_Poszczegolnego_zglaszajacego as select ID_z, tytul,Opis,zglaszajacy from zgloszenia where Serwisant;

create view Przedawnione as select ID_z,Tytul,Opis,Zglaszajacy,Serwisant,Data from zgloszenie where datediff(now())-datediff((Data))>30;

create view Podzial_na_dzialy as select ID_Login,Imie,Nazwisko,Obsluga_dzialu from serwisanci where Obsluga_dzialu;

create view Liczba_zrealizowanych_na_serwisanta as select count(ID_Z) as liczbaZgloszen, Serwisant from zgloszenia where  Status="4" group by Serwisant;

