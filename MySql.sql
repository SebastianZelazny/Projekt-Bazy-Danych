create Database projekt1;
use projekt1;


########################Tworzenie Bazy oraz Tabel###############################

create table reports(
ID_Z int primary key auto_increment,
Title varchar(100) not null,
description varchar(1000) not null,
Requester int not null,
Repairer int not null,
Status int not null,
Data_R date not null,
priority int default 2,
foreign key (priority) references priorities(ID_P),
foreign key (Status) references statusy(ID_S),
foreign key (Repairer) references repairers(ID_rep),
foreign key (Requester) references Requester(ID_req)
);

drop table reports;

create table Requester( 
ID_req int primary key auto_increment,
ID_Login int not null,
Name_r varchar(50) not null,
Surname varchar(50) not null,
E_mail varchar(50) not null,
foreign key (ID_Login) references Logins(ID_L) 
);

drop table Requester;

create table repairers( 
ID_rep int primary key auto_increment,
ID_Login int not null,
Name_r varchar(50) not null,
Surname varchar(50) not null,
E_mail varchar(50) not null,
division int not null,
foreign key (division) references Divisions(ID_d),
foreign key (ID_Login) references Logins(ID_L) 
);

drop table repairers;

create table Logins(
ID_L int primary key auto_increment,
Login varchar(50) unique not null,
password varchar(50) not null
);

create table Divisions(
ID_d int primary key auto_increment,
Type_Division varchar(50) not null
);

create table priorities(
Id_P int auto_increment primary key,
priority varchar(20) not null
);

create table statusy(
Id_S int auto_increment primary key,
Status varchar(20) not null
);


############################ Wstawianie wartości do tabeli ###################################

insert into Divisions values (1,'CRM'),
						  (2,'Helpdesk'),
						  (3,'Develop'),
						  (4,'Poczta'),
						  (5,'Siec');

insert into statusy values  (1,'Oczekuje'),
							(2,'W Realizacji'),
							(3,'Zrealizowane');
                            
insert into priorities (priority) values ('Niski'),
										  ('Normalny'),
										  ('Wysoki'),
										  ('Krytyczny');

insert into Logins (Login,password) values  ('AdamK','AdamK123'),
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
                                            
insert into repairers (ID_Login,Name_r,Surname,E_mail,division) values (1,"Adam","Kurek","adam.kurek@o2.pl",5),
																			 (2,"Jurek","Borys","Jurek.Borys@o2.pl",2),
																			 (6,"Kuba","Witkowski","Kuba.Witkowski@o2.pl",3),
																			 (7,"Krzysiek","Florek","Krzysiek.Florek@o2.pl",1),
																			 (9,"Ada","Tomaszek","Ada.Tomaszek@o2.pl",4),
																			 (11,"Filip","Janass","Filip.Janass@o2.pl",2),
																			 (13,"Basia","Barbara","Basia.Barbara@o2.pl",2);



drop table Divisions;
drop table Logins;
drop table priorities;
drop table repairers;
drop table statusy;
drop table Requester;
drop table reports;



																			
insert into Requester (ID_Login,Name_r,Surname,E_mail) values 	(3,"Tomek","Zachariasz","Tomek.Zachariasz@o2.pl"),
																(4,"Ala","Duda","Ala.Duda@o2.pl"),
																(5,"Ula","Radomiak","Ula.Radomiak@o2.pl"),
																(8,"Szymon","Kurzep","Szymon.Kurzep@o2.pl"),
																(10,"Ola","Olek","Ola.Olek@o2.pl"),
																(12,"Witek","Hanys","Witek.Hanys@o2.pl");
                                                                
insert into reports (Title,description,Requester,Repairer,Status,Data_R,priority)  values ("Awaria Laptopa","Nie uruchamia się",3,2,1,"2017.03.20",2),
																						("Bląd w aplikacji","zly foramt daty w tescie.exe",5,3,1,"2017.03.23",3),
                                                                                        ("Dodanie uzytkownika do CRM","Dodanie uzytkownika do CRM",6,4,3,"2017.03.19",1),
                                                                                        ("Mysz do Laptopa","Nie działa mysz",4,7,2,"2017.03.24",2),
                                                                                        ("Nie mam dostępu do sieci","Mam ! na znaczku polaczenia ethernet",2,1,3,"2017.03.22",4),
                                                                                        ("Ponowna Awaria Laptopa","Znow sie nie uruchamia się",3,2,1,"2017.03.22",4);
                                                              
																			

############################ Tworzenie Widoków################################################
create view Numbers_of_requests_per_repairer as select ID_z, Title, repairers.Name_r as Name_r , repairers.Surname as Surname from reports, repairers   where Repairer and repairers.ID_rep=reports.Repairer;

drop view Numbers_of_requests_per_repairer;

create view Numbersof_request_per_requester as select ID_z, Title ,description,Requester.Name_r as Name_r, Requester.Surname as Surname from reports,Requester where Requester and Requester.ID_req=reports.Requester;

drop view Numbersof_request_per_requester;

create view Expaired as select ID_z,Title,description, Requester.Name_r as Name_req, Requester.Surname as Surname_req, repairers.Name_r as Name_rep , repairers.Surname as Surname_rep,Data_R, now() as Current_Data_R from reports, Requester, repairers where (datediff(now(),Data_R))>30 and repairers.ID_rep=reports.Repairer and Requester.ID_req=reports.Requester;

drop view Expaired;

create view departmentalization as select ID_Login,Name_r,Surname,Divisions.Type_Division from repairers, Divisions where division and Divisions.id_d=repairers.division;

drop view departmentalization;


create view Numbers_ended_per_requester as select count(ID_Z) as Numbers_requestes, repairers.Name_r as Name_rep , repairers.Surname as surname_rep from reports,repairers where  Status="3" and repairers.ID_rep=reports.Repairer group by Repairer;

drop view Numbers_ended_per_requester;