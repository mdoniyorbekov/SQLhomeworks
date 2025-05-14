------------1-------------
---delete/truncate/drop---
drop table if exists test_identity;
create table test_identity (
							id int identity(1,1) primary key,
							value varchar(50)
							);

insert into test_identity(value)
values ('A'),('B'), ('C'), ('D'), ('E');

select * from test_identity;

delete from test_identity; --remains column names

drop table test_identity; --nothing remains/table completely vanishes

truncate table test_identity; --remains column names

------------2----------
drop table if exists data_types_demo;
create table data_types_demo (
								id int primary key identity(1, 1),
								name1 varchar(100),
								name2 nvarchar(100),
								queue1 decimal(10,2),
								time DATETIME default GETDATE()
								);

insert into data_types_demo (name1, name2, queue1)
values ('name1', 'name2', 1312);

select * from data_types_demo;


------------3----------
drop table if exists photos;
create table photos (
						id int primary key identity(1, 1),
						image varbinary(max));

insert into photos(image)
select BulkColumn from openrowset(bulk 'C:\Users\user\Pictures\MY_PHOTOOO.jpg', single_blob) as ferrari;

select * from photos;


------------4----------
drop table if exists student;
create table student (
						id int primary key identity(1, 1),
						name varchar(200),
						classes int,
						tuition_p_class decimal(10,2),
						total_tuition as (classes*tuition_p_class));

insert into student (name, classes, tuition_p_class)
values ('name1', 4, '20000'), ('name2', 2, '530000'), ('name3', 7, '130000');

select * from student;


------------5----------
drop table if exists worker;
create table worker (id int primary key identity(1,1),
						name varchar(100));

bulk insert worker from 'C:\Users\user\Desktop\Transfermarkt\workers.csv'
	with (fieldterminator = ',',
	rowterminator = '\n',
	firstrow = 1);


select * from worker;