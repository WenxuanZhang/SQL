/*show all database*/
/*show all table of database*/
use world_schema;
show tables;


create table gdp (
country_or_area varchar(255),
yr  int,
gdp float
);

describe  gdp;

create table population(country_or_area varchar(255), 
yr int,
scenario varchar(255),
population float);

create table gdp_by_exp (country_or_area varchar(255),
yr int,
exp_type varchar(255),
gdp float);

describe gdp_by_exp;

insert into gdp (country_or_area,yr, gdp)
values
('usa',2019, 2143000000000),
('usa',2020, 2083000000000)
;
/*delete duplicate value in sql*/

select * from  gdp;

alter table gdp add id int not null auto_increment primary key;

select * from gdp;

SET SQL_SAFE_UPDATES = 0;

delete g1 from gdp g1
inner join gdp g2 
where 
    g1.gdp = g2.gdp and
    g1.country_or_area = g2.country_or_area and
    g1.yr = g2.yr and g1.id < g2.id  ;

/*drop demo data in gdp*/
delete from gdp;

create table gdp (
country_or_area varchar(255),
yr  int,
metric varchar(255),
gdp float
);
    
/*load data in file*/
show variables like "secure_file_priv";


show variables like "local_infile";


set global local_infile = 1;

SELECT @@global.secure_file_priv;

load data  infile '/Users/wenxuanzhang/Downloads/gdp.csv'  
into table gdp_test
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
IGNORE 1 ROWS;

/*selec*/

select * from gdp_test;
alter  table gdp drop
metric;
select * from gdp_test;

rename table gdp_test to gdp;

show tables;

select * from gdp;
/*load in gdp by_exp*/
select * from gdp where country_or_area ='United States' ;

select * from gdp where country_or_area like 'A%' and yr = 2018 order by gdp desc;

select g.* , p.scenario, p.population from gdp g left join population p on g.country_or_area = p.country_or_area and
g.yr = p.yr where p.scenario = 'Medium' and g.yr = 2018 order by g.gdp desc, p.population asc;

select distinct country_or_area from population;
/*where p.scenario = 'Medium' and  g.country_or_area = 'United States';*/

/*group by*/
select * from gdp_by_exp where country_or_area = 'United States' and yr = 2018 ;

select country_or_area,exp_type, sum(gdp) from gdp_by_exp where country_or_area = 'United States' and yr  between 2008 and 2018
group by exp_type order by sum(gdp) desc;

select country_or_area , avg (gdp) from gdp where yr between 2008 and 2018  group by country_or_area having avg(gdp)>10000
order by avg(gdp) desc;

select distinct scenario from population;

select distinct  country_or_area, yr from gdp;

use mysql;
select * from user where User="root";

/*Follow up question 1*/
CREATE TABLE gdp_g select g.*, p.population*g.gdp* 1000  as gross_gdp from gdp g left join population p on 
g.country_or_area = p.country_or_area and
g.yr = p.yr where p.scenario ='Medium';

/*Follow up question 2*/
select g1.* , format (g1.gdp/g2.gdp ,2)as pct from gdp_by_exp g1  left  join (select * from gdp_by_exp where exp_type = 'Gross Domestic Product (GDP)' ) g2 
on  g1.country_or_area = g2.country_or_area
and g1.yr = g2.yr
;

select distinct exp_type from gdp_by_exp;

/*Follow up question 3* select he country  with */
select country_or_area, yr, format (gdp,1)from gdp where yr = '2018' order by gdp desc limit 54,1;




