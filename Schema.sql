DROP DATABASE Project;
CREATE DATABASE Project;
USE Project;


CREATE TABLE Police_Employee (
                               Police_ID varchar(10) NOT NULL,
                               Name varchar(50) NOT NULL,
                               DOB date DEFAULT NULL,
                               Spouse_name varchar(50) DEFAULT NULL,
                               Blood_Group enum('A+','A-','B+','B-','O+','O-','AB+','AB-') DEFAULT NULL,
                               Gender enum('M','F') DEFAULT NULL,
                               Rank enum('Constable','SI','Asst.Inspector','Inspector','DSP','ASP','SP','DIG','IGP','ADGP','DGP','DIB') DEFAULT NULL,
                               Phone_number bigint(10) DEFAULT NULL,
                               salary bigint(20) DEFAULT NULL,
                               Department varchar(10) DEFAULT NULL,
                               PRIMARY KEY (Police_ID)
);

CREATE TABLE Police_Station (
                              Branch_ID varchar(10) NOT NULL,
                              Police_ID varchar(10) DEFAULT NULL,
                              Building_No int(11) DEFAULT NULL,
                              Street varchar(50) DEFAULT NULL,
                              City varchar(50) DEFAULT NULL,
                              District_ID varchar(10) DEFAULT NULL,
                              PRIMARY KEY (Branch_ID),
                              KEY Police_ID (Police_ID),
                              FOREIGN KEY (Police_ID) REFERENCES Police_Employee (Police_ID)
                              On Delete restrict
) ;



CREATE TABLE Attendance (
                          Date date NOT NULL,
                          Police_ID varchar(10) NOT NULL,
                          Entry_time time DEFAULT NULL,
                          Exit_time time DEFAULT NULL,
                          PRIMARY KEY (Date,Police_ID),
                          KEY Police_ID (Police_ID),
                          FOREIGN KEY (Police_ID) REFERENCES Police_Employee (Police_ID)
                          On Delete restrict
);





CREATE TABLE History (
                       Police_ID varchar(10) NOT NULL,
                       Branch_ID varchar(10) NOT NULL,
                       Start_Date date DEFAULT NULL,
                       End_Date date DEFAULT NULL,
                       Rank enum('Constable','SI','Asst.Inspector','Inspector','DSP','ASP','SP','DIG','IGP','ADGP','DGP','DIB') DEFAULT NULL,
                       FOREIGN KEY (Police_ID) REFERENCES Police_Employee (Police_ID),
                       FOREIGN KEY (Branch_ID) REFERENCES Police_Station (Branch_ID)
                       On Delete restrict
);


CREATE TABLE District (
                        District_ID varchar(10) NOT NULL,
                        Police_ID varchar(10) DEFAULT NULL,
                        District_Magistrate varchar(50) DEFAULT NULL,
                        Division_Commissioner varchar(50) DEFAULT NULL,
                        PRIMARY KEY (District_ID),
                        FOREIGN KEY (Police_ID) REFERENCES Police_Employee (Police_ID)
                        On Delete restrict
);


CREATE TABLE Crime (
                     Case_ID varchar(10) NOT NULL,
                     Crime_Type enum('Murder','Kidnapping','Robbery','Missing','Challan') NOT NULL,
                     Police_ID varchar(10) DEFAULT NULL,
                     Date_Of_Reporting date NOT NULL,
                     Date_Of_Crime date DEFAULT NULL,
                     Time_Of_Reporting time NOT NULL,
                     Time_Of_Crime time DEFAULT NULL,
                     Filer_Name varchar(50) NOT NULL,
                     Crime_Location varchar(50) DEFAULT NULL,
                     Filer_Relation_To_Victim varchar(50) DEFAULT NULL,
                     PRIMARY KEY (Case_ID),
                     FOREIGN KEY (Police_ID) REFERENCES Police_Employee (Police_ID)
                     On Delete restrict
);


CREATE TABLE Murder (
                      Murder_ID varchar(10) NOT NULL,
                      Name_Of_Victim varchar(50) DEFAULT NULL,
                      Weapon varchar(50) DEFAULT NULL,
                      Autopsy enum('Y','N') DEFAULT NULL,
                      PRIMARY KEY (Murder_ID),
                      FOREIGN KEY (Murder_ID) REFERENCES Crime (Case_ID)
) ;


CREATE TABLE Kidnapping (
                          Kidnap_ID varchar(10) NOT NULL,
                          Name_Of_Victim varchar(50) DEFAULT NULL,
                          Name_Of_Kidnapper varchar(50) DEFAULT NULL,
                          Last_Seen_Date date DEFAULT NULL,
                          Last_Seen_Time time DEFAULT NULL,
                          PRIMARY KEY (Kidnap_ID),
                          FOREIGN KEY (Kidnap_ID) REFERENCES Crime (Case_ID)
);

CREATE TABLE Robbery (
                       Robbery_ID varchar(10) NOT NULL,
                       Loss varchar(250) DEFAULT NULL,
                       PRIMARY KEY (Robbery_ID),
                       FOREIGN KEY (Robbery_ID) REFERENCES Crime (Case_ID)
);

CREATE TABLE Missing (
                       Missing_ID varchar(10) NOT NULL,
                       Name varchar(30) NOT NULL,
                       Father_name varchar(30) DEFAULT NULL,
                       Age int(11) NOT NULL,
                       Color varchar(10) DEFAULT NULL,
                       Height decimal(2,1) DEFAULT NULL,
                       PRIMARY KEY (Missing_ID)
);






CREATE TABLE Challan (
                       Challan_ID varchar(10) NOT NULL,
                       Vehicle_ID varchar(10) DEFAULT NULL,
                       Name varchar(30) DEFAULT NULL,
                       Vechile_Registration_No varchar(20) DEFAULT NULL,
                       Offence_description varchar(50) DEFAULT NULL,
                       PRIMARY KEY (Challan_ID),
                       FOREIGN KEY (Challan_ID) REFERENCES Crime (Case_ID)
);

CREATE TABLE Passport_verification (
                                     Pass_ID varchar(15) NOT NULL,
                                     Name varchar(30) NOT NULL,
                                     Address varchar(50) NOT NULL,
                                     Phone_no bigint(10) NOT NULL,
                                     Verified_by varchar(30) NOT NULL,
                                     Spouse_name varchar(30) DEFAULT NULL,
                                     Status enum('Verified','Pending','Rejected') DEFAULT NULL,
                                     FOREIGN KEY (Verified_by) REFERENCES Police_Employee (Police_ID)
                                     ON Delete restrict
) ;


CREATE TABLE Person_of_interest (
                                  Suspect_ID varchar(10) NOT NULL,
                                  Case_Involved varchar(50) NOT NULL,
                                  Name varchar(30) NOT NULL,
                                  DOB date DEFAULT NULL,
                                  Gender enum('M','F') DEFAULT NULL,
                                  Blood_Group enum('A+','A-','B+','B-','O+','O-','AB+','AB-') DEFAULT NULL,
                                  Residential_address varchar(150) DEFAULT NULL,
                                  Phone_no bigint(10) DEFAULT NULL,
                                  Office_address varchar(50) DEFAULT NULL,
                                  DNA varchar(100) DEFAULT NULL,
                                  Finger_print varchar(50) DEFAULT NULL,
                                  Passport_details varchar(150) DEFAULT NULL,
                                  Spouse_name varchar(30) DEFAULT NULL,
                                  PRIMARY KEY (Suspect_ID),
                                  FOREIGN KEY (Case_Involved) REFERENCES Crime (Case_ID) 
                                  ON DELETE CASCADE
) ;


CREATE TABLE Court (
                     Court_ID varchar(10) NOT NULL,
                     Date date NOT NULL,
                     Crime_ID varchar(10) NOT NULL,
                     Name_Of_Judge varchar(50) DEFAULT NULL,
                     Name_Of_Defender varchar(50) DEFAULT NULL,
                     Name_Of_Accuser varchar(50) DEFAULT NULL,
                     Sentence varchar(250) DEFAULT NULL,
                     PRIMARY KEY (Court_ID,Date,Crime_ID)
);



CREATE TABLE Solved_Cases (
                            Case_ID varchar(10) NOT NULL,
                            Court_ID varchar(10) DEFAULT NULL,
                            Section_Of_Law varchar(20) DEFAULT NULL,
                            Suspect_ID varchar(10) DEFAULT NULL,
                            PRIMARY KEY (Case_ID),
                            KEY Court_ID (Court_ID),
                            FOREIGN KEY (Court_ID) REFERENCES Court (Court_ID)
) ;



Create table  Insert_Crime_Audit(
                                  Case_ID varchar(10) Primary Key,
                                  Audit_Data varchar(150)
);

Create table  Insert_Solved_caset(
                                   Case_ID varchar(10) Primary Key,
                                   Audit varchar(150)
);


INSERT INTO Police_Employee VALUES
('IPS1001','Sanjeev Tyagi','1982-10-15','Rapti','A-','M','DIB',9152365984,145000,'Police'),
('IPS1002','Moin Khan','1935-10-05','Zubeda','A+','M','IGP',9236541024,90000,'Police'),
('IPS1003','Suman Singh','1935-08-30','Kartik','B-','F','DIB',8076541024,152000,'IPS'),
('IPS1004','Nissar Khan','1955-05-04','Tabassum','AB+','F','DIB',9236541251,147000,'IPS'),
('IPS1005','Pratyush Sirkar','1930-05-29','Ritu','A+','M','DIG',9125445011,133000,'IPS'),
('IPS1006','Kareem Qureshi','1949-03-19','Garima','O+','M','ADGP',8975445011,103000,'IPS'),
('IPS1201','Abdul Khalid','1975-11-17','Rashi','AB-','M','DIG',9807545011,133000,'IPS'),
('IPS1202','Milkha Singh','1970-01-25','Rehsma','A+','M','DIG',8075045011,133000,'IPS'),
('IPS1203','Rameshwar Bapat','1980-06-14','Kaarthi','AB+','M','Inspector',7000124501,43000,'IPS'),
('IPS1204','Surendra Kashyap','1975-12-12','Menka','B+','M','SP',8145045011,63000,'IPS'),
('IPS1205','Lalit Ladhha','1980-09-03','Shailja','O+','M','DIG',9236123456,105000,'IPS'),
('KPS1004','Girish Chandran','1965-10-23','Suman','O+','M','Constable',9987456103,85000,'Police'),
('KPS1005','Abhishek Khandekar','1960-05-13','Maria','O+','M','Constable',9876545103,85000,'Police');

INSERT INTO Police_Station VALUES 
('KL101','IPS1001',1,'KSHB Collony, Kalleppully','Palakkad','673004'),
('KL102','IPS1002',13,'Hemambika Nagar, Railway Colony, Olavakkode','Palakkad','678005'),
('KL103','IPS1003',3,'Kerala Gazetted Officers Association, Ward No 81, ','Thiruvananthapuram','679531'),
('KL104','IPS1004',2,'Cheruthuruthy Police Station','Thrissur','356401'),
('KL105','IPS1005',13,'Thalook Office Rd, Puthiyara','Kozhikode','211175'),
('KL106','IPS1006',14,'702 Blackburn Drive Essex','kochi','486407'),
('KL107','IPS1201',2,'24 Harvard Street Rocklin','Palakkad','211179'),
('KL108','IPS1202',5,'3 Marconi Lane South Windsor','Coimbatore','431470'),
('KL109','IPS1203',41,'7451 Bowman Avenue Port Washington,','Kozhikode','273208'),
('KL110','IPS1204',114,'5 N. Strawberry Lane Basking Ridge','Trivendrum','482363'),
('KL111','IPS1205',105,'7950 N. Lafayette Ave. Saratoga Springs','Kollam','431196'),
('KL112','KPS1004',33,'42 E. Summerhouse St.Hackettstown','Kovalam','809111'),
('KL113','KPS1005',33,'502 SE. Clinton Street Manchester Township','Ottapalam','330409');


INSERT INTO History VALUES ('IPS1001','KL101','1997-10-15','2015-03-01','DSP'),
('IPS1002','KL101','1952-03-05','1955-05-29','DSP'),
('IPS1002','KL103','1955-05-30','1959-10-03','SP'),
('IPS1003','KL103','1953-05-15','1967-10-31','DIG'),
('IPS1002','KL101','1967-11-03','1976-10-07','IGP'),
('KPS1004','KL102','1979-10-29','1985-06-13','Constable'),
('KPS1004','KL105','1985-06-15','1989-03-02','Constable'),
('KPS1005','KL105','1991-05-10','1992-06-22','SI'),
('KPS1005','KL102','1992-03-17','1992-06-21','Inspector'),
('KPS1005','KL106','1992-06-25','1995-06-21','DSP'),
('IPS1004','KL103','1971-04-02','1995-09-25','ADGP'),
('IPS1004','KL105','1995-09-30','1997-10-21','DGP'),
('IPS1004','KL103','1997-10-22','2000-09-25','DIB'),
('IPS1005','KL102','1953-02-06','1965-12-21','ASP'),
('IPS1006','KL111','1968-04-28','1976-10-07','SP'),
('IPS1006','KL104','1976-10-08','1977-10-03','DIG'),
('IPS1006','KL106','1977-11-12','1979-04-12','IGP'),
('IPS1006','KL109','1979-04-20','1989-10-17','ADGP'),
('IPS1006','KL101','1989-12-06','1990-03-01','DGP'),
('IPS1201','KL110','2001-02-05','2015-12-01','SP'),
('IPS1201','KL101','2015-12-05','2016-12-01','DIG'),
('IPS1202','KL102','2001-02-05','2009-12-01','SP'),
('IPS1203','KL110','2001-02-05','2005-02-01','Inspector'),
('IPS1204','KL105','2003-02-05','2005-12-12','ASP'),
('IPS1204','KL110','2005-12-15','2015-12-01','SP'),
('IPS1205','KL101','1990-02-15','1995-03-14','ASP'),
('IPS1205','KL102','1995-03-15','2002-03-24','SP'),
('IPS1205','KL113','2002-03-25','2014-12-01','DIG');




INSERT INTO Attendance VALUES ('2019-02-01','IPS1001','10:00:15','17:25:10'),('2019-02-01','IPS1002','09:59:13','17:32:13'),('2019-02-01','IPS1003','09:55:10','17:39:18'),('2019-02-01','IPS1004','10:00:19','17:18:00'),('2019-02-01','IPS1005','09:47:19','17:07:30'),('2019-02-01','IPS1006','09:55:09','17:30:40'),('2019-02-01','IPS1201','09:45:47','17:34:01'),('2019-02-01','IPS1202','10:06:20','17:39:12'),('2019-02-01','IPS1203','10:12:15','17:15:16'),('2019-02-01','IPS1204','09:47:06','17:12:43'),('2019-02-01','IPS1205','09:33:19','17:20:56'),('2019-02-01','KPS1004','09:51:44','17:36:59'),('2019-02-01','KPS1005','10:08:19','17:09:54'),('2019-02-02','IPS1002','10:20:30','17:41:12'),('2019-02-02','IPS1003','10:01:38','17:09:23'),('2019-02-02','IPS1004','10:27:21','17:04:38'),('2019-02-02','IPS1005','10:21:26','17:18:47'),('2019-02-02','IPS1006','10:21:19','17:29:26'),('2019-02-02','IPS1202','09:56:35','17:33:56'),('2019-02-02','IPS1203','10:20:02','17:04:40'),('2019-02-02','IPS1205','09:48:01','17:23:32'),('2019-02-02','KPS1004','10:25:14','17:36:24'),('2019-02-02','KPS1005','09:35:56','17:24:50'),('2019-02-03','IPS1002','10:12:00','17:41:35'),('2019-02-03','IPS1004','10:29:28','17:07:36'),('2019-02-03','IPS1005','10:17:08','17:26:37'),('2019-02-03','IPS1006','09:34:52','17:08:03'),('2019-02-03','IPS1201','09:52:23','17:11:01'),('2019-02-03','IPS1202','10:23:52','17:13:03'),('2019-02-03','IPS1204','09:52:34','17:03:47'),('2019-02-03','IPS1205','10:28:17','17:01:25'),('2019-02-03','KPS1005','10:00:12','17:37:11'),('2019-02-04','IPS1001','10:01:31','17:36:23'),('2019-02-04','IPS1002','10:11:52','17:09:08'),('2019-02-04','IPS1003','10:13:08','17:30:39'),('2019-02-04','IPS1004','10:00:09','17:26:14'),('2019-02-04','IPS1005','09:58:19','17:39:32'),('2019-02-04','IPS1006','10:08:11','17:22:40'),('2019-02-04','IPS1202','10:23:05','17:00:06'),('2019-02-04','IPS1203','10:17:00','17:06:25'),('2019-02-04','KPS1004','09:52:01','17:23:52'),('2019-02-04','KPS1005','09:31:18','17:14:27'),('2019-02-05','IPS1001','09:45:01','17:26:35'),('2019-02-05','IPS1002','09:56:45','17:34:27'),('2019-02-05','IPS1003','09:48:49','17:04:37'),('2019-02-05','IPS1005','09:41:52','17:13:31'),('2019-02-05','IPS1006','09:58:23','17:33:42'),('2019-02-05','IPS1201','10:15:15','17:31:04'),('2019-02-05','IPS1203','09:49:12','17:34:26'),('2019-02-05','IPS1205','09:45:56','17:23:33'),('2019-02-05','KPS1004','10:01:12','17:11:49'),('2019-02-05','KPS1005','10:13:19','17:03:38');






INSERT INTO District VALUES ('211175','IPS1005','Muttu swami Iyer','Rose Mary'),('211179','IPS1201','Prabhu Shanakar','Mary Jacob'),('273208','IPS1203','Deepak Kalra','Rakulpreet'),('330409','KPS1005','Rizhwan Khan','Sajida siddiki'),('356401','IPS1004','Shereen Shaikh','Abhiram Roychand'),('431196','IPS1205','Shalina sengupta','Prakash Das'),('431470','IPS1202','Rachel Rutherford','Kennedy Pandit'),('482363','IPS1204','Priyta Iyyer','Santhosh Abraham'),('486407','IPS1006','Ram Krishna','Salena Mary'),('673004','IPS1001','P.S Gupta','R. Aggrawal'),('678005','IPS1002','Muzahid Sheikh','Kavya Bansal'),('679531','IPS1003','Achin Venkatswami','Stephen Boyd'),('809111','KPS1004','Preetesh Dhaniya','Priya Prakash');



INSERT INTO Crime VALUES ('101','Murder','IPS1205','2008-05-17','2008-05-13','10:15:00','20:03:00','Mukesh Talvar','Sector-15,Palakkad','Father'),('102','Murder','IPS1001','2015-01-23','2015-01-12','13:05:00','23:03:00','Manoj Baveja','814 W. Race Avenue ,Trivendrum','Neighbour'),('103','Kidnapping','IPS1003','1960-03-12','1960-01-22','12:23:24','23:09:10','Paresh Rawal','6 Fairfield St.Brunswick,Thrivandrum','Father'),('104','Robbery','IPS1202','2007-02-01','2007-02-04','16:29:30','01:25:27','Shailesh Raichand','Kanjikiode,Palakkad','Bank Manager'),('105','Missing','KPS1004','1955-02-10','1955-02-04','09:30:35','03:09:10','Ishan Gadgil','Kalam Road, Kozhikode','Father'),('106','Challan','KPS1004','1982-03-12','1982-03-12','12:21:22','10:20:40','Rakesh Pancholi','Olympic Ground, Palakkad','NIL'),('107','Missing','IPS1002','1953-02-10','1953-02-04','11:28:40','04:19:12','Isha David','3 W. Redwood Ave., Madurai','Father'),('108','Kidnapping','IPS1005','1962-12-03','1962-03-18','13:22:25','24:08:11','Amitabh Tocchan','40 Newcastle Street Neptune,Thrissur','Uncle'),('109','Missing','IPS1202','2006-02-10','2006-02-04','12:26:45','07:29:14','Bhagya Vijayan','9 Creek Lane Elizabeth, Chennai','Father'),('110','Challan','KPS1005','1994-03-12','1995-03-12','13:20:23','08:22:39','Saniya Girja','7 Cobblestone Rd.Clinton, Coimbatore','NIL'),('111','Missing','IPS1205','2009-02-10','2009-02-04','15:24:50','09:39:16','Shilpa R Nair','8 West Corona St.Palm Beach Gardens, Indore','Father'),('112','Kidnapping','IPS1201','2005-08-15','2005-10-16','14:21:26','00:07:12','Pihu kukreja','64 King Street,Kochuveli','Wife'),('113','Robbery','IPS1004','1975-02-01','1975-02-04','18:27:32','03:21:21','Sunder Pichkari','31 East Second Street Pompano Beach,Kochi','Bank Account Holder'),('114','Challan','KPS1004','1983-03-12','1983-03-12','14:19:32','05:25:38','Paridhi Sutwal','59 Shore St.Santa Monica, Kochi','NIL'),('115','Robbery','IPS1002','1956-02-01','1956-02-04','19:26:33','05:19:31','Satya Nandala','29 East Rd. ,Ottapalam','Bank CEO'),('116','Missing','IPS1006','1968-02-10','1968-02-04','16:22:55','11:49:18','Amit Makkhi','64 Canal Avenue , Palakkad','Father'),('117','Kidnapping','IPS1203','2003-07-26','2003-11-21','15:20:27','01:06:13','Suresh Ramesh','55 Wakehurst Street Griffin,Chennai','Son'),('118','Murder','IPS1004','1997-05-08','1997-03-23','09:35:00','13:01:00','Krish Kumar','9945 Water Road Newtown,Kozhiode','Cousin'),('119','Kidnapping','IPS1202','2008-06-29','2007-05-13','16:19:28','02:05:14','Pinnarayan Swami','2 Theatre Drive Rockville Centre,Pondicherry','Father-in-law'),('120','Challan','KPS1005','1992-03-12','1992-03-12','15:18:25','03:29:37','Shubham Gupta','89 N. High Point Lane ,Palakkad','NIL'),('121','Murder','IPS1006','1976-07-16','1976-05-20','16:45:00','03:06:00','Rambo Rajkumar','42 Harvard Drive ,Palakkad','Landlord'),('122','Missing','IPS1001','1999-02-10','1999-02-04','19:20:00','29:59:19','Arpita Pandey','22 E. Pineknoll Ave. Rapid City, Coimbatore','Father'),('123','Kidnapping','IPS1004','1997-07-01','1996-06-01','17:18:29','03:04:15','Shridhar Salunke','Army colony,Thrivandrum','Step-Brother'),('124','Murder','IPS1001','2000-09-19','2000-07-05','23:55:00','15:09:00','Travor James','5 North Garden Street,Selam','Friend'),('125','Challan','IPS1203','2003-03-12','2003-03-12','16:17:26','01:35:36','Ipsita Singh','230 Warren Dr.Apt 23 Frederick, Trivandrum','NIL'),('126','Robbery','IPS1005','1954-02-01','1954-02-04','20:25:34','07:17:33','Chotu Gandhi','40 Devonshire Drive Crystal Lake,Kollam','Bank Manager'),('127','Murder','IPS1004','1995-11-29','1995-08-13','14:02:00','23:11:00','Shafeek Mohammad','621 East Fairway Street ,Navakkarai','Brother'),('128','Robbery','IPS1202','2002-02-01','2002-02-04','22:23:36','11:13:37','Rishikesh David','78 Old Snake Hill Street ,Palakkad','Bank Security Guard'),('129','Robbery','IPS1006','1989-02-01','1989-02-04','21:24:35','09:15:35','Samiksha Amazon','9 West Lilac Street Mansfield,Trivendrum','Account Holder'),('130','Murder','IPS1006','1972-12-10','1972-10-19','19:23:00','01:13:00','Jiya Toteja','57 South Walt Whitman Street ,Kollam','Wife'),('131','Murder','IPS1002','1954-02-02','1954-01-15','09:19:00','06:25:00','Shubham Saniyar','88 West Evergreen St.Hephzibah,Kovalam','Son'),('132','Robbery','IPS1205','1997-02-01','1997-02-04','17:28:31','02:23:29','Tribhuvan Das','6 River Street,Malampuzha','Bank Employee'),('133','Murder','IPS1204','2001-05-09','2001-04-01','05:17:00','09:33:00','Yahya Bootwala','36 Bellevue Drive,Thrissur','Employee'),('134','Murder','IPS1202','2008-09-12','2008-08-09','20:55:00','10:46:00','Disha Mathur','78 Overlook St.Merrillville,Kochi','Fiance'),('135','Murder','IPS1205','2014-12-15','2014-02-22','17:35:00','12:59:00','Honey Satwani','14 Old Bear Hill Street Lake Mary,Kochi','Girlfriend');


INSERT INTO Murder VALUES ('101','Arushi Talvar','Tibbetian Knife','Y'),('102','Pradyumn Thakur','Poison,Hanged with Rope, Iron Rod','Y'),('118','Swayam Dhawan','Fan blades','Y'),('121','Ruchi Sagar','Iron Rod','Y'),('124','Shyam Sharma','Chainsaw','Y'),('127','Savita Kashyap','Poison','Y'),('130','Keerti kumari','Electric Drill through the head  ','Y'),('131','Pukhraj Shashidhar','Buried Alive ','Y'),('133','Vishnu Kori','Tied up and died in negative temperatures  ','Y'),('134','Salma khan','AK47 Rifle','Y'),('135','Arushi Gour','Chinese Cooking Knife','Y');


INSERT INTO Kidnapping VALUES ('103','Shivansh Gupta','Pradeep PK,Harish Sandhu,Shweta','1959-11-03','09:49:27'),('108','Rakul Pareek','Shree, Hari, Raju, Ramesh','1962-10-05','19:23:27'),('112','Shivansh Gupta','Shiv,Suman,Karishma','2005-02-13','23:09:27'),('117','Shivansh Gupta','Shweksha, Sharief, Pankaj, Kaushal','2003-04-03','12:14:00'),('119','Shivansh Gupta','Mokshda, Kantabai, Suresh, Pintu','2007-05-23','19:00:27'),('123','Shivansh Gupta','Kasim, Rafeek, Rizwan, Salman','1997-03-03','05:47:27');


INSERT INTO Missing VALUES ('105','Nisha Prasad','Ishan Gadgil',13,'Wheatish',5.0),('107','Kumar Ajitabh','Vishwaroop Chandran',20,'Fair',5.3),('109','Gayatri Rathore','Shirish Rathore',5,'Fair',5.2),('111','Preeti Kapoor','Vishal Kapoor',15,'Wheatish',5.2),('116','Gangadhar Shastri','Bala Shastri',19,'Wheatish',5.5),('122','Shruti Patel','Kapil Patel',17,'Wheatish',5.9);






INSERT INTO Robbery VALUES ('104','Rs. 10,000,000,000 and 140 lockers looted'),('113','3Kg Gold and Rs. 3,00,000 Cash looted'),('115','Property and confidential Documents of Worth 50 Billion looted'),('126','Brief case with cash Rs 20 billion and a Bugati veyron Looted'),('128','Locker Keys theift and locker had worth 120 Millions looted'),('129','14 lockers looted'),('132','Whole Bank Looted');




INSERT INTO Challan VALUES ('106','KL12MJ8966','Vishesh Padmanabhan','RTO12345678910','Tripling on 2-wheeler without licence'),('110','KL01AV1102','Girish Sharma','RTO0123456789','Overload Vehicle'),('114','KL05KI1597','Paridhi Chopra','RTO0147852369','Signal Breaking'),('120','KL20SE9854','Maarich Sendhupati','RTO9382714560','Under Age Bike Riding without learning licence'),('125','KL23AK1245','Mosquito Maharaj','RTO0369852147','No Permit And No Registration');



INSERT INTO Passport_verification VALUES ('P001','Shubham Gupta','IIT Palakkad',8075016346,'IPS1205','Kaarthika','Verified'),('P002','Sourabh Joshi','Ottapalam',8075026346,'IPS1001','Ritika','Pending'),('P003','Ganesh Gaitonde','Kailash Pada',9175026346,'IPS1202','Kukkoo','Rejected');


INSERT INTO Person_of_interest VALUES ('S101','101','Ganesh Gaitonde','1997-10-25','M','O-','Kailash Pada,Mumbai',7895649871,'Kukko Niwas, Kailash pada','DNA001','FIN052','P003','Subhadra'),('S102','102','Pappu panchar','1967-11-05','M','B-','Kali Pahadi k Peeche,Palakkad',9195649871,'B/2, Sector-16 Chiplun','DNA002','FIN019','NIL','Shanti Bai'),('S103','103','Bunty Babu','1999-05-15','M','AB-','Ghatkopar,Mumbai',7891024871,'Mannat Tapri, Kolkata','DNA101','FIN252','P003','Suhani'),('S104','104','Chota Badariya','2000-01-01','M','AB-','Ottapalam,Kerala',7123456789,'Rizwan Aawas,Civil Lines','DNA111','FIN362','NIL','Neha Shitole'),('S105','105','Kanta Bai','1986-12-12','F','A+','Kanjikode,Palakkad',7694979189,'Shanta Plaza,Coimbatore','DNA420','FIN069','P102','Shakeel Saiyad');



INSERT INTO Court VALUES ('C001','2008-06-12','101','Aadish Parmar','Rustum Pavri','Amit Makhija','No conclusion, court is adjourned till 2008-08-25'),('C001','2018-02-21','121','Keerthi Kulsekara','Siraj Alam','Jagdish chandra patnik','DNA Test of the knife and cloths should be done till then the court is adjourn, next date 2019-02-13'),('C001','2018-12-12','102','Aadish Parmar','Anita Modi','Parvez Shaikh','Suraj also involved,next date 2019:2:01'),('C0010','2005-07-10','127','Saroj Khan','Karishma Raijada','Joseph Paul','Raju was also involved in planning and should sent to imprisonment for 9 years, next date 2019-12-25'),('C002','1972-11-02','103','Kratika Sinha','Parul Pareek','Arun Kurur','Imprison for 10 years under IPC Sec. 359 and Rs. 2,00,000 Penalty,closed'),('C002','2000-09-03','129','Ishan Sharma','Ehasas Qureshi','Sadik Pathan','Faizal was not accused and found not Guilty, next date 2005-02-13'),('C002','2006-12-17','132','Abraham Sachin','Faiyaz Siddiki','Hansraj Kirodimal','All Accused should pay back to the Bank and should be imprison for 10 years each,Closed'),('C003','2003-01-27','123','Sukhda sharma','Siraj Alam','Peter England','No Conclusion in the session, next date 2018-02-13'),('C003','2006-08-22','128','Satya Bhai Patel','Manohar Patel','Jagdish chandra Das','Found Guilty Neel,Nitin,Mukesh Imprisonment for 5 years to each, Closed'),('C003','2008-10-02','104','Shubham Sharma','Nilind Vyas','Shama Parveen','Found Guilty and involvement in Robbery Jail for 5 Years,closed'),('C003','2019-05-23','134','Veneet Chouhan','Rakesh K Arya','Dalbeer Bhutto','Found Guilty Shankar Ehasaan and loy Imprisonment for 5 years to each, Closed'),('C004','1980-09-15','108','Awdhesh Gupta','Rajesh Pandya','Sartaj Singh','Imprison for 15 years under IPC Sec. 242,closed'),('C004','2018-04-16','133','Gurpreet chaddha','Sai Pulkit','Indravesh Arya','Accused are innocent and are free with due respect, the case is closed'),('C005','2006-08-14','112','Diljit Dosanjh','Preetam Das','Arijit Singh','No direct proof and the accused is not Guilty,closed'),('C005','2017-06-29','135','Kasim Khan','Siraj Alam','Shanaya Singhaniya','DNA Test of the knife and cloths should be done till then the court is adjourn, next date 2019-05-13'),('C005','2018-05-25','124','Keerthi Subramaniyam','Suraj Prabhakar','Jagdish Kirodi','Imprisonment till death to Ramesh, Raj and simran, Closed'),('C006','1955-06-04','126','Deep Kulsekara','Alam Araju','Bhagwat chandra patnik','Imprisenment for 36 years and Penalty of Rs 100000 for each accuser'),('C006','1980-07-10','113','Sarabjeet Singh','Niranjan Chowdhary','Palak Santhom','Imprison for 10 years under IPC Sec. 359,closed'),('C007','1961-11-21','131','Kaizat soda bottle operner wala','Krishna Patnik','Rahul Malhotra','All were Found Guilty and should hanged till death,Closed'),('C007','1970-06-04','115','Diljit Dosanjh','Preetam Das','Arijit Singh','Court is Adjourn and the next date is 2019-03-25'),('C008','2009-05-25','117','Diljit Dosanjh','Preetam Das','Arijit Singh','Accused is Dead so no Punishment though it was proved that he was accused,closed'),('C009','1997-10-08','130','Greesha Namdev','Sarfaroz Qureshi','Kim zhoung','DNA Test comes positive and all the accused are sentenced to death, Closed'),('C009','2018-04-16','118','David Rocco','Satoshi Kurinama','Bharat Shukla','Defender is Given Last chance to prove his client is not guilty till the court is adjourned, next date 2018-12-03'),('C010','2009-03-09','119','Sarvesh multani','Preetam Pavri','Sukhraj Singh','Imprison for 17 years under IPC Sec. 359,closed');



INSERT INTO Solved_Cases VALUES ('103','C002','IPC 359','S103'),('104','C003','IPC 395','S104'),('108','C004','IPC 392','S101'),('112','C005','IPC 345','S103'),('113','C006','IPC 374','S104'),('117','C008','IPC 363','S104'),('119','C010','IPC 410','S105'),('124','C005','IPC 452','S103'),('128','C003','IPC 341','S104'),('130','C009','IPC 784','S101'),('131','C007','IPC 789','S101'),('132','C002','IPC 105','S102'),('133','C004','IPC 655','S103'),('134','C003','IPC 143','S104');


CREATE VIEW Employee AS (SELECT Police_ID, Name, DOB, Blood_Group,Gender, Rank, Phone_number, Department
                         FROM Police_Employee);


CREATE VIEW Superintendent_History AS (SELECT Police_ID, Branch_ID,Start_Date,End_Date, Rank
                                       FROM History
                                       where Rank in ('Constable','SI','Asst.Inspector','DSP','ASP','SP'));
                                       
                                       
                                       
                                       
                                       
/****************Views for Clerk and constable*************/

/*abstract out phone number and salary => for Clerk and constalble*/
create view employee_level1 as (select Police_ID, Name, DOB, Blood_Group, Gender, Rank, Department from Police_Employee);

/*Constable****************/
/*abstract out phone number, DNA, Finger_Print*/
create view poi_level1 as (select Suspect_ID, Case_Involved, Name, DOB, Gender, Blood_Group, Residential_address, Office_address, Passport_details, Spouse_name
from Person_of_interest);


/**************************Superintendent************/

/*abstract out salary => Employee*/
create view employee_level2 as (select Police_ID, Name, DOB, Blood_Group, Gender, Rank, Phone_number, Department from Police_Employee);

/*cant see history of higher ranks=> Superintendent*/
CREATE VIEW history_level2 AS (SELECT Police_ID, Branch_ID,Start_Date,End_Date, Rank
                         FROM History
                          where Rank in ('Constable','SI','Asst.Inspector','DSP','ASP','SP'));

/*cant see attendance of higher rank*/
create view attendance_level2 as (select Date, Police_ID, Entry_time,Exit_time from Attendance natural join Police_Employee
 where Rank in('Constable','SI','Asst.Inspector','DSP','ASP','SP'));


/**************************************************************/
create view solved_cases_data as (select * from Crime natural join Solved_Cases);

create view ongoing_cases_data as (select * from Crime where Case_ID not in (select Case_ID from Solved_Cases));

/*one for person of interset and Solved_Cases*/
Create role 'Clerk';
Create role 'Constable';
Create role 'Superintendent';
Create role 'Head';

grant select on Attendance to 'Clerk';
grant insert on Attendance to 'Clerk';
grant delete on Attendance to 'Clerk';
grant select on Police_Station to 'Clerk';
grant select on District to 'Clerk';
grant select on employee_level1 to 'Clerk';



grant select on Attendance to 'Constable';
grant select on employee_level1 to 'Constable';
grant select on Police_Station to 'Constable';
grant select on District to 'Constable';
grant select on Crime to 'Constable';
grant select on Murder to 'Constable';
grant insert on Murder to 'Constable';
grant select on Person_of_interest to 'Constable';
grant select on Solved_Cases to 'Constable';
grant select on Court to 'Constable';
grant select on Passport_verification to 'Constable';
grant select on poi_level1 to 'Constable';

grant select on employee_level2 to 'Superintendent';
grant select on Crime to 'Superintendent';
grant select on Attendance to 'Superintendent';
grant select on history_level2 to 'Superintendent';
grant select on Police_Station to 'Superintendent';
grant select on District to 'Superintendent';
grant insert on Crime to 'Superintendent';
grant update on Crime to 'Superintendent';
grant select on Murder to 'Superintendent';
grant insert on Murder to 'Superintendent';
grant update on Murder to 'Superintendent';
grant select on Person_of_interest to 'Superintendent';
grant insert on Person_of_interest to 'Superintendent';
grant delete on Person_of_interest to 'Superintendent';
grant update on Person_of_interest to 'Superintendent';
grant select on attendance_level2 to 'Superintendent';
grant select on Solved_Cases to 'Superintendent';
grant insert on Solved_Cases to 'Superintendent';
grant update on Solved_Cases to 'Superintendent';
grant select on Court to 'Superintendent';
grant insert on Court to 'Superintendent';
grant update on Court to 'Superintendent';
grant select on Passport_verification to 'Superintendent';
grant insert on Passport_verification to 'Superintendent';
grant update on Passport_verification to 'Superintendent';



grant select on Attendance to 'Head';
grant select on Employee to 'Head';
grant select on History to 'Head';
grant select on Police_Station to 'Head';
grant select on District to 'Head';
grant select on Crime to 'Head';
grant insert on Crime to 'Head';
grant update on Crime to 'Head';
grant select on Murder to 'Head';
grant insert on Murder to 'Head';
grant update on Murder to 'Head';
grant select on Person_of_interest to 'Head';
grant insert on Person_of_interest to 'Head';
grant update on Person_of_interest to 'Head';
grant delete on Person_of_interest to 'Head';
grant select on Solved_Cases to 'Head';
grant insert on Solved_Cases to 'Head';
grant update on Solved_Cases to 'Head';
grant select on Court to 'Head';
grant insert on Court to 'Head';
grant update on Court to 'Head';
grant select on Passport_verification to 'Head';
grant insert on Passport_verification to 'Head';
grant update on Passport_verification to 'Head';


Create user 'Clerk'@'localhost' identified by '100';
Create user 'Constable'@'localhost' identified by '101';
Create user 'Superintendent'@'localhost' identified by '102';
Create user 'Head'@'localhost' identified by '103';

grant Clerk to 'Clerk'@'localhost';
grant Constable to 'Constable'@'localhost';
grant Superintendent to 'Supeintendent'@'localhost';
grant Head to 'Head'@'localhost';



delimiter //

create PROCEDURE proc_city_station(city varchar(50))
begin select * from Police_Station where Police_Station.City = city;
end; //



create function fun_attendance_per (ID varchar(10)) returns double
READS SQL DATA
DETERMINISTIC
begin
  DECLARE attPer double;
  DECLARE numDate int;
  DECLARE numAttend int;
  select COUNT(Distinct Attendance.Date)  into numDate from Attendance;
  select count(DISTINCT Attendance.Date) into numAttend from Attendance where Attendance.Police_ID=ID;
  select (numAttend/numData)*100 into attPer;
  return attPer;
end; //



create PROCEDURE rankEmp(in rank varchar(10))
begin
  select Name from Police_Employee where Police_Employee.Rank = rank;
end; //


create procedure mark_entry (in pid varchar(10))
begin
  insert into Attendance
  values (now(), pid,now(), NULL);
end;  //



create procedure mark_exit (in pid varchar(10))
begin
  update Attendance
  set Exit_time= now()
  where Police_ID=pid
    and Date= curdate();
end; //



create function num_cases(pid varchar(10)) returns int
READS SQL DATA
DETERMINISTIC
begin
  declare num int;
  select count(*) into num from Crime
  where Crime.Police_ID=pid;
  return num;
end; //



create procedure Crime_stat()
begin
  select Crime_Type,COUNT(Crime_Type) from Crime group by (Crime_Type);
end //



create procedure Criminal_Finder (Crime_weapon varchar(30))
begin
  select Name,DOB, Gender, Case_ID, Suspect_ID
  from Person_of_interest JOIN Murder.Murder_ID = Person_of_interest,Case_Involved join Crime on Crime.Case_ID = Person_of_interest.Case_involved
  where Weapon = Crime_Weapon;
end //



CREATE procedure Case_summary (pid varchar(10))
begin
  select Court.Court_ID, Date, Name_Of_Judge,Section_Of_Law,Sentence from Court join Solved_Cases on Court.Crime_ID = Solved_Cases.Case_ID where Solved_Cases.Case_ID=pid;
end //

/*1. Procedure to find the employees who are having birthday today.*/
delimiter //
CREATE PROCEDURE todayBirthday()
BEGIN
  DECLARE todayDay int;
  DECLARE todayMonth int;
  SELECT DAY(CURDATE()) INTO todayDay;
  SELECT MONTH(CURDATE()) INTO todayMonth;

  SELECT * FROM employee
  WHERE DAY(employee.DOB) = todayDay AND
      MONTH(employee.DOB) = todayMonth;

END;
//

/*2. Procedure to find the number of employees present today.*/
delimiter //
CREATE PROCEDURE presentToday ()
BEGIN
  DECLARE totEmp int;
  DECLARE present int;
  DECLARE attPer double;

  SELECT COUNT(DISTINCT Police_ID) INTO present FROM Attendance WHERE Date = CURDATE();
  SELECT COUNT(DISTINCT Police_ID) INTO totEmp FROM employee;
  SELECT (present/totEmp)*100 INTO attPer;

  SELECT present, totEmp, attPer;

END;
//
delimiter ;



/*3. Procedure to find the posting history of a given employee*/
delimiter //
CREATE PROCEDURE myHistory (IN empID varchar(10))
BEGIN
  select * from History where Police_ID = empID;
END;
//
delimiter ;



/*4. Procedure to identify a missing person.*/
delimiter //
CREATE PROCEDURE missingQuery1 (IN age int(11), IN color varchar(10), IN height decimal(2,1))
BEGIN
  SELECT * FROM Missing WHERE Missing.Age = age
                          AND Missing.Color = color
                          AND Missing.Height > height - 0.2
                          AND Missing.Height < height + 0.2;

END;
//
delimiter ;


delimiter //
CREATE PROCEDURE missingQuery2 (IN age int(11), IN color varchar(10), IN height decimal(2,1))
BEGIN
  SELECT * FROM missing WHERE
      missing.Color = color
                          AND missing.Height > height - 0.2
                          AND missing.Height < height + 0.2;

END;
//
delimiter ;

/*5. Procedure to find the legal status and history of a case.*/
delimiter //
CREATE PROCEDURE crimeCourtHistory (IN crimeID varchar(10))
BEGIN
  SELECT * FROM Court where Crime_ID = crimeID;

END;
//
delimiter ;

/*6. Function to display the number of open cases.*/
delimiter //

CREATE FUNCTION openCaseCount() RETURNS int
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE caseCount int;
    select sum(M.Case_count) into caseCount from (select Police_ID, count(Police_ID) as Case_count
                 from (select * from Crime where Case_ID not in
                               (select Case_ID from Solved_Cases)
                       )as T
                 group by Police_ID) as M;

    RETURN caseCount;

END;
//

delimiter ;


/*  Triggers*/
/*1. On insert of Crime depending on type make an entry in corresponding table*/

DELIMITER //

create trigger insert_crime

  after insert on Crime
  for each row begin

  if(new.Crime_Type = "Murder") then

    insert into Murder(Murder_ID) values (new.Case_ID);
  end if;

  if(new.Crime_Type = "Kidnapping") then

    insert into Kidnapping(Kidnap_ID) values (new.Case_ID);
  end if;

  if(new.Crime_Type = "Robbery") then

    insert into Robbery(Robbery_ID) values (new.Case_ID);

  end if;
  if(new.Crime_Type = "Missing") then

    insert into Missing(Missing_ID) values (new.Case_ID);
  end if;

  if(new.Crime_Type = "Challan") then

    insert into Challan(Challan_ID) values (new.Case_ID);

  end if; end;   //  DELIMITER ;


/*2.    Trigger to see if any suspect has become victim of crime*/

/*For Murder Table*/
DELIMITER //
create trigger suspect_to_victim

  After update on Murder
  for each row begin

  if(new.Name_Of_Victim in (select Name from Person_of_interest)) then
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "This person is in Suspect Table";
  end if;
end;
//
DELIMITER ;

/*For Kidnapping Table*/

DELIMITER //

create trigger suspect_to_victim0

  after update on Kidnapping
  for each row begin

  if(new.Name_Of_Victim in (select Name from Person_of_interest)) then
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "This person is in Suspect Table";
  end if;
end;
//
DELIMITER ;

/*For table Missing*/
DELIMITER //

create trigger suspect_to_victim1

  after update on Missing
  for each row begin

  if(new.Name in (select Name from Person_of_interest)) then
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "This person is in Suspect Table";
  end if;
end;
//
DELIMITER ;

/*log file for insert crime*/
delimiter //
create  or replace trigger tr_insert_crime
             after update on Crime
                     for each row
begin
set @id = new.Case_ID ;
set @msg1 = 'New Case with caseID = ';
set @msg2 = 'is added at ';
set @msg3 = concat(@msg1, @id);
set @msg4 = concat(@msg2,now());
set @res = concat(@msg3, @msg4);
insert into Insert_Crime_Audit
values (@id, @res);
end //

DELIMITER ;

/*log file for Solved cases*/
DELIMITER //
create or replace trigger tr_insert_Solved_cases
            after update on Solved_Cases
                    for each row
begin
set @id = new.Case_ID ;
set @msg1 := 'Case Solved with caseID = ';
set @msg2 := ' is added at ';
set @msg3 = concat(@msg1, @id);
set @msg4 = concat(@msg2,now());
set @res = concat(@msg3, @msg4);

insert into Insert_Solved_Cases_Audit
values (@id,@res);
end //
