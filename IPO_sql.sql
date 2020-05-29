

alter table daily_stock
alter column shares_outstanding
type bigint;


alter table daily_stock
alter column ticker_symbol

type varchar(10);


alter table daily_stock
alter column issue_id_dividends
type varchar(10);


alter table daily_stock
alter column company_number
type float using (company_number::float);


alter table daily_stock
add primary key (ticker_symbol, data_date_dividends);

select * from daily_stock where data_date_dividends is null;

select count(*) from daily_stock;

select distinct(issue_id_dividends) from daily_stock ;

select distinct(company_name) from ipo.daily_stock order by company_name;  --832

select distinct(ticker_symbol) from ipo.daily_stock order by ticker_symbol; --900

select distinct(company_number) from ipo.daily_stock order by company_number; --830

select distinct company_number, ticker_symbol, company_name from ipo.daily_stock order by ticker_symbol; --902

select distinct(company_name, ticker_symbol) from ipo.daily_stock;

select * from ipo.daily_stock where ticker_symbol = 'SSNC.1';

delete from ipo.daily_stock where ticker_symbol = 'INVE'; --why?

\copy ipo.daily_stock from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT - Public Biotech/Project with Anne Schnader/Raw Data/StockDataIPOsCSVs/New061317.csv' with csv header delimiter ',';

select * from ipo.daily_stock where shares_outstanding is null;


select * from ipo.daily_stock where price_close_daily is null order by ticker_symbol, data_date_dividends;

--drop table ipo.daily_stocktest;

create table ipo.daily_stocktest as
select * from ipo.daily_stock;

alter table ipo.daily_stocktest add column market_cap float;

alter table ipo.daily_stock drop column market_cap;

update ipo.daily_stocktest set market_cap = shares_outstanding * price_close_daily;

select distinct on (ticker_symbol)
ticker_symbol, data_date_dividends, price_close_daily, shares_outstanding from daily_stock
where shares_outstanding is null
group by ticker_symbol, data_date_dividends, price_close_daily
order by ticker_symbol, data_date_dividends;

select distinct(company_number) from daily_stock where ticker_symbol = 'FNCX';


select * from daily_stock where company_number = '24506';

select * from daily_stock where company_name ~* 'Bind';

select distinct company_name, ticker_symbol from daily_stock where ticker_symbol ~* 'EAGL';

create table IPOvalwindow (
company_number float primary key,
company_name varchar(100),
ticker varchar(20),
valuation_at_ipo float,
date_of_ipo date,
ipo_window integer,
company_type varchar(15)
);

alter table biotechs
rename to IPOvalwindow;

--truncate table IPOvalwindow;

select * from IPOvalwindow where ticker = 'FNCX';


select * from daily_stock where ticker_symbol = 'QIWI';


select distinct (company_number) from IPOvalwindow ; --870

alter table IPOvalwindow
alter column valuation_at_ipo
type bigint;

select distinct company_number from daily_stock; --830

select * from daily_stock where ticker_symbol = 'ETSY';

select distinct(ticker_symbol) from IPOvalwindow i full outer join daily_stock d on i.company_number = d.company_number where i.company_number is null or d.company_number is null; --4

select ticker from daily_stock d full outer join IPOvalwindow i on i.company_number = d.company_number where i.company_number is null or d.company_number is null order by ticker; --42

update daily_stock
set company_number = '316.9' where ticker_symbol = 'CVGP';

update daily_stock
set company_number = '15' where ticker_symbol = 'ADRO';

update daily_stock
set company_number = '15.1' where ticker_symbol = 'ETSY';

update daily_stock
set company_number = '327.9' where ticker_symbol = 'SMPL.1';

delete from IPOvalwindow
where ticker = 'HMST' and company_number = '81.1';

delete from IPOvalwindow
where ticker = 'CCXI' and company_number = '316.1';


create table ipo_survival_829 as 
select  d.company_number, i.ticker, i.company_name, i.company_type, i.ipo_window, min(d.data_date_dividends) as date_of_ipo, 
max(d.data_date_dividends) as last_date, (max(d.data_date_dividends)-min(d.data_date_dividends)) as days_passed 
from daily_stock d inner join ipovalwindow i on d.company_number = i.company_number 
group by d.company_number, i.ticker, i.company_name, i.company_type, i.ipo_window; --829 (PULM was excluded)

drop table ipo_survival_868;

create table ipo_survival_868 as 
select  d.company_number, i.ticker, i.company_name, i.company_type, i.ipo_window, min(d.data_date_dividends) as min_date, 
max(d.data_date_dividends) as last_date, (max(d.data_date_dividends)-min(d.data_date_dividends)) as days_passed 
from daily_stock d inner join ipovalwindow i on d.company_number = i.company_number and d.ticker_symbol = i.ticker
group by d.company_number, i.ticker, i.company_name, i.company_type, i.ipo_window;

create view ipo_survival_982 as 
select  d.company_number, i.ticker, i.company_name, i.company_type, i.ipo_window, i.date_of_ipo, min(d.data_date_dividends) as first_date, 
max(d.data_date_dividends) as last_date, (max(d.data_date_dividends)-min(d.data_date_dividends)) as days_passed 
from daily_stock d inner join ipovalwindow i on d.company_number = i.company_number and d.ticker_symbol = i.ticker
group by d.company_number, i.ticker, i.company_name, i.company_type, i.ipo_window, i.date_of_ipo;

select *, (date_of_ipo - first_date) as diff from ipo_survival_982 where date_of_ipo <> first_date order by diff;

alter table ipo_survival_829
add column years_passed decimal(10,2)
months_passed decimal(10,2)
stockstatus varchar(2);

update ipo_survival_829
set stockstatus = 
CASE 
when last_date = '2015-12-31' THEN 'S' 
else 'F' end;

select count(*) from ipo_survival_829 where stockstatus = 'F'; --330 vs 499

alter table ipo_survival_829
drop column months_passed;

update ipo_survival_829
set months_passed = days_passed/30.436875;

update ipo_survival_829
set years_passed = months_passed/12;


select * from ipovalwindow where ticker = 'ESPR.1';

select * from ipovalwindow where ticker = 'BINDQ';

select * from daily_stock where ticker_symbol = 'ESPR';

select count(*) from ipo_survival_829 where company_type = 'Biotech'; --312 vs 517

select * from ipo_survival_829 where ipo_window = 4 and company_type = 'Non Biotech' order by date_of_ipo limit 10;

select * from daily_stock where ticker_symbol = 'CDW' order by data_date_dividends;
select * from ipo.daily_stock where ticker_symbol = 'FNCX' order by data_date_dividends;  --2011

select min(d.data_date_dividends) from ipo.daily_stock d where ticker_symbol = 'FNCX'; --2014

select * from ipo.ipovalwindow where ticker = 'FNCX'; --2014

select * from ipo.ipo_survival_829 where ticker = 'FNCX'; --1995

select * from ipo.daily_stock where ticker_symbol = 'CDW' order by data_date_dividends;  --2013

select min(d.data_date_dividends) from ipo.daily_stock d where ticker_symbol = 'CDW'; --2013

select * from ipo.ipovalwindow where ticker = 'CDW'; --2013

select * from ipo.ipo_survival_829 where ticker = 'CDW'; --1995

--
select * from ipo.daily_stock where ticker_symbol = 'ABCW' order by data_date_dividends;  --2014, but ABCWQ is 1995

select min(d.data_date_dividends) from ipo.daily_stock d where ticker_symbol = 'ABCW'; --2014

select * from ipo.ipovalwindow where ticker = 'ABCW'; --2014

select * from ipo.ipo_survival_829 where ticker = 'ABCW'; --1995 fix

select min(d.data_date_dividends) from ipo.daily_stock d where ticker_symbol = 'SPHS';


drop table ipo_date_diffs2;

create table ipo_date_diffs as
select d.ticker, d.company_number, v.date_of_ipo, d.min_date as first_stockprice_date, (v.date_of_ipo - d.min_date) as diff from ipovalwindow v, ipo_survival_868 d 
where v.company_number = d.company_number and v.ticker = d.ticker and v.date_of_ipo <> d.min_date group by date_of_ipo, d.ticker, v.ticker, min_date, d.company_number order by diff; --redo with ticker_symbol

select * from ipo.daily_stock where ticker_symbol = 'EPRSQ' order by data_date_dividends; --2014

select * from ipo.daily_stock where ticker_symbol = 'PCOP' order by data_date_dividends; --2004

select * from ipo.daily_stock where ticker_symbol = 'SYRX' order by data_date_dividends; --2003 

select * from ipo.daily_stock where ticker_symbol = 'SMOD' order by data_date_dividends; --2006 fix; got assigned to SMOD.1 (1995)

select * from ipo.daily_stock where ticker_symbol ~ 'MRKT' order by data_date_dividends; --missing
select * from ipo.ipo_survival_868 where ticker = 'MRKT'; --2005

select distinct(ticker_symbol) from daily_stock; --1000

select * from daily_stock where company_number = '144.9'; --INFO (IHS + Markit merger; IHS IPO'ed in 2005)
select * from ipovalwindow where company_number = '144.9'; --MRKT

select * from ipo.daily_stock where ticker_symbol = 'OPTT' order by data_date_dividends; 

select * from ipo.daily_stock where ticker_symbol = 'HOUH' order by data_date_dividends; --HOUH missing 

select * from ipo.daily_stock where ticker_symbol = 'FUIZ' order by data_date_dividends; --missing

select * from ipo.daily_stock where ticker_symbol = 'ONXX' order by data_date_dividends;


select * from daily_stock where company_number = '150'; --TRGA 1996-2001
select * from ipovalwindow where company_number = '150'; --HOUH 1996-2000

select * from daily_stock where company_number = '138'; --FUSE 1995-1999
select * from ipovalwindow where company_number = '138'; --FUIZ

select  distinct i.ticker, d.ticker_symbol, d.company_number from ipovalwindow i, daily_stock d where i.ticker <> d.ticker_symbol and d.company_number = i.company_number;


create table ipo_survival_866 as
select  distinct on (i.ticker) d.ticker_symbol, i.company_number, i.company_name, i.company_type, i.ipo_window, min(d.data_date_dividends) as min_date, 
max(d.data_date_dividends) as last_date, (max(d.data_date_dividends)-min(d.data_date_dividends)) as days_passed, price_close_daily  
from daily_stock d inner join ipovalwindow i on i.company_number = d.company_number
group by d.ticker_symbol, i.company_number, d.company_number, i.company_name, i.ticker, i.company_type, i.ipo_window 
order by i.ticker, min_date desc; --866 d.ticker_symbol, d.company_number;

drop table ipo_date_diffs;

create table ipo_date_diffs as
select d.ticker, d.company_number, v.date_of_ipo, d.first_date as first_stockprice_date, (v.date_of_ipo - d.first_date) as diff 
from ipovalwindow v, ipo_survival_962 d where v.company_number = d.company_number and v.ticker = d.ticker and v.date_of_ipo <> d.first_date 
group by v.date_of_ipo, d.ticker, v.ticker, first_date, d.company_number order by diff; 


drop table ipo_survival_analysis;

create view ipo_survival_analysis as
select i.*, max(d.data_date_dividends) as last_stock_date, max(d.data_date_dividends)-date_of_ipo as days_since_ipo from ipovalwindow i, 
daily_stock d where d.company_number = i.company_number group by i.company_number;

select company_number, max(data_date_dividends) from daily_stock group by company_number having max(data_date_dividends) = '2015-12-31' ; --341

select distinct (company_number), max(data_date_dividends) from daily_stock group by company_number having max(data_date_dividends) = '2016-12-30' ; --581

select distinct (company_number), max(data_date_dividends) from daily_stock group by company_number having max(data_date_dividends) < '2016-12-30' ; --398

select * from daily_stock where company_number = 48.0 order by data_date_dividends desc;

drop table ipo_survival_868;

create table ipo_survival_959 as 
select  d.company_number, i.ticker, i.company_name, i.company_type, i.ipo_window, i.date_of_ipo, min(d.data_date_dividends) as first_date, 
max(d.data_date_dividends) as last_date, (max(d.data_date_dividends)-min(d.data_date_dividends)) as days_passed 
from daily_stock d inner join ipovalwindow i on d.company_number = i.company_number and d.ticker_symbol = i.ticker
group by d.company_number, i.ticker, i.company_name, i.company_type, i.ipo_window, i.date_of_ipo; --959

select distinct (company_number) from ipo_survival_962;

select o.company_number, o.ticker from ipo_survival_962 o full outer join ipo_survival_959 n on o.company_number = n.company_number where n.company_number is null; --7

select *, (date_of_ipo - first_date) as diff from ipo_survival_962 where date_of_ipo <> first_date order by diff;

alter table ipo_survival_962
add column
stockstatus varchar(2);

update ipo_survival_962
set stockstatus = 
CASE 
when last_date = '2016-12-30' THEN 'S' 
else 'F' end;

select count(*) from ipo_survival_962 where stockstatus = 'S';  --569/393


select count(*) from ipo_survival_962 where stockstatus = 'S' and ipo_window = '0'; --198 
select count(*) from ipo_survival_962 where stockstatus = 'F' and ipo_window = '0';  --103

alter table ipo_survival_829
drop column months_passed;

update ipo_survival_829
set months_passed = days_passed/30.436875;

update ipo_survival_829
set years_passed = months_passed/12;

select  distinct on (i.ticker) d.ticker_symbol, i.company_number, i.company_name, i.company_type, i.ipo_window,  
max(d.data_date_dividends) as last_date, i.date_of_ipo, price_close_daily  
from daily_stock d inner join ipovalwindow i on i.company_number = d.company_number
group by d.ticker_symbol, i.company_number, d.company_number, i.company_name, i.ticker, i.company_type, i.ipo_window, d.price_close_daily 
order by i.ticker, last_date desc, d.price_close_daily; 

select  distinct on (i.company_number) i.company_number, d.ticker_symbol, i.company_name, i.company_type, i.ipo_window,  
max(d.data_date_dividends) as last_stock_date, i.date_of_ipo, price_close_daily  
from daily_stock d inner join ipovalwindow i on i.company_number = d.company_number where price_close_daily is not null
group by d.ticker_symbol, i.company_number, d.company_number, i.company_name, i.ticker, i.company_type, i.ipo_window, d.price_close_daily 
order by i.company_number, last_stock_date desc, d.price_close_daily; 

select count(*) from ipo_survival_962 where stockstatus = 'F' and company_type = 'Biotech'; --148 unique COs disappeared

select * from ipo_survival_962 where stockstatus = 'F' and company_type = 'Biotech';

--drop table daily_stock_derived;

create table ipo.daily_stock_derived as
select *, EXTRACT(YEAR FROM data_date_dividends) as year from ipo.daily_stock;

alter table ipo.daily_stock_derived add column market_cap float;

update ipo.daily_stock_derived set market_cap = shares_outstanding * price_close_daily;

select distinct on (company_number) ticker_symbol, EXTRACT(YEAR FROM data_date_dividends) as year, avg(price_close_daily) as avg_yearly_stock from daily_stock_derived 
group by company_number, data_date_dividends, ticker_symbol order by company_number, ticker_symbol;

select * from daily_stock_derived order by company_number;

create table if not exists avg_stock_price as
select company_number, year, round(avg(price_close_daily)::numeric,3) as avg_yearly_stock from daily_stock_derived group by company_number, year order by company_number, year; --6237

drop table avg_stock_price;

--drop table first_last_stock;

CREATE table if not exists first_last_stock AS
SELECT DISTINCT
       company_number
      ,first_value(data_date_dividends) OVER w AS first_time
      ,first_value(price_close_daily)         OVER w AS first_stock
      ,last_value(data_date_dividends)  OVER w AS last_time
      ,last_value(price_close_daily)          OVER w AS last_stock
FROM   daily_stock_derived where price_close_daily is not null
WINDOW w AS (PARTITION BY company_number ORDER BY data_date_dividends, price_close_daily
             ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
ORDER  BY 1 limit 40;
--977 does not allow null values

select * from daily_stock where company_number = 2 order by data_date_dividends desc;

create table first_last_valuation as
SELECT DISTINCT
       company_number
      ,first_value(data_date_dividends) OVER w AS first_date
      ,first_value(price_close_daily)         OVER w AS first_stock
      ,first_value(shares_outstanding)         OVER w AS first_shares
      ,first_value(price_close_daily * shares_outstanding) OVER w AS first_valuation
      ,last_value(data_date_dividends)  OVER w AS last_date
      ,last_value(price_close_daily)          OVER w AS last_stock
      ,last_value(shares_outstanding)          OVER w AS last_shares
      ,last_value(price_close_daily * shares_outstanding) OVER w AS last_valuation
FROM   daily_stock_derived where shares_outstanding is not null
WINDOW w AS (PARTITION BY company_number ORDER BY data_date_dividends, price_close_daily
             ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
ORDER  BY 1; --contains nulls


alter table first_last_stock
add column stockstatus varchar(20);

update first_last_stock
set stockstatus = 
CASE 
when last_time = '2016-12-30' THEN 'Active' 
else 'Inactive' end;


select * from ipo.daily_stock where ticker_symbol = 'RCPT' order by data_date_dividends desc; 
select * from ipo.daily_stock where ticker_symbol = 'PCYC' order by data_date_dividends desc; 
select * from ipo.daily_stock where ticker_symbol = 'SQNM' order by data_date_dividends desc; 

select * from daily_stock where company_number = 267 order by data_date_dividends desc;

drop table ipo_survival_868;

select distinct company_number from ipo_survival_959;

select distinct company_number from ipovalwindow; --979

create table first_last_valuation as
select s.*, s.first_stock*d.shares_outstanding as marketcap from first_last_stock s, daily_stock d where s.company_number = d.company_number and first_time = data_date_dividends;

select * from daily_stock where company_number = 30 order by data_date_dividends;

select count(*) from first_last_valuation where first_valuation > last_valuation; --503/all

select count(*) from first_last_valuation where first_valuation < last_valuation;  --472/all

select * from first_last_valuation where first_valuation = last_valuation; --263 (SANO), 267 (SQNA)

select count(*) from first_last_valuation where first_valuation > last_valuation ;

select * from daily_stock where company_number = '152'; --ABIO -> HYSEQ in ipovalwindow

select * from ipovalwindow where company_number = '152';

select * from daily_stock_derived where company_number = '163'; 


update ipovalwindow
set ticker = 'HYSQ' where ticker = 'ABIO' and company_number = '152';

create table ipofate  (
company_number float primary key,
ticker_symbol varchar(10),
company_name varchar(100),
activity_status varchar(10),
deletion_reason smallint,
company_type varchar(15),
ipo_window smallint,
last_stock_date date,
price_close_daily float,
date_of_ipo date,
ipo_price float,
fate varchar(10),
fate_detail varchar(15)
)

select i.company_number, i.date_of_ipo, f.first_time, (f.first_stock-i.ipo_price) as pricediff, (i.date_of_ipo - f.first_time) as datefiff from ipofate i natural inner join first_last_stock f 
where i.date_of_ipo != f.first_time; --157

select i.company_number, i.date_of_ipo, f.first_time, (f.first_stock-i.ipo_price) as pricediff, (i.date_of_ipo - f.first_time) as datefiff from ipofate i natural inner join first_last_stock f 
where i.ipo_price != f.first_stock; --0

--end value < IPO?

alter table first_last_valuation
add column endval_higherthanIPO smallint;

update first_last_valuation 
set endval_higherthanIPO = 1 where first_valuation < last_valuation;

select * from first_last_valuation where endval_higherthanIPO = 1; --472/505

alter table first_last_valuation
add column endstock_higherthan1dollar smallint;

update first_last_valuation 
set endstock_higherthan1dollar = 
case when last_stock > 1 then 1
else 0
end;

create table ipogeo (
company_number float primary key,
company_name varchar(100),
ticker varchar(10),
global_company_key int,
region varchar(100),
state varchar(2)
)

alter table ipogeo
add column country varchar(100);

alter table ipogeo
rename to ipogeobiotech;

\copy ipo.ipogeo from 'C:\Users\ecleary\Dropbox (ScienceandIndustry)\PROJECT - Public Biotech\Project with Anne Schnader\Test Run Files\IPOgeo.csv' csv header delimiter ',';

--match ipogeobiotech company_name with fda_db.orangebookproducts applicant or applicant_full_name or fda_db.applications sponsorname or labels.manufacturer_name

select distinct on (o.applicant_full_name) o.applicant, o.trade_name, i.company_name, i.state from fda_db.orangebookproducts o, ipogeobiotech i where translate(i.company_name, '.', '') ILIKE o.applicant_full_name;
--43

select distinct on (o.sponsorname) o.sponsorname, o.applno, i.company_name, i.state from fda_db.applications o, ipogeobiotech i where translate(i.company_name, '.', '') ILIKE o.sponsorname order by sponsorname;
--10


select distinct on (l.manufacturer_name) l.manufacturer_name, l.brand_name, i.company_name, i.state from fda_db.labels l, ipogeobiotech i where translate(i.company_name, '.,', '') ILIKE 
translate(l.manufacturer_name, '.,', '') order by manufacturer_name;
--0

select distinct (applicant_full_name) from fda_db.orangebookproducts order by applicant_full_name;

select * from time.master where project = 'CV2' order by runid;
select * from time.master where runid = 315;
select * from time.master where search_term = 'CYP17A1';

drop table notbillioncos;

create table timeto1B as
select distinct on (d.company_number)
d.company_number, d.ticker_symbol, d.company_name, d.data_date_dividends as billion_reached_date, d.market_cap as valuation, i.date_of_ipo,
i.valuation_at_ipo, d.data_date_dividends-i.date_of_ipo as daystoreach1B, i.ipo_window, i.company_type
from daily_stock_derived d inner join ipovalwindow i on d.company_number = i.company_number
where d.market_cap > 1000000000 and extract(year from i.date_of_ipo) >= 1997 
group by d.company_number, d.ticker_symbol, d.company_name, d.data_date_dividends, d.market_cap, i.date_of_ipo,
i.valuation_at_ipo, daystoreach1B, i.ipo_window, i.company_type
order by d.company_number, d.ticker_symbol, d.data_date_dividends;
--add endval_higherthanIPO/these are all 1B companies

select * from daily_stock_derived where ticker_symbol = 'ABGX' order by data_date_dividends desc;  --market cap: 9E7 in 1998 to 2E9 in 2006

select * from daily_stock_derived where company_number = '144.9' order by data_date_dividends; --MRKT/INFO issue [ipo date 2014/06/19]

select * from ipovalwindow where company_number = '144.9';

select * from ipovalwindow where ticker = 'MRKT';


create table timeto1b_postmoney as
select distinct on (d.company_number)
d.company_number, d.ticker_symbol, d.company_name, d.data_date_dividends as billion_reached_date, d.market_cap as billion_val, f.first_date, f.first_valuation,
d.data_date_dividends-f.first_date as daystoreach1B, endval_higherthanipo as endval_higherthanfirst, endstock_higherthan1dollar
from daily_stock_derived d inner join first_last_valuation f on d.company_number = f.company_number
where d.market_cap > 1000000000 and extract(year from f.first_date) >= 1997 
group by d.company_number, d.ticker_symbol, d.company_name, d.data_date_dividends, d.market_cap, f.first_date, daystoreach1B, f.first_valuation, endval_higherthanipo, endstock_higherthan1dollar
order by d.company_number, d.ticker_symbol, d.data_date_dividends;
--these are all 1B companies

alter table timeto1b_postmoney
rename column endval_higherthanIPO to endval_higherthanfirst;

update timeto1b_postmoney 
set endval_higherthanIPO = 1 where first_valuation < last_valuation;

select * from timeto1B where billion_reached_date = date_of_ipo; --93

select b.*, i.deletion_reason, activity_status from timeto1B b, ipofate i where i.company_number = b.company_number;

select company_number from daily_stock group by company_number having count(shares_outstanding) = 1; --263, 267


-- non 1B companies:
create table notBillioncos as
select distinct on (d.company_number)
d.company_number, d.ticker_symbol, d.company_name, d.data_date_dividends as last_activity_date, d.market_cap as valuation, i.date_of_ipo,
i.valuation_at_ipo, d.data_date_dividends-i.date_of_ipo as daysonmarket, i.ipo_window, i.company_type 
from daily_stock_derived d, ipovalwindow i where d.company_number = i.company_number and extract(year from i.date_of_ipo) >= 1997 
--and shares_outstanding is not null
and not exists (select * from timeto1b t where d.company_number = t.company_number)
order by d.company_number, d.ticker_symbol, d.data_date_dividends desc;
--593

SELECT * from daily_stock_derived where company_number = '328.9' order by data_date_dividends desc; 
---QPACU, (RPFG, ARTD, FSTF, IISX are ok) has all 0 shares 

alter table timeto1B
add column billion_status smallint;

update timeto1B
set billion_status = 1;

alter table notBillioncos
add column billion_status smallint;

update notBillioncos
set billion_status = 0;

select b.*, i.deletion_reason, activity_status from timeto1B b, ipofate i where i.company_number = b.company_number;

select b.*, i.deletion_reason, activity_status from notbillioncos b, ipofate i where i.company_number = b.company_number;

select distinct (fate_detail), count(*) from ipofate group by fate_detail;

select * from ipofate where fate_detail = 'other'; --Immtech (No longer filing financials)

select distinct (deletion_reason), count(*) from ipofate group by deletion_reason;


select distinct (deletion_reason), company_type, count(*) from ipofate group by deletion_reason, company_type;

select distinct deletion_reason, fate_detail  from ipo.ipofate where deletion_reason = 1 group by deletion_reason, fate_detail;

create table deletion_key (
code int primary key,
reason text
)


select distinct (activity_status), count(*) from ipo.ipofate where deletion_reason == 0 group by activity_status;

update deletion_key
set reason = 'active' where code = 0;

select * from ipovalwindow where valuation_at_ipo >= 1000000000 order by company_type, valuation_at_ipo; --21 (9 are biotechs)

--check high biotech vals (234, 62; 18, 193, 107)
SELECT * from daily_stock_derived where company_number = '62' order by data_date_dividends desc; 

select  i.company_name, i.ticker, v.* from first_last_valuation v inner join ipovalwindow i on i.company_number = v.company_number where i.company_type = 'Biotech';

--inflation adjust everything

--valuation at IPO vs first-day trading (pre/post market)

select * from daily_stock where ticker_symbol = 'QURE';

drop table drug_to_search;

drop table s_1;

drop table ipo_survival_959;

select * from ipovalwindow where ticker = 'DDDP'; --premoney = 195,023,475
select * from daily_stock_derived where ticker_symbol = 'DDDP'; --postmoney = 348,931,200
select avg(price_close_daily) from daily_stock_derived where ticker_symbol = 'DDDP' and price_close_daily is not null; --9.64

select *, date_of_ipo + interval '6 month' as sixmonth_date from ipovalwindow where ticker = 'DDDP';

--select * from daily_stock_derived where ticker_symbol = 'DDDP' and  data_date_dividends > data_date_dividends - interval '6 month';

alter table ipovalwindow_v0
add column sixmonth_date date;

update ipovalwindow_v0
set sixmonth_date =  date_of_ipo + interval '180 days';

select * from ipovalwindow_v0 where ticker = 'ACAD';

select d.* from daily_stock_derived d inner join ipovalwindow i on i.company_number = d.company_number where ticker_symbol = 'DDDP' and i.sixmonth_date = d.data_date_dividends;

select * from daily_stock_derived where ticker_symbol = 'DDDP' and data_date_dividends = '2001-02-04'; --closest date is 02/05 and no shares info available.

select d.*, i.sixmonth_date from daily_stock_derived d inner join ipovalwindow_v0 i on i.company_number = d.company_number where ticker_symbol = 'DDDP' and d.data_date_dividends < i.sixmonth_date
order by d.data_date_dividends desc limit 1; ----2001-02-02 

select d.*, i.sixmonth_date from daily_stock_derived d inner join ipovalwindow_v0 i on i.company_number = d.company_number where ticker_symbol = 'DDDP' 
order by abs(d.data_date_dividends - i.sixmonth_date) limit 1; --2001-02-05 (closer)

--above both work, but shares out can be null, fill in later?


create table ipo_survival_960 as 
select  d.company_number, i.ticker, i.company_name, i.company_type, i.ipo_window, min(d.data_date_dividends) as min_date, 
max(d.data_date_dividends) as last_date, (max(d.data_date_dividends)-min(d.data_date_dividends)) as days_passed 
from daily_stock d inner join ipovalwindow i on d.company_number = i.company_number and d.ticker_symbol = i.ticker
group by d.company_number, i.ticker, i.company_name, i.company_type, i.ipo_window;

select distinct(company_number) from ipovalwindow; --979
select distinct(company_number) from daily_stock; --977

select distinct (i.company_number), sum(d.market_cap) as postmoney from daily_stock_derived d, ipovalwindow i 
where d.company_number = i.company_number and i.company_type = 'Biotech' group by i.company_number; --365

select distinct (i.company_number), sum(d.market_cap) as postmoney from daily_stock_derived d, ipovalwindow i 
where d.company_number = i.company_number and i.company_type = 'Non Biotech' group by i.company_number; --612

select count(company_number) from ipovalwindow where company_type = 'Biotech'; --367
select count(company_number) from ipovalwindow where company_type = 'Non Biotech'; --612

select company_type, sum(d.market_cap) as postmoney, count (distinct d.company_number) from daily_stock_derived d, ipovalwindow i 
where d.company_number = i.company_number group by i.company_type; 

select count(distinct company_name) from ipovalwindow where company_type = 'Biotech'; --367
select count(distinct company_name) from ipovalwindow where company_type = 'Biotech' and EXTRACT (YEAR FROM date_of_ipo) > '1996'; --325 (1995-353)

select distinct (i.company_number), sum(d.market_cap) as postmoney from daily_stock_derived d, ipovalwindow i where
d.company_number = i.company_number and i.company_type = 'Biotech' and EXTRACT (YEAR FROM date_of_ipo) > '1996' group by i.company_number; --325

select company_number, ticker, company_name, EXTRACT (YEAR FROM date_of_ipo) as ipo_year from ipovalwindow where company_type = 'Biotech' 
order by company_number; --367


select company_number, ticker, company_name date_of_ipo from ipovalwindow where company_type = 'Biotech'
and EXTRACT (YEAR FROM date_of_ipo) >= 1997 order by company_number; --325

select c.* from company_list c full outer join ipovalwindow i on c.company_number = i.company_number where i.company_number is null; --1 missing
select c.* from company_list c full outer join ipovalwindow i on c.company_name = i.company_name where i.company_number is null; --MediciNova/191 missing


select company_number, ticker, company_name, date_of_ipo from ipovalwindow where company_type = 'Biotech' and EXTRACT (YEAR FROM date_of_ipo) >= 1997 order by company_number; --325

create table company_list (
company_number int primary key,
company_name varchar(150),
ipo_date date
)

alter table company_list
rename to laura_company_list;

\copy ipo.laura_company_list from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT - Public Biotech/Project with Anne Schnader/original_IPO_company_list.csv' with csv header delimiter ',';

select i.* from company_list c full outer join ipovalwindow i on c.company_name = i.company_name where c.company_number is null
and company_type = 'Biotech';

select distinct d.company_number, d.company_name from daily_stock d inner join ipovalwindow i on d.company_number = i.company_number where i.company_type = 'Biotech'; --367
select distinct i.company_number, i.company_name from daily_stock d inner join ipovalwindow i on d.company_number = i.company_number where i.company_type = 'Biotech'; --365

select distinct d.company_number, d.company_name, EXTRACT (YEAR FROM date_of_ipo) from daily_stock d inner join ipovalwindow i on d.company_number = i.company_number where i.company_type = 'Biotech' and EXTRACT (YEAR FROM date_of_ipo) >= 1997; --327
select company_number, ticker, company_name, EXTRACT (YEAR FROM date_of_ipo) from ipovalwindow where company_type = 'Biotech' and EXTRACT (YEAR FROM date_of_ipo) >= 1997 order by company_number; --325

select i.company_number, i.company_name, i.date_of_ipo from daily_stock d full outer join ipovalwindow i on d.company_number = i.company_number 
where  EXTRACT (YEAR FROM date_of_ipo) >= 1997 and d.company_number is null or i.company_number is null; 

select * from ipovalwindow where company_number = 161 or company_number = 36; --there
select * from daily_stock where company_number = 161 or company_number = 36; --not there

select * from daily_stock d full outer join ipovalwindow i on d.company_number = i.company_number 
where EXTRACT (YEAR FROM date_of_ipo) >= 1997 and d.company_number is null or i.company_number is null ; 

select i.ticker from daily_stock d full outer join ipovalwindow i on d.ticker_symbol = i.ticker
where EXTRACT (YEAR FROM date_of_ipo) >= 1997 and i.ticker is null; --null

select  i.company_number, i.ticker, i.company_name from daily_stock d full outer join ipovalwindow i on d.ticker_symbol = i.ticker
where EXTRACT (YEAR FROM date_of_ipo) >= 1997 and d.ticker_symbol is null;  --17

select * from daily_stock where ticker_symbol = 'CEMR' limit 10; --CEMP
select * from daily_stock where company_number = '78' limit 10;

select * from daily_stock where ticker_symbol = 'FAT' limit 10; --FATE
select * from daily_stock where company_number = '133' limit 10;

select * from daily_stock where ticker_symbol = 'FIBO' limit 10; --FGEN
select * from daily_stock where company_number = '134' limit 10;

select * from daily_stock where ticker_symbol = 'FIV' limit 10; --FPRX
select * from daily_stock where company_number = '135' order by data_date_dividends limit 10;

select * from daily_stock where ticker_symbol = 'DHRM' limit 10; --LLIT
select * from daily_stock where company_number = '25.9' order by data_date_dividends limit 10;

select * from daily_stock where ticker_symbol = 'COWN' limit 10; --COWN.1
select * from daily_stock where company_number = '84.9' limit 10;

select * from daily_stock where ticker_symbol = 'CITC' limit 10; --CITC.1
select * from daily_stock where company_number = '89.9' limit 10;

select * from daily_stock where ticker_symbol = 'FISH' limit 10; --AZURQ
select * from daily_stock where company_number = '95.1' limit 10;

select * from daily_stock where ticker_symbol = 'HWTO' limit 10; --HTWO
select * from daily_stock where company_number = '125.1' limit 10;

select * from daily_stock where ticker_symbol = 'CNTE' limit 10; --FOGO
select * from daily_stock where company_number = '208.1' limit 10;

select * from daily_stock where ticker_symbol = 'CNTE' limit 10; --NGLS
select * from daily_stock where company_number = '222.1' limit 10;

select * from daily_stock where ticker_symbol = 'CNTE' limit 10; --CADTU
select * from daily_stock where company_number = '314.1' limit 10;

select * from daily_stock where company_number = '98' limit 10;

select * from daily_stock where ticker_symbol = 'CAPN';
select * from daily_stock where ticker_symbol = 'BANFP'; 
select * from daily_stock where ticker_symbol = 'GMAN';
select * from daily_stock where ticker_symbol = 'GMET';
select * from daily_stock where ticker_symbol = 'SYRX';
select * from daily_stock where ticker_symbol = 'TSRA' order by data_date_dividends desc;
select * from daily_stock where ticker_symbol = 'CNC' order by data_date_dividends desc;
select * from daily_stock where ticker_symbol = 'QRVO' order by data_date_dividends desc;
select * from daily_stock where ticker_symbol = 'TRTL' order by data_date_dividends desc;
select * from daily_stock where ticker_symbol = 'ADMA' order by data_date_dividends desc;
select * from daily_stock where ticker_symbol = 'XNCR' order by data_date_dividends desc;
select * from daily_stock where ticker_symbol = 'LIND' order by data_date_dividends desc;
select * from daily_stock where company_number = '191' order by data_date_dividends desc;
select * from daily_stock where ticker_symbol = 'KYTH';
select * from daily_stock where ticker_symbol = 'MNOV';


select * from ipofate where company_number = '39'; --Antivirals
select distinct(ticker_symbol) from daily_stock where company_number = '39'; --SRPT
select distinct(company_name) from daily_stock where company_number = '39'; --Antivirals/Sarepta

--drop table daily_stocktest

insert into daily_stock
select * from daily_stock_derived;

alter table daily_stock
add column year float,
add column market_cap float;

alter table daily_stock
drop column year,
drop column market_cap;

select count (distinct company_number) from daily_stock; --978
select count (distinct company_number) from daily_stock_derived; --977

select count (distinct ticker_symbol) from daily_stock; --992
select count (distinct ticker_symbol) from daily_stock_derived; --991

select distinct(d.company_number, d.ticker_symbol) from daily_stock d full outer join daily_stock_derived dd on d.company_number = dd.company_number where 
dd.company_number is null; --MNOV is missing from derived, but that's OK

alter table ipovalwindow
drop column sixmonth_date;

select * from daily_stock where ticker_symbol = 'CVGP' limit 10;
select * from daily_stock where ticker_symbol = 'ADRO' limit 10;

\copy ipo.ipovalwindow from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT - Public Biotech/Project with Anne Schnader/Raw Data/ControlsBiotechListTickerValDate.csv' with csv header delimiter ',';

select * from ipofate where fate_detail = 'name change'; --10  [VCEL, AGEN, SRPT, CPRX, CTIC, HZNP, RDEA, JAZZ, MEIP, RIGL]
select * from ipofate where fate_detail = 'merged'; --18
select * from ipofate where fate_detail = 'acquired'; --90
select * from ipofate where fate_detail = 'bankrupt'; --5

select distinct(fate_detail) from ipofate where activity_status = 'active';  --null/active/1 bankrupt/name change
select distinct(fate_detail) from ipofate where activity_status = 'inactive';  --null/active/bankrupt/name change, merged, acquired

select distinct f.fate_detail, f.deletion_reason, count(f.*) from ipofate f where fate_detail is not null group by fate_detail, deletion_reason order by fate_detail;
--select distinct f.fate_detail, f.deletion_reason, count(f.*), k.reason from ipofate f, deletion_key k where fate_detail is not null group by fate_detail, deletion_reason, reason order by fate_detail;

select distinct f.fate_detail, k.reason from ipofate f, deletion_key k where fate_detail is not null group by fate_detail, reason order by fate_detail;

select * from ipofate where activity_status = 'active' and fate_detail = 'bankrupt'; --ARYX -active, bankrupt, stock price 0.005

select * from ipofate where activity_status = 'inactive' and fate_detail = 'active'; --CBYL, IMMP should be inactive

select * from ipofate i inner join first_last_stock f on i.company_number = f.company_number where last_stock_date <> last_time; --172.9/HRMNU
--last date should have been 2016-12-14, not 2016-12-30; Explanation: merger new ticker = NEXT (does not exist in DB)

select * from ipofate i inner join first_last_stock f on i.company_number = f.company_number where last_price_close_daily <> last_stock; --148.1/EAGLW.2 ~$11 difference
select * from daily_stock where ticker_symbol = 'EAGLW.2';
select * from daily_stock where company_number = '148.1';

select * from ipofate where company_number = '191';

select * from ipofate where company_type = 'Biotech' and EXTRACT (YEAR FROM date_of_ipo) >= 1997;  --325

select * from ipofate where company_number = '94'; --ZLCS 
select * from daily_stock where company_number = '94' limit 10;  --ZLCS
select * from ipovalwindow where company_number = '94'; --EPRSQ --needs to be changed
select * from daily_stock where ticker_symbol = 'EPRSQ'; --null
select * from ipovalwindow where ticker = 'ZLCS'; --null

update ipovalwindow
set ticker = 'ZLCS' where company_number = '94';

select * from ipofate where company_number = '232'; --missing
select * from ipovalwindow where company_number = '232'; --PCOP --change to ACCL
select * from daily_stock where company_number = '232'; --ACCL --1995
select * from daily_stock where ticker_symbol = 'PCOP'; --null

update ipovalwindow
set ticker = 'ACCL' where company_number = '232'; --1995 co, so doesn't matter

select * from ipofate where company_number = '110.1'; --ATLS.2 Arkhan --2004
select * from ipovalwindow where company_number = '110.1'; --ATLS Arkhan
select * from daily_stock where ticker_symbol = 'ATLS'; --null
select * from daily_stock where company_number = '110.1' limit 10; --ATLS.2 Atlas Energy
--Note: be aware that company 110.1 changed names and tickers.

select * from ipofate i inner join first_last_stock f on i.company_number = f.company_number where first_stock <> ipo_price; --all matches

select * from daily_stock where ticker_symbol = 'CCXI'; --81
select * from ipovalwindow where ticker = 'CCXI';

delete from IPOvalwindow
where ticker = 'CCXI' and company_number = '316.1';

select * from ipovalwindow where company_number = '81.1'; --Homestreet
select * from ipovalwindow where ticker = 'HMST'; --77.9/81.1
select * from ipofate where ticker_symbol = 'HMST'; --78.1
select * from daily_stock where ticker_symbol = 'HMST'; --78.1

select * from ipovalwindow where company_number = '78.1'; --CZR Caesar's --incorrect 316.1
select * from daily_stock where company_number = '78.1'; --HMST Homestreet --correct
select * from ipofate where company_number = '78.1'; --HMST Homestreet --correct

select * from ipovalwindow where company_number = '77.9'; --Homestreet -- incorrect
select * from daily_stock where company_number = '77.9'; --REGI - Renewable
select * from ipofate where company_number = '77.9'; --REGI - Renewable

select * from ipovalwindow where company_number = '77.9'; --Homestreet -- incorrect

--Should be:
77.9 – Renewable Energy Group, Inc. (315.9?)
78.1 – Homestreet, Inc.
81.1 – Synacor, Inc
316.1 - CZR Caesar

select * from ipovalwindow i inner join first_last_valuation f on i.company_number = f.company_number where valuation_at_ipo <> first_valuation; --863

--select * from ipofate i inner join first_last_stock f on i.company_number = f.company_number where price_close_daily <> last_stock; 

select * from ipofate i inner join first_last_stock f on i.company_number = f.company_number where f.first_stock <> i.ipo_price; --all good 
select * from ipofate i inner join first_last_stock f on i.company_number = f.company_number where date_of_ipo <> first_time; --157
--CHECK ipofate and ipovalwindow for IPO date consistency

select * from ipovalwindow where company_name ~* 'Xtl biopharmaceuticals'; --XTLB/326.0
select * from ipovalwindow where company_name ~* 'VBL therapeutics'; --VBLT/314.0

select * from ipovalwindow where company_name ~* 'Medicinova'; --191
select * from daily_stock where company_name ~* 'Medicinova'; --last stock price 2015-12-31

select * from first_last_stock where last_time = '2015-12-31'; --126.9

select * from first_last_stock where company_number = '191'; --null
select * from daily_stock_derived where company_number = '191'; --null

select * from ipovalwindow where company_number = '126.9'; --FNBC (First NBC Bank Holding Co) last stock price should be 2016

delete from IPOvalwindow
where ticker = 'XTLB' and company_number = '326';

delete from IPOvalwindow
where ticker = 'VBLT' and company_number = '314';

create ipofatecopy as
select * from ipofate;

delete from ipofate
where ticker_symbol = 'XTLB' and company_number = '326';

delete from ipofate
where ticker_symbol = 'VBLT' and company_number = '314';


select * from ipovalwindow where company_type = 'Biotech' and extract (YEAR from date_of_ipo) >= 1997; --287??

select * from ipofate where company_type = 'Biotech' and extract (YEAR from date_of_ipo) >= 1997; --323 (323.csv)

select * from ipofate where company_type = 'Non Biotech' and extract (YEAR from date_of_ipo) >= 1997; --612

--crosschecking first dates/prices

select * from ipofate i inner join first_last_stock f on i.company_number = f.company_number where f.first_stock <> i.ipo_price; --First stock price in daily_stocks = ipo_price in ipofate

select (f.first_time - i.date_of_ipo) as diff, i.*, f.first_time from ipofate i inner join first_last_stock f on i.company_number = f.company_number 
where f.first_time <> i.date_of_ipo order by diff; --several companies need to be investigated here

select (f.first_time - i.date_of_ipo) as diff, i.*, f.first_time from ipovalwindow i inner join first_last_stock f on i.company_number = f.company_number 
where f.first_time <> i.date_of_ipo order by diff; --check 144.9 (MRKT -> INFO), 218.1

select ( f.first_valuation - i.valuation_at_ipo) as diff, i.*, f.first_valuation from ipovalwindow i inner join 
first_last_valuation f on i.company_number = f.company_number where f.first_valuation <> i.valuation_at_ipo; --not equal!!


select ( f.first_valuation - i.valuation_at_ipo) as diff, i.*, f.first_valuation from ipovalwindow i inner join 
first_last_valuation f on i.company_number = f.company_number where f.first_valuation <> i.valuation_at_ipo and company_type = 'Biotech'; --325

--crosschecking last dates/prices

select * from ipofate i inner join first_last_stock f on i.company_number = f.company_number where f.last_stock <> i.price_close_daily; 

select * from ipofate i inner join first_last_stock f on i.company_number = f.company_number where f.last_time <> i.last_stock_date; 

-- crosschecking valuation @ IPO

select market_cap, data_date_dividends from daily_stock_derived where ticker_symbol = 'GBIM' order by data_date_dividends;

select * from daily_stock where ticker_symbol = 'GBIM' order by data_date_dividends;

select * from daily_stock_derived where company_number = '143' order by data_date_dividends;

select * from ipovalwindow where ticker = 'GBIM'; --matches Laura's  Valuation at IPO column (O)

-- Feb. 7 re-importing file with Skyler's changes in company numbers

\copy ipo.ipovalwindow from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT - Public Biotech/Project with Anne Schnader/Raw Data/ControlsBiotechListTickerValDate.csv' with csv header delimiter ',';

truncate table laura_company_list;

alter table laura_company_list
add column ticker varchar(10);

alter table laura_company_list
rename to final_company_list;

alter table final_company_list
rename to final_biotech_list;

\copy ipo.final_biotech_list from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT - Public Biotech/Project with Anne Schnader/Analyses/crosschecking/323.csv' with csv header delimiter ',';

select * from ipovalwindow where company_number = 335;

delete from ipofate where 

select * from ipofate where company_type = 'Biotech';

select * from ipofate i, ipovalwindow w where i.company_type = 'Biotech' and i.company_number = w.company_number; --286

select i.company_number, w.company_number from ipofate i, ipovalwindow w where i.company_type = 'Biotech' and 
i.company_number <> w.company_number and i.company_name = w.company_name;  --0

select * from ipofate i, ipovalwindow w where  i.company_name = w.company_name and i.company_type = 'Biotech'; --286

select w.* from ipofate i, ipovalwindow w where  i.ticker_symbol = w.ticker and i.company_type = 'Biotech'; --270

select * from ipofate i, ipovalwindow w where i.company_name = w.company_name and i.ticker_symbol <> w.ticker and i.company_type = 'Biotech'; --19

select i.*, d.company_name, d.ticker_symbol from ipofate i, daily_stock d where i.company_name = d.company_name 
and i.ticker_symbol <> d.ticker_symbol and i.company_type = 'Biotech';  --all match

select i.*, d.company_name, d.ticker_symbol from ipofate i, daily_stock d where i.company_name = d.company_name 
and i.company_type = 'Biotech' and i.company_name <> d.company_name;  --all match

select distinct d.company_name, d.ticker_symbol, i.company_name from ipovalwindow i, daily_stock d where i.company_number = d.company_number 
and i.ticker <> d.ticker_symbol and i.company_type = 'Biotech';  --23 (look into SRRA, SNOA, TRGA - changed name,  the rest is capitalization issues)

--upload new ipovalwindow

create table ipovalwindow_v0 as
select * from ipovalwindow;

truncate table ipovalwindow;

alter table IPOvalwindow
alter column valuation_at_ipo
type float;

copy ipo.ipovalwindow from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT - Public Biotech/Project with Anne Schnader/Raw Data/BiotechListTickValDate_FEB2018.csv' with csv header delimiter ',';
--323

\copy ipo.ipovalwindow from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT - Public Biotech/Project with Anne Schnader/Raw Data/ControlsListTickValDate_JAN2018.csv' with csv header delimiter ',';
--540

--TODO: fill in controls info in ipovalwindow


select c.* from ipofate c full outer join ipovalwindow i on c.company_number = i.company_number where i.company_number is null; --72 missing controls

select * from ipovalwindow where company_number = '39' or company_number = '308'; --uniQure (QURE) and Antivirals (AVII)

select * from ipofate where company_number = '39' or company_number = '308'; --uniQure (QURE) and Antivirals (SRPT) changed name to Sarepta

alter table ipofate
rename price_close_daily to last_price_close_daily;

alter table ipofate
rename ipo_price to first_price_close_daily;

 update ipovalwindow
 set ipo_window = f.ipo_window
 from ipofate f
 where ipovalwindow.company_number = f.company_number;

select * from ipovalwindow where ticker = 'NTLA';

select * from daily_stock where company_number = '218.1' order by data_date_dividends; --XGTI 2011-07-19
select * from ipovalwindow where company_number = '218.1'; --XGTI 2013-07-19
select * from ipofate where company_number = '218.1'; --XGTI 2013-07-19

select * from daily_stock where ticker_symbol = 'EPIQ' order by data_date_dividends; --no shares reported until 1998
select * from daily_stock where ticker_symbol = 'YURI' order by data_date_dividends; --spurious shares reported
select * from daily_stock where ticker_symbol = 'BLBD' order by data_date_dividends; --missing 1 year of data in Compustat (IPO 2014); IPO symbol HCACU

select v.ticker_symbol, d.company_number, v.date_of_ipo, d.first_date as first_stockprice_date, (v.date_of_ipo - d.first_date) as diff 
from ipofate v, first_last_valuation d where v.company_number = d.company_number and v.date_of_ipo <> d.first_date 
group by date_of_ipo, v.ticker_symbol, d.first_date, d.company_number order by diff;

create table first_last_marketcap as
select * from first_last_valuation;

alter table first_last_marketcap
rename column first_valuation to first_marketcap;

alter table first_last_marketcap
rename column last_valuation to last_marketcap;

select distinct(last_stock_date) from ipofate where fate = 'desister'; --341
select distinct(last_stock_date) from ipofate where fate = 'persister'; --all 2016-12-30

select count(company_number) from ipofate where fate = 'desister' and company_type = 'Biotech'; --115
select count(company_number) from ipofate where fate = 'persister' and company_type = 'Biotech'; --208


alter table ipovalwindow_v0
add column ipowindow int;

update ipovalwindow_v0
set ipowindow =
CASE when date_of_ipo between '1995-07-01' and '1996-11-30' THEN 1
when date_of_ipo between '1999-07-01' and '2000-11-30' THEN 2 
when date_of_ipo between '2004-02-01' and '2007-10-31' THEN 3
when date_of_ipo between '2013-01-01' and '2016-12-30' THEN 4
ELSE 0 end;


select * from ipovalwindow_v0 i where ipowindow <> ipo_window; -- all match

select * from ipofate where company_type = 'Biotech'; --323

select table_schema, table_name, column_name from information_schema.columns where column_name like '%global%'; --ipogeobiotech

create table gvc_naics (
gvc int primary key,
ticker_symbol varchar(10),
company_name varchar(100),
naics int
);

\copy ipo.gvc_naics from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT - Public Biotech/Project with Anne Schnader/NAICS/WRDS.csv' with csv header delimiter ',';
--repeat for all WRDS file in that directory

create table naics_key (
naics_code varchar(10) primary key,
description varchar(200)
);

\copy ipo.naics_key from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT - Public Biotech/Project with Anne Schnader/NAICS/2017_NAICS_Codes_Key.csv' with csv header delimiter ',';
--2196

select * from ipofate where company_number = 253; --RNA short lifespan?
select distinct(ticker_symbol) from daily_stock where company_number = 253;

select distinct(deletion_reason), count(*) from ipofate where company_type = 'Biotech' group by deletion_reason order by deletion_reason;

select distinct(deletion_reason), count(*) from ipofate where company_type = 'Non Biotech' group by deletion_reason order by deletion_reason;

select * from ipogeobiotech i, gvc_naics g where g.gvc = i.global_company_key; --181 (~365 missing)

select * from ipofate i, gvc_naics g where g.ticker_symbol = i.ticker_symbol; --511

select * from ipofate i left join gvc_naics g on g.ticker_symbol = i.ticker_symbol; --511 (some tickers changed)

select * from ipofate i left join gvc_naics g on g.company_name = upper(i.company_name) or g.ticker_symbol = i.ticker_symbol; --164

select * from ipofate i,gvc_naics  g where g.company_name = upper(i.company_name) or g.ticker_symbol = i.ticker_symbol; --514


--revised 2/22: changed 4 IPO windows to 5 with no gaps - based on the number of companies that IPOed per quarter (Tableau):

alter table ipofate
add column ipowindownew int;

update ipofate
set ipo_window =
CASE when date_of_ipo between '1997-01-01' and '1999-12-31' THEN 1 --end at 1998/start next in 1999 to match Laura's?
when date_of_ipo between '2000-01-01' and '2002-12-31' THEN 2 
when date_of_ipo between '2003-01-01' and '2007-12-31' THEN 3
when date_of_ipo between '2009-01-01' and '2013-03-31' THEN 4 --end at 2012?
when date_of_ipo between '2013-04-01' and '2016-12-31' THEN 5
ELSE 0 end;

select distinct(ipo_window) from ipofate;

select count (company_number), ipowindownew from ipofate group by ipowindownew;

alter table ipofate
drop column ipowindownew; 

create table ipofate_v0 as
select * from ipofate;

--Adjusted to match Laura's scatterplot on 3/14; changes to first and last (2) windows

alter table ipofate
add column adj_ipo_window int;

update ipofate
set adj_ipo_window =
CASE when date_of_ipo between '1997-01-01' and '1998-12-31' THEN 1 
when date_of_ipo between '1999-01-01' and '2002-12-31' THEN 2 
when date_of_ipo between '2003-01-01' and '2007-12-31' THEN 3
when date_of_ipo between '2009-01-01' and '2012-12-31' THEN 4 
when date_of_ipo between '2013-01-01' and '2016-12-31' THEN 5
ELSE 0 end;



drop table ipowindowkey;

create table ipowindowkey (
adj_ipo_window int primary key,
ipo_year_range text,
ipo_window int,
previous_ipo_year_range text );

insert into ipowindowkey(adj_ipo_window, ipo_year_range, ipo_window, previous_ipo_year_range)
values (1, '1997-1998', 1, '1997-1999'), 
 (2, '1999-2002', 2, '2000-2002'), 
 (3, '2002-2007', 3, '2003-2007'), 
 (4, '2009-2012', 4, '2009-2013/03/31'), 
 (5, '2013-2016', 5, '2013/04/01-2016');

select * from ipofate where adj_ipo_window <> ipo_window;  --31 changed

--NAICS check


select * from naics_key where naics_code LIKE '42%'; 
select * from naics_key where naics_code = '541512'; --Computer systems Design services
select * from naics_key where naics_code LIKE '999990'; --Unclassified Establishments added on 3/2/2018

insert into naics_key(naics_code, description)
values (999990, 'Unclassified Establishments');

select * from daily_stock where ticker_symbol = 'CODE';

select * from ipofate where ticker_symbol = 'CODE';

select * from ipofate where ticker_symbol = 'CAMBU';

select * from gvc_naics where ticker_symbol = 'CAMB';

select * from daily_stock where company_name LIKE 'CAMBRIDGE%'; --290.1 (ABIL/Ability Inc.)
select * from daily_stock where ticker_symbol LIKE 'ABIL'; --290.1

select * from ipofate where company_number = '290.1';

select * from daily_stock where company_name LIKE 'COLLABRIUM%'; --179.1 JANCF

select * from daily_stock where company_name LIKE 'CPI%'; --285.1 CPII

select * from daily_stock where company_name LIKE 'GLOBAL D%'; --16.9 This is a SPAC that bought STG

select * from daily_stock where company_name LIKE 'HF2%'; --125.1

select * from daily_stock where ticker_symbol = 'SNAP'; --Synaptic Pharma...not to be confused with SNAP, Inc 2017 IPO

--Aastrom = VCEL

delete from gvc_naics
where ticker_symbol = 'SNAP' and gvc = '30091'; --wrong SNAP.

select * from gvc_naics g full outer join ipogeobiotech i on i.global_company_key = g.gvc where g.gvc is null; --6 (NYSQ, PZRX, CAPN, KBIO, RNA, IMMP)

--Find 20 controls that are missing NAICS

--select i.*, g.naics, n.description from ipofate i inner join gvc_naics g on , naics_key n where

select * from daily_stock where ticker_symbol = 'OXBRW';

create table ipogeo_class (
gvc int,
ticker varchar(10),
company_name varchar(100),
stock_xcode int,
street varchar(100),
postal_code varchar(10),
city varchar(100),
company_legal_name varchar(100),
active_status char(2),
stateinc varchar(2),
naics int,
sic int,
state varchar(2),
primary key (gvc, ticker)
);

\copy ipo.ipogeo_class from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT - Public Biotech/Project with Anne Schnader/NAICS/WRDSGVC.csv' with csv header delimiter ',';

--Filling in missing NAICS

select distinct gvc from ipogeo_class; --923

select * from ipogeobiotech b left join ipogeo_class a on a.gvc = b.global_company_key where a.gvc is null; --19 biotechs missing

select * from gvc_naics b left join ipogeo_class a on a.gvc = b.gvc where a.gvc is null; --58

select * from gvc_naics b right join ipogeo_class a on a.gvc = b.gvc where b.gvc is null; --54

--select * from ipogeo_class c right join ipofate f on f.company_name = c.company_legal_name where c.company_legal_name is null;

select * from ipogeo_class c right join ipofate f on f.ticker_symbol = c.ticker where c.ticker is null; --79 to fill in

select * from gvc_naics c right join ipofate f on f.ticker_symbol = c.ticker_symbol where c.ticker_symbol is null; --37

--select * from gvc_naics c right join ipofate f on upper(f.company_name) = c.company_name where c.company_name is null; --37

select * from daily_stock where ticker_symbol = 'BUYX'; -- =BUYY

update gvc_naics
set ticker_symbol = 'JAGX' where gvc = '21619';

update gvc_naics
set company_name = 'JAGUAR ANIMAL HEALTH INC' where gvc = '21619'; 

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (129518,'BUYY','BUY.COM INC',454110);

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (20898,'CAPN','CAPNIA INC',334510); --now SLNO SOLENO THERAPEUTICS INC

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (148396,'SYRX','SYSOREX GLOBAL',423430); --now INPX	INPIXON

select * from daily_stock where ticker_symbol = 'BANFP'; -- =BANCFIRST

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (28022,'BANF','BANCFIRST CORPORATION',522110);

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (17709,'FNBCQ','FIRST NBC BANK HOLDING CO',522110);

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (133866,'PRPL','PURPLE COMMUNICATIONS INC',517210);

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (18580,'ROIQU','ROI ACQUISITION CORP II',999990);

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (18325,'EAGL.2','SILVER EAGLE ACQUISITION CP',999990);

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (182309,'HYSQ','HYSEQ PHARMACEUTICALS INC.',325414); --now ABIO,ARCA BIOPHARMA

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (22225,'OACQF','ORIGO ACQUISITION CORP',999990); 

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (15489,'KBIO','KALOBIOS PHARMACEUTICALS INC',325414); 

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (21944,'HRMN','HARMONY MERGER CORP',999990); 

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (156153,'TSRA','TESSERA TECHNOLOGIES INC',334413); --now XPER,XPERI CORPORATIO

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (185190,'GMAN','GORDMANS STORES, INC',4481); --now GMANQ,G-ESTATE LIQUIDATION STORES

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (21206,'SMAC','SINO MERCURY ACQUISITION CP',999990); 

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (20517,'LMB','LIMBACH HOLDINGS INC',238); 

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (163772,'CODE','SPANSION INC',334413); 

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (23882,'EACQ','EASTERLY ACQUISITION CORP',999990); 

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (27198,'PZRX','PHASERX INC',325414); 

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (26514,'MSDI','MONSTER DIGITAL INC',334112); 

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (24175,'LTEA','LONG IS ICED TEA CORP',312111); 

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (26562,'JSYN','JENSYN ACQUISITION CORP',999990); 

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (27241,'LCA','LANDCADIA HOLDINGS INC',999990); 

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (23936,'ECAC','E-COMPASS ACQUISITION CORP',999990); 

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (001,'KFED','K-FED BANCORP',522110); 

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (002,'CPAAU','CONYERS PARK ACQUISITION CORP',999990); 

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (003,'CFCOU','CF CORP',999990);

insert into gvc_naics(gvc, ticker_symbol, company_name, naics)
values (141390,'RNA','RIBAPHARM INC',325414); --Is now Prosensa gvc = 18076

select * from gvc_naics where gvc= 18076; --RNA (PROSENSA)

select * from gvc_naics where gvc= 253523; --Immutep (same as Immtech? 120051)

select * from gvc_naics g, ipofate i where g.ticker_symbol = i.ticker_symbol and EXTRACT(YEAR FROM i.date_of_ipo) < 1997; --0

select * from gvc_naics c right join ipofate f on f.ticker_symbol = c.ticker_symbol where c.ticker_symbol is null and company_type = 'Biotech';

select * from gvc_naics c right join ipofate f on upper(f.company_name) = c.company_name where c.company_name is null and company_type = 'Biotech';

create table gvc_cisikey (
company_number float primary key,
company_name varchar(100),
ticker varchar(10),
gvc int,
ipo_date date
)

\copy ipo.gvc_cisikey from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT - Public Biotech/Project with Anne Schnader/Raw Data/gvc_company_number_key_final.csv' with csv header delimiter ',';
--935

--truncate table gvc_cisikey;

select g.*, i.company_type from gvc_cisikey g full outer join ipofate i on i.company_number = g.company_number where
 EXTRACT(YEAR FROM i.date_of_ipo) >= 1997;
 
select * from gvc_cisikey where EXTRACT(YEAR FROM ipo_date) >= 1997;

select distinct i.company_number, g.* from gvc_cisikey g left join daily_stock i on i.company_number = g.company_number;

select g.*, i.company_type from gvc_cisikey g full outer join ipofate i on i.company_number = g.company_number where
 EXTRACT(YEAR FROM i.date_of_ipo) >= 1997;
 
select g.*, i.naics from gvc_cisikey g full outer join gvc_naics i on i.gvc = g.gvc where EXTRACT(YEAR FROM g.ipo_date) >= 1997;
--5 didn't match on gvc (CLACU.1, DMGI, SYRX, RNA, IMMP)

select g.*, i.naics from gvc_cisikey g full outer join ipo i on i.gvc = g.gvc where naics = '999990'; --32 (not all are acqui corps)

select t1.name, t2.image_id, t3.path
from table1 t1 inner join table2 t2 on t1.person_id = t2.person_id
inner join table3 t3 on t2.image_id=t3.image_id

select i.company_number, i.company_name, i.company_type, i.date_of_ipo, i.last_stock_date, (i.date_of_ipo - i.last_stock_date)/365 as diff, n.naics 
from gvc_naics n inner join gvc_cisikey g on g.gvc = n.gvc
inner join ipofate i on i.company_number = g.company_number where i.company_type = 'Biotech'; --321 (2 missing NAICS)


select i.company_number, i.company_name, i.company_type, i.date_of_ipo, i.last_stock_date, (i.date_of_ipo - i.last_stock_date)/365 as diff, n.naics 
from gvc_naics n inner join gvc_cisikey g on g.gvc = n.gvc
inner join ipofate i on i.company_number = g.company_number where i.company_type = 'Non Biotech' order by n.naics; --609 (3 missing NAICS)


select i.company_number, i.company_name, i.company_type, i.date_of_ipo, i.last_stock_date, (i.last_stock_date-i.date_of_ipo)/12 as diff, n.naics 
from gvc_naics n inner join gvc_cisikey g on g.gvc = n.gvc inner join 
ipofate i on i.company_number = g.company_number where i.company_name LIKE '%Acquisition%' and activity_status = 'inactive'; --5 (listed 1-2 yrs)

select * from ipofate where activity_status = 'inactive' and last_stock_date = '2016-12-30'; --ASBM Ventrus (merged with Assembly)

select * from naics_key where naics_code LIKE '3254%' order by naics_code; --chem/pharma manuf

select * from naics_key where naics_code LIKE '3345%' order by naics_code; --electromedical, etc instruments manuf

select * from naics_key where naics_code LIKE '339%' order by naics_code; --medical equip manuf

select * from naics_key where naics_code LIKE '339%' order by naics_code; --medical(surgical) equip manuf

select * from naics_key where naics_code LIKE '6215%' order by naics_code;  --medical/diagnostic labs

select * from naics_key where naics_code LIKE '5417%' order by naics_code; --scientific rsrch

--3 way join
select i.company_number, i.company_name, i.company_type, i.date_of_ipo, i.last_stock_date, (i.date_of_ipo - i.last_stock_date)/365 as diff, n.sic, n.naics 
from ipogeo_class n inner join gvc_cisikey g on g.gvc = n.gvc
inner join ipofate i on i.company_number = g.company_number where i.company_type = 'Biotech'; --14 missing

select i.company_number, n.gvc, i.company_name, i.ticker_symbol, i.company_type, i.date_of_ipo, i.last_stock_date, 
(i.date_of_ipo - i.last_stock_date)/365 as diff, n.naics, n.sic from ipogeo_class n inner join gvc_cisikey g on g.gvc = n.gvc
inner join ipofate i on i.company_number = g.company_number where i.company_type = 'Non Biotech'; --19 missing

select distinct (n.sic) 
from ipogeo_class n inner join gvc_cisikey g on g.gvc = n.gvc
inner join ipofate i on i.company_number = g.company_number where i.company_type = 'Non Biotech'; --check 2833-6, 382x-384x

select distinct (n.sic) 
from ipogeo_class n inner join gvc_cisikey g on g.gvc = n.gvc
inner join ipofate i on i.company_number = g.company_number where i.company_type = 'Biotech'; --check 3812 (Metabasis), 9995 (Bind) -- should both be 2834

select * from ipofate where company_name LIKE 'SIRF%'; --gvc got mixed up with Metabasis in gvc_cisikey, originally in IPOBiotechCompanies_JULY2017.xlsx; Others: Millennium 62784, Onyx should be 62826 (1996 co).

select * from gvc_cisikey where company_name LIKE 'SIRF%';
select * from gvc_cisikey where company_name LIKE 'Metabasis%';

update gvc_cisikey
set gvc = '158746' where company_number = 195;

select * from gvc_cisikey where company_name LIKE 'Bind%';
select * from gvc_naics where company_name LIKE 'BIND%';  --0 changed name to DBIN UNWIND

update gvc_naics
set naics = '325412' where gvc = '18535';

update ipogeo_class
set naics = '325412' where gvc = '18535';

update ipogeo_class
set sic = '2834' where gvc = '18535';

select table_schema, table_name, column_name from information_schema.columns where column_name LIKE '%gvc%';

select m.*, i.date_of_ipo, i.company_name from first_last_marketcap m full outer join ipofate i on m.company_number = i.company_number;

select count(*) from ipofate where extract (year from date_of_ipo) = 2016;  --51

select * from ipofate where company_type = 'Non Biotech' and fate_detail is null; --612 (Biotechs all have a fate)

--Immtech still active?

select * from daily_stock where ticker_symbol = 'IMMP' order by data_date_dividends desc; --2014 Compustat stops outputting stock prices after 01-15-2014, but is active

update ipofate
set fate_detail = 'other'
where company_number = '156.0';

alter table daily_stock_derived
add column market_cap_2017 float;

update daily_stock_derived
set market_cap_2017 = 
CASE
when year = 1997 then market_cap * 1.5272
when year = 1998 then market_cap * 1.5038
when year = 1999 then market_cap * 1.4713
when year = 2000 then market_cap * 1.4235
when year = 2001 then market_cap * 1.3841
when year = 2002 then market_cap * 1.3625
when year = 2003 then market_cap * 1.3322
when year = 2004 then market_cap * 1.2976
when year = 2005 then market_cap * 1.2551
when year = 2006 then market_cap * 1.2159
when year = 2007 then market_cap * 1.1822
when year = 2008 then market_cap * 1.1385
when year = 2009 then market_cap * 1.1426
when year = 2010 then market_cap * 1.1241
when year = 2011 then market_cap * 1.0897
when year = 2012 then market_cap * 1.0676
when year = 2013 then market_cap * 1.0522
when year = 2014 then market_cap * 1.0354
when year = 2015 then market_cap * 1.0342
when year = 2016 then market_cap * 1.0213
end;

select * from daily_stock_derived where market_cap_2017 is not null limit 10;

alter table daily_stock_derived
add column market_cap_2016 float;

update daily_stock_derived
set market_cap_2016 =
CASE
when year = 1997 then market_cap * 1.4954
when year = 1998 then market_cap * 1.4724
when year = 1999 then market_cap * 1.4406
when year = 2000 then market_cap * 1.3938
when year = 2001 then market_cap * 1.3552
when year = 2002 then market_cap * 1.3341
when year = 2003 then market_cap * 1.3044
when year = 2004 then market_cap * 1.2706
when year = 2005 then market_cap * 1.2289
when year = 2006 then market_cap * 1.1905
when year = 2007 then market_cap * 1.1575
when year = 2008 then market_cap * 1.1147
when year = 2009 then market_cap * 1.1187
when year = 2010 then market_cap * 1.1007
when year = 2011 then market_cap * 1.0670
when year = 2012 then market_cap * 1.0454
when year = 2013 then market_cap * 1.0303
when year = 2014 then market_cap * 1.0138
when year = 2015 then market_cap * 1.0126
when year = 2016 then market_cap
end;

alter table first_last_marketcap
add column first_marketcap2017 float;

update first_last_marketcap
set first_marketcap2017 =
CASE
when extract(year from first_date) = 1997 then first_marketcap * 1.5272
when extract(year from first_date) = 1998 then first_marketcap * 1.5038
when extract(year from first_date) = 1999 then first_marketcap * 1.4713
when extract(year from first_date) = 2000 then first_marketcap * 1.4235
when extract(year from first_date) = 2001 then first_marketcap * 1.3841
when extract(year from first_date) = 2002 then first_marketcap * 1.3625
when extract(year from first_date) = 2003 then first_marketcap * 1.3322
when extract(year from first_date) = 2004 then first_marketcap * 1.2976
when extract(year from first_date) = 2005 then first_marketcap * 1.2551
when extract(year from first_date) = 2006 then first_marketcap * 1.2159
when extract(year from first_date) = 2007 then first_marketcap * 1.1822
when extract(year from first_date) = 2008 then first_marketcap * 1.1385
when extract(year from first_date) = 2009 then first_marketcap * 1.1426
when extract(year from first_date) = 2010 then first_marketcap * 1.1241
when extract(year from first_date) = 2011 then first_marketcap * 1.0897
when extract(year from first_date) = 2012 then first_marketcap * 1.0676
when extract(year from first_date) = 2013 then first_marketcap * 1.0522
when extract(year from first_date) = 2014 then first_marketcap * 1.0354
when extract(year from first_date) = 2015 then first_marketcap * 1.0342
when extract(year from first_date) = 2016 then first_marketcap * 1.0213
end;


select * from first_last_marketcap where first_marketcap2017 is not null limit 10;

alter table first_last_marketcap
add column last_marketcap2017 float;

update first_last_marketcap
set last_marketcap2017 =
CASE
when extract(year from last_date) = 1997 then last_marketcap * 1.5272
when extract(year from last_date) = 1998 then last_marketcap * 1.5038
when extract(year from last_date) = 1999 then last_marketcap * 1.4713
when extract(year from last_date) = 2000 then last_marketcap * 1.4235
when extract(year from last_date) = 2001 then last_marketcap * 1.3841
when extract(year from last_date) = 2002 then last_marketcap * 1.3625
when extract(year from last_date) = 2003 then last_marketcap * 1.3322
when extract(year from last_date) = 2004 then last_marketcap * 1.2976
when extract(year from last_date) = 2005 then last_marketcap * 1.2551
when extract(year from last_date) = 2006 then last_marketcap * 1.2159
when extract(year from last_date) = 2007 then last_marketcap * 1.1822
when extract(year from last_date) = 2008 then last_marketcap * 1.1385
when extract(year from last_date) = 2009 then last_marketcap * 1.1426
when extract(year from last_date) = 2010 then last_marketcap * 1.1241
when extract(year from last_date) = 2011 then last_marketcap * 1.0897
when extract(year from last_date) = 2012 then last_marketcap * 1.0676
when extract(year from last_date) = 2013 then last_marketcap * 1.0522
when extract(year from last_date) = 2014 then last_marketcap * 1.0354
when extract(year from last_date) = 2015 then last_marketcap * 1.0342
when extract(year from last_date) = 2016 then last_marketcap * 1.0213
end;

alter table first_last_marketcap
add column last_marketcap2016 float;

alter table first_last_marketcap
add column first_marketcap2016 float;

update first_last_marketcap
set first_marketcap2016 =
CASE
when extract(year from first_date) = 1997 then first_marketcap * 1.4954
when extract(year from first_date) = 1998 then first_marketcap * 1.4724
when extract(year from first_date) = 1999 then first_marketcap * 1.4406
when extract(year from first_date) = 2000 then first_marketcap * 1.3938
when extract(year from first_date) = 2001 then first_marketcap * 1.3552
when extract(year from first_date) = 2002 then first_marketcap * 1.3341
when extract(year from first_date) = 2003 then first_marketcap * 1.3044
when extract(year from first_date) = 2004 then first_marketcap * 1.2706
when extract(year from first_date) = 2005 then first_marketcap * 1.2289
when extract(year from first_date) = 2006 then first_marketcap * 1.1905
when extract(year from first_date) = 2007 then first_marketcap * 1.1575
when extract(year from first_date) = 2008 then first_marketcap * 1.1147
when extract(year from first_date) = 2009 then first_marketcap * 1.1187
when extract(year from first_date) = 2010 then first_marketcap * 1.1007
when extract(year from first_date) = 2011 then first_marketcap * 1.0670
when extract(year from first_date) = 2012 then first_marketcap * 1.0454
when extract(year from first_date) = 2013 then first_marketcap * 1.0303
when extract(year from first_date) = 2014 then first_marketcap * 1.0138
when extract(year from first_date) = 2015 then first_marketcap * 1.0126
when extract(year from first_date) = 2016 then first_marketcap
end;

update first_last_marketcap
set last_marketcap2016 =
CASE
when extract(year from last_date) = 1997 then last_marketcap * 1.4954
when extract(year from last_date) = 1998 then last_marketcap * 1.4724
when extract(year from last_date) = 1999 then last_marketcap * 1.4406
when extract(year from last_date) = 2000 then last_marketcap * 1.3938
when extract(year from last_date) = 2001 then last_marketcap * 1.3552
when extract(year from last_date) = 2002 then last_marketcap * 1.3341
when extract(year from last_date) = 2003 then last_marketcap * 1.3044
when extract(year from last_date) = 2004 then last_marketcap * 1.2706
when extract(year from last_date) = 2005 then last_marketcap * 1.2289
when extract(year from last_date) = 2006 then last_marketcap * 1.1905
when extract(year from last_date) = 2007 then last_marketcap * 1.1575
when extract(year from last_date) = 2008 then last_marketcap * 1.1147
when extract(year from last_date) = 2009 then last_marketcap * 1.1187
when extract(year from last_date) = 2010 then last_marketcap * 1.1007
when extract(year from last_date) = 2011 then last_marketcap * 1.0670
when extract(year from last_date) = 2012 then last_marketcap * 1.0454
when extract(year from last_date) = 2013 then last_marketcap * 1.0303
when extract(year from last_date) = 2014 then last_marketcap * 1.0138
when extract(year from last_date) = 2015 then last_marketcap * 1.0126
when extract(year from last_date) = 2016 then last_marketcap
end;

alter table first_last_marketcap
add column first_stock2016 float;

update first_last_marketcap
set first_stock2016 =
CASE
when extract(year from first_date) = 1997 then first_stock * 1.4954
when extract(year from first_date) = 1998 then first_stock * 1.4724
when extract(year from first_date) = 1999 then first_stock * 1.4406
when extract(year from first_date) = 2000 then first_stock * 1.3938
when extract(year from first_date) = 2001 then first_stock * 1.3552
when extract(year from first_date) = 2002 then first_stock * 1.3341
when extract(year from first_date) = 2003 then first_stock * 1.3044
when extract(year from first_date) = 2004 then first_stock * 1.2706
when extract(year from first_date) = 2005 then first_stock * 1.2289
when extract(year from first_date) = 2006 then first_stock * 1.1905
when extract(year from first_date) = 2007 then first_stock * 1.1575
when extract(year from first_date) = 2008 then first_stock * 1.1147
when extract(year from first_date) = 2009 then first_stock * 1.1187
when extract(year from first_date) = 2010 then first_stock * 1.1007
when extract(year from first_date) = 2011 then first_stock * 1.0670
when extract(year from first_date) = 2012 then first_stock * 1.0454
when extract(year from first_date) = 2013 then first_stock * 1.0303
when extract(year from first_date) = 2014 then first_stock * 1.0138
when extract(year from first_date) = 2015 then first_stock * 1.0126
when extract(year from first_date) = 2016 then first_stock
end;


update first_last_marketcap 
set marketcapdiff_2016 = last_marketcap2016 - first_marketcap2016;

update first_last_marketcap 
set marketcapratio_2016 = last_marketcap2016/first_marketcap2016; 

select * from first_last_marketcap where extract(year from first_date) > 1996 and marketcapratio_2016 is null; --no nulls

select table_schema, table_name, column_name from information_schema.columns where column_name LIKE '%company_type%'; --9 ipo tables

--ipofate, ipovalwindow, notbillioncos, timeto1b

update ipofate
set company_type = 'Biotech'
where company_number = '246.1'; --Applied Genetic Tech.

update ipofate
set company_type = 'Biotech'
where company_number = '19.9'; --Versartis

update ipovalwindow
set company_type = 'Biotech'
where company_number = '246.1'; --Applied Genetic Tech.

update ipovalwindow
set company_type = 'Biotech'
where company_number = '19.9'; --Versartis

--07/18/2018
update ipofate
set company_type = 'Non Biotech'
where company_number = '12'; --Adeza

update ipofate
set company_type = 'Non Biotech'
where company_number = '32'; --Amyris

update ipofate
set company_type = 'Non Biotech'
where company_number = '9'; --Aclara

update ipofate
set company_type = 'Non Biotech'
where company_number = '79'; --Cepheid

update ipofate
set company_type = 'Non Biotech'
where company_number = '140'; --Genaissance

update ipovalwindow
set company_type = 'Non Biotech'
where company_number = '12'; --Adeza

update ipovalwindow
set company_type = 'Non Biotech'
where company_number = '32'; --Amyris

update ipovalwindow
set company_type = 'Non Biotech'
where company_number = '9'; --Aclara

update ipovalwindow
set company_type = 'Non Biotech'
where company_number = '79'; --Cepheid

update ipovalwindow
set company_type = 'Non Biotech'
where company_number = '140'; --Genaissance



--drop table biotechcontrolpairs;

create table biotechcontrolpairs (
pair_ID int,
company_number float,
company_name varchar(100),
company_type varchar(20),
date_of_ipo date,
primary key (pair_ID, company_type)
)

select table_schema, table_name, column_name from information_schema.columns where column_name LIKE '%last_stock_date%'; 

--company list now contains 325 biotechs
ALTER TABLE final_biotech_list
ALTER COLUMN company_number SET DATA TYPE float;

insert into final_biotech_list (company_number, company_name, ipo_date, ticker)
values ('246.1','Applied Genetic Technologies Corp','2014-03-27','AGTC');

insert into final_biotech_list (company_number, company_name, ipo_date, ticker)
values ('19.9','Versartis, Inc.','2014-03-21','VSAR');

select b.pair_id, i.* from ipofate i inner join biotechcontrolpairs b on b.company_number = i.company_number; --650

alter table first_last_marketcap 
add column marketcapdiff_2017 float;

alter table first_last_marketcap 
add column marketcapdiff_2016 float;

--update first_last_marketcap 
--set marketcapdiff_2017 = first_marketcap2017 - last_marketcap2017;

update first_last_marketcap 
set marketcapdiff_2017 = last_marketcap2017 - first_marketcap2017;
--updated June, 28 2018


update first_last_marketcap 
set marketcapdiff_2016 = last_marketcap2016 - first_marketcap2016;

alter table first_last_marketcap 
add column marketcapratio_2017 float;

alter table first_last_marketcap 
add column marketcapratio_2016 float;

update first_last_marketcap 
set marketcapratio_2017 =
case when last_marketcap2017 > 0 then last_marketcap2017/first_marketcap2017 --division by zero issue
else 0 end;

update first_last_marketcap 
set marketcapratio_2017 = last_marketcap2017/first_marketcap2017 ; --changed ratio to last vs first; no division by zero issue = STEP UP

update first_last_marketcap 
set marketcapratio_2016 = last_marketcap2016/first_marketcap2016; 

select * from daily_stock where company_number = '328.9' order by data_date_dividends desc;

select sum(last_marketcap2017) from first_last_marketcap f inner join biotechcontrolpairs b on b.company_number = f.company_number where company_type = 'Biotech'; --2.596175804721919E11

select sum(first_marketcap2017) from first_last_marketcap f inner join biotechcontrolpairs b on b.company_number = f.company_number where company_type = 'Biotech'; --2.596175804721919E11

select b.pair_id, b.company_number, b.company_name, b.company_type, f.* from first_last_marketcap f inner join biotechcontrolpairs b on b.company_number = f.company_number; 

select f.*,  b.first_date "first day traded", b.last_date as "last day traded", b.first_stock as "first stock price", b.last_stock as "last stock price" from first_last_marketcap b inner join gvc_cisikey f on b.company_number = f.company_number; 

select distinct (n.naics) 
from biotechcontrolpairs b inner join gvc_cisikey g on b.company_number = g.company_number
inner join naics_key n on 

select  g.* from gvc_naics g, naics_key n where cast(g.naics as varchar) = n.naics_code;

select  g.*, description from gvc_naics g, naics_key n where cast(g.naics as varchar) = n.naics_code;

select distinct(description) from gvc_naics g, naics_key n where substring(cast(g.naics as varchar),1,3) = n.naics_code;

select  distinct n.description, g.naics, count(*) from gvc_naics g, naics_key n where cast(g.naics as varchar) = n.naics_code group by n.description, g.naics order by count desc;

select * from ipofate where activity_status = 'active' and adj_ipo_window = '1'; --long-time survivors (1997)

select * from daily_stock where company_number = 2 order by data_date_dividends desc limit 100; --VERICAL not VERICEL (Aastrom) --1996 IPO??
delete from daily_stock where company_name = 'VERICAL CORP'; --(reuploaded)
--delete from daily_stock where company_number = 2; 

select * from daily_stock where company_number = 317.1 order by data_date_dividends limit 100; --Eroomsystem: 306.25 here, but less when I re-downloaded (reverse-split)
--delete from daily_stock where company_number = '317.1';  --(reuploaded)

select * from daily_stock where company_number = 37.9 order by data_date_dividends limit 100; --OK

select * from daily_stock where company_number = 208.9 order by data_date_dividends; --Centene: 2 different prices CNTE vs CNC == stock split in 2/20/2015

select * from daily_stock where company_number = 296.9 order by data_date_dividends;  --HELIX ENERGY SOLUTIONS GROUP INC. vs HELIX ENERGY SOLUTIONS GROUP (Bloomberg and latest WRDS say $20, not $5). 2 stock splits

select * from daily_stock where company_number = 303.1 order by data_date_dividends; --Identiv stock split
--delete from daily_stock where company_number = '303.1'; 
select * from daily_stock where ticker_symbol = 'INVE'; --(reuploaded, but missing 1st shares out)

select * from daily_stock where company_number = 39 order by data_date_dividends; --Antivirals/Sarepta: $39 here, but less when I re-downloaded (reverse-split)

--5/17/18 put back 317.1, 2, 303.1

create table first_stock (
company_number float primary key,
company_name varchar(100),
ticker varchar(20),
gvc int,
date_of_ipo date,
first_stock_price float,
shares_out float
);

--drop table first_stock;

alter table first_stock rename to ipo_pricing;

alter table ipo_pricing rename first_stock_price to ipo_price;

select f.gvc, f.company_name, m.company_number, m.first_stock, f.first_stock_price, (m.first_stock-f.first_stock_price) as diff  from first_last_marketcap m inner join first_stock f 
on f.company_number = m.company_number where f.first_stock_price <> m.first_stock and extract(year from f.date_of_ipo) > 1996 order by diff;


--update ipofate
--set first_price_close_daily = 1120 where company_number = 2.0; --last price was already listed correctly

alter table biotechcontrolpairs
add column ticker varchar(10);

update biotechcontrolpairs
set ticker = f.ticker_symbol
from ipofate f
where biotechcontrolpairs.company_number = f.company_number;


alter table biotechcontrolpairs
add column gvkey int;

update biotechcontrolpairs
set gvkey = f.gvc
from gvc_cisikey f
where biotechcontrolpairs.company_number = f.company_number;

--6-month calculation: use first price, not IPO date this time (UPDATE: IPO date is better)
--05/17/18

alter table first_last_stock
add column sixmonth_date date;

alter table  first_last_stock
add column sixmonth_price float;

update first_last_stock
set sixmonth_date =  first_time + interval '6 month';


--drop view sixmonthfromipo;

create view sixmonth_price as
select distinct on (i.company_number)
d.company_number, d.company_name, d.ticker_symbol, d.price_close_daily as closest_6mo_price, i.sixmonth_date, d.data_date_dividends from 
daily_stock_derived d inner join  first_last_stock i on i.company_number = d.company_number  
order by i.company_number, abs(d.data_date_dividends - i.sixmonth_date); --doesn't look correct for KURA

select d.*, i.sixmonth_date from daily_stock_derived d inner join  first_last_stock i on i.company_number = d.company_number where ticker_symbol = 'KURA' 
order by abs(d.data_date_dividends - i.sixmonth_date) limit 1; --check 

update first_last_stock 
set sixmonth_price = s.price_close_daily
from sixmonth_price s 
where first_last_stock.company_number = s.company_number;

--comparison to IPO (check lockout from Bloomberg):
select i.company_name, f.*, i.sixmonth_date as sixmo_fromIPO, i.date_of_ipo, i.sixmonth_date - f.sixmonth_date as diff from ipofate i inner join 
first_last_stock f on i.company_number = f.company_number order by diff; --8 are a potential problem

create view sixmonthfromIPO as
select distinct on (i.company_number)
d.company_number, d.company_name, d.ticker_symbol, i.date_of_ipo, i.sixmonth_date as sixmo_fromIPOdate, d.price_close_daily as sixmo_fromIPOprice, 
d.data_date_dividends from daily_stock_derived d inner join ipofate i on i.company_number = d.company_number  
order by i.company_number, abs(d.data_date_dividends - i.sixmonth_date); 

--KURA: 05/03/16 -- IPO date is closer (180 days from)
--INFO: 12/16/14 24.96

select * from daily_stock where ticker_symbol = 'INFO';

select * from sixmonthfromipo where ticker_symbol = 'KURA';

select * from sixmonthfromipo where ticker_symbol = 'INFO';

select * from ipovalwindow_v0 where company_number = '144.9';
--ticker = 'INFO';

select * from daily_stock where company_number = '144.9';

select * from ipofate where company_number = '66';

alter table ipofate
drop column sixmonth_price;

alter table ipofate
add column day180_date date;

alter table  ipofate
add column day180_price float;

update ipofate
set day180_date =  date_of_ipo + interval '180 days';

create view day180fromIPO_v0 as
select distinct on (i.company_number)
d.company_number, d.company_name, d.ticker_symbol, i.date_of_ipo, i.day180_date as day180_fromIPOdate, d.price_close_daily as day180_fromIPOprice, d.shares_outstanding as day180_fromIPOsharesout,
d.data_date_dividends from daily_stock_derived d inner join ipofate i on i.company_number = d.company_number  
order by i.company_number, abs(d.data_date_dividends - i.day180_date); --INFO seems incorrect ($115)

update ipofate
set day180_price = s.day180_fromipoprice
from day180fromIPO s 
where ipofate.company_number = s.company_number;

--new 11/12/18 for Liam
--If a company is active, but the time point is past 2017, take the 12-30-2016 price but set to null anything past 2017.
--If a company is inactive (acquired), take the last available price. However, if the price is more than 5 days after delisting, don�t use it.
--Yurie (#2.1) when public on 02-05-1997.
--Its last trading day is 05-29-1998
--It will have a 30 day, 90 day, 180 day and 1 year price.
--It will not have a 3 or 5 year price.

select company_name, date_of_ipo, first_price_close_daily,  date_of_ipo + interval '30 days' as day30fromipo, date_of_ipo + interval '90 days' as day90fromipo, date_of_ipo + interval '180 days' as day180fromipo, 
date_of_ipo + interval '1 year' as year1fromipo, date_of_ipo + interval '3 year' as year3fromipo, date_of_ipo + interval '5 year' as year5fromipo from ipofate_derived;

select b.pair_id, b.company_number, company_type, d.data_date_dividends, d.market_cap from biotechcontrolpairs b inner join daily_stock_derived d on b.company_number = d.company_number
 where b.company_type = 'Biotech' order by b.pair_id, d.data_date_dividends limit 10;

select count(b.*) from biotechcontrolpairs b inner join daily_stock_derived d on b.company_number = d.company_number where b.company_type = 'Non biotech'; --855,492

alter table ipofate_derived
add column last_shares float;

 update ipofate_derived
 set last_shares = f.last_shares
 from first_last_valuation f
 where ipofate_derived.company_number = f.company_number;

alter table ipofate_derived
add column week1fromIPO_date date;

alter table ipofate_derived
add column week1fromIPO_price float;

alter table ipofate_derived
add column week1fromIPO_sharesout float;

alter table ipofate_derived
add column day30_date date;

alter table ipofate_derived
add column day30_price float;

alter table ipofate_derived
add column day30_sharesout int;

alter table ipofate_derived
add column day90_date date;

alter table ipofate_derived
add column day90_price float;

alter table ipofate_derived
add column day90_sharesout int;

alter table ipofate_derived
add column day180_sharesout int;

alter table ipofate_derived
--rename day30_date to day30fromipo_date,
--rename day30_price to day30fromipo_price
--rename day30_sharesout to day30fromipo_sharesout
--rename day90_date to day90fromipo_date
--rename day90_price to day90fromipo_price
rename day90_sharesout to day90fromipo_sharesout;

alter table ipofate_derived
add column year1fromipo_date date;

alter table ipofate_derived
add column year1fromipo_price float;

alter table ipofate_derived
add column year1fromipo_sharesout int;

alter table ipofate_derived
add column year3fromipo_date date;

alter table ipofate_derived
add column year3fromipo_price float;

alter table ipofate_derived
add column year3fromipo_sharesout int;

alter table ipofate_derived
add column year5fromipo_date date;

alter table ipofate_derived
add column year5fromipo_price float;

alter table ipofate_derived
add column year5fromipo_sharesout int;

alter table ipofate_derived
add column founding_year int;

select day180_date, date_of_ipo + interval '180 days' from ipofate_derived; -- calculated from IPO

update ipofate_derived
set week1fromIPO_date = date_of_ipo + interval '1 week',
set day30fromipo_date = date_of_ipo + interval '30 days',
day90fromipo_date = date_of_ipo + interval '90 days',
year1fromipo_date = date_of_ipo + interval '1 year',
year3fromipo_date = date_of_ipo + interval '3 year',
set year5fromipo_date = date_of_ipo + interval '5 year';

select price_close_daily from daily_stock where company_number = 114 and data_date_dividends +  interval '30 days' ;

create view week1fromIPO as
select distinct on (i.company_number)
d.company_number, d.company_name, d.ticker_symbol, i.date_of_ipo, week1fromIPO_date, d.price_close_daily as week1fromIPO_price,  d.shares_outstanding as week1fromIPO_sharesout, 
d.data_date_dividends as actual_date_pulled, i.activity_status from daily_stock_derived d inner join ipofate_derived i on i.company_number = d.company_number  
order by i.company_number, abs(d.data_date_dividends - i.week1fromIPO_date);


create view day30fromIPO as
select distinct on (i.company_number)
d.company_number, d.company_name, d.ticker_symbol, i.date_of_ipo, day30fromipo_date, d.price_close_daily as day30fromipo_price,  d.shares_outstanding as day30fromipo_sharesout, 
d.data_date_dividends as actual_date_pulled, i.activity_status from daily_stock_derived d inner join ipofate_derived i on i.company_number = d.company_number  
order by i.company_number, abs(d.data_date_dividends - i.day30fromipo_date);

create view day30fromIPO as
select distinct on (i.company_number)
d.company_number, d.company_name, d.ticker_symbol, i.date_of_ipo, day30fromipo_date, d.price_close_daily as day30fromipo_price,  d.shares_outstanding as day30fromipo_sharesout, 
d.data_date_dividends as actual_date_pulled, i.activity_status from daily_stock_derived d inner join ipofate_derived i on i.company_number = d.company_number  
order by i.company_number, abs(d.data_date_dividends - i.day30fromipo_date);

select *, actual_date_pulled - day30fromIPO_date as datediff from day30fromIPO order by datediff;

update ipofate_derived
set founding_year = v.founding_year
from founding_years_allpairs v
where ipofate_derived.company_number = v.company_number;

update ipofate_derived
set week1fromIPO_price = v.week1fromIPO_price,
week1fromIPO_sharesout = v.week1fromIPO_sharesout
from week1fromIPO v
where ipofate_derived.company_number = v.company_number;

update ipofate_derived
set day30fromIPO_price = v.day30fromIPO_price,
day30fromIPO_sharesout = v.day30fromIPO_sharesout
from day30fromIPO v
where ipofate_derived.company_number = v.company_number;

create view day90fromIPO as
select distinct on (i.company_number)
d.company_number, d.company_name, d.ticker_symbol, i.date_of_ipo, day90fromipo_date, d.price_close_daily as day90fromipo_price,  d.shares_outstanding as day90fromipo_sharesout, 
d.data_date_dividends as actual_date_pulled, i.activity_status from daily_stock_derived d inner join ipofate_derived i on i.company_number = d.company_number  
order by i.company_number, abs(d.data_date_dividends - i.day90fromipo_date);

select *, actual_date_pulled - day90fromIPO_date as datediff from day90fromIPO order by datediff;

update ipofate_derived
set day90fromIPO_price = v.day90fromIPO_price,
day90fromIPO_sharesout = v.day90fromIPO_sharesout
from day90fromIPO v
where ipofate_derived.company_number = v.company_number
--and actual_date_pulled - v.day90fromipo_date >= -5;

create view day180fromIPO as
select distinct on (i.company_number)
d.company_number, d.company_name, d.ticker_symbol, i.date_of_ipo, day180_date as day180fromipo_date, d.price_close_daily as day180fromipo_price,  d.shares_outstanding as day180fromipo_sharesout, 
d.data_date_dividends as actual_date_pulled, i.activity_status from daily_stock_derived d inner join ipofate_derived i on i.company_number = d.company_number  
order by i.company_number, abs(d.data_date_dividends - i.day180_date);

select *, actual_date_pulled - day180fromipo_date as datediff from day180fromIPO order by datediff;

update ipofate_derived 
set --day180fromIPO_price = v.day180fromipo_price, --already have the price set from previous query day180_price
day180_sharesout = v.day180fromipo_sharesout
from day180fromIPO v
where ipofate_derived.company_number = v.company_number
--and actual_date_pulled - v.day180fromipo_date >= -2;

create view year1fromIPO as
select distinct on (i.company_number)
d.company_number, d.company_name, d.ticker_symbol, i.date_of_ipo, year1fromipo_date, d.price_close_daily as year1fromipo_price,  d.shares_outstanding as year1fromipo_sharesout, 
d.data_date_dividends as actual_date_pulled, i.activity_status from daily_stock_derived d inner join ipofate_derived i on i.company_number = d.company_number  
order by i.company_number, abs(d.data_date_dividends - i.year1fromipo_date);

select *, actual_date_pulled - year1fromipo_date as datediff from year1fromIPO order by datediff;

select *, actual_date_pulled - year1fromipo_date as datediff from year1fromIPO where  (actual_date_pulled - year1fromipo_date) < -5 and extract(year from year1fromIPO_date) < 2017; 

update ipofate_derived
set year1fromIPO_price = v.year1fromIPO_price,
year1fromIPO_sharesout = v.year1fromIPO_sharesout
from year1fromIPO v
where ipofate_derived.company_number = v.company_number
and extract(year from v.year1fromIPO_date) < 2017;
--and actual_date_pulled - v.year1fromipo_date >= -5;

create view year3fromIPO as
select distinct on (i.company_number)
d.company_number, d.company_name, d.ticker_symbol, i.date_of_ipo, year3fromipo_date, d.price_close_daily as year3fromipo_price,  d.shares_outstanding as year3fromipo_sharesout, 
d.data_date_dividends as actual_date_pulled, i.activity_status  from daily_stock_derived d inner join ipofate_derived i on i.company_number = d.company_number  
order by i.company_number, abs(d.data_date_dividends - i.year3fromipo_date);

select *, actual_date_pulled - year3fromipo_date as datediff from year3fromIPO order by datediff;

select *, actual_date_pulled - year3fromipo_date as datediff from year3fromIPO where  (actual_date_pulled - year3fromipo_date) < -5 and extract(year from year3fromIPO_date) < 2017; --all inactive, so we want to exclude

update ipofate_derived
set year3fromIPO_price = v.year3fromIPO_price,
year3fromIPO_sharesout = v.year3fromIPO_sharesout
from year3fromIPO v
where ipofate_derived.company_number = v.company_number
and extract(year from v.year3fromIPO_date) < 2017;
--and actual_date_pulled - v.year3fromipo_date >= -5;

alter table ipofate_derived
alter column year5fromIPO_sharesout type float
--alter column year3fromIPO_sharesout type float,
--alter column year1fromIPO_sharesout type float,
alter column day180_sharesout type float,
alter column day90fromIPO_sharesout type float,
alter column day30fromIPO_sharesout type float;

create view year5fromIPO as
select distinct on (i.company_number)
d.company_number, d.company_name, d.ticker_symbol, i.date_of_ipo, year5fromipo_date, d.price_close_daily as year5fromipo_price,  d.shares_outstanding as year5fromipo_sharesout, 
d.data_date_dividends as actual_date_pulled, i.activity_status from daily_stock_derived d inner join ipofate_derived i on i.company_number = d.company_number  
order by i.company_number, abs(d.data_date_dividends - i.year5fromipo_date);

select *, actual_date_pulled - year5fromipo_date as datediff from year5fromIPO order by datediff;

select *, actual_date_pulled - year5fromipo_date as datediff from year5fromIPO where actual_date_pulled - year5fromipo_date >= -5;

select *, actual_date_pulled - year5fromipo_date as datediff from year5fromIPO where  (actual_date_pulled - year5fromipo_date) < -5 and extract(year from year5fromIPO_date) < 2017; --all inactive, so we want to exclude

update ipofate_derived
set year5fromIPO_price = v.year5fromIPO_price,
year5fromIPO_sharesout = v.year5fromIPO_sharesout
from year5fromIPO v
where ipofate_derived.company_number = v.company_number
and actual_date_pulled - v.year5fromipo_date >= -5;

--newly updated
update ipofate_derived
set year5fromIPO_price = 
case when extract(year from v.year5fromIPO_date) < 2017 then v.year5fromIPO_price
else null end,
year5fromIPO_sharesout = 
case when extract(year from v.year5fromIPO_date) < 2017 then v.year5fromIPO_sharesout
else null end 
from year5fromIPO v
where ipofate_derived.company_number = v.company_number;

update ipofate_derived
set year3fromIPO_price = 
case when extract(year from v.year3fromIPO_date) < 2017 then v.year3fromIPO_price
else null end,
year3fromIPO_sharesout = 
case when extract(year from v.year3fromIPO_date) < 2017 then v.year3fromIPO_sharesout
else null end 
from year3fromIPO v
where ipofate_derived.company_number = v.company_number;

update ipofate_derived
set year1fromIPO_price = 
case when extract(year from v.year1fromIPO_date) < 2017 then v.year1fromIPO_price
else null end,
year1fromIPO_sharesout = 
case when extract(year from v.year1fromIPO_date) < 2017 then v.year1fromIPO_sharesout
else null end 
from year1fromIPO v
where ipofate_derived.company_number = v.company_number;

update ipofate_derived
set day180_sharesout = 
case when extract(year from v.day180fromipo_date) < 2017 then v.day180fromipo_sharesout
else null end 
from day180fromipo v
where ipofate_derived.company_number = v.company_number;

update ipofate_derived
set day90fromIPO_price = 
case when extract(year from v.day90fromipo_date) < 2017 then v.day90fromIPO_price
else null end,
day90fromIPO_sharesout = 
case when extract(year from v.day90fromipo_date) < 2017 then v.day90fromipo_sharesout
else null end 
from day90fromIPO v
where ipofate_derived.company_number = v.company_number;

alter table ipofate_derived
add column first_date date;

update ipofate_derived
set first_date = f.first_time
from first_last_stock f
where ipofate_derived.company_number = f.company_number;

alter table ipofate_derived
add column first_shares float;

update ipofate_derived
set first_shares = f.first_shares
from first_last_valuation f
where ipofate_derived.company_number = f.company_number;

select company_number, company_name, deletion_key, ticker_symbol, date_of_ipo, first_date, date_of_ipo - first_date as diff from ipofate_derived order by diff;

create view forLiam as
select b.*, i.founding_year, i.first_date, i.first_price_close_daily, i.first_shares, week1fromIPO_date, week1fromIPO_price, week1fromIPO_sharesout,
day30fromipo_date, day30fromipo_price, day30fromipo_sharesout, day90fromipo_date, day90fromipo_price, day90fromipo_sharesout, day180_date,
day180_price, day180_sharesout, year1fromipo_date, year1fromipo_price, year1fromipo_sharesout, year3fromipo_date, year3fromipo_price, year3fromipo_sharesout, year5fromipo_date, year5fromipo_price,
year5fromipo_sharesout, last_stock_date, last_price_close_daily, last_shares, (last_price_close_daily * last_shares) as last_marketcap
from ipofate_derived i inner join biotechcontrolpairs b on i.company_number = b.company_number; --CSV for LIAM export (BiotechControlPairs_timelinesForLiam_updated)

--modified 1/24/2019 to not filter on 5 days and just take the last price

select * from daily_stock where company_number = '37.9';

select * from daily_stock where company_number = '39' and shares_outstanding is not null; 

select * from daily_stock where company_number = '180.1'; --only 6 stock prices reported in 2005; very spotty (Evolve EVLVQ); spotty with ATG (ATGCQ/92.9) -5 year issue

select * from daily_stock where company_number = '152'; --Hyseq 180 day price is $24885

select * from daily_stock where company_number = '316.9'; 

select * from daily_stock where company_number = '89.9'; 

select * from daily_stock where company_name LIKE 'BOJ%'; 

update biotechcontrolpairs
set company_number = '91.9' where  company_number = '90.9';

update biotechcontrolpairs
set company_number = '91.9' where  company_number = '89.9';

update biotechcontrolpairs
set date_of_ipo = '2015-05-08' where  company_number = '91.9'; --fixed in BiotechControlPairs and ControlsPairing

select * from daily_stock where company_number = '144.9' order by data_date_dividends; 

select adj_ipo_window, avg(day180_price - first_price_close_daily) as diff from ipofate d group by adj_ipo_window;

create table ipofate_derived as
select * from ipofate;

alter table ipofate_derived
add column day180_first_price_diff float;

update ipofate_derived
set day180_first_price_diff = day180_price - first_price_close_daily;

alter table ipofate_derived
add column day180_first_price_change float;

update ipofate_derived
set day180_first_price_change = ((day180_price - first_price_close_daily)/first_price_close_daily)*100;

alter table ipofate_derived
add column day180_first_price_diff_direction varchar(10);

update ipofate_derived
set day180_first_price_diff_direction =
CASE 
when day180_first_price_diff > 0 THEN 'positive'
when day180_first_price_diff < 0 THEN 'negative'
ELSE 'no change' end;

select adj_ipo_window, day180_first_price_diff_direction, count(day180_first_price_diff_direction) from ipofate_derived d group by adj_ipo_window, day180_first_price_diff_direction order by adj_ipo_window;
--can separate by co type


alter table ipofate_derived
add column day180_first_price_change_direction varchar(10);

update ipofate_derived
set day180_first_price_change_direction =
CASE 
when day180_first_price_change > 0 THEN 'positive'
when day180_first_price_change < 0 THEN 'negative'
ELSE 'no change' end; --One(1) was delisted (combine no change and neg to get gains vs no gains?)

select * from ipofate_derived where day180_first_price_change_direction <> day180_first_price_diff_direction; --same

select d.company_type, day180_first_price_diff_direction, count(day180_first_price_diff_direction) from ipofate_derived d inner join biotechcontrolpairs b on b.company_number = d.company_number
group by d.company_type, day180_first_price_diff_direction; --biotech group has fewer negative and more positive outcomes than controls overall

select * from daily_stock where company_name LIKE 'ACLARA%'; 

select * from daily_stock where company_number = '195'; --missing from Jeremy's data gathering (Metabasis Therapeutics 195 and Moleculin 361.0 have the same ticker MBRX)

select * from daily_stock where company_number = '217'; --Omthera - IPO'ed and got acquired; Annual data available for 2011, 2012 in Compustat, but stock for partial 2013 only

select * from daily_stock where company_number = '181.9'; 

--where data was not found in Bloomberg, a different control was assigned (June 2018)
create table biotechcontrolpairs_v0 as
select * from biotechcontrolpairs; 

--truncate table biotechcontrolpairs;

----June 25, 2018 Took out medical device companies (these can now be controls -- TO DO):

delete from final_biotech_list where company_number = '12'; --Adeza/ADZA

delete from final_biotech_list where company_number = '9'; --Aclara/ACLA

delete from final_biotech_list where company_number = '32'; --Amyris/AMRS

delete from final_biotech_list where company_number = '79'; --Cepheid/CPHD

delete from final_biotech_list where company_number = '140'; --Genaissance/GNSC

delete from final_biotech_list where company_number = '308'; --UniQure

--total is 319

select * from biotechcontrolpairs b inner join ipofate i on i.company_number = b.company_number where ipo_window = 5;

select distinct (stock_exchange_code), count(distinct company_number) from daily_stock group by stock_exchange_code; --1, 11, 13, 14, 19, 20 (http://finabase.blogspot.com/2014/09/interantional-stock-exchange-codes-for.html)

select distinct (stock_exchange_code), count(distinct b.company_number), company_type from daily_stock d inner join biotechcontrolpairs b on d.company_number = b.company_number group by stock_exchange_code, company_type; 

select company_name from daily_stock where stock_exchange_code = 1; --URIGEN  

select distinct company_number, company_name from daily_stock where stock_exchange_code = 1; --Urigen/Megabios

select distinct company_number, company_name from daily_stock where stock_exchange_code = 13; --16 Cos

select distinct company_number, company_name from daily_stock where stock_exchange_code = 19; --99 Cos

select distinct company_number, company_name from daily_stock where stock_exchange_code = 20; --Exodus 

select distinct (issue_id_dividends) from daily_stock group by issue_id_dividends;

create table daily_stock_indices as
select * from daily_stock
with no data;

--Assigned ^NBI company number 0.1

\copy ipo.alldailystocks from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT - Public Biotech/Project with Anne Schnader/Raw Data/NonCompustat/Composite_Indices.csv' with csv header delimiter ',';

alter table ipofate_derived
add column ipo_price float;

update ipofate_derived
set ipo_price = p.ipo_price
from ipo_pricing p
where ipofate_derived.company_number = p.company_number;

create view post_ipo_price_BCpairs as
select b.pair_id, p.* from biotechcontrolpairs b inner join ipofate_derived p on b.company_number = p.company_number; --updated from final

select adj_ipo_window, count (*) from post_ipo_price_BCpairs group by adj_ipo_window;

select * from ipo_products.dummy_variable_indl_only where company_legal_name LIKE 'Urigen%';

create view post_ipo_price_BCpairs as
select b.pair_id, p.* from biotechcontrolpairs b inner join ipofate_derived p on b.company_number = p.company_number;

alter table biotechcontrolpairs
add column adj_ipo_window int;

update biotechcontrolpairs
set adj_ipo_window = p.adj_ipo_window
from ipofate p
where biotechcontrolpairs.company_number = p.company_number;

create view longterm_mktcap_BCpairs as
select b.pair_id, b.company_name, b.ticker, b.company_type, b.date_of_ipo, b.adj_ipo_window as ipo_window, p.* from biotechcontrolpairs b inner join first_last_marketcap p on b.company_number = p.company_number
order by b.pair_id, b.company_type; --updated from final

--drop view longterm_mktcap_BCpairs;

select count(i.company_number), endstock_higherthan1dollar, i.company_type from ipofate i, longterm_mktcap_BCpairs f where i.company_number = f.company_number and deletion_reason = 1 
group by i.company_type, endstock_higherthan1dollar;

81	1	Biotech
77	1	Non Biotech
13	0	Biotech
7	0	Non Biotech

--p value = 0.34 https://www.graphpad.com/quickcalcs/contingency2/

--drop table ipo_financials;

create table ipo_financials (
Company_name	varchar(100),
company_number float,
Company_pair	int,
Bloomberg_ticker	varchar(100),
datasource	int,
IPO_year	int,
Offer_price2016	float,
Offer_price	float,
Shares_before_offering	float,
Shares_offered	float,
Shares_outstanding_after_offering	float,
Calculated_ahares_after_offering	float, 
Offer_size2016	float, 
Offer_size	float, 
Cash_raised	int, 
Mkt_Cap_before_offering_premoney	float, 
Mkt_Cap_at_offer_2016	float,
Calculated_Mkt_cap_at_offer	int, 
Mkt_Cap_At_Offer 	float, 
Capital_percent	float, 
Option2_capital_percent	float, 
Shares_exercised	int,
Company_type	varchar(20)
)

select * from biotechcontrolpairs b inner join ipo_financials i on b.company_name = i.company_name; --643


select * from biotechcontrolpairs b full outer join ipo_financials i on b.company_name = i.company_name; --643

--select b.* from biotechcontrolpairs b left join ipo_financials i on b.pair_id = i.Company_pair; --1194


update ipo_financials
 set company_pair = f.pair_id
 from biotechcontrolpairs f
 where ipo_financials.company_number = f.company_number;

create table alldailystocks as
select * from daily_stock; --daily stock plus indices

drop view biotechcontrolpairsindices;

create table biotechcontrolpairsindices as
select * from biotechcontrolpairs;


insert into biotechcontrolpairsindices
values ('0', '0.1', 'NASDAQ Biotechnology Index', 'NBI Index', '1997-01-01', '^NBI', '1');

insert into biotechcontrolpairsindices
values ('0', '0.2', 'S&P 500 INFORMATION TECHNOLOGY INDEX', 'S5INFT Index', '1997-01-01', 'S5INFT', '1');

insert into biotechcontrolpairsindices
values ('0', '0.3', 'CBOE Volatility Index', 'Volatility Index', '1997-01-01', 'VIX', '1');

insert into biotechcontrolpairsindices
values ('0', '0.4', 'Dow Jones U.S. Retail Index', 'DOW J Retail Index', '1997-01-01', 'DJUSRT', '1');

insert into biotechcontrolpairsindices
values ('0', '0.5', 'Nasdaq Inc', 'Nasdaq Index', '2002-07-01', 'NDAQ', '1');

--delete from biotechcontrolpairsindices where ticker = 'NDAQ';

delete from biotechcontrolpairs where pair_id = 0;


select distinct company_number, company_name, ticker_symbol from daily_stock_indices order by company_number;

select table_schema, table_name, column_name from information_schema.columns where column_name LIKE '%naics%';

create table biotechcontrolpairs_v1 as
select * from biotechcontrolpairs;

--7/18/2018
--truncate table biotechcontrolpairs; --upload a new version from BiotechControlPairs_new.csv
\copy ipo.biotechcontrolpairs from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT - Public Biotech/Project with Anne Schnader/Analyses/Paired comparisons/BiotechControlPairs_new.csv' with csv header delimiter ',';

--drop view daily_stock_pairs;

create view daily_stock_pairs as
select d.*, b.company_type, b.pair_id from daily_stock d inner join biotechcontrolpairs b on d.company_number = b.company_number;

select distinct company_number, pair_id from daily_stock_pairs;

--clean up
--drop table biotechcontrolpairs_v0;
--drop table ipo_survival_962
--drop table ipofate_v0 -- does not work b/c of dependencies
drop table alldailystocks;
drop table daily_stock_indices;
drop table ipo_survival_analysis;
drop table ipofate_v0;
drop table ipovalwindow_v0;
drop view ipo_fate_old;
drop table ipo_financials;

create table bloomberg_financials (
Company_name	varchar(100),
company_number float,
Company_pair	int,
Company_type	varchar(20),
Company_type_dummy int,
Bloomberg_ticker	varchar(100),
datasource	int,
datasource_key text,
IPO_year	int,
Offer_price2016	float,
Offer_price	float,
Shares_before_offering	float,
Shares_offered	float,
Shares_outstanding_after_offering	float,
Calculated_shares_after_offering	float, 
Offer_size2016	float, 
Offer_size	float, 
Cash_raised	int, 
premoney_2016 float, --NEW
Mkt_Cap_before_offering_premoney	float, 
Mkt_Cap_at_offer_2016	float,
Calculated_Mkt_cap_at_offer	int, 
Mkt_Cap_At_Offer 	float, 
Capital_percent	float, 
Option2_capital_percent	float, 
Shares_exercised float
)
--\copy from IPO Bloomberg for database.csv (created from Liam/WORKING SPREADSHEET 10-18)
--Cash raised at IPO = Offer size (inflation adjusted, 2016)
--Private Investment = Private capital raised prior to IPO (existing shareholder, inflation adjusted 2016)


 update bloomberg_financials 
 set company_type = f.company_type
 from biotechcontrolpairs f
 where bloomberg_financials.company_number = f.company_number;

select * from bloomberg_financials where company_type = 'Biotech' and company_type_dummy <> '1';

select * from bloomberg_financials where company_type = 'Non biotech' and company_type_dummy <> '2';

select * from daily_stock where company_number = '101.1';

select b.pair_id, f.company_name, f.company_number, b.company_name, f.company_number from bloomberg_financials f full outer join biotechcontrolpairs b on b.company_number = f.company_number where f.company_number is null or b.company_number is null;

update bloomberg_financials 
set company_number = '101.1' where company_number = '101.9'; --Five9

delete from bloomberg_financials where company_number = '166.9';  --China Electric

delete from bloomberg_financials where bloomberg_ticker = 'NXPI US Equity';  --deleted NXP
--Mainspring is a duplicate, replace with Rita

update bloomberg_financials 
set company_type_dummy = 1 where company_type = 'Biotech';
  
update bloomberg_financials 
set company_type_dummy = 2 where company_type = 'Non biotech';
 
select company_name, ticker_symbol, fate, fate_detail, activity_status, company_type from ipofate where deletion_reason = 3; --liquidation

Biopure Corp.	BPURQ	desister	bankrupt	inactive	Biotech
Large Scale Biology Corp.	LSBC	desister	bankrupt	inactive	Biotech
Maxygen Inc.	MAXY	desister	bankrupt	inactive	Biotech
3-Dimensional Pharmaceuticals Inc.	DDDP	desister	acquired	inactive	Biotech

select company_name, ticker_symbol, fate, fate_detail, activity_status, company_type from ipofate where fate_detail = 'bankrupt';
 
ARYx Therapeutics Inc.	ARYX	persister	bankrupt	active	Biotech
Biopure Corp.	BPURQ	desister	bankrupt	inactive	Biotech
Dendreon Corp.	DNDNQ	desister	bankrupt	inactive	Biotech
Large Scale Biology Corp.	LSBC	desister	bankrupt	inactive	Biotech
Maxygen Inc.	MAXY	desister	bankrupt	inactive	Biotech

-- Dendreon listed as bankrupt in Laura's file, but other in Compustat; DDDP is acquired in Laura's, but liquidation according to Compustat

select b.pair_id, i.*, b.adj_ipo_window from biotechcontrolpairs b inner join ipofate i on i.company_number = b.company_number;

--check
select * from ipofate where activity_status = 'active'; --ARTD/ArtistDirect Inc should not be active as last stock was in 2015

select * from ipofate where activity_status = 'inactive'; --change active status for ASMB/315 - still trading under new name Assembly Biosciences in all ipofate files (correct in ipogeo_class)

select * from daily_stock where company_number = 165.1;

--7/30/2018
update ipofate
set activity_status = 'active' where company_number = 315; --ASBM

update ipofate
set fate = 'persister' where company_number = 315;

update ipofate
set deletion_reason = 0 where company_number = 315;

update ipofate_derived
set activity_status = 'active' where company_number = 315; --ASBM

update ipofate_derived
set fate = 'persister' where company_number = 315;

update ipofate_derived
set deletion_reason = 0 where company_number = 315;

select * from ipogeo_class i inner join biotechcontrolpairs b on i.ticker = b.ticker; --597
select * from ipogeo_class i inner join biotechcontrolpairs b on i.company_name = upper(b.company_name); --148

select * from daily_stock where company_number = 4;

--post_ipo_price_bcpairs is missing first stock date

select distinct(description) from gvc_naics g, naics_key n where substring(cast(g.naics as varchar),1,3) = n.naics_code; --58 industries

select distinct(description) from gvc_naics g, naics_key n where substring(cast(g.naics as varchar),1,2) = n.naics_code; --15 industries

--outcomes 07/31
select b.pair_id, i.*, b.adj_ipo_window from biotechcontrolpairs b inner join ipofate i on i.company_number = b.company_number where deletion_reason = 1; --180/638 (28.2%) acquired

select b.pair_id, i.*, b.adj_ipo_window from biotechcontrolpairs b inner join ipofate i on i.company_number = b.company_number where deletion_reason = 1 and b.company_type = 'Biotech'; --93 (14.58%)

select b.pair_id, i.*, b.adj_ipo_window from biotechcontrolpairs b inner join ipofate i on i.company_number = b.company_number where deletion_reason = 1 and b.company_type = 'Non biotech'; --87 (13.64%)

select b.pair_id, i.*, b.adj_ipo_window from biotechcontrolpairs b inner join ipofate i on i.company_number = b.company_number where deletion_reason = 0; --414 active 

select b.pair_id, i.*, b.adj_ipo_window from biotechcontrolpairs b inner join ipofate i on i.company_number = b.company_number where deletion_reason = 0 and b.company_type = 'Biotech'; --209 (32.76%)

select b.pair_id, i.*, b.adj_ipo_window from biotechcontrolpairs b inner join ipofate i on i.company_number = b.company_number where deletion_reason = 0 and b.company_type = 'Non biotech'; --205 (32.13%)

select b.pair_id, i.*, b.adj_ipo_window from biotechcontrolpairs b inner join ipofate i on i.company_number = b.company_number where deletion_reason = 3; --8 (4 B/4 NB)

select b.pair_id, i.*, b.adj_ipo_window from biotechcontrolpairs b inner join ipofate i on i.company_number = b.company_number where deletion_reason = 3 or  deletion_reason = 2; --11 (4 B/ 7 NB)

--select  b.company_number, i.stock_exchange_code from biotechcontrolpairs b left join daily_stock i on i.company_number = b.company_number where i.company_number is null;

select * from longterm_mktcap_bcpairs i inner join ipofate b on i.company_number = b.company_number where deletion_reason = 1; --180

select l.*, p.day180_fromipodate, p.day180_fromipoprice, p.day180_fromiposharesout from longterm_mktcap_bcpairs l inner join day180fromipo p on l.company_number = p.company_number order by pair_id; --for Liam; 180 day shares spotty for some

select * from daily_stock where company_number = 253;

select * from ipofate i inner join biotechcontrolpairs b on i.company_number = b.company_number where extract(year from b.date_of_ipo) = 2009;

select * from biotechcontrolpairs b where extract(year from b.date_of_ipo) = 2009;

select * from ipofate b where extract(year from b.date_of_ipo) = 2009;

select activity_status, count(*) from ipofate i inner join biotechcontrolpairs b on i.company_number = b.company_number group by activity_status;

select b.adj_ipo_window, count(*) from ipofate i inner join biotechcontrolpairs b on i.company_number = b.company_number where activity_status = 'active' group by b.adj_ipo_window;

alter table ipofate_derived 
add column deletion_key varchar(200);

update ipofate_derived
set deletion_key = reason
from deletion_key d
where ipofate_derived.deletion_reason = d.code;

create table compustat_financials as
select * from ipo_products.dummy_variable_indl_only;

alter table compustat_financials
add primary key (global_company_key, data_date); 

select * from compustat_financials
where global_company_key = '66673'; --some companies have more than 1 filing in a year

select count(distinct global_company_key) from compustat_financials; --964

alter table compustat_financials
add column company_number float(8); --already exists as original_company_id

update compustat_financials
set company_number = g.company_number
from gvc_cisikey g
where compustat_financials.global_company_key = g.gvc;

--alter table compustat_financials
--drop column company_number;

select distinct company_legal_name, company_number, global_company_key from compustat_financials where company_number is null; --38

select b.company_number, b.pair_id, b.company_name, c.company_legal_name, c.ticker_symbol, c.global_company_key from compustat_financials c left join biotechcontrolpairs b 
on c.company_number = b.company_number where c.company_number is null; 

select b.company_number, b.pair_id, b.company_name, c.company_legal_name, c.ticker_symbol, c.global_company_key from compustat_financials c right join biotechcontrolpairs b 
on c.company_number = b.company_number where c.company_number is null; 

select * from gvc_cisikey where gvc = '21209'; --VBLT

select * from compustat_financials where ticker_symbol = 'PIH'; --259.1 in compustat_financials; gvc = 19528

select b.*, c.company_legal_name, c.ticker_symbol, c.global_company_key from compustat_financials c inner join biotechcontrolpairs b 
on c.company_number = b.company_number;

select * from post_ipo_price_bcpairs where last_price_close_daily < 1 order by company_type, company_name;

select count(*), company_type from post_ipo_price_bcpairs where last_price_close_daily < 1 group by company_type;

select p.*, l.last_stock from post_ipo_price_bcpairs p, longterm_mktcap_bcpairs l where p.company_number = l.company_number and p.pair_id = l.pair_id and l.last_stock <> p.last_price_close_daily;  
--4 do not match (last stock price vs last stock with share = last_stock)

176.9	ATLPA	ATL Products Inc
253.0	RNA	Ribapharm Inc.
318.1	SEAB	Seabright Holdings, Inc.
1.0	DDDP	3-Dimensional Pharmaceuticals Inc.

select * from daily_stock where company_number = 1 order by data_date_dividends desc;

select * from compustat_financials order by company_legal_name limit 1000;

select * from compustat_financials where original_company_id != company_number; --does not work

select * from compustat_financials where global_company_key = '158746'; --Metabasis missing from Jeremy's data (#195, gvc = 158746)

select * from compustat_financials where ticker_symbol = 'ANGO';

select count(*) from compustat_financials where company_number is null; --342
select count(*) from compustat_financials where original_company_id is null; --342

select * from longterm_mktcap_bcpairs where last_stock <= 1 and company_type = 'Non biotech'; -- --82 (42 biotech/42 non)

select * from biotechcontrolpairs b inner join ipofate_derived l on b.company_number = l.company_number where last_price_close_daily <= 1 and b.company_type = 'Non biotech'; -- --84 

select * from longterm_mktcap_bcpairs b full outer join ipofate_derived l on b.company_number = l.company_number where last_price_close_daily != last_stock;

select * from biotechcontrolpairs b inner join longterm_mktcap_bcpairs l on b.company_number = l.company_number where last_stock <= 2 and b.company_type = 'Non biotech'; -- 130 (71 biotech/59 non)

select * from longterm_mktcap_bcpairs where last_stock <= 1 --82
select * from biotechcontrolpairs b inner join longterm_mktcap_bcpairs l on b.company_number = l.company_number where last_stock <= 1; --84

select b.pair_id, c.original_company_id, c.company_legal_name, c.ticker_symbol, sum(dividends_total_inflation_adj_2016) as dividends_adj2016_sum, sum(market_value_total_fiscal_inflation_adj_2016) 
as total_market_value_adj2016_sum, sum(purchase_of_common_and_preferred_stock_inflation_adj_2016) as sum_purchase_of_common_and_preferred_stock_adj2016
from compustat_financials c inner join biotechcontrolpairs b on c.original_company_id = b.company_number group by c.original_company_id, b.pair_id, company_legal_name, c.ticker_symbol; 
--637 No Metabasis - redo with last year, not sum


select b.pair_id, c.original_company_id, c.company_legal_name, c.ticker_symbol, sum(dividends_total_inflation_adj_2016) as dividends_adj2016_sum, sum(market_value_total_fiscal_inflation_adj_2016) 
as total_market_value_adj2016_sum, sum(purchase_of_common_and_preferred_stock_inflation_adj_2016) as sum_purchase_of_common_and_preferred_stock_adj2016
from compustat_financials c inner join biotechcontrolpairs b on c.original_company_id = b.company_number group by c.original_company_id, b.pair_id, company_legal_name, c.ticker_symbol; 
--637 No Metabasis - TODO: redo with last year, not sum

--08/31/18
--\copy ipo_products.dummy_variable_pre_cleaning from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT - Public Biotech/Holden Working Files/metabasis.csv' csv header delimiter ',';

select * from dummy_variable_pre_cleaning where global_company_key = '158746';

select * from dummy_variable_indl_only where global_company_key = '158746'; --TO fill infl adj in for Metabasis and copy to IPO schema

--delete from dummy_variable_indl_only where global_company_key = '158746' and data_year < 2004;


select * from dummy_variable_indl_only where data_year <> data_year_fisical; --fiscal year vs annual report year

select * from dummy_variable_indl_only where company_legal_name LIKE 'Secure%';
select * from dummy_variable_indl_only where original_company_id = '6300';

alter table dummy_variable_indl_only
rename data_year_fisical to data_year_fiscal;

alter table dummy_variable_pre_cleaning
rename data_year_fisical to data_year_fiscal;

alter table compustat_financials
rename data_year_fisical to data_year_fiscal;

alter table compustat_financials
drop company_number;

insert into compustat_financials
select * from ipo_products.dummy_variable_indl_only where original_company_id = '195';

select * from compustat_financials where original_company_id = '0.9'; --1 year of data

SELECT DISTINCT
       original_company_id as company_number
      ,company_legal_name as company_name
      ,global_company_key as gvc
      ,ticker_symbol as ticker
      ,first_value(data_date) OVER w AS first_data_date
      ,first_value(data_year_fiscal) OVER w AS first_data_year_fiscal
      ,first_value(price_close_annual_fiscal) OVER w AS first_stock_fiscal
      ,first_value(common_shares_outstanding) OVER w AS first_shares_fiscal
      ,first_value(price_close_annual_fiscal_inflation_adj_2016 * common_shares_outstanding_inflation_adj_2016) OVER w AS first_valuation_fiscal_infladj2016
      ,first_value(dividends_total_inflation_adj_2016) OVER w AS first_dividends_infladj2016
      ,first_value(purchase_of_common_and_preferred_stock_inflation_adj_2016) OVER w AS first_purchase_stock_infladj2016
      ,first_value(sale_of_common_and_preferred_stock_inflation_adj_2016) OVER w AS first_sale_stock_infladj2016
      ,first_value(revenue_total_inflation_adj_2016) OVER w AS first_revenue_infladj2016
      ,last_value(data_date) OVER w AS last_data_date
      ,last_value(data_year_fiscal) OVER w AS last_data_year_fiscal
      ,last_value(price_close_annual_fiscal) OVER w AS last_stock_fiscal
      ,last_value(common_shares_outstanding) OVER w AS last_shares_fiscal
      ,last_value(price_close_annual_fiscal_inflation_adj_2016 * common_shares_outstanding_inflation_adj_2016) OVER w AS last_valuation_fiscal_infladj2016
      ,last_value(dividends_total_inflation_adj_2016) OVER w AS last_dividends_infladj2016
      ,last_value(purchase_of_common_and_preferred_stock_inflation_adj_2016) OVER w AS last_purchase_stock_infladj2016
      ,last_value(sale_of_common_and_preferred_stock_inflation_adj_2016) OVER w AS last_sale_stock_infladj2016
      ,last_value(revenue_total_inflation_adj_2016) OVER w AS last_revenue_infladj2016
FROM   compustat_financials --where shares_outstanding is not null
WINDOW w AS (PARTITION BY original_company_id ORDER BY data_date
             ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
ORDER  BY 1; --935 improved version below

--drop table first_last_compustat_financials

select * from compustat_financials where original_company_id = '146.1';

select * from first_last_compustat_financials where first_valuation_fiscal_infladj2016 is null; --4

select * from first_last_compustat_financials where last_valuation_fiscal_infladj2016 is null; --6

alter table first_last_marketcap
add column first_last_stockprice_change_perc float;

update first_last_marketcap
set first_last_stockprice_change_perc = (last_stock - first_stock)/first_stock * 100;

alter table first_last_marketcap
add column company_name varchar(100);

 update first_last_marketcap
 set company_name = f.company_name
 from daily_stock f
 where first_last_marketcap.company_number = f.company_number;

create table founding_years (
pair_ID int,
company_number float,
company_name varchar(100),
company_type varchar(20),
date_of_ipo date,
ticker varchar(10),
adj_ipo_window int,
gvc int,
founding_year int,
primary key (pair_ID, company_number)
);

 update founding_years
 set founding_year = i.year_founded
 from ipo_products.company_list i
 where founding_years.company_number = i.original_company_id and founding_years.company_type = 'Biotech';

--checking Laura's and Liam's founding years

create table founding_years_all (
pair_ID int,
company_number float,
company_name varchar(100),
company_type varchar(20),
date_of_ipo date,
ticker varchar(10),
adj_ipo_window int,
gvc int,
founding_year int,
primary key (pair_ID, company_number)
);

select * from founding_years_all a inner join founding_years f on a.company_number = f.company_number and a.pair_id = f.pair_id where a.founding_year = f.founding_year and f.company_type = 'Non biotech'; --316 matches

select a.* from founding_years_all a left join founding_years f on a.company_number = f.company_number and a.pair_id = f.pair_id where a.founding_year <> f.founding_year and f.company_type = 'Non biotech';

select * from founding_years_all a inner join founding_years f on a.company_number = f.company_number and a.pair_id = f.pair_id where a.founding_year = f.founding_year and f.company_type = 'Biotech'; --231 match
--Lexicon wrong in Liam's version

select a.company_number, a.company_name, a.date_of_ipo, a.founding_year as founding_year_Liam, f.founding_year as foundingyear_laura, (a.founding_year - f.founding_year) as diff, a.company_type from founding_years_all a 
inner join founding_years f  on a.company_number = f.company_number and a.pair_id = f.pair_id where a.founding_year <> f.founding_year and f.company_type = 'Biotech' order by diff; --87 don't match

update founding_years_all
--set founding_year = 1995 where company_number = 182;
--set founding_year = 2002 where company_number = 366.9;
set founding_year = 1980 where company_number = 39;

alter table founding_years
rename to founding_years_Laura;

alter table founding_years_all
rename to founding_years_allpairs;

select *, extract(year from date_of_ipo) - founding_year as age_of_company from founding_years_allpairs;

select company_type, avg(extract(year from date_of_ipo) - founding_year) as age_of_company from founding_years_allpairs group by company_type;

alter table biotechcontrolpairs
drop constraint biotechcontrolpairs_pkey;

alter table biotechcontrolpairs
add primary key (company_number, pair_id);

select b.*, f.gvc from biotechcontrolpairs b inner join first_last_compustat_financials f on b.company_number = f.company_number; --638

select * from bloomberg_financials b inner join ipo_products.company_list i on 
b.company_number = i.original_company_id where offer_size = i.ext_shares_num and company_type = 'Biotech'; --0

select * from bloomberg_financials b inner join ipo_products.company_list i on 
b.company_number = i.original_company_id where offer_size = i.amount_raised and company_type = 'Biotech'; 

select b.*, i.ext_amt_raised_prior_to_ipo from bloomberg_financials b inner join ipo_products.company_list i on 
b.company_number = i.original_company_id where offer_size = i.ext_amt_raised_prior_to_ipo and company_type = 'Biotech'; --1 exact match (Eagle)

select b.company_number, offer_size, i.ext_amt_raised_prior_to_ipo, (offer_size - i.ext_amt_raised_prior_to_ipo) as diff from 
bloomberg_financials b inner join ipo_products.company_list i on b.company_number = i.original_company_id where company_type = 'Biotech';

select  ext_amt_raised_prior_to_ipo, amount_raised from ipo_products.company_list limit 10;

select b.company_number, offer_size, i.ext_amt_raised_prior_to_ipo, amount_raised from 
bloomberg_financials b inner join ipo_products.company_list i on b.company_number = i.original_company_id where company_type = 'Biotech';

create table venture_money (
pair_id	int,
company_number	float,
company_type	varchar(20),
date_of_ipo	date,
IPO_year 	int,
company_name	varchar(100),
number_shares_purchased	float,
percent_shares_purchased float,
amount_shares_purchased	float,
amount_shares_purchased_infladj2016 	float,
percent_total_consideration	float,
average_price_per_share	float,
primary key (pair_id, company_number)
);

--09/11/2018
\copy ipo.venture_money from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT - Public Biotech/Liam/VM Controls for database.csv' with csv header delimiter ',';

select b.company_number, b.company_name, b.amount_shares_purchased, i.ext_amt_raised_prior_to_ipo, 
(b.amount_shares_purchased - i.ext_amt_raised_prior_to_ipo) as diff from venture_money b inner join ipo_products.company_list i on 
b.company_number = i.original_company_id where company_type = 'Biotech' order by diff desc; --2 missing (253, 322) one inconsistent (#40 Applied Molecular Evolution Inc.)
--amount of shares offered = private money
--to do: check Applied Molecular Evolution Inc.; find Xbiotech

select b.company_number, offer_size, amount_raised, (offer_size - amount_raised) as diff from bloomberg_financials b inner join 
ipo_products.company_list i on b.company_number = i.original_company_id where company_type = 'Biotech' order by diff desc;

alter table bloomberg_financials
rename calculated_ahares_after_offering to calculated_shares_after_offering;

create view first_last_compustat_financials as
SELECT DISTINCT
       original_company_id as company_number
      ,pair_id
      ,company_legal_name as company_name
      ,global_company_key as gvc
      ,ticker_symbol as ticker
      ,first_value(data_date) OVER w AS first_data_date
      ,first_value(data_year_fiscal) OVER w AS first_data_year_fiscal
      ,first_value(price_close_annual_fiscal_inflation_adj_2016) OVER w AS first_stock_fiscal_infladj2016
      ,first_value(common_shares_outstanding_inflation_adj_2016) OVER w AS first_shares_fiscal_infladj_2016
      ,first_value(price_close_annual_fiscal_inflation_adj_2016 * common_shares_outstanding_inflation_adj_2016) OVER w AS first_valuation_fiscal_infladj2016
      ,first_value(dividends_total_inflation_adj_2016) OVER w AS first_dividends_infladj2016
      ,first_value(purchase_of_common_and_preferred_stock_inflation_adj_2016) OVER w AS first_purchase_stock_infladj2016
      ,first_value(sale_of_common_and_preferred_stock_inflation_adj_2016) OVER w AS first_sale_stock_infladj2016
      ,first_value(revenue_total_inflation_adj_2016) OVER w AS first_revenue_infladj2016
      ,last_value(data_date) OVER w AS last_data_date
      ,last_value(data_year_fiscal) OVER w AS last_data_year_fiscal
      ,last_value(price_close_annual_fiscal_inflation_adj_2016) OVER w AS last_stock_fiscal_infladj2016
      ,last_value(common_shares_outstanding_inflation_adj_2016) OVER w AS last_shares_fiscal_infladj2016
      ,last_value(price_close_annual_fiscal_inflation_adj_2016 * common_shares_outstanding_inflation_adj_2016) OVER w AS last_valuation_fiscal_infladj2016
      ,last_value(dividends_total_inflation_adj_2016) OVER w AS last_dividends_infladj2016
      ,last_value(purchase_of_common_and_preferred_stock_inflation_adj_2016) OVER w AS last_purchase_stock_infladj2016
      ,last_value(sale_of_common_and_preferred_stock_inflation_adj_2016) OVER w AS last_sale_stock_infladj2016
      ,last_value(revenue_total_inflation_adj_2016) OVER w AS last_revenue_infladj2016
FROM   compustat_financials c inner join biotechcontrolpairs b on c.original_company_id = b.company_number
WINDOW w AS (PARTITION BY original_company_id ORDER BY data_date
             ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
ORDER  BY 1; --638


alter table bloomberg_financials
rename cash_raised to private_money_2016;
--cash raised = offer_size
--private money = amount shares purchased

 update bloomberg_financials
 set private_money_2016 = i.amount_shares_purchased_infladj2016
 from venture_money i
 where bloomberg_financials.company_number = i.company_number;

ALTER TABLE bloomberg_financials
    ALTER COLUMN private_money_2016 TYPE float;
    
select company_name, company_number, first_stock_fiscal_infladj2016, round((last_valuation_fiscal_infladj2016 + last_dividends_infladj2016 + last_purchase_stock_infladj2016)/last_shares_fiscal_infladj2016,2) 
as End_shareholder_value, last_purchase_stock_infladj2016 from first_last_compustat_financials where company_number = '120.9'; 
--value created/destroyed - matches Tableau --if purchase is missing, will be set to null - Symbion
--rename table to value_creation

select company_name, company_number, first_stock_fiscal_infladj2016, round((last_valuation_fiscal_infladj2016 + last_dividends_infladj2016 + coalesce(last_purchase_stock_infladj2016,0))/last_shares_fiscal_infladj2016,2)
as End_shareholder_value, last_purchase_stock_infladj2016 from first_last_compustat_financials where company_number = '120.9'; 
--value created/destroyed - matches Tableau; coalesce function treats nulls as zero

--TODO: change nulls to zero in sale & purchase of stock, dividends
--change last dividends and stock buybacks to sum

 create table value_creation as
 SELECT DISTINCT
       original_company_id as company_number
      ,pair_id
      ,company_legal_name as company_name
      ,global_company_key as gvc
      ,ticker_symbol as ticker
      ,first_value(data_date) OVER w AS first_data_date
      ,first_value(data_year_fiscal) OVER w AS first_data_year_fiscal
      ,first_value(price_close_annual_fiscal_inflation_adj_2016) OVER w AS first_stock_fiscal_infladj2016
      ,first_value(common_shares_outstanding_inflation_adj_2016) OVER w AS first_shares_fiscal_infladj_2016
      ,first_value(price_close_annual_fiscal_inflation_adj_2016 * common_shares_outstanding_inflation_adj_2016) OVER w AS first_valuation_fiscal_infladj2016
      ,last_value(data_date) OVER w AS last_data_date
      ,last_value(data_year_fiscal) OVER w AS last_data_year_fiscal
      ,last_value(price_close_annual_fiscal_inflation_adj_2016) OVER w AS last_stock_fiscal_infladj2016
      ,last_value(common_shares_outstanding_inflation_adj_2016) OVER w AS last_shares_fiscal_infladj2016
      ,last_value(price_close_annual_fiscal_inflation_adj_2016 * common_shares_outstanding_inflation_adj_2016) OVER w AS last_valuation_fiscal_infladj2016
FROM   compustat_financials c inner join biotechcontrolpairs b on c.original_company_id = b.company_number  group by original_company_id, pair_id, company_legal_name, global_company_key, ticker_symbol, data_date
WINDOW w AS (PARTITION BY original_company_id ORDER BY data_date
             ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
ORDER  BY 1; --has to be daily stock prices, not fiscal

--drop view value_creation;

select dividends_total_inflation_adj_2016 from compustat_financials where original_company_id = 209; --51.394

--change nulls to zero in sale & purchase of stock, dividends:
update compustat_financials
set dividends_total_inflation_adj_2016 = 0 where dividends_total_inflation_adj_2016 is null;

update compustat_financials
set sale_of_common_and_preferred_stock_inflation_adj_2016 = 0 where sale_of_common_and_preferred_stock_inflation_adj_2016 is null;

update compustat_financials
set purchase_of_common_and_preferred_stock_inflation_adj_2016 = 0 where purchase_of_common_and_preferred_stock_inflation_adj_2016 is null;

create view sum_dividends_sale_purchase_stock as
select original_company_id, company_legal_name, sum(dividends_total_inflation_adj_2016) as cumul_dividends_infladj2016, 
sum(purchase_of_common_and_preferred_stock_inflation_adj_2016)
as cumul_purchase_stock_infladj2016, sum(sale_of_common_and_preferred_stock_inflation_adj_2016) as 
cumul_sale_stock_infladj2016 from compustat_financials group by original_company_id, company_legal_name;


--drop view sum_dividends_sale_purchase_stock;

alter table value_creation
add column cumul_dividends_infladj2016 float;

alter table value_creation
add column cumul_purchase_stock_infladj2016 float;

alter table value_creation
add column cumul_sale_stock_infladj2016 float;

alter table value_creation
drop column ebitda_infladj2016 float;

update value_creation
 set cumul_dividends_infladj2016 = i.cumul_dividends_infladj2016 * 1000000
 from sum_dividends_sale_purchase_stock i
 where value_creation.company_number = i.original_company_id;
 
update value_creation
 set cumul_purchase_stock_infladj2016 = i.cumul_purchase_stock_infladj2016 * 1000000
 from sum_dividends_sale_purchase_stock i
 where value_creation.company_number = i.original_company_id;

update value_creation
 set cumul_sale_stock_infladj2016 = i.cumul_sale_stock_infladj2016 * 1000000
 from sum_dividends_sale_purchase_stock i
 where value_creation.company_number = i.original_company_id;
 
select company_name, company_number, first_stock_fiscal_infladj2016, (last_valuation_fiscal_infladj2016 + cumul_dividends_infladj2016 + 
cumul_purchase_stock_infladj2016)/last_shares_fiscal_infladj2016 as End_shareholder_value, last_valuation_fiscal_infladj2016 from value_creation 
where company_number = '262.1'; 
--change data type to float for last val

--alter table value_creation
--alter column End_shareholder_value type float;

alter table value_creation
add column end_shareholder_value_2016 float;

alter table value_creation
add column private_money_2016 float;

alter table value_creation
add column cash_raised_2016 float;

--cash raised = offer_size
--private money = amount shares purchased

 update bloomberg_financials
 set private_money_2016 = i.amount_shares_purchased_infladj2016
 from venture_money i
 where bloomberg_financials.company_number = i.company_number;

select company_name, year_founded from ipo_products.company_list;

select first_valuation_fiscal_infladj2016, first_marketcap2016 from first_last_compustat_financials f inner join first_last_marketcap m on f.company_number = m.company_number where 
first_valuation_fiscal_infladj2016 <> first_marketcap2016; --634

select first_date as daily_date, first_data_date as first_fiscal_date, first_stock_fiscal_infladj2016, first_stock from first_last_compustat_financials f inner join first_last_marketcap m 
on f.company_number = m.company_number where first_stock_fiscal_infladj2016 <> first_stock;

select last_date as daily_date, last_data_date as last_fiscal_date, last_stock_fiscal_infladj2016, last_stock from first_last_compustat_financials f inner join first_last_marketcap m 
on f.company_number = m.company_number where last_stock_fiscal_infladj2016 <> last_stock;

--create table endshareholder_value as
--select f.company_number, f.pair_id, f.first_stock, f.first_stock, f.first_shares, f.first_marketcap, f.first_marketcap2016, f.marketcapratio_2016, f.first_stock, f.last_stock, f.last_shares, f.last_marketcap, 
--f.last_marketcap2016 from first_last_marketcap f inner join biotechcontrolpairs b on f.company_number = b.company_number;

alter table value_creation
add column IPO_stock_price2016 float;


select table_schema, table_name, column_name from information_schema.columns where column_name LIKE 'first_stock%'; 

 update value_creation
 set IPO_stock_price2016 = round(i.offer_price2016::numeric,2)
 from bloomberg_financials i
 where value_creation.company_number = i.company_number;

--IPO_stock_price2016 is offer_price2016 from bloomberg_financials rounded to 2 digits

 alter table value_creation
add column end_shareholder_value_2016 float;

alter table value_creation
add column private_money_2016 float;

alter table value_creation
add column cash_raised_2016 float;

alter table value_creation
alter column last_valuation_fiscal_infladj2016 type float;

alter table value_creation
alter column last_shares_fiscal_infladj2016 type float;


update value_creation
set end_shareholder_value_2016 = (last_valuation_fiscal_infladj2016 + cumul_dividends_infladj2016 + cumul_purchase_stock_infladj2016)/last_shares_fiscal_infladj2016;
--REDO -done below 

update value_creation
set end_shareholder_value_2016 = (last_marketcap2016 + cumul_dividends_infladj2016 + cumul_purchase_stock_infladj2016)/last_shares2016;
--REDO x millions --done
--REDO / shares (below)

--7/18/19 change
alter table value_creation
rename end_shareholder_value_2016 to end_shareholder_value_pershare_2016;

update value_creation
set end_shareholder_value_2016 = (last_marketcap2016 + cumul_dividends_xmillions_infladj2016 + cumul_purchase_stock_xmillions_infladj2016);

alter table value_creation
rename cumul_dividends_infladj2016 to cumul_dividends_xmillions_infladj2016;

alter table value_creation
rename cumul_purchase_stock_infladj2016 to cumul_purchase_stock_xmillions_infladj2016;

alter table value_creation
rename cumul_sale_stock_infladj2016 to cumul_sale_stock_xmillions_infladj2016;

update value_creation
set end_shareholder_value_2016 = (last_marketcap2016 + cumul_dividends_xmillions_infladj2016 + cumul_purchase_stock_xmillions_infladj2016)/last_shares2016;

update value_creation
set end_shareholder_value_2016 = round(end_shareholder_value_2016::numeric,3)

select * from value_creation where end_shareholder_value_2016 = 0; --6 last_marketcap2016 = last_shares2016


select * from value_creation where end_shareholder_value_2016 = 0; 

 update value_creation
 set private_money_2016 = i.amount_shares_purchased_infladj2016
 from venture_money i
 where value_creation.company_number = i.company_number;

 update value_creation
 set cash_raised_2016 = i.offer_size2016
 from bloomberg_financials i
 where value_creation.company_number = i.company_number;

--add last market cap & shares (infl adj)

alter table value_creation
add column last_marketcap2016 float;

 update value_creation
 set last_marketcap2016 = i.last_marketcap2016
 from first_last_marketcap i
 where value_creation.company_number = i.company_number;
 
 alter table value_creation
add column last_shares float;

 update value_creation
 set last_shares = i.last_shares
 from first_last_marketcap i
 where value_creation.company_number = i.company_number;
 
 --TO DO -inflation adjust shares --done
 
  alter table value_creation
add column last_shares2016 float;

  alter table value_creation
add column last_stock_date date;

 update value_creation
 set last_stock_date = i.last_date
 from first_last_marketcap i
 where value_creation.company_number = i.company_number;

update value_creation
set last_shares2016 =
CASE
when extract(year from last_stock_date) = 1997 then last_shares * 1.4954
when extract(year from last_stock_date) = 1998 then last_shares * 1.4724
when extract(year from last_stock_date) = 1999 then last_shares * 1.4406
when extract(year from last_stock_date) = 2000 then last_shares * 1.3938
when extract(year from last_stock_date) = 2001 then last_shares * 1.3552
when extract(year from last_stock_date) = 2002 then last_shares * 1.3341
when extract(year from last_stock_date) = 2003 then last_shares * 1.3044
when extract(year from last_stock_date) = 2004 then last_shares * 1.2706
when extract(year from last_stock_date) = 2005 then last_shares * 1.2289
when extract(year from last_stock_date) = 2006 then last_shares * 1.1905
when extract(year from last_stock_date) = 2007 then last_shares * 1.1575
when extract(year from last_stock_date) = 2008 then last_shares * 1.1147
when extract(year from last_stock_date) = 2009 then last_shares * 1.1187
when extract(year from last_stock_date) = 2010 then last_shares * 1.1007
when extract(year from last_stock_date) = 2011 then last_shares * 1.0670
when extract(year from last_stock_date) = 2012 then last_shares * 1.0454
when extract(year from last_stock_date) = 2013 then last_shares * 1.0303
when extract(year from last_stock_date) = 2014 then last_shares * 1.0138
when extract(year from last_stock_date) = 2015 then last_shares * 1.0126
when extract(year from last_stock_date) = 2016 then last_shares
end;

 alter table value_creation
add column first_marketcap2016 float;
 
 update value_creation
 set first_marketcap2016 = i.first_marketcap2016
 from first_last_marketcap i
 where value_creation.company_number = i.company_number;
 
 
alter table value_creation
add column last_stock float;

 update value_creation
 set last_stock = i.last_stock
 from first_last_marketcap i
 where value_creation.company_number = i.company_number;
 
 
 --update bloomberg_financials
 --set private_money_2016 = 0 where company_number = 316.1 or company_number = 338.1;
  
 update bloomberg_financials
 set private_money_2016 = null where company_number = 316.1 or company_number = 338.1;
 
 select count(*) from biotechcontrolpairs b inner join first_last_marketcap f on b.company_number = f.company_number where marketcapratio_2016 < 1 and company_type = 'Biotech'; --172 (vs 147 > 1)
 
 select count(*) from biotechcontrolpairs b inner join first_last_marketcap f on b.company_number = f.company_number where marketcapratio_2016 < 1 and company_type = 'Non biotech'; --175

--Explore time to (3 consecutive years of) positive constant earnings (EBITA or net income); 

select company_legal_name, data_year, earning_before_interest_inflation_adj_2016 from compustat_financials;

select distinct(original_company_id) from compustat_financials; --927

select distinct(original_company_id) from compustat_financials where earning_before_interest_inflation_adj_2016 < 0; --665

--create view timeto_first_positive_earnings as

select distinct on (d.original_company_id) 
d.original_company_id, d.company_legal_name, d.data_year, d.earning_before_interest_inflation_adj_2016, b.date_of_ipo, 
(data_year - extract(year from b.date_of_ipo)) as time_passed, company_type from compustat_financials d inner join biotechcontrolpairs b 
on b.company_number = d.original_company_id where earning_before_interest_inflation_adj_2016 > 0 and company_type = 'Non biotech'
group by d.original_company_id, d.company_legal_name, d.data_year, d.earning_before_interest_inflation_adj_2016, b.date_of_ipo, company_type
order by d.original_company_id, d.company_legal_name, company_type, d.data_year; --225
--and company_type = 'Biotech' (66)

select distinct on (d.original_company_id) 
d.original_company_id, d.company_legal_name, d.data_year, d.earning_before_interest_inflation_adj_2016, b.date_of_ipo, 
(data_year - extract(year from b.date_of_ipo)) as time_passed, company_type from compustat_financials d inner join biotechcontrolpairs b 
on b.company_number = d.original_company_id --where earning_before_interest_inflation_adj_2016 < 0
group by d.original_company_id, d.company_legal_name, d.data_year, d.earning_before_interest_inflation_adj_2016, b.date_of_ipo, company_type
order by d.original_company_id, d.company_legal_name, d.data_year, company_type; --460

select company_legal_name, data_year, earning_before_interest_inflation_adj_2016 from compustat_financials where original_company_id = 1.1 order by data_year; 

select b.pair_id, d.original_company_id, d.company_legal_name, d.data_year, d.earning_before_interest_inflation_adj_2016, net_income_or_loss_inflation_adj_2016, 
b.date_of_ipo, (data_year - extract(year from b.date_of_ipo)) as time_passed, company_type from compustat_financials d inner join 
biotechcontrolpairs b on b.company_number = d.original_company_id order by original_company_id, pair_id, data_year;

--select count (distinct pmid) from nih_grants.drugpmids where drug_id = 'drug96';

[Offer Size2016]+[Private Money 2016]+[cumul_sale_stock_xmillions_infladj2016]-[cumul_dividends_xmillions_infladj2016]-[cumul_purchase_stock_xmillions_infladj2016]

alter table value_creation
add column cash_inputs float;

update value_creation
set cash_inputs = cash_raised_2016 + coalesce(private_money_2016,0) + cumul_sale_stock_xmillions_infladj2016 - 
cumul_dividends_xmillions_infladj2016 - cumul_purchase_stock_xmillions_infladj2016; --3 private $ is null

update value_creation
set cash_inputs = round(cash_inputs::numeric,3)

alter table value_creation
rename cash_inputs to net_capital_raised; 

select * from value_creation where last_marketcap2016 > cash_inputs; --312

select * from value_creation where last_marketcap2016 < cash_inputs; --326

select * from value_creation v inner join biotechcontrolpairs b on b.company_number = v.company_number and b.pair_id = v.pair_id
 where last_marketcap2016 < cash_inputs and b.company_type = 'Biotech'; --191
 
select * from value_creation v inner join biotechcontrolpairs b on b.company_number = v.company_number and b.pair_id = v.pair_id
 where last_marketcap2016 > cash_inputs and b.company_type = 'Biotech'; --128
  
select * from value_creation v inner join biotechcontrolpairs b on b.company_number = v.company_number and b.pair_id = v.pair_id
 where last_marketcap2016 < cash_inputs and b.company_type = 'Non biotech'; --135 vs 132+3
 
select * from value_creation v inner join biotechcontrolpairs b on b.company_number = v.company_number and b.pair_id = v.pair_id
 where last_marketcap2016 > cash_inputs and b.company_type = 'Non biotech'; --184 vs 169+13
 
select * from ipofate where ipo_window = 1 and company_type = 'Biotech' and activity_status = 'active';
 
select * from compustat_financials where company_legal_name LIKE 'Caesars%';

create view actively_trading_pairs2016 as
select b.pair_id, v.* from compustat_financials v inner join biotechcontrolpairs b on b.company_number = v.original_company_id 
where data_year = 2016 --and company_type = 'Biotech' order by pair_id;
--399

--more biotechs reporting financials than controls after 2000

--check fate

--drop view actively_trading_pairs2016;

select a.pair_id, i.company_number, i.deletion_reason from actively_trading_pairs2016 a inner join ipofate i on 
i.company_number = a.original_company_id;

select b.pair_id, v.* from ipofate v inner join biotechcontrolpairs b on b.company_number = v.company_number;

--Add fate to value creation

alter table value_creation 
add column deletion_reason_code int;

alter table value_creation 
add column deletion_reason text;

update value_creation
set deletion_reason_code = d.deletion_reason
from ipofate d
where value_creation.company_number = d.company_number;

update value_creation
set deletion_reason = d.reason
from deletion_key d
where value_creation.deletion_reason_code = d.code;

create view compustat_financials_pairs as
select b.pair_id, b.company_type,  b.date_of_ipo, c.* from compustat_financials c inner join biotechcontrolpairs b on c.original_company_id = b.company_number;

select * from biotechcontrolpairs where company_number not in (
select original_company_id from compustat_financials_pairs);

--drop view compustat_financials_pairs;

alter table value_creation 
add column company_type varchar(20);

 update value_creation
 set company_type = f.company_type
 from biotechcontrolpairs f
 where value_creation.company_number = f.company_number;
 
 select table_schema, table_name, column_name from information_schema.columns where column_name LIKE 'first_shares';
 
 --TODO: inflation adjust first_last_stock
 
select b.pair_id, b.company_number, b.company_type, d.data_date_dividends, d.price_close_daily from biotechcontrolpairs b inner join daily_stock_derived d on b.company_number = d.company_number 
and company_type = 'Non biotech' order by company_number, data_date_dividends;

select * from naics_key where naics_code LIKE '3254%';

select * from ipogeo_class  where naics = '325412';

select distinct(naics) from ipogeo_class  where sic = '2836';

select distinct(naics) from ipogeo_class  where sic = '2834';

select * from naics_key where naics_code LIKE '9999%';

select company_type, data_year, count(*),
percentile_cont(0.25) within group (order by net_income_or_loss_inflation_adj_2016) as perc25_netincome_2016,
percentile_cont(0.5) within group (order by net_income_or_loss_inflation_adj_2016) as median_netincome_2016,
 percentile_cont(0.75) within group (order by net_income_or_loss_inflation_adj_2016) as perc75_netincome_2016,
 percentile_cont(0.25) within group (order by research_and_development_inprogress_expense_inflation_adj_2016) as perc25_rndiprd_2016,
percentile_cont(0.5) within group (order by research_and_development_inprogress_expense_inflation_adj_2016) as median_rndiprd_2016,
 percentile_cont(0.75) within group (order by research_and_development_inprogress_expense_inflation_adj_2016) as perc75_rndiprd_2016,
 percentile_cont(0.25) within group (order by gross_profit_or_loss_inflation_adj_2016) as perc25_grossprofit_2016,
percentile_cont(0.5) within group (order by gross_profit_or_loss_inflation_adj_2016) as median_grossprofit_2016,
 percentile_cont(0.75) within group (order by gross_profit_or_loss_inflation_adj_2016) as perc75_grossprofit_2016
from ipo.compustat_financials_pairs group by company_type, data_year;
--R&D should be research_and_development_expense_inflation_adj_2016 + in_progress_research_and_development_expense_inflation_adj_2016 -- Sunyi 12/14/18*/

alter table ipo.compustat_financials
add column Research_and_Development_expense_and_in_progress_RD_expense_inflation_adj_2016 numeric(10,3);

update ipo.compustat_financials
set Research_and_Development_expense_and_in_progress_RD_expense_inflation_adj_2016 = 
research_and_development_expense_inflation_adj_2016+in_progress_research_and_development_expense_inflation_adj_2016; --redone below

alter table compustat_financials
rename Research_and_Development_expense_and_in_progress_RD_expense_inflation_adj_2016 to research_and_development_inprogress_expense_infl_adj_2016_nulls;

--For Fred:
select pair_id, original_company_id, company_type, data_year, purchase_of_common_and_preferred_stock_inflation_adj_2016, dividends_total_inflation_adj_2016, 
sale_of_common_and_preferred_stock_inflation_adj_2016, extract (year from date_of_ipo) as ipo_year, data_year - extract (year from date_of_ipo) as years_since_IPO
from compustat_financials_pairs;

select count (distinct original_company_id) from compustat_financials_pairs; --606 (some companies reused!)
select count (distinct original_company_id) from compustat_financials; --927
select count (distinct global_company_key) from compustat_financials_pairs; --606
select distinct pair_id from compustat_financials_pairs;
select * from compustat_financials where ticker_symbol = 'TMPL';
select * from compustat_financials_pairs where original_company_id = '104.1';
select distinct pair_id, company_type from compustat_financials_pairs order by pair_id;
select distinct pair_id, original_company_id from compustat_financials_pairs order by pair_id;
select count (distinct pair_id) from compustat_financials_pairs;

select * from compustat_financials_pairs where data_year = 1997 and company_type = 'Biotech' order by data_year; --nulls because in progress R&D is null - redone below

select original_company_id, data_year, company_type, research_and_development_expense_inflation_adj_2016, in_progress_research_and_development_expense_inflation_adj_2016, 
research_and_development_inprogress_expense_inflation_adj_2016 from compustat_financials_pairs where research_and_development_inprogress_expense_inflation_adj_2016 is null order by data_year; --665

update ipo.compustat_financials
set research_and_development_inprogress_expense_inflation_adj_2016 = 
coalesce(research_and_development_expense_inflation_adj_2016,0) + coalesce(in_progress_research_and_development_expense_inflation_adj_2016,0);

alter table compustat_financials
drop column Research_and_Development_expense_and_in_progress_RD_expense_inflation_adj_2016;


select company_type, (percentile_cont(0.5) within group (order by research_and_development_inprogress_expense_inflation_adj_2016)) * 1000000 as median_rnd_millions2016, 
(percentile_cont(0.5) within group (order by net_income_or_loss_inflation_adj_2016)) * 1000000 as median_netincome_millions2016,
(percentile_cont(0.5) within group (order by gross_profit_or_loss_inflation_adj_2016)) * 1000000 as median_grossprofit_millions2016 from compustat_financials_pairs group by company_type;

select company_type, data_year, (percentile_cont(0.5) within group (order by research_and_development_inprogress_expense_inflation_adj_2016)) as median_rnd_millions2016_zn, 
(percentile_cont(0.5) within group (order by Research_and_Development_expense_and_in_progress_RD_expense_inflation_adj_2016)) as median_rnd_millions2016
from compustat_financials c inner join biotechcontrolpairs b on c.original_company_id = b.company_number group by company_type, data_year; --very different when adding nulls

select company_legal_name, in_progress_research_and_development_expense_inflation_adj_2016, research_and_development_expense_inflation_adj_2016,
research_and_development_inprogress_expense_inflation_adj_2016 from compustat_financials_pairs where data_year = 2000 and company_type = 'Biotech' order by data_year;

select company_legal_name, in_progress_research_and_development_expense, research_and_development_expense
from compustat_financials_pairs where data_year = 2000 and company_type = 'Biotech' order by data_year;

select company_type, avg(extract(year from date_of_ipo) - founding_year) as age_of_company from founding_years_allpairs group by company_type; --7.66 vs 14.80

select company_type, extract(year from date_of_ipo) - founding_year as age_of_company from founding_years_allpairs where company_type = 'Biotech';

select company_type, (percentile_cont(0.5) within group (order by extract(year from date_of_ipo) - founding_year)) as age_of_company from founding_years_allpairs group by company_type; --7 vs 9

select t.company_name, activity_status, deletion_key, t.company_type from timeto1b t inner join ipofate_derived i on i.company_number = t.company_number; 

select activity_status, count(*) from timeto1b t inner join ipofate_derived i on i.company_number = t.company_number group by activity_status; --123 inactive/220 active

--drop view billiondollarpairs
create view billiondollarpairs as
select distinct on (d.company_number)
d.company_number, i.pair_id, d.ticker_symbol, d.company_name, d.data_date_dividends as billion_reached_date, d.market_cap as valuation, i.date_of_ipo,
 d.data_date_dividends-i.date_of_ipo as daystoreach1B, i.adj_ipo_window, i.company_type
from daily_stock_derived d inner join biotechcontrolpairs i on d.company_number = i.company_number
where d.market_cap_2016 > 1000000000 and extract(year from i.date_of_ipo) >= 1997 
group by d.company_number, i.pair_id, d.ticker_symbol, d.company_name, d.data_date_dividends, d.market_cap, i.date_of_ipo,
 daystoreach1B, i.adj_ipo_window, i.company_type order by d.company_number, d.ticker_symbol, d.data_date_dividends; --263
--changed market_cap > 1000000000 (243) to market_cap_2016 > 1000000000 (263)
 
select count(*), company_type from billiondollarpairs group by company_type;
 
select activity_status, t.company_type, count(*) from billiondollarpairs t inner join ipofate_derived i on i.company_number = t.company_number group by activity_status, t.company_type;
select t.company_type, count(*), avg(daystoreach1b) from billiondollarpairs t inner join ipofate_derived i on i.company_number = t.company_number group by t.company_type;


select activity_status, t.company_type, count(*) from billiondollarpairs t inner join ipofate_derived i on i.company_number = t.company_number group by activity_status, t.company_type;
select t.company_type, count(*), avg(daystoreach1b) from billiondollarpairs t inner join ipofate_derived i on i.company_number = t.company_number group by t.company_type; --123 Biotechs/120 Controls

select company_type, (percentile_cont(0.5) within group (order by cash_raised_2016)), count(company_number) from value_creation group by company_type;

select v.company_type, (percentile_cont(0.5) within group (order by cash_raised_2016)) as median_cash_raised, (percentile_cont(0.5) within group (order by private_money_2016)) as private_money_raised
 from value_creation v inner join biotechcontrolpairs b on v.company_number = b.company_number where (extract(year from date_of_ipo) = 2014) group by v.company_type;
 
select v.company_type, extract(year from date_of_ipo) as ipo_year, (percentile_cont(0.5) within group (order by cash_raised_2016)) as median_cash_raised, (percentile_cont(0.5) within group 
(order by private_money_2016)) as private_money_raised from value_creation v inner join biotechcontrolpairs b on v.company_number = b.company_number group by v.company_type, ipo_year;

select v.company_type, extract(year from date_of_ipo) as ipo_year, (percentile_cont(0.5) within group (order by cash_raised_2016)) as median_cash_raised, (percentile_cont(0.5) within group 
(order by private_money_2016)) as private_money_raised from value_creation v inner join biotechcontrolpairs b on v.company_number = b.company_number 
where v.company_type = 'Biotech' group by v.company_type, ipo_year;

select v.company_type, sum( cash_raised_2016) as total_cash_raised_2016, sum(private_money_2016) as total_private_money_raised from value_creation v group by v.company_type;

select v.company_type, (percentile_cont(0.5) within group (order by premoney_2016)) as median_premoney2016, sum(premoney_2016) as total_premoney2016 from bloomberg_financials v group by v.company_type; 
-- =mkt_cap_before_offering_premoney

--drop view company_acquisitions_pairs;
create view company_acquisitions_pairs as
select i.company_number, i.ticker_symbol, i.company_name, i.company_type, ipo_window, ipo_price, first_date, first_price_close_daily, first_shares, last_stock_date, last_price_close_daily, last_shares, deletion_key 
from ipofate_derived i inner join biotechcontrolpairs b on i.company_number = b.company_number where deletion_reason = 1 ; --180

create view company_acquisitions_biotech as
select i.company_number, i.ticker_symbol, i.company_name, i.company_type, ipo_window, ipo_price, first_date, first_price_close_daily, first_shares, last_stock_date, last_price_close_daily, last_shares, deletion_key 
from ipofate_derived i inner join biotechcontrolpairs b on i.company_number = b.company_number where deletion_reason = 1 and i.company_type = 'Biotech'; --93 biotechs were acquired

--extract drugs and companies with approved drugs prior to or at acquisition.  (view ipo_products.products_at_acquisition)
select drug_id, original_company_id, company_name,acquisition_year,approval_year from project_list
where acquisition_year is not null and approval_year is not null and approval_year<=acquisition_year;

--extract the distinct company names and the number of approved drugs at acquisition.
select distinct original_company_id, company_name,count(*) from ipo_products.products_at_acquisition group by original_company_id,company_name;

select c.*, count(p.*) from company_acquisitions_biotech c full outer join ipo_products.products_at_acquisition p on p.original_company_id = c.company_number group by c.company_number,
c.ticker_symbol, c.company_type, ipo_window, ipo_price, first_price_close_daily, first_shares, last_price_close_daily, last_shares, deletion_key, original_company_id, c.company_name; --182

select distinct (original_company_id), p.company_name, count(p.*) from company_acquisitions_biotech c full outer join ipo_products.products_at_acquisition p on p.original_company_id = c.company_number 
group by c.company_number, c.ticker_symbol, c.company_type, ipo_window, ipo_price, first_price_close_daily, first_shares, last_price_close_daily, last_shares, deletion_key, original_company_id, c.company_name;

alter table first_last_marketcap
add column last_stock_2016 float;

update first_last_marketcap
set last_stock_2016 =
CASE
when extract(year from last_date) = 1997 then last_stock * 1.4954
when extract(year from last_date) = 1998 then last_stock * 1.4724
when extract(year from last_date) = 1999 then last_stock * 1.4406
when extract(year from last_date) = 2000 then last_stock * 1.3938
when extract(year from last_date) = 2001 then last_stock * 1.3552
when extract(year from last_date) = 2002 then last_stock * 1.3341
when extract(year from last_date) = 2003 then last_stock * 1.3044
when extract(year from last_date) = 2004 then last_stock * 1.2706
when extract(year from last_date) = 2005 then last_stock * 1.2289
when extract(year from last_date) = 2006 then last_stock * 1.1905
when extract(year from last_date) = 2007 then last_stock * 1.1575
when extract(year from last_date) = 2008 then last_stock * 1.1147
when extract(year from last_date) = 2009 then last_stock * 1.1187
when extract(year from last_date) = 2010 then last_stock * 1.1007
when extract(year from last_date) = 2011 then last_stock * 1.0670
when extract(year from last_date) = 2012 then last_stock * 1.0454
when extract(year from last_date) = 2013 then last_stock * 1.0303
when extract(year from last_date) = 2014 then last_stock * 1.0138
when extract(year from last_date) = 2015 then last_stock * 1.0126
when extract(year from last_date) = 2016 then last_stock
end;

select v.pair_id, company_name, ticker, v.company_type, v.date_of_ipo, adj_ipo_window as ipo_window, deletion_reason, ipo_stock_price2016 as "inflation adjusted IPO price",
first_price_closing_2016, first_marketcap2016, last_stock_date, last_price_closing_2016, last_marketcap2016,
(percentile_cont(0.5) within group (order by earning_before_interest_inflation_adj_2016)) * 1000000 as median_ebitda_millions2016, 
(percentile_cont(0.5) within group (order by revenue_total_inflation_adj_2016)) * 1000000 as median_revenue_millions2016, 
(percentile_cont(0.5) within group (order by net_income_or_loss_inflation_adj_2016)) * 1000000 as median_netincome_millions2016,
(percentile_cont(0.5) within group (order by gross_profit_or_loss_inflation_adj_2016)) * 1000000 as median_grossprofit_millions2016,
(percentile_cont(0.5) within group (order by research_and_development_inprogress_expense_inflation_adj_2016)) * 1000000 as median_rnd_millions2016, 
(percentile_cont(0.5) within group (order by sale_of_common_and_preferred_stock_inflation_adj_2016)) * 1000000 as median_postipo_stock_sale_millions2016,
(percentile_cont(0.5) within group (order by purchase_of_common_and_preferred_stock_inflation_adj_2016)) * 1000000 as median_stock_purchase_millions2016,
cumul_dividends_xmillions_infladj2016, private_money_2016 as "pre-IPO investment, 2016", cash_raised_2016 as "IPO offer size", end_shareholder_value_2016
from compustat_financials_pairs c inner join value_creation v on c.original_company_id = v.company_number group by v.pair_id, company_name, ticker, v.company_type,
v.date_of_ipo, adj_ipo_window, deletion_reason, ipo_stock_price2016, first_price_closing_2016, first_marketcap2016, last_stock_date, last_price_closing_2016, 
last_marketcap2016, cumul_dividends_xmillions_infladj2016, private_money_2016, cash_raised_2016, end_shareholder_value_2016; --add Total capital raised (pre-IPO investment, IPO offer size, post-IPO stock sales)

create view supplementaryCompustat as
select pair_id, original_company_id, global_company_key, company_legal_name, ticker_symbol, v.company_type, v.date_of_ipo, adj_ipo_window as ipo_window, data_year,
earning_before_interest_inflation_adj_2016, revenue_total_inflation_adj_2016, net_income_or_loss_inflation_adj_2016, gross_profit_or_loss_inflation_adj_2016, 
research_and_development_inprogress_expense_inflation_adj_2016, sale_of_common_and_preferred_stock_inflation_adj_2016, purchase_of_common_and_preferred_stock_inflation_adj_2016, 
dividends_total_inflation_adj_2016 from compustat_financials_pairs v; --Compustat-paired-data-used-in-Paper.csv

create view supplementaryBloomberg as
select company_number, pair_id, gvc, company_name, ticker, company_type, date_of_ipo, first_data_date, ipo_stock_price2016, first_price_closing_2016, first_marketcap2016, cumul_dividends_xmillions_infladj2016,
cumul_purchase_stock_xmillions_infladj2016 as "cumulative stock_buybacks2016", cumul_sale_stock_xmillions_infladj2016 as "cumulative post-IPO_stock_sales2016", private_money_2016 as "pre-IPO_investment2016", 
cash_raised_2016 as "IPO_offer_size2016", end_shareholder_value_2016, last_stock_date, last_shares2016, last_marketcap2016, net_capital_raised, (private_money_2016 + cash_raised_2016 + cumul_sale_stock_xmillions_infladj2016) 
as "total_capital_raised2016", deletion_reason_code, deletion_reason from value_creation; --Bloomberg-paired-data-used-in-Paper.csv


select company_type, (percentile_cont(0.5) within group (order by net_capital_raised)) as median_net_capital_raised2016, 
(percentile_cont(0.5) within group (order by total_capital_raised2016)) as median_total_capital_raised2016, 
(percentile_cont(0.5) within group (order by end_shareholder_value_2016)) as median_end_shareholder_value_2016 
 from supplementaryBloomberg group by company_type;
 
 select company_type, (percentile_cont(0.5) within group (order by sale_of_common_and_preferred_stock_inflation_adj_2016)) as "median_post-IPO_stocksales"
 from supplementaryCompustat group by company_type;

select company_type, sum (net_capital_raised) as "net", sum(total_capital_raised2016) as "total", sum(end_shareholder_value_2016) as "ESV" from supplementaryBloomberg group by company_type;

select company_type, sum( "cumulative post-IPO_stock_sales2016" ) as "post-IPO", sum("pre-IPO_investment2016") as "pre-IPO", sum("IPO_offer_size2016") as "offer", sum("cumulative stock_buybacks2016") as stock_buybacks, 
sum(cumul_dividends_xmillions_infladj2016) as dividends, sum(total_capital_raised2016) as "total_capital", sum("cumulative post-IPO_stock_sales2016" + "pre-IPO_investment2016" + "IPO_offer_size2016") as calc_total,
sum (net_capital_raised) as "net" from supplementaryBloomberg group by company_type;

--drop table supplementary;

create table supplementary as
select f.*, v.deletion_reason, ipo_stock_price2016 as "inflation adjusted IPO price",
first_price_closing_2016, first_marketcap2016, last_stock_date, last_price_closing_2016, last_marketcap2016
from founding_years_allpairs f  inner join value_creation v on f.company_number = v.company_number group by f.pair_id, f.company_number, v.company_name, v.ticker, v.company_type, v.date_of_ipo, adj_ipo_window, 
f.gvc, founding_year, deletion_reason, ipo_stock_price2016, first_price_closing_2016, first_marketcap2016, last_stock_date, last_price_closing_2016, last_marketcap2016 order by f.pair_id, f.company_type;

alter table supplementary 
add column naics int;

update supplementary
set naics = f.naics
from gvc_naics f
where supplementary.gvc = f.gvc;

alter table supplementary 
add column naics_key varchar;

--match on the first 2 characters (3 had several missing)
update supplementary
set naics_key = f.description
from naics_key f
where substring(supplementary.naics,1,2) = f.naics_code;

alter table supplementary
alter column naics type varchar(100);

select distinct(naics_key) from supplementary; --39

select s.*, ipo_year_range as "IPO window" from supplementary s inner join ipowindowkey i on s.adj_ipo_window = i.adj_ipo_window;

select table_schema, table_name, column_name from information_schema.columns where column_name LIKE 'last_stock%'; 

--check all Compustat numbers
select company_type, (percentile_cont(0.5) within group (order by revenue_total_inflation_adj_2016)) * 1000000 as median_revenue_millions2016, 
(percentile_cont(0.5) within group (order by net_income_or_loss_inflation_adj_2016)) * 1000000 as median_netincome_millions2016,
(percentile_cont(0.5) within group (order by gross_profit_or_loss_inflation_adj_2016)) * 1000000 as median_grossprofit_millions2016,
(percentile_cont(0.5) within group (order by research_and_development_inprogress_expense_inflation_adj_2016)) * 1000000 as median_rnd_millions2016, 
(percentile_cont(0.5) within group (order by sale_of_common_and_preferred_stock_inflation_adj_2016)) * 1000000 as median_stock_sale_millions2016,
(percentile_cont(0.5) within group (order by purchase_of_common_and_preferred_stock_inflation_adj_2016)) * 1000000 as median_stock_bought_millions2016 from compustat_financials_pairs group by company_type;

select company_type, (percentile_cont(0.5) within group (order by revenue_total_inflation_adj_2016))  as median_revenue_2016, 
(percentile_cont(0.5) within group (order by net_income_or_loss_inflation_adj_2016))  as median_netincome_2016,
(percentile_cont(0.5) within group (order by gross_profit_or_loss_inflation_adj_2016))  as median_grossprofit_2016,
(percentile_cont(0.5) within group (order by research_and_development_inprogress_expense_inflation_adj_2016)) as median_rnd_2016, 
(percentile_cont(0.5) within group (order by sale_of_common_and_preferred_stock_inflation_adj_2016))  as median_stock_sale_2016,
(percentile_cont(0.5) within group (order by purchase_of_common_and_preferred_stock_inflation_adj_2016))  as median_stock_bought_2016 from compustat_financials_pairs group by company_type;

--check all Bloomberg numbers
select company_type, (percentile_cont(0.5) within group (order by ipo_stock_price2016)) as median_IPOstockprice_2016, 
(percentile_cont(0.5) within group (order by first_marketcap2016)) as median_first_marketcap2016, 
(percentile_cont(0.5) within group (order by last_marketcap2016)) as median_last_marketcap2016,
(percentile_cont(0.5) within group (order by end_shareholder_value_2016)) as medianend_shareholder_value_2016 
 from value_creation group by company_type;

--top line numbers for Win-Loss-Table.xlsx
select company_type, sum(first_marketcap2016) as sum_firstmktcap, sum(last_marketcap2016) as sum_lastmktcap, sum(private_money_2016) as sum_private_investment, sum(cash_raised_2016) as sum_cashraised_atIPO, 
sum(cumul_sale_stock_xmillions_infladj2016) as sum_sale_stock2016, sum(cumul_dividends_xmillions_infladj2016) as sum_dividends_2016,  sum(cumul_purchase_stock_xmillions_infladj2016) as sum_stockbuyback2016, 
( sum(private_money_2016) + sum(cash_raised_2016) + sum(cumul_sale_stock_xmillions_infladj2016)) as total_capital_raised_2016,  
( sum(private_money_2016) + sum(cash_raised_2016) + sum(cumul_sale_stock_xmillions_infladj2016) - sum(cumul_dividends_xmillions_infladj2016) - sum(cumul_purchase_stock_xmillions_infladj2016)) as net_value_2016 
from value_creation group by company_type;

select company_type, last_marketcap2016/first_marketcap2016 from value_creation group by company_type, last_marketcap2016, first_marketcap2016;

select company_type, (percentile_cont(0.5) within group (order by last_marketcap2016/first_marketcap2016)) from value_creation group by company_type; --step up?

select count(*), ipo_window from supplementary where deletion_reason = 'active' group by ipo_window;

select table_schema, table_name, column_name from information_schema.columns where column_name = 'gvc';

alter table value_creation 
drop column last_data_year_fiscal
last_valuation_fiscal_infladj2016
last_stock_fiscal_infladj2016
last_shares_fiscal_infladj2016
first_valuation_fiscal_infladj2016
first_stock_fiscal_infladj2016
first_shares_fiscal_infladj_2016
first_data_year_fiscal;

update value_creation
set first_data_date = f.first_time
from first_last_stock f
where value_creation.company_number = f.company_number;

alter table value_creation
add column date_of_ipo date;

update value_creation
set date_of_ipo = f.date_of_ipo
from ipofate_derived f
where value_creation.company_number = f.company_number;

alter table value_creation
add column first_price_closing float;

update value_creation
set first_price_closing = f.first_stock
from first_last_stock f
where value_creation.company_number = f.company_number;

select * from value_creation where company_type = 'Biotech' order by last_marketcap2016 desc; --Jazz and United are in S&P500

alter table value_creation
add column first_price_closing_2016 float;

 update value_creation
 set first_price_closing_2016 = f.first_stock2016
 from first_last_marketcap f
 where value_creation.company_number = f.company_number;
 
 alter table value_creation
add column last_price_closing_2016 float;

 update value_creation
 set last_price_closing_2016 = f.last_stock_2016
 from first_last_marketcap f
 where value_creation.company_number = f.company_number;
 
 --drop table daily_stock_closing;
 
 create table daily_stock_closing (
 gvkey int,
 issue_id varchar(5),
 datadate date,
 ticker varchar(10),
 price_open_daily float,
 company_name varchar (100),
 deletion_date date,
 primary key (gvkey, datadate) ); --C:\Users\ecleary\Dropbox (ScienceandIndustry)\PROJECT - Public Biotech\Holden Working Files\607 company opening prices.csv
 
 alter table daily_stock_closing
 rename to daily_stock_opening;
 
 select distinct(issue_id_dividends) from daily_stock where ticker_symbol like 'LAND%'; --removing iid 2 for LAND (gvc = 12081) due to duplicate entry with iid = 1 (renamed to 606 company opening prices in database.csv)
 
 select * from daily_stock where ticker_symbol like 'COR%'; 
 
 select * from daily_stock where company_name ilike 'Hyseq%'
 
  select * from daily_stock_opening where company_name ilike 'ARCA%' order by datadate desc; 
 
select table_schema, table_name, column_name from information_schema.columns where column_name LIKE 'ipo_stock%';
 
 select distinct on (i.gvc)
 i.company_name, i.company_number, i.gvc, company_type, date_of_ipo, offer_price, price_open_daily, datadate as opening_date, (price_open_daily - offer_price) as price_diff_withIPO, (date_of_ipo - datadate) as date_diff
 from value_creation i inner join daily_stock_opening d on i.gvc = d.gvkey; --this shows that IPO offer price does not equal opening price and that sometimes this difference is very large
 
  select distinct on (i.gvc)
 i.company_name, i.company_number, i.gvc, company_type, date_of_ipo, offer_price, price_open_daily, first_price_closing, datadate as opening_date, (first_price_closing - price_open_daily ) as price_diff_openclose
 from value_creation i inner join daily_stock_opening d on i.gvc = d.gvkey;
 
 alter table value_creation 
 add column offer_price float;
  
 update value_creation
 set offer_price = f.offer_price
 from bloomberg_financials f
 where value_creation.company_number = f.company_number;
  
 select * from daily_stock_opening where gvkey = '19149' order by datadate;
 
 select * from compustat_financials where global_company_key = '141390';

 select * from daily_stock_opening where gvkey = '141390'; --346
 select * from daily_stock_opening where gvkey = '18076'; --0

 select * from daily_stock_opening where ticker = 'TTPH'; --CAMBU

 select * from compustat_financials where global_company_key = '158740';

 select * from daily_stock_opening where gvkey = '158740'; --1304
 
  select * from compustat_financials where global_company_key = '182309'; --Hyseq starts on 2007
  
 select * from daily_stock_opening where gvkey = '182309'; --2009 ABIO/ARCA Biopharma
 
 select * from daily_stock where company_number = '152'; --HYSEQ
 
select distinct(gvkey) from daily_stock_opening; --606

select distinct(ticker) from daily_stock_opening; --633

--create view forLiam as
select b.*, i.founding_year, i.first_date, i.first_price_close_daily, i.first_shares, week1fromIPO_date, week1fromIPO_price, week1fromIPO_sharesout,
day30fromipo_date, day30fromipo_price, day30fromipo_sharesout, day90fromipo_date, day90fromipo_price, day90fromipo_sharesout, day180_date,
day180_price, day180_sharesout, year1fromipo_date, year1fromipo_price, year1fromipo_sharesout, year3fromipo_date, year3fromipo_price, year3fromipo_sharesout, year5fromipo_date, year5fromipo_price,
year5fromipo_sharesout from ipofate_derived i inner join biotechcontrolpairs b on i.company_number = b.company_number; --append opening price to ipofate_derived

alter table ipofate_derived
add column price_open_daily float;

 update ipofate_derived
 set daily_stock_opening = f.ipo_window
 from daily_stock_opening f
 --where ipovalwindow.company_number = f.company_number; missing gvc key
 
alter table ipofate_derived
add column gvc int;

 update ipofate_derived
 set gvc = f.gvc
 from gvc_cisikey f
 where ipofate_derived.company_number = f.company_number;
 
 create schema rnd;
 
 --drop table rnd.pharma_mergers;
 
 create table rnd.pharma_mergers ( --based on humana (42)
 date_announced date,
 date_effective date,
 target_co_date_fin date,
 target_name varchar(100),
 target_sic int,
 acquiror_name varchar(100),
 acquiror_sic int,
 percent_shares_acq float,
 percent_owned_after_transaction float,
 value_of_transaction_mil float, --missing from waters corp; 1,000.00 invalid (might need to set to number in excel)
 enterprise_value_mil varchar(50),
 equity_value_mil varchar(50),
 price_per_share float );
 
 update rnd.pharma_mergers
 set enterprise_value_mil = 'np' where enterprise_value_mil is null;
 
  update rnd.pharma_mergers
 set equity_value_mil = 'np' where equity_value_mil is null;
 
 select * from rnd.pharma_mergers where  percent_shares_acq = 100; --1891
 
 select * from rnd.pharma_mergers where  percent_owned_after_transaction = 100 and substring(acquiror_name,0,7) <> substring(target_name,0,7); --1924
 
 select * from rnd.pharma_mergers where date_effective is not null; --2883
  
where substring(supplementary.naics,1,2) = f.naics_code;

select * from daily_stock where company_number = 38.9 order by data_date_dividends;

select * from daily_stock_opening where gvkey = 64853 and price_open_daily is not null order by datadate;

select * from value_creation where deletion_reason_code = 1 and company_type = 'Biotech';  --93

create view approval_acquisitions as
select v.company_number, extract(year from last_data_date) as compustat_acquisition_year, p.* from value_creation v inner join 
ipo_products.project_list p on v.company_number = p.original_company_id where v.deletion_reason_code = 1 and company_type = 'Biotech' 
and approval_year is not null and companies_first_approval_0_no_1_yes = 1 and approval_year < 2017; --45 companies had a product before 2017 and were acquired vs 43 Sunyi - Jazz)

select company_number, company_name, compustat_acquisition_year, approval_year, compustat_acquisition_year - approval_year as diff from approval_acquisitions where approval_year < 2017; --45

select v.company_name, v.last_marketcap2016, v.deletion_reason, extract(year from v.last_stock_date) as last_year, p.approval_year, extract(year from v.last_stock_date) - p.approval_year as diff 
from value_creation v inner join ipo_products.project_list p on v.company_number = p.original_company_id where company_type = 'Biotech' and v.deletion_reason_code > 1
and approval_year is not null and companies_first_approval_0_no_1_yes = 1 and approval_year < 2017; --42 active with product (Sunyi has 48) (equivalent to last_data_date) ****change deletion reason to see other outcomes

select distinct (original_company_id ), v.company_number, v.deletion_reason_code, extract(year from last_data_date) as compustat_acquisition_year, extract(year from v.last_stock_date) as last_year, 
p.approval_year, extract(year from v.last_data_date) - p.approval_year as diff  from value_creation v inner join 
ipo_products.project_list p on v.company_number = p.original_company_id where company_type = 'Biotech' and p.deletion_reason_code = 1
and approval_year is not null and companies_first_approval_0_no_1_yes = 1 and approval_year < 2017; --45 total: 13 acq < appr; 25 within 5 years; 9 5+ years after approval
and approval_year is null; --41 acquired with no product
--and approved = 0; --41

select v.company_number, v.deletion_reason_code, extract(year from last_data_date) as compustat_acquisition_year, extract(year from v.last_stock_date) as last_year, 
p.approval_year, extract(year from v.last_data_date) - p.approval_year as diff  from value_creation v inner join 
ipo_products.project_list p on v.company_number = p.original_company_id where company_type = 'Biotech' and v.deletion_reason_code = 1
and approval_year is not null and companies_first_approval_0_no_1_yes = 1 and approval_year < 2017; 

select * from value_creation where deletion_reason_code = 1 and company_type = 'Biotech'; --93

select * from biotechcontrolpairs where adj_ipo_window >= 4 and company_type = 'Biotech'; --182

select distinct (original_company_id ) from ipo_products.project_list where deletion_reason_code = 1 and approval_year is null; -- approved = 0; --93 (41 no approval, 47 approval)

select distinct (original_company_id ) from ipo_products.project_list where deletion_reason_code = 1 and approval_year is not null and companies_first_approval_0_no_1_yes = 1 and approval_year < 2017; 

select distinct (p.original_company_id), v.deletion_reason_code, extract(year from last_data_date) as compustat_acquisition_year, p.* from value_creation v inner join 
ipo_products.project_list p on v.company_number = p.original_company_id where v.deletion_reason_code = 1 and company_type = 'Biotech' 
and approval_year is null; --62 not distinct...

--does Compustat's inactive/active status correspond to last date traded? --all good 6/12/19

select * from value_creation where last_data_date = '2016-12-31' ; --356 active; --Careful, last_data_date <> last_stock_date (ARCA, 152)

select * from value_creation where deletion_reason_code = 0; --414 sort by last_data_date to see <2016-12-31

select * from ipofate where activity_status = 'active' and fate = 'desister'; --1 ARTD/165.1

select deletion_reason from ipofate where activity_status = 'inactive' group by deletion_reason;

select * from value_creation v inner join ipofate i on v.company_number = i.company_number where v.last_stock_date = '2016-12-30' and v.deletion_reason = 'inactive'; --0

select * from ipofate where deletion_reason > 0 and last_stock_date = '2016-12-30'; --0, meaning all inactive Cos correspond to trading date; 

select last_stock_date from ipofate where activity_status = 'active' group by last_stock_date;

select * from ipofate where activity_status = 'active' order by last_stock_date; --ARTD has 2015-12-23

create table splitadjipoprice (
company_name varchar(100),
company_number float,
bloomber_ticker varchar(50),
ipo_date date,
ipo_price_splitadj float ) 
-- from PROJECT - Public Biotech\Liam\SplitAdjIPOprice_forDB.csv

--create view forFred as
select l.*, s.ipo_price_splitadj from forLiam l right join splitadjipoprice s on l.company_number = s.company_number; --inner join stock_price_adjustment

create table allpricespairs as
select l.*, i.permo, i.adjustment_factor, i.opening_price, i.closing_price, s.ipo_price_splitadj from forLiam l right join splitadjipoprice s on l.company_number = s.company_number 
inner join stock_price_adjustment i on l.gvkey = i.gvkey; --missing 10 records, has duplicates

select a.*, b.ipo_year, b.offer_price, b.offer_price2016 from allpricespairs a INNER join bloomberg_financials b on a.company_number = b.company_number and a.pair_id = b.company_pair;

alter table allpricespairs
add column offer_price float;

update allpricespairs
set offer_price = b.offer_price
from bloomberg_financials b
where allpricespairs.company_number = b.company_number and allpricespairs.pair_id = b.company_pair;

select f.*, i.ipo_price from forFred f inner join ipofate_derived i on f.company_number = i.company_number;

select count(*), v.company_type from billiondollarpairs b inner join value_creation v on b.company_number = v.company_number and b.pair_id = v.pair_id where deletion_reason_code = 1 group by v.company_type;
--243 distinct $1B Cos (65 acquired)

select count(*), company_type from value_creation where last_marketcap2016 > 1000000000 and deletion_reason_code = 1 group by company_type; --29 biotech and 14 controls
select count(*), company_type from value_creation where deletion_reason_code = 1 group by company_type; --93 biotech/87 controls acquired

select count(*), company_type from value_creation where last_marketcap2016 < 100000000 and deletion_reason_code > 0 group by company_type; --45 biotechs and 41 controls
select count(*), company_type from value_creation where deletion_reason_code > 0 group by company_type; --110 biotech and 114 controls


select (percentile_cont(0.5) within group (order by employee)) as median_employee from compustat_financials; ---204 x 1000 = 204

select v.company_type, (percentile_cont(0.5) within group (order by employee)) as median_employee from compustat_financials c inner join value_creation v on c.original_company_id = v.company_number group by company_type;
--biotech = 0.087 (87) vs non-biotech 0.522 (522)

--select company_type, (last_marketcap2016 - net_capital_raised) as net_value_created from supplementarybloomberg group by company_type, last_marketcap2016, net_capital_raised ;

--COX
create view bloomberg_compustat_pairs as
select gvc, original_company_id, company_pair, d.company_name, d.company_type, founding_year, d.date_of_ipo, (d.date_of_ipo - founding_year) as company_age, last_stock_date, 
(last_stock_date - d.date_of_ipo) as days_listed, activity_status, deletion_reason, deletion_key, d.adj_ipo_window, postal_code, d.state, stateinc, offer_price2016, premoney_2016, private_money_2016,
(percentile_cont(0.5) within group (order by employee)) as median_employees_thousands,
(percentile_cont(0.5) within group (order by earning_before_interest_inflation_adj_2016))  as median_EBITDA_2016,  
(percentile_cont(0.5) within group (order by revenue_total_inflation_adj_2016))  as median_revenue_2016, 
(percentile_cont(0.5) within group (order by net_income_or_loss_inflation_adj_2016))  as median_netincome_2016,
(percentile_cont(0.5) within group (order by gross_profit_or_loss_inflation_adj_2016))  as median_grossprofit_2016,
(percentile_cont(0.5) within group (order by research_and_development_inprogress_expense_inflation_adj_2016)) as median_rnd_2016, 
(percentile_cont(0.5) within group (order by sale_of_common_and_preferred_stock_inflation_adj_2016))  as median_stock_sale_2016,
(percentile_cont(0.5) within group (order by purchase_of_common_and_preferred_stock_inflation_adj_2016))  as median_stock_bought_2016
from compustat_financials_pairs c inner join bloomberg_financials b on c.original_company_id = b.company_number 
inner join ipofate_derived d on b.company_number = d.company_number 
group by gvc, original_company_id, company_pair, d.company_name, d.company_type, founding_year, activity_status, d.date_of_ipo, last_stock_date, deletion_reason, deletion_key, d.adj_ipo_window, 
postal_code, d.state, stateinc, offer_price2016, premoney_2016, private_money_2016;
--add products

alter table ipofate_derived
add column postal_code varchar(10),
add column stateinc varchar(5),
add column state varchar(5);

 update ipofate_derived
 set postal_code = f.postal_code
 from ipogeo_class f
 where ipofate_derived.gvc = f.gvc;

 update ipofate_derived
 set stateinc = f.stateinc
 from ipogeo_class f
 where ipofate_derived.gvc = f.gvc;
 
 update ipofate_derived
 set state = f.state
 from ipogeo_class f
 where ipofate_derived.gvc = f.gvc;

select *, (days_listed/365) as years_listed_fromIPO_rnd from bloomberg_compustat_pairs;

select *, (days_listed/365) as years_listed_fromIPO_rnd from bloomberg_compustat_pairs b full outer join ipo_products.s1_approved s on b.original_company_id = s.original_company_id; --bloomberg_compustat_pairs.csv

select s1_p3.original_company_id, s1_p3.company_name,s1_approved.original_company_id,s1_approved.company_name,num_of_phase_3, 
num_of_approved, b.* from s1_p3 full outer join s1_approved on s1_p3.original_company_id=s1_approved.original_company_id
full outer join ipo.bloomberg_compustat_pairs b on b.original_company_id = s1_approved.original_company_id where company_type = 'Biotech';

create view ipo.cox_products as
select b.*, num_of_phase_3, num_of_approved from s1_p3 full outer join s1_approved on s1_p3.original_company_id=s1_approved.original_company_id
full outer join ipo.bloomberg_compustat_pairs b on b.original_company_id = s1_approved.original_company_id; --delete extra rows

create table stock_price_adjustment (
permo int primary key,
gvkey int,
first_date date,
adjustment_factor float,
opening_price float,
closing_price float
)
--copy from PROJECT - Public Biotech\Project with Anne Schnader\Analyses\crosschecking\CRSP_DATA_splitadjustment.csv --Sarah's data - do not use due to negative stock prices

select count(*), nme_or_reformulation, approval_year from drug_list group by nme_or_reformulation, approval_year;