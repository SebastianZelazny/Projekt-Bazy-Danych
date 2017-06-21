create Database projekt1;
use projekt1;


########################Tworzenie Bazy oraz Tabel###############################

create table reports(
ID_Z int primary key auto_increment,
Title varchar(100) not null,
description varchar(1000) not null,
Requester int not null,
Repairer int not null,
Status int default 1,
Data_R date not null,
priority int default 2,
foreign key (priority) references priorities(ID_P),
foreign key (Status) references statusy(ID_S),
foreign key (Repairer) references repairers(ID_rep),
foreign key (Requester) references Requester(ID_req)
);


create table Requester( 
ID_req int primary key auto_increment,
ID_Login_req int not null,
Name_req varchar(50) not null,
Surname_req varchar(50) not null,
E_mail_req varchar(50) not null,
foreign key (ID_Login_req) references Logins(ID_L) 
);


create table repairers( 
ID_rep int primary key auto_increment,
ID_Login_rep int not null,
Name_rep varchar(50) not null,
Surname_rep varchar(50) not null,
E_mail_rep varchar(50) not null,
division int not null,
foreign key (division) references Divisions(ID_d),
foreign key (ID_Login_rep) references Logins(ID_L) 
);


create table Logins(
ID_L int primary key auto_increment,
Login varchar(50) unique not null,
password varchar(50) not null,
Role varchar(10)
);

create table Divisions(
ID_d int primary key auto_increment,
Type_Division varchar(50) not null
);

create table priorities(
Id_P int auto_increment primary key,
priority_p varchar(20) not null
);

create table statusy(
Id_S int auto_increment primary key,
Status_s varchar(20) not null
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
                            
insert into priorities (priority_p) values ('Niski'),
										  ('Normalny'),
										  ('Wysoki'),
										  ('Krytyczny');

insert into Logins (Login,password,Role) values  ('AdamK','AdamK123','rep'),
											('JureB','JureB123','rep'),
											('TomekZ','TomekZ123','req'),
											('AlaD','AlaD123','req'),
											('UlaR','UlaR123','req'),
											('KubaW','KubaW123','rep'),
											('SzymonK','SzymonK123','rep'),
											('KrzysiekF','KrzysiekF123','req'),
											('AdaT','AdaTk123','rep'),
											('OlaO','OlaO123','req'),
											('FilipJ','FilipJ123','rep'),
											('WitekH','WitekH123','req'),
											('BasiaB','BasiaB123','rep');
                                            
insert into repairers (ID_Login_rep,Name_rep,Surname_rep,E_mail_rep,division) values (1,"Adam","Kurek","adam.kurek@o2.pl",5),
																			 (2,"Jurek","Borys","Jurek.Borys@o2.pl",2),
																			 (6,"Kuba","Witkowski","Kuba.Witkowski@o2.pl",3),
																			 (7,"Krzysiek","Florek","Krzysiek.Florek@o2.pl",1),
																			 (9,"Ada","Tomaszek","Ada.Tomaszek@o2.pl",4),
																			 (11,"Filip","Janass","Filip.Janass@o2.pl",2),
																			 (13,"Basia","Barbara","Basia.Barbara@o2.pl",2);


																			
insert into Requester (ID_Login_Req,Name_req,Surname_req,E_mail_req) values 	(3,"Tomek","Zachariasz","Tomek.Zachariasz@o2.pl"),
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
                                                              
###################################### Drop Table ###########################################			
            
drop table Divisions;
drop table Logins;
drop table priorities;
drop table repairers;
drop table statusy;
drop table Requester;
drop table reports;

############################ Tworzenie Widoków ###############################################


create view Numbers_of_requests_per_repairer as select ID_z, Title, repairers.Name_rep as Name_r , repairers.Surname_rep as Surname from reports, repairers   where Repairer and repairers.ID_rep=reports.Repairer;
create view Numbersof_request_per_requester as select ID_z, Title ,description,Requester.Name_req as Name_r, Requester.Surname_req as Surname from reports,Requester where Requester and Requester.ID_req=reports.Requester;
create view Expaired as select ID_z,Title,description, Requester.Name_req as Name_req, Requester.Surname_req as Surname_req, repairers.Name_rep as Name_rep , repairers.Surname_rep as Surname_rep,Data_R, now() as Current_Data_R from reports, Requester, repairers where (datediff(now(),Data_R))>30 and repairers.ID_rep=reports.Repairer and Requester.ID_req=reports.Requester;
create view departmentalization as select ID_Login_rep,Name_rep,Surname_rep,Divisions.Type_Division from repairers, Divisions where division and Divisions.id_d=repairers.division;
create view Numbers_ended_per_requester as select count(ID_Z) as Numbers_requestes, repairers.Name_rep as Name_rep , repairers.Surname_rep as surname_rep from reports,repairers where  Status_s="3" and repairers.ID_rep=reports.Repairer group by Repairer;
create view list_of_repairers as select ID_rep, ID_Login_Rep,logins.Login as Login,logins.Role as Rola from logins,repairers where logins.ID_L=repairers.ID_Login_Rep;
create view view_request_how_repairer as select * from reports left join repairers on reports.Repairer=repairers.ID_rep left join requester on reports.requester=requester.ID_req left join logins on logins.ID_L=repairers.ID_Login_rep left join priorities on reports.priority=priorities.ID_P left join statusy on reports.status=statusy.ID_S;
create view view_request_how_requester as select * from reports left join repairers on reports.Repairer=repairers.ID_rep left join requester on reports.requester=requester.ID_req left join logins on logins.ID_L=requester.ID_Login_req left join priorities on reports.priority=priorities.ID_P left join statusy on reports.status=statusy.ID_S;


###################################Usuwanie Widokow#############################################

drop view Numbers_of_requests_per_repairer;
drop view Numbersof_request_per_requester;
drop view Expaired;
drop view departmentalization;
drop view Numbers_ended_per_requester;
drop view list_of_repairers;
drop view view_request_how_repairer;
drop view view_request_how_requester;

################################# Testowe Zapytania ##############################################

select ID_Z,Title,description,priority_p,E_mail_rep,E_mail_req,Status_s,Data_R from view_request_how_requester where login='witekh';

select * from repairers left join logins on repairers.ID_Login_rep=logins.ID_L where logins.login='kubaw'
 

