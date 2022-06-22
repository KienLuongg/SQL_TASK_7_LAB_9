create database ClassRoomLab9
go

create table Class(
ClassCode varchar(10) primary key,
HeadTeacher varchar(30),
Room varchar(30),
TimeSlot char,
CloseDate datetime
)
go

create table Student(
RollNo varchar(10) primary key,
ClassCode varchar(10) foreign key references Class(ClassCode),
FullName varchar(30),
Male bit,
BirthDate datetime,
Address varchar(30),
Province char(2),
Email varchar(30)
)
go

create table Suject(
SubjectCode varchar(10) primary key,
SubjectName varchar(40),
WTest bit,
PTest bit,
WTest_per int,
PTest_per int
)
go

create table Mark(
RollNo varchar(10) 
constraint fk_RollNo foreign key (RollNo) references Student(RollNo),
SubjectCode varchar(10) 
constraint fk_SubjectCode foreign key(SubjectCode) references Suject(SubjectCode),
constraint pk_RollNo_SubjectCode primary key (RollNo, SubjectCode),
WMark float,
PMark float,
Mark float
)
go

INSERT INTO Class(ClassCode,HeadTeacher,Room,TimeSlot,CloseDate) VALUES ('A101','ElonMusk','B16','M','08-08-2022'),
                                                                        ('B102','Bill Gate','B15','G','11-10-2022'),
                                                                        ('C103','Tien Bip','B10','N','09-09-2022'),
                                                                        ('D104','Huan Hoa Hong','B07','N','10-10-2022'),
                                                                        ('E105','Loc FuHo','B05','G','12-12-2022')



INSERT INTO Student(RollNo,ClassCode,FullName,Male,BirthDate,Address,Province,Email)
            VALUES ('A1001','A101','Mai Xuan Tien',1,'02-06-1990','Ha noi','hn','xuantien.6290@gmail.com'),
                    ('B1001','B102','Nguyen Ba Quoc',1,'11-12-2000','Ha noi','hn','nguyenbaquoc@gmail.com'),
                    ('C1001','C103','Nguyen Dinh Hien',1,'11-09-1995','Hung yen','hy','nguyendinhhien@gmail.com'),
                    ('D1001','A101','Tong Minh Duong',1,'08-08-1997','Thanh hoa','th','tongminhduong@gmail.com'),
                    ('E1001','E105','Nguyen Huu Thinh',1,'06-22-2022','Thanh hoa','th','nguyenhuthinh@gmail.com'),
                    ('F1001','A101','Vu Duy Khanh',1,'09-11-1996','Nam dinh','nd','vuduykhanh@gmail.com'),
                    ('G1001','A101','Hoang Cong Minh',1,'09-09-1998','Thai nguyen','tn','hoangcongminh@gmail.com')


INSERT INTO Suject(SubjectCode,SubjectName,WTest,PTest,WTest_per,Ptest_per)
            VALUES ('DD','Bi Kip Du Dinh',1,1,1,2),
                    ('KDDH','Khong Hoc Dai Hoc Van La Ty Phu',1,1,1,3),
                    ('NCHT','Nghien Co Hoc Thuc',1,1,1,10),
                    ('KLDCA','Khong Lam Doi Co An',1,1,1,20),
                    ('BKLTC','Bi Kip Lam Tho Ca',1,1,1,5)

INSERT INTO Mark(RollNo,SubjectCode,WMark,PMark,Mark) 
          VALUES('A1001','DD',1,1,1),
                ('A1001','KLDCA',2,2,2),
                ('B1001','KDDH',8,9,8.8),
                ('B1001','KLDCA',2,2,2),
                ('C1001','NCHT',3,3,3),
                ('C1001','KLDCA',2,2,2),
                ('E1001','BKLTC',7,8,7.8),
                ('E1001','KLDCA',2,2,2),
                ('D1001','NCHT',10,8,8.1),
                ('D1001','KLDCA',10,10,10),
                ('F1001','KLDCA',1,1,1),
                ('G1001','KLDCA',3,3,3)

GO
create view view_4_2
as
select Student.FullName, count(Suject.SubjectCode) as CK
from Student 
inner join Mark on Student.RollNo=Mark.RollNo
inner join Suject on Suject.SubjectCode=Mark.SubjectCode
group by Student.FullName
having COUNT(Suject.SubjectCode)>=2
GO

SELECT * FROM view_4_2
GO

create view V_4_3
as
select Student.FullName, count(Suject.SubjectCode) as CK
from Student 
inner join Mark on Student.RollNo=Mark.RollNo
inner join Suject on Suject.SubjectCode=Mark.SubjectCode
group by Student.FullName
having COUNT(Suject.SubjectCode) <=1
GO 

SELECT * FROM V_4_3
GO

create view V_4_4
as
select Student.FullName, TimeSlot
from Student
inner join Class on Class.ClassCode = Student.ClassCode and Class.TimeSlot='G'
GO

SELECT * FROM V_4_4
GO

create view V_4_5
as
select Class.HeadTeacher
from Class
inner join Student on Student.ClassCode = Class.ClassCode
inner join Mark on Student.RollNo = Mark.RollNo
inner join Suject on Suject.SubjectCode = Mark.SubjectCode
group by Class.HeadTeacher
having COUNT(Suject.SubjectCode) <=1
GO

SELECT * FROM V_4_5
GO

create view V_4_6
as
select Student.FullName, Class.Room, Class.HeadTeacher, Mark.Mark
from Class
inner join Student on Class.ClassCode=Student.ClassCode
inner join Mark  on Mark.RollNo=Student.RollNo
inner join Suject on Suject.SubjectCode=Mark.SubjectCode 
and Suject.SubjectCode='EPC'
where Mark.Mark<=4
GO

SELECT * FROM V_4_6
GO