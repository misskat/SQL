
select distinct (d.target, r.project_number, r.pub_year )
from nih_grants.targetpmids d, nih_grants.reporterpublink r 
where d.pmid = r.pmid


select distinct (project_number, pub_year, pmid, target) from nih_grants.targetpmidprojects;



create table nih_grants.uniquedrugtargetmerger as
(select t.project_number, t.pub_year, t.target, d.drug,
CASE 
when d.drug is null then 'T'
when (d.drug is not null and t.target is not null) then 'Both'
else 'D' 
end
from nih_grants.uniquetargetpmidprojectyear t
left join nih_grants.uniquedrugpmidprojectyear d ON ( t.project_number = d.project_number and t.pub_year = d.pub_year)
)
UNION

(
select d.project_number, d.pub_year, t.target, d.drug,
CASE 
when d.drug is null then 'T'
when (d.drug is not null and t.target is not null) then 'Both'
else 'D' 
end
from nih_grants.uniquedrugpmidprojectyear d
left join nih_grants.uniquetargetpmidprojectyear t ON ( t.project_number = d.project_number and t.pub_year = d.pub_year)
)

6.3

select count(distinct(project_number, pub_year)),pmid from nih_grants.uniquedrugpmidprojectyear group by pmid;

select count(distinct(project_number, pub_year)),pmid from nih_grants.uniquetargetpmidprojectyear group by pmid;

select  distinct (target) from drugtargetmerger where classification = 'Both'; --153
select  distinct (target) from drugtargetmerger where classification = 'T'; --153

CREATE UNIQUE INDEX title_idx ON films (title);

create unique index appno_idx on projects_final(application_number);

select distinct (target) from targetpmids order by target;

select count(*) from nih_grants.drugpmids


select count(pmid) from nih_grants.drugpmidprojects


select count(pmid), target from nih_grants.targetpmidprojects group by target;
Select count (distinct(pmid)), target from nih_grants.targetpmids group by target

select sum(sum), drug, fy from nih_grants.cost_drug
group by fy, drug
order by drug, fy

select sum(sum), drug from nih_grants.cost_drug
group by drug
order by drug

select distinct (drug) from cost_drug_n order by drug;

select distinct (drug) from uniquedrugreporter_n order by drug;

--truncate table uniquedrugreporter_n;

select p.fy, t.pub_year, t.drug, p.total_cost, p.core_project_num
from nih_grants.projects_final p, nih_grants.uniquedrugreporter t
where p.core_project_num = t.project_number
and drug = 'dienogest'
group by p.fy, p.core_project_num, t.drug, p.total_cost, t.pub_year
order by t.drug;

select * from uniquedrugreporter where drug = 'dienogest';

create table uniquedrugreporter_n as
select distinct(d.drug, r.project_number, r.pub_year )
from nih_grants.drugpmids d, nih_grants.reporterpublink r 
where d.pmid = r.pmid 

select distinct(d.target, r.project_number, r.pub_year )
from nih_grants.targetpmids d, nih_grants.reporterpublink r 
where d.pmid = r.pmid

create table uniquetargetreporter_n as select * from uniquetargetreporter where 1=2;

create table uniqueprojectyearsforalldrugs_n as select * from uniqueprojectyearsforalldrugs where 1=2;

----drop table cost_drug_n;

create table cost_drug_n as
select p.fy, t.drug, sum(p.total_cost), p.core_project_num
from nih_grants.projects_final p, nih_grants.uniquedrugreporter_n t
where p.core_project_num = t.project_number
and p.total_cost is not null
and p.fy = t.pub_year
group by p.fy, p.core_project_num, t.drug
order by t.drug

select distinct(project_number, pub_year) from nih_grants.uniquedrugreporter_n

select sum(sum), drug, fy from nih_grants.cost_drug_n
group by fy, drug
order by drug, fy

select distinct (drug) from drugtargetinfo;

create view dtmergerinfo as
select m.*, i.targeted_phenotypic, i.firstinclass_followon, i.approval_year, i.target as truetarget from nih_grants.drugtargetmerger m LEFT JOIN nih_grants.drugtargetinfo i on m.drug=i.drug;

select count(distinct(project_number, pub_year)) from uniquedrugreporter;

select count(distinct(project_number, pub_year)) from drugpmidprojects;

select distinct(drug) from drugtargetmerger;

select distinct(drug) from uniquedrugpmidprojectyear;


select distinct(drug) from uniquedrugreporter;

select * from reporterpublink where project_number = 'R01MH071916';


select distinct (project_number, pub_year, pmid) from nih_grants.drugpmidprojects;

select * from drugpmidprojects where drug = 'Vilazodone'; --R21DA034089

select * from drugpmids where pmid = '26685701';

select * from drugpmidprojects where pmid = '26685701';

select * from uniquedrugreporter where project_number = 'R21DA034089'; --pub_year = 2016

select p.fy, u.pub_year, p.core_project_num from projects_final p, uniquedrugreporter u where core_project_num = 'R21DA034089' and p.fy = u.pub_year;

select p.fy, t.pub_year, t.drug, sum(p.total_cost), p.core_project_num
from nih_grants.projects_final p, nih_grants.uniquedrugreporter t
where p.core_project_num = t.project_number
and p.total_cost is not null
and p.fy = t.pub_year
group by p.fy, p.core_project_num, t.drug, t.pub_year

select distinct (project_number, pub_year, pmid, drug) from nih_grants.drugpmidprojects; --22655
        
        select distinct (project_number, pub_year, pmid), drug from nih_grants.drugpmidprojects group by drug, project_number, pub_year, pmid;

select count(*) from uniquedrugpmidprojectyear; --22644

select distinct(drug) from uniquedrugpmidprojectyear;

select count(pmid) as pmidcount, drug, pub_year from drugpmids group by drug, pub_year order by drug, pub_year;

select count(pmid) as pmidcount, target, pub_year from targetpmids group by target, pub_year order by target, pub_year;

select count(pmid), target, pub_year from nih_grants.targetpmidprojects group by target, pub_year order by target, pub_year;

select count(pmid), drug, pub_year from nih_grants.drugpmidprojects group by drug, pub_year order by drug, pub_year;

select distinct((project_number, pub_year)), drug from nih_grants.uniquedrugreporter group by drug, project_number, pub_year;

select distinct((project_number, pub_year)), target from nih_grants.uniquetargetreporter group by target, project_number, pub_year;

select * from cost_target where target = 'dystrophin';

select count (distinct(core_project_num, fy)) from cost_target; --108114

select count (distinct(core_project_num, fy)) from cost_drug; --9014

select count (distinct(core_project_num)) from cost_target; --42724

select count (distinct(core_project_num)) from cost_drug; --5637

select * from cost_target where core_project_num = 'P01HL036444'; --12

select * from cost_target where core_project_num = 'P01HL036444' and fy = 2000;

----drop table target_proj_year_nodups;

create table target_proj_year_nodups (
target text,
project_year varchar,
project varchar,
year int
)

create table proj_year_nodups (
project_year varchar,
year int,
project varchar

)


select * from reporterpublink where project_number = 'ZIGHL006020'; --present 194x

select fy, total_cost from projects_final where core_project_num = 'ZIGHL006020'; --present

select d.drug, r.project_number, r.pub_year
from nih_grants.drugpmids d, nih_grants.reporterpublink r 
where project_number = 'ZIGHL006020';

select * from uniquetargetreporter where project_number = 'ZIGHL006020'; --present, but not present in uniquedrugreporter

select * from cost_target where core_project_num = 'ZIGHL006020'; --present

select fy from projects_final where core_project_num = 'C06RR029965' order by fy;


select p.fy, t.pub_year, t.target, sum(p.total_cost), p.core_project_num
from nih_grants.projects_final p, nih_grants.uniquetargetreporter t
where p.core_project_num = t.project_number
and p.total_cost is not null
and core_project_num = 'ZIGHL006020'
group by p.fy, p.core_project_num, t.target, t.pub_year  --30 hits

select t.*, c.core_project_num, c.sum, c.fy from target_proj_year_nodups t LEFT JOIN cost_target c on c.core_project_num=t.project and c.fy=t.year where t.year IS NOT NULL; --286059

select t.*, sum(c.total_cost) as sum from proj_year_nodups t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where t.year IS NOT NULL group by t.project, t.year, t.target, t.project_year; --180767 use this

select * from cost_target where core_project_num = 'K23AR052404' and fy = 2010; 

select * from projects_final where core_project_num = 'ZIESC000853' and fy = 2016; 


select * from target_proj_year_nodups where project_year = '2016ZIESC000853'; 

--truncate table  target_proj_year_nodups;

select count(*) from target_proj_year_nodups;

select distinct (target) from target_proj_year_nodups order by target;

select t.*, sum(c.total_cost) as sum from target_proj_year_nodups t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where t.year IS NOT NULL group by t.project, t.year, t.target, t.project_year; --221891 use this

select distinct (i.target), p.target from target_proj_year_nodups p, drugtargetinfo i where i.target = p.target;


select distinct (p.target), i.target as infotgt from target_proj_year_nodups p, drugtargetinfo i where i.target ILIKE p.target ;

select distinct (target) from target_proj_year_nodups where target ~* 'urate';


select distinct (p.target), i.target as infotgt from target_proj_year_nodups p LEFT JOIN drugtargetinfo i on i.target ILIKE p.target ;

select count(*) from  proj_year_nodups_costs;

create table proj_year_nodups_costs as
select t.*, sum(c.total_cost) as sum from proj_year_nodups t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where t.year IS NOT NULL group by t.project, t.year,t.project_year; --221891

select t.*, sum(c.total_cost) as sum from proj_year_nodups_cases t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year group by t.project, t.year,t.project_year,
t.first_proj, t.drug, t.target, t.bothdrtg, t.target_only; --221891 (92574998042)


select sum(costs) from proj_year_nodups_costs ; --$92,574,998,042

select sum(sum_projects_finalcosts) from proj_year_nodups_costs_v2; --$92574998042

select sum(lastyearscosts) from proj_year_nodups_costs; --47250508805
select sum(lastyearscosts) from proj_year_nodups_costs_v2; --28244510247


update proj_year_nodups_costs_v2 c
set lastyearscosts = m.total_cost
from yearmismatches_lastyearscosts m
where c.project_number = m.project
and c.pub_year = m.pub_year; --not used


select t.*, i.indication from proj_year_nodups_costs LEFT JOIN drugtargetinfo i;

select count(*) from drugtargetmerger m where m.case ~* 'Both';

create table proj_year_nodups_cases (
project_year varchar,
year int,
costs int,
project varchar,
drug int,
target int,
bothdrtg int
)

select sum(costs), year from proj_year_nodups_cases p where p.bothdrtg = 1 group by year order by year;

select distinct( pub_year, project_number), drug from uniquedrugpmidprojectyear group by drug, project_number, pub_year order by drug;

select distinct( pub_year, project_number), drug from uniquedrugreporter group by drug, project_number, pub_year order by drug;


select drug, count(distinct(project_number, pub_year)) from nih_grants.uniquedrugreporter group by drug;
select drug, count(distinct(project_number, pub_year)) from nih_grants.uniquedrugpmidprojectyear group by drug; #bad file

select distinct(target) from drugtargetinfo order by target;

select distinct(target) from targetpmids order by target;

select count(pmid), target from nih_grants.targetpmids group by target order by count;

select distinct(d.drug, r.project_number, r.pub_year )
from nih_grants.drugpmids d, nih_grants.reporterpublink r 
where d.pmid = r.pmid


select distinct(t.target_id, t.target, t.pmid, r.project_number, r.pub_year)
from nih_grants.targetpmids t, nih_grants.reporterpublink r 
where t.pmid = r.pmid

----drop table targetpmidprojects;

create table nih_grants.targetpmidprojects as
select r.*, t.target_id, t.target from nih_grants.reporterpublink r INNER JOIN nih_grants.targetpmids t on r.pmid=t.pmid;


----drop table drugpmidprojects;

create table nih_grants.drugpmidprojects as
select r.*, d.drug_id, d.drug from nih_grants.reporterpublink r INNER JOIN nih_grants.drugpmids d on r.pmid=d.pmid;

select r.*, d.drug_id, d.drug from nih_grants.reporterpublink r INNER JOIN nih_grants.drugpmids d on r.pmid=d.pmid where d.drug_id = 'drug1' order by pub_year;

select count(distinct(drug_id, drug, pmid, project_number, pub_year))
from drugpmidprojects ;

select r.*, d.drug_id, d.drug from nih_grants.reporterpublink r INNER JOIN nih_grants.drugpmids d on r.pmid=d.pmid where d.drug_id = 'drug1' order by pub_year;

select r.*, t.target_id, t.target from nih_grants.reporterpublink r INNER JOIN nih_grants.targetpmids t on r.pmid=t.pmid where t.target_id = 2 order by pub_year;


select distinct(t.target_id, t.target, t.pmid, r.project_number, r.pub_year)
from nih_grants.targetpmids t, nih_grants.reporterpublink r where t.pmid = r.pmid;

select count (*) from drugpmidprojects; #pmids not unique for microtubule assembly

select distinct (target), target_id from targetpmidprojects group by target_id, target order by target_id;

select drug from drugpmids where drug_id = 'drug54' limit 5;

select target from targetpmids where target_id = '112' limit 5;

Tables redefined on 5/5

----drop table proj_year_nodups_cases;
----drop table proj_year_nodups_costs;

create table proj_year_nodups_cases (
project varchar,
year int,
project_year varchar,
first_proj int,
drug int,
target int,
bothdrtg int,
target_only int
)

select count (*) from proj_year_nodups_cases;
select count (*) from proj_year_nodups_costs;

select a.project_year as inputprojyr, o.project_year from proj_year_nodups_cases a FULL OUTER JOIN proj_year_nodups_costs o on a.project_year = o.project_year limit 100;

select a.project_year  from proj_year_nodups_cases a

select count(*) from proj_year_nodups_cases a FULL OUTER JOIN proj_year_nodups_costs o on a.project_year = o.project_year limit 100;

create table proj_year_nodups_costs as
select t.*, c.administering_ic, sum(c.total_cost) as costs from proj_year_nodups_cases t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where t.year IS NOT NULL group by t.project, t.year, t.first_proj, t.drug, t.target, t.target_only, t.bothdrtg, t.project_year, c.administering_ic order by project_year desc limit 20; 

select sum(costs) as costs, year from proj_year_nodups_costs p where p.drug = 1 group by year order by year desc;


select sum(adj_costs) as costs from proj_year_nodups_costs where target_only = 1;

select sum(costs) as costs, year from proj_year_nodups_costs p where p.target = 1 group by year order by year desc;


create table proj_year_nodups_cases_ind (
target_id int,
drug_id varchar,
project varchar,
year int,
project_year varchar,
indication int,
first_proj int,
drug int,
target int,
bothdrtg int,
target_only int
)

create table proj_year_nodups_cases_ind_costs as
select t.*, sum(c.total_cost) as costs from proj_year_nodups_cases_ind t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where t.year IS NOT NULL group by t.target_id, t.drug_id, t.project, t.year, t.first_proj, t.indication, t.drug, t.target, t.target_only, t.bothdrtg, t.project_year; 

select count(distinct(pmid, target)) from targetpmids; --1966481

select count(pmid), target from targetpmids group by target order by target;

select count(distinct(pmid, drug)) from drugpmids; --131092


select count(pmid), drug from drugpmids group by drug order by drug;

select pmid, target from targetpmids where target_id = 94 order by pmid; --35891
select distinct(pmid, target) from targetpmids_temp where target_id = '94'; --31444 (4447)

----drop table targetpmids_nodups;

SELECT ctid, * FROM targetpmidprojects where target_id = '94' and pmid='1311696' order by pmid;

SELECT ctid, * FROM targetpmidprojects order by target, pmid;

select count (pmid), target from targetpmidprojects where target_id = '94' group by target order by target;

select count (pmid), target from uniquetargetpmidprojectyear where target = 'microtubule assembly' group by target order by target;

select count (pmid), target from targetpmidprojects_dups where target = 'microtubule assembly' group by target order by target; 
--12142

select count (pmid), target from targetpmidprojects where target_id = '94' group by target order by target;
--10392

alter table targetpmidprojects
rename to targetpmidprojects_dups;

create table targetpmidprojects as
select distinct pmid, project_number, pub_year, target_id, target from targetpmidprojects_dups;

create table targetpmids_nodups as
select * from nih_grants.targetpmids;

 DELETE FROM targetpmids_nodups
 WHERE ctid IN (SELECT min(ctid)
 FROM targetpmids_nodups
 GROUP BY target_id
 HAVING count(*) > 1) and target_id = '94';
 
 DELETE FROM targetpmids
WHERE  ctid NOT IN (
   SELECT min(ctid)
   FROM   targetpmids
   GROUP  BY pmid, target_id);
 
select count(distinct(pmid, target)) from nih_grants.targetpmids_nodups;

create table targetpmids_nodups as
select distinct pmid, target, target_id, pub_year
  from targetpmids;
  
  
create table targetpmidprojects_nodups as
select distinct pmid, target, target_id, pub_year
  from targetpmids;
  
  create table uniquetargetpmidprojectyear as
select distinct project_number, pub_year, pmid, target, target_id
  from targetpmidprojects;
  
  select count(*) from uniquetargetpmidprojectyear; --587996
  select count(*) from uniquetargetpmidprojectyear_dups; --587996
  
  ----drop table targetpmids_temp;
  
  select distinct (drug) from drugpmidprojects;
  select distinct (drug) from drugpmids;
  
  select distinct (fy), count(fy) from projects_2017 group by fy;
  
  select distinct(ic_name), fy from projects_final order by ic_name, fy;
  
  
  select distinct(ic_name), fy from projects_final;
  select distinct(ic_name) from projects_final where total_cost is not null;
  
  select distinct(administering_ic) from projects_final;
  
  ----drop table cost_drug_py;
  
  alter table targetpmids_nodups
  rename to targetpmids;

  alter table uniquetargetpmidprojectyear
  rename to uniquetargetpmidprojectyear_dups;

select count(distinct(project_year)) from proj_year_nodups_cases; --221891

select count(distinct(project_year)) from proj_year_nodups_cases where drug = 1; --6767

select count(distinct(project_year)) from proj_year_nodups_cases where target = 1; --219586

select count(distinct(project_year)) from proj_year_nodups_cases where bothdrtg = 1; --11862

select count(distinct(project_year)) from proj_year_nodups_cases where target_only = 1; --207724

select count(distinct(project_year)) from proj_year_nodups_cases;

select count(distinct (project_number, pub_year, pmid, target)) from nih_grants.targetpmidprojects; --587996

select count(distinct (pub_year, pmid, target)) from nih_grants.targetpmidprojects; --277643

select count(distinct (project_number, pmid, target)) from nih_grants.targetpmidprojects; --587996

select count(distinct (project_number, pmid)) from nih_grants.targetpmidprojects; --413109

select distinct(project_number, pub_year) from reporterpublink;

create view targetprojectcount as
select count(project_number), target from nih_grants.targetpmidprojects group by target;

select sum(count) from targetprojectcount;

select count(distinct(project_number, pub_year, target)) from targetpmidprojects; --450606

select count(*) from targetpmidprojects;

select count(distinct(project_number, pub_year)), drug)) from drugpmidprojects; --19073

select distinct project_number, pub_year, pmid, drug from nih_grants.drugpmidprojects; --22706

select count(distinct(project_number, pub_year)) from nih_grants.uniquedrugpmidprojectyear ; --14292

select count (distinct(project_number, pub_year)) from uniquedrugpmidprojectyear; --14292

select distinct(project_number) from targetpmidprojects;

select count(project_year) from proj_year_nodups_cases where target = 1;

select count(pmid) as count, pub_year, drug from drugpmids group by pub_year, drug order by drug, pub_year;

select count(pmid) as count, pub_year, target from targetpmids group by pub_year, target order by target, pub_year;

create table uniquedrugpmidprojectyear as
select distinct project_number, pub_year, pmid, drug from nih_grants.drugpmidprojects; --22706

create table uniquetargetpmidprojectyear as
select distinct project_number, pub_year, pmid, target from nih_grants.targetpmidprojects; --587996


select count(pmid), target from nih_grants.uniquetargetpmidprojectyear group by target order by target;

select pmid, target from targetpmidprojects where target_id = '94' group by pmid, target order by pmid;

select count (distinct(project_number, pub_year)) from uniquetargetpmidprojectyear; --219586
select count (distinct(project_number, pub_year)) from uniquedrugpmidprojectyear; --14292

select count (project_number), pub_year, drug from uniquedrugpmidprojectyear group by pub_year, drug order by drug, pub_year; 

select distinct(drug) from drugpmidprojects;

select distinct(fy) from projects_final where ic_name ~* 'FOOD AND DRUG' limit 5;

select * from projects_final where ic_name ~* 'CLINICAL CENTER' limit 5;


select distinct (ic_name), fy, administering_ic from projects_final where administering_ic = 'FD' order by fy;

  select distinct ic_name, administering_ic, org_name from projects_final  where org_state = 'MA' order by ic_name;
  
  select distinct(org_zipcode) from projects_final; --17059
  
  select distinct(org_zipcode) from projects_final where org_fips = 'US'; --16425
  
  select distinct(org_FIPS) from projects_final; --130 ISO codes
  
  select distinct(org_district) from projects_final;  --67
  
  select distinct(org_district) from projects_final where org_state = 'MA'; --28
  
  create table proj_year_nodups_costs_geo as
select t.*, c.org_country, c.org_fips, c.org_state, c.org_zipcode, c.org_district, sum(c.total_cost) as costs from proj_year_nodups_cases t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where t.year IS NOT NULL group by t.project, t.year, t.first_proj, t.drug, t.target, t.target_only, t.bothdrtg, t.project_year,  c.org_fips, c.org_state, c.org_zipcode, c.org_district, c.org_country order by project_year desc; 
--225310

select t.*, c.org_district from proj_year_nodups_cases t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year  group by t.project, t.year, t.first_proj, t.drug, t.target, t.target_only, t.bothdrtg, t.project_year, c.org_district order by project_year desc; 
--221919


select count(*) from proj_year_nodups_costs;
--221891

select t.*, c.org_country, c.org_fips, c.org_state, c.org_zipcode, c.org_district, sum(c.total_cost) as costs from proj_year_nodups_cases t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where t.year IS NOT NULL group by t.project, t.year, t.first_proj, t.drug, t.target, t.target_only, t.bothdrtg, t.project_year,  c.org_fips, c.org_state, c.org_zipcode, c.org_district, c.org_country order by project_year desc; 

select c.org_country, c.ed_inst_type, count(t.project_year) from proj_year_nodups_imputed_costs t LEFT JOIN projects_final c on 
c.core_project_num=t.project and c.fy=t.year where org_country = 'UNITED STATES' and group by c.org_country, c.ed_inst_type; --370625

select count (distinct project_year), c.org_country, c.ed_inst_type from proj_year_nodups_imputed_costs t LEFT JOIN projects_final c on 
c.core_project_num=t.project and c.fy=t.year group by c.org_country, c.ed_inst_type;

select  c.org_name, count ( project_year) as count from proj_year_nodups_imputed_costs t LEFT JOIN projects_final c on 
c.core_project_num=t.project and c.fy=t.year where org_country = 'UNITED STATES' group by c.org_name order by count desc;

select count (*) as count from proj_year_nodups_imputed_costs t LEFT JOIN projects_final c on 
c.core_project_num=t.project and c.fy=t.year where org_country = 'UNITED STATES';

select * from projects_final where core_project_num='U54NS048843' and fy=2005;

select c.org_country, c.ed_inst_type, count(t.project_year) from proj_year_nodups_imputed_costs t inner JOIN projects_final c on 
c.core_project_num=t.project and c.fy=t.year group by c.org_country, c.ed_inst_type; --377702

select c.org_country, c.ed_inst_type, count(t.project_year) from proj_year_nodups_imputed_costs t, projects_final c where 
c.core_project_num=t.project and c.fy=t.year group by c.org_country, c.ed_inst_type;

select distinct(org_name) from projects_final where org_state = 'WA';

select distinct(org_name), count(core_project_num) as count from projects_final where org_state = 'TX' group by org_name order by count desc;

select distinct(org_name, core_project_num), total_cost from projects_final where org_state = 'MA' limit 10;

select org_name, sum(total_cost) from projects_final where org_state = 'MA' and total_cost is not null group by org_name limit 10;

select * from projects_final where total_cost_sub_project is not null and total_cost is not null limit 50;

select * from projects_2017 where administering_ic = 'FD';

--

alter table proj_year_nodups_cases_ind_costs
add column adj_costs int;


update proj_year_nodups_cases_ind_costs
SET adj_costs = 
CASE
when year = '2000' then costs * 1.39
when year = '2001' then costs * 1.36
when year = '2002' then costs * 1.33
when year = '2003' then costs * 1.3
when year = '2004' then costs * 1.27
when year = '2005' then costs * 1.23
when year = '2006' then costs * 1.19
when year = '2007' then costs * 1.16
when year = '2008' then costs * 1.11
when year = '2009' then costs * 1.12
when year = '2010' then costs * 1.1
when year = '2011' then costs * 1.07
when year = '2012' then costs * 1.05
when year = '2013' then costs * 1.03
when year = '2014' then costs * 1.01
when year = '2015' then costs * 1.01
when year = '2016' then costs
end;

----drop table drugtargetinfo;

create table nih_grants.drugtargetinfo (
drug text not null,
drug_id varchar,
target text,
target_id int,
NCE_Biologic int,
Targeted_phenotypic int,
FirstInclass_Followon int,
approval_year int,
indication text,
indication_symbol int
);

select * from proj_year_nodups_costs where costs is not null order by year asc limit 100 ;

select * from targetpmidprojects order by pub_year desc;

select sum(costs), year from proj_year_nodups_costs p where p.bothdrtg = 1 group by year order by year desc; --$103B

select sum(adj_costs) from proj_year_nodups_costs p where p.target_only = 1;

select sum(adj_costs) from proj_year_nodups_cases_ind_costs p where p.target_only = 1;

select t.*, c.administering_ic, sum(c.total_cost) as costs from proj_year_nodups_cases t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where t.year IS NOT NULL group by t.project, t.year, t.first_proj, t.drug, t.target, t.target_only, t.bothdrtg, t.project_year, c.administering_ic order by project_year desc limit 20; 

select count(t.project_year) as projyr_count, c.administering_ic, sum(t.costs) as costs, sum(t.adj_costs) as adj  from proj_year_nodups_costs t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where t.year IS NOT NULL group by administering_ic order by administering_ic; 

***
select count(t.project_year) as projyr_count, c.administering_ic, sum(c.total_cost) as unadj_costs from proj_year_nodups_costs t LEFT JOIN projects_final c on c.core_project_num=t.project group by administering_ic; #c.fy=t.year 


select t.project, t.year, c.ic_name from proj_year_nodups_costs t LEFT JOIN projects_final c on c.core_project_num=t.project where ic_name IS NULL group by ic_name, project, year, year order by year desc limit 30; 

select * from projects_final where ic_name IS NULL; 


select count(t.project_year) as projyr_count, c.administering_ic, sum(t.costs) as costs  from proj_year_nodups_costs t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where t.year IS NOT NULL and administering_ic = 'IP' group by administering_ic order by administering_ic; 

select count(t.project_year) as projyr_count, c.administering_ic, sum(c.total_cost) as costs  from proj_year_nodups_costs t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where t.year IS NOT NULL and administering_ic = 'DD' group by administering_ic order by administering_ic; 

select t.project_year, t.costs from proj_year_nodups_costs t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where c.administering_ic = 'DD';

select project_year from proj_year_nodups_costs where project_year = '2009U01DD000189';

select * from nih_grants.projects_final where core_project_num = 'ZIACL010306';
select * from nih_grants.reporterpublink where project_number = 'ZIACL010306'; --26 projects in linking table, but not in project_final

select count(*) from proj_year_nodups_costs t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where ic_name IS NULL; --72720/377702

select count(*) from proj_year_nodups_costs t LEFT JOIN projects_final c on c.core_project_num=t.project where ic_name IS NULL; --26/7675581

select count(*) from proj_year_nodups_costs t LEFT JOIN projects_final c on c.core_project_num=t.project and t.year = c.fy-1 where ic_name IS NOT NULL; --93926/338069

select count(*) from proj_year_nodups_costs t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy = t.year-1 where ic_name IS NOT NULL; --65459/389252

select count(distinct(project_number)) from reporterpublink; --129728

select count(*) from reporterpublink t INNER JOIN projects_final c on c.core_project_num=t.project_number and t.pub_year = c.fy;  --9,356,066

select count(*) from reporterpublink t INNER JOIN projects_final c on c.core_project_num=t.project_number and t.pub_year = c.fy-1; --8326701

select count(pmid) from reporterpublink t INNER JOIN projects_final c on c.core_project_num=t.project_number and t.pub_year-1 = c.fy; --9,761,335

select distinct(target) from targetpmids order by target;

select target, count(distinct(project_number, pub_year)) from targetpmidprojects group by target;

select pub_year, count(distinct(project_number)) from targetpmidprojects group by pub_year order by pub_year; --dips down after 2013 (matches Excel out)

select pub_year, count(project_number) from targetpmidprojects group by pub_year order by pub_year; --dips down after 2014

select fy, count(distinct(core_project_num,fy)) from projects_2017 group by fy order by fy;

select year, count(distinct(project)) from proj_year_nodups_cases group by year order by year; --dips after 2014

select year, count(distinct(project)) from proj_year_nodups_cases where target = 1 group by year order by year; --dips after 2013

select year, count(project_year) from proj_year_nodups_cases where target_only = 1 group by year order by year;  --dips after 2013


select year, sum(costs) from proj_year_nodups_costs where target_only = 1 and year > 1999 group by year order by year; --dips after 2009

select count(distinct(project_number, pub_year)) from targetpmidprojects; --219586 =uniquetargetreporter

select target, count(distinct(project_number, pub_year)) from uniquetargetpmidprojectyear group by target; --219586

create table Uniqueprojectyearforalltargets as
select distinct project_number, pub_year from targetpmidprojects;

select count(*) from uniqueprojectyearforalltargets; --219586

create table nih_grants.cost_target_PY as
select p.fy, p.core_project_num, sum(p.total_cost)
from nih_grants.projects_final p, nih_grants.uniqueprojectyearforalltargets t
where p.core_project_num = t.project_number
and p.total_cost is not null
and p.fy = t.pub_year
group by p.fy, p.core_project_num

create table nih_grants.cost_target_nulls as
select p.fy, p.core_project_num, sum(p.total_cost)
from nih_grants.projects_final p, nih_grants.uniqueprojectyearforalltargets t
where p.core_project_num = t.project_number
and p.fy = t.pub_year
group by p.fy, p.core_project_num

select fy, sum(sum) from cost_target_PY group by fy order by fy; --vs select year, count(distinct(project)) from proj_year_nodups_cases where target = 1 group by year order by year;

select core_project_num, sum from cost_target_PY where fy = 2010 order by sum; --11853

select * from cost_target_nulls where core_project_num = 'D43TW006571' order by sum limit 100;


select * from uniqueprojectyearforalltargets where project_number = 'D43TW006571';

select core_project_num, fy, sum from cost_target_nulls where sum is null and fy > 1999 order by core_project_num; --2657

select distinct(core_project_num, fy) from projects_final where total_cost is not null and fy > 1999 group by core_project_num, fy; --381232

select count(distinct(core_project_num, fy)) from projects_final where total_cost is not null and fy > 1999; --931135 

select application_id, activity, core_project_num, fy, total_cost  from projects_final where core_project_num ='R18HS018226'; --all missing

select * from projects_final where core_project_num ='R01FD002525'; --only 2012

select application_id, activity, core_project_num, fy, total_cost  from projects_2017 where core_project_num ='R18HS018226'; --0

select core_project_num, fy, sum from cost_target_nulls where fy=2000 order by core_project_num; --2520
select core_project_num, fy, sum from cost_target_nulls where fy=2000 and  sum is null order by core_project_num; --230


select fy, count(distinct(core_project_num)) as project_count from projects_final where fy > 1999 group by fy order by fy;

select fy, count(distinct(core_project_num)) as missing_count from projects_final where total_cost is null and fy > 1999 group by fy order by fy;

select year, count(distinct(project)) as project_count from proj_year_nodups_costs where year > 1999 and costs is null group by year order by year; --matches Excel

select * from cost_target_nulls order by fy;

select distinct target_id, project, year from proj_year_nodups_cases_ind_costs where costs is null and year > 1999 and target_only = 1 order by year;

select core_project_num, fy, total_cost from projects_final where core_project_num in ('F32MH085433', 'P01HL040962',	'R01CA120719',	'P50NS016375',	'R01NS036081',	'R37NS031348',	'R56NS028721') and fy = 2000 or fy = 2001 order by fy;


select core_project_num, fy, total_cost from projects_final where core_project_num = 'R01NS036081' order by fy;

select * from reporterpublink where project_number = 'R01NS036081' and pub_year = 2001; --11180153/2001

select count(*) from cost_target_py; --131113

select count(*) from cost_target_nulls; --147749


select count (distinct(core_project_num, fy)) from cost_target_nulls; --same

select count(project) as project_count from proj_year_nodups_costs where costs is not null and target = 1; --46084

select m.case, m.project_number, m.pub_year, c.sum from uniquedrugtargetmerger m, cost_target_py c where  m.project_number = c.core_project_num and m.pub_year = c.fy and m.case = 'T'; --251233


create table proj_year_nodups_costs_exactmatch as
select t.project, t.year, sum(c.total_cost) as sum from proj_year_nodups_cases t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year group by t.project, t.year, t.project_year;


create table nih_grants.cost_target_PY as
select p.fy, p.core_project_num, sum(p.total_cost)
from nih_grants.projects_final p, nih_grants.uniqueprojectyearforalltargets t
where p.core_project_num = t.project_number
and p.total_cost is not null
and p.fy = t.pub_year
group by p.fy, p.core_project_num
--147749 without costs; 131113 with costs (88.7%)


select count(*) from uniqueprojectyearforalltargets; --219586

select t.project, t.year, sum(c.total_cost) as sum from proj_year_nodups_cases t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where target = 1 group by t.project, t.year, t.project_year;
--219586


select t.project, t.year, sum(c.total_cost) as sum from proj_year_nodups_cases t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where target = 1 and c.total_cost is not null group by t.project, t.year, t.project_year;
--131113 


select year, sum(costs) as sum from proj_year_nodups_costs where costs is not null and target = 1 group by year order by year;

select fy, sum(sum) from cost_target_PY where sum is not null group by fy order by fy;

select distinct(p.pmid, p.pub_year) as pubmedyr, r.pub_year as nihyear from targetpmids p, targetpmidprojects r where p.pmid = r.pmid and p.pub_year <> r.pub_year; --32227

select distinct(p.pmid, p.pub_year) as pubmedyr, r.pub_year as nihyear, (p.pub_year - r.pub_year) as diff from targetpmids p, targetpmidprojects r where p.pmid = r.pmid and p.pub_year <> r.pub_year order by diff desc; -- -3 to 29

select distinct(r.project_number, r.pub_year)  from reporterpublink r, projects_final p where r.project_number = p.core_project_num and r.pub_year = p.fy limit 100;

select distinct(r.project_number, r.pub_year), p.fy  from reporterpublink r, projects_final p where r.project_number = p.core_project_num and r.pub_year <> p.fy limit 100;

select distinct(r.project_number) from reporterpublink r full outer join projects_final p on r.project_number = p.core_project_num where r.project_number is null or p.core_project_num is null; --50

CREATE INDEX project_idx ON projects_final (core_project_num);

CREATE INDEX projectnim_idx ON reporterpublink (project_number);

select count(r.project_number) from reporterpublink r, projects_final p where r.project_number = p.core_project_num and r.pub_year <> p.fy; --1.9B

create table yearmismatchesnih as
select r.project_number, r.pub_year, p.fy, (p.fy - r.pub_year) as diff  from reporterpublink r, projects_final p where r.project_number = p.core_project_num and r.pub_year <> p.fy;

select count(*) from yearmismatches; --196349011

select pub_year, count(distinct(project_number)), max(diff) as max_diff from yearmismatches group by pub_year order by pub_year limit 5;

select count(distinct(r.project_number)) from reporterpublink r, projects_final p where r.project_number = p.core_project_num and r.pub_year <> p.fy;  --127441

select distinct(project_number, pub_year) from yearmismatches limit 5;

select distinct project_number, pub_year from reporterpublink; --725101

select  count(distinct(project_number, pub_year)) from yearmismatches where diff  = 1; --320202

create table yearmismatches as
select r.project, r.year, p.fy, (p.fy - r.year) as diff  from proj_year_nodups_cases r, projects_final p where r.project = p.core_project_num and r.year <> p.fy;


select  count(distinct(project, year)) from yearmismatches; --220,908

select distinct r.project, r.year  from proj_year_nodups_cases r, projects_final p where r.project = p.core_project_num and r.year = p.fy; --149,171 


select distinct project, year from yearmismatches limit 50;

----drop table yearmismatches;
        create table yearmismatches as
        select r.project, p.total_cost, r.year, p.fy, (p.fy - r.year) as diff from proj_year_nodups_cases r, projects_final p where r.project = p.core_project_num and r.year <> p.fy group by r.project, r.year, p.fy, p.total_cost;

select   distinct(r.project, max(p.total_cost),max(p.fy)) from proj_year_nodups_cases r, projects_final p where r.project = p.core_project_num and r.year <> p.fy group by r.project, r.year, p.fy limit 5;

select project, max_totalcost, fy, year from yearmismatches group by project,  max_totalcost, fy, year having fy = max(fy) and year= max(year) and max_totalcost = max(max_totalcost) limit 5;

select project, max(fy), max_totalcost from yearmismatches group by project, fy limit 20 ;

select max_totalcost, distinct project from yearmismatches limit 20;

create view sumyearlycosts_yearmismatches as
select distinct(project), sum(total_cost), year, fy, diff from yearmismatches group by project, diff, fy, year limit 20; --should be sum

--where project = 'B01DP009010' group by project, fy, sum having fy = max(fy); 

select distinct on (project)
 project, max(sum), fy from sumyearlycosts_yearmismatches 
 group by project, sum, fy
 order by project, sum, fy desc limit 20; --works!


select distinct on (project)
 project, total_cost, fy, year, diff from yearmismatches 
 where project = 'B01DP009010' and total_cost > 1
 group by project, total_cost, fy, year, diff
 order by project, total_cost, fy;
 
 
select distinct on (project)
 project, total_cost, fy, year, diff from yearmismatches 
 where project = 'B01DP009010' and total_cost > 1
 group by project, total_cost, fy, year, diff
 order by project, fy desc;


----drop table yearmismatches_maxyearcosts;

create table yearmismatches_lastyearscosts as
select distinct on (project)
 project, total_cost, fy as last_fy, year as pub_year, diff as pubyr_fy_diff from yearmismatches 
 where total_cost > 1
 group by project, total_cost, fy, year, diff
 order by project, fy desc;


create table yearmismatches_maxyearcosts as
select distinct on (project)
 project, total_cost, fy as fyofmaxcost, year as pub_year, diff as pubyr_fy_diff from yearmismatches 
 where total_cost > 1
 group by project, total_cost, fy, year, diff
 order by project, total_cost desc;
 
 select count(distinct(project)) from yearmismatches_maxyearcosts; --61580
 
 select * from yearmismatches_lastyearscosts where pubyr_fy_diff = -2;
 
 select * from reporterpublink where project_number = 'R01CA008010';
 
 select * from yearmismatches_lastyearscosts where pub_year < 2000 order by pubyr_fy_diff desc ;
 
 select count(distinct(project)) from proj_year_nodups_cases; --221891 (27.7%)
 
 select application_id, core_project_num, fy, total_cost from projects_final where core_project_num = 'B01DP009010' order by fy;
 
select year, count(distinct(project)) as totaluniqueprojects from proj_year_nodups_cases group by year; --range 91 to 19415
  
select pub_year, count(distinct(project)) as uniqprojectsmismatch from yearmismatches_lastyearscosts group by pub_year; --range 91 to 3223
 

select count(*) from yearmismatches where year = 1980;  --3057

select count(*) from yearmismatches where year = 1980 and year <> fy --3057;


select distinct on (project)
 project, total_cost, year, fy, diff from yearmismatches where year = 1980;  --91
 
 
select distinct on (project_number)
 project_number, pub_year, fy, diff from yearmismatchesnih where pub_year = 1980;  --597
 
select count(distinct(project_number)) from reporterpublink where pub_year = 1980;  --597

select distinct(pub_year) from reporterpublink where project_number = 'R01HL021644'; --1980-2004, 2006, 2008-2015

select * from yearmismatches where project= 'R01HL021644'; --1980-2004, 2006, 2008-2015

select distinct(fy) from projects_final where core_project_num = 'R01HL021644'; --1985-2000, 2002-2005, 2007-09.

--ALL PROJECT YEARS (NEW) score each project-year as matching or not to fy;

select count(distinct(project_number)) from targetpmidprojects;  --61753 vs 61580?

create table proj_year_nodups_cases_old as
select * from proj_year_nodups_cases; --uploaded recent table with correct drug labels, recalculated costs table 6/15

select * from projects_final where total_cost = 0; --258 application_type = 2-7 or missing

----drop table proj_year_nodups_costs;
create table proj_year_nodups_costs as
select t.*, sum(c.total_cost) as sum from proj_year_nodups_cases t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where t.year IS NOT NULL group by t.project, t.year,t.project_year;


create table proj_year_nodups_costs as
select t.*, sum(c.total_cost) as costs from proj_year_nodups_cases t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where t.year IS NOT NULL group by t.project, t.year, t.project_year, t.first_proj, t.drug, t.target, t.target_only, t.bothdrtg; 

alter table proj_year_nodups_costs
add column lastyearscosts int;


update proj_year_nodups_costs c
set lastyearscosts = m.total_cost
from yearmismatches_lastyearscosts m
where c.project = m.project
and c.year = m.pub_year;


update proj_year_nodups_costs c
set fy_minus_pubyear = m.diff
from yearmismatches_lastyearscosts m
where c.project = m.project
and c.year = m.pub_year;


select distinct project, year, fy_minus_pubyear from proj_year_nodups_costs limit 10 ; --R01HG006272/2012/2    -- D43TW000668/2008/2

select * from yearmismatches where project = 'D43TW000668' and year = 2008;

select * from projects_final where core_project_num = 'D43TW000668' and fy = 2008;

alter table yearmismatches_maxyearcosts
rename column pubyr_fy_diff to diff

SELECT *
FROM   B
WHERE  NOT EXISTS (SELECT 1 
                   FROM   A 
                   WHERE  A.ID = B.ID)

  
  create table projectyearmismatches as
select r.project, r.year from proj_year_nodups_cases r where not exists (select 1 from projects_final p where r.project = p.core_project_num and r.year = p.fy);
--72720; all are unique!

 create table projectyearmismatches2 as --need to get fy
select r.project, r.year, p.fy from proj_year_nodups_cases r, projects_final p where not exists (select 1 from projects_final p where r.project = p.core_project_num and r.year = p.fy);

select distinct project, year from projectyearmismatches;

alter table projectyearsmismatches rename to projectyearmismatches;

select * from projectyearmismatches where project = 'DP1OD000490'; --2010

----drop table yearmismatches_maxyearcosts;

create table projectyearmismatches_withallcosts as
select m.*, p.fy, (p.fy - m.year) as diff, p.total_cost from projectyearmismatches m, projects_final p where m.project = p.core_project_num;

create table projectyearmismatches_costs as
select distinct on (project, year)
 project, fy as last_fy, year as pub_year, diff as fy_minus_pubyear, total_cost as lastyearscost from projectyearmismatches_withallcosts 
 where total_cost > 1
 group by project, total_cost, fy, year, diff
 order by project, fy desc, year, diff, total_cost limit 9;
 
 ----drop table projectyearmismatches_costs;
 
 update proj_year_nodups_costs set lastyearscosts = null;
 update proj_year_nodups_costs set ifmismatch = null;
 update proj_year_nodups_costs set fy_minus_pubyear = null;
 
 
 update proj_year_nodups_costs c
set lastyearscosts = m.lastyearscost
from projectyearmismatches_costs m
where c.project = m.project
and costs is null;
--and c.year = m.pub_year;


 update proj_year_nodups_costs c
set fy_minus_pubyear = m.fy_minus_pubyear
from projectyearmismatches_costs m
where c.project = m.project
and costs is null;
--and c.year = m.pub_year;



update proj_year_nodups_costs
SET ifmismatch = 1 where fy_minus_pubyear is not null and lastyearscosts is not null and costs is null;

select core_project_num, fy, total_cost from projects_final where core_project_num = 'D43TW001038';

select * from proj_year_nodups_costs where project = 'D43TW001038';


select * from projectyearmismatches_costs where project = 'P50CA070907';

select * from projectyearmismatches_withallcosts where project = 'P50CA070907';

select count(*) from proj_year_nodups_costs where costs is null and lastyearscosts is null; --51947

select * from proj_year_nodups_costs order by costs limit 100;

--for ppt/paper

select pmid, target from targetpmids order by pmid limit 100; --2K

select count (distinct pmid) from targetpmids; --1451588

select count (distinct pmid) from drugpmids; --109473

select count (pmid) from drugpmids; --131092

select count (distinct pmid) from targetpmidprojects; --195990

select count (pmid) from targetpmidprojects; --587996

select count (distinct pmid) from drugpmidprojects; --9152/22706

select count(*) from proj_year_nodups_cases where target_only = 1; --207599

select count (*) from drugtargetinfo where target is null; --13

select count (pmid) as pmid_count, pub_year from drugpmids group by pub_year order by pub_year;

select count (project_year) from proj_year_nodups_costs where target_only = 1 and year > 1999 and (ifmismatch = 1 and (fy_minus_pubyear = -1 
or fy_minus_pubyear = -2 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4)) or (fy_minus_pubyear is null and costs is not null); --170222

create table countable_projects as
select * from proj_year_nodups_costs where year > 1999 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null); --174876

select count(project_year) from countable_projects where target_only= 1 and year < 2016 and (costs is not null or lastyearscosts is not null); --150278

select count(project_year) from countable_projects where drug= 1 and year < 2016 and (costs is not null or lastyearscosts is not null); --10031


select sum(costs) from proj_year_nodups_costs where target_only = 1; --81,032,833,631

select sum(costs) from proj_year_nodups_costs where target_only = 1 and year < 2016; --76,601,881,097

select sum(lastyearscosts) from countable_projects where target_only = 1 and year < 2016; --16,203,989,426


select sum(costs) from proj_year_nodups_costs where drug = 1 and year < 2016; --9941239022

select sum(lastyearscosts) from countable_projects where drug = 1 and year < 2016; --1799406193

select count(pmid) from drugpmidprojects; --587996 + 22706 =~ 610K

select count (distinct pmid) from targetpmidprojects; --195990 (9152 unique drugs)

select d.pmid, d.drug, t.target from drugpmidprojects d inner join targetpmidprojects t on d.pmid=t.pmid order by d.pmid; --97068

select count(distinct d.pmid) from drugpmidprojects d full outer join targetpmidprojects t on d.pmid=t.pmid; --195990

select count( distinct pmid) from reporterpublink; --1,380,121 (2,710,885 are not unique)

select * from proj_year_nodups_costs where costs <= 1000; --140

select total_cost, fy from projects_final where core_project_num = 'R01AR050496';

select count(pmid) from targetpmids where target = 'slamf7';

select count(pmid) from targetpmids;

select count (project_year) from countable_projects where ifmismatch = 1; --40607/174876 (134269 match 76.8%)

select count (project_year) from countable_projects where fy_minus_pubyear is null; --134269

select count (project_year) from countable_projects where ifmismatch = 1; --40607/174876 (134269 match 76.8%)


select * from proj_year_nodups_costs where year > 1999 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null); --174876

select count(*) from proj_year_nodups_costs where year > 1999; --202716 (174876/202716 = 86.3% (13.7% removed)

create view avg_proj_duration_uniqFY as
select core_project_num, count(distinct fy) from projects_final group by core_project_num;

select * from projects_final where core_project_num = 'P41RR001209';

select * from projects_final where core_project_num = 'P01CA026731';

select avg(count), core_project_num from avg_proj_duration group by core_project_num limit 10;


select avg(count) from avg_proj_duration_uniqFY; --5.23 not unique vs 3.8 unique

select max(count) from avg_proj_duration_uniqFY; --4915 not unique vs 32 unique

select distinct (drug) from drugpmidprojects;


select distinct (target) from targetpmidprojects order by target;

select count, core_project_num from avg_proj_duration_uniqFY order by count desc limit 10; 


select min(pub_year) from reporterpublink; proj_year_nodups_costs; projects_final;

select count(*) from countable_projects where target_only = 1;

select count(project_number) from reporterpublink; --2,710,885 

select count (distinct project_number) from reporterpublink; --129,728

select count(pmid) from reporterpublink; --2,710,885 

select count (distinct pmid) from reporterpublink; --1,380,121

select distinct(pub_year) from targetpmids order by pub_year;

select * from proj_year_nodups_costs_geo where org_country = 'SPAIN';

select * from projects_final where core_project_num = 'R01CA073735' and fy = 2004;


select distinct(org_name), org_district, org_DUNS, org_Zipcode, count(core_project_num) as proj_count
from projects_final where org_state = 'MA' group by org_name, org_district, org_DUNS, org_Zipcode order by org_name desc limit 20;

create table MA_stats as
select distinct(org_name), org_district, org_Zipcode, org_DUNS, count(distinct core_project_num) as proj_count, sum(total_cost) as total_costs
from projects_final where org_state = 'MA' and total_cost > 1 group by org_name, org_district, org_DUNS, org_Zipcode order by total_costs;

select  org_name, sum(proj_count) as projects, sum(total_costs) as costs from ma_stats group by org_name order by costs desc;

select org_district,  count(distinct core_project_num) as proj_count, sum(total_cost) as total_costs 
from projects_final where org_state = 'MA' and total_cost > 1 group by org_district order by org_district desc;

select org_name, core_project_num, total_cost from projects_final where org_state = 'MA' and total_cost > 1  and org_name ~ 'BOSTON UNIVERSITY';


select distinct(core_project_num) from projects_final where org_name = 'BOSTON UNIVERSITY MEDICAL CENTER HOSP'; --75

select org_district, org_Zipcode, count(distinct core_project_num) as proj_count, sum(total_cost) as total_costs 
from projects_final where org_state = 'MA' and org_district = '11' and total_cost > 1 group by org_district, org_Zipcode;

select org_district, count(distinct project) as proj_count, sum(costs) as total_costs 
from proj_year_nodups_costs_geo where org_state = 'MA' and costs > 1 group by org_district order by org_district desc;

select f.org_name, count(distinct d.project) as project_count, sum(d.costs) as total_costs from projects_final f, proj_year_nodups_costs d 
where d.project = f.core_project_num and f.org_state = 'MA' and d.costs > 1  group by org_name order by total_costs desc; --do not use

select f.org_name, count(distinct d.project_year) as project_count, sum(d.adj_costs) as total_costs from projects_final f, 
proj_year_nodups_imputed_costs d where d.project = f.core_project_num and f.fy = d.year and
f.org_state = 'MA' and d.adj_costs > 1  group by org_name order by total_costs desc;


select org_state, org_district, count(distinct project) as proj_count, sum(costs) as total_costs 
from proj_year_nodups_costs_geo where org_country = 'UNITED STATES' and costs > 1 group by org_state, org_district order by org_state;


select org_state, count(distinct project) as proj_count, sum(costs) as total_costs 
from proj_year_nodups_costs_geo where org_country = 'UNITED STATES' and costs > 1 group by org_state order by total_costs desc;

---
 
 select * from proj_year_nodups_cases_ind where target_id = 17;
 
 select distinct p.pmid, p.target from targetpmids p inner join proj_year_nodups_cases_ind i on p.target_id = i.target_id where i.indication = 10 limit 10;
 
 select distinct (p.pmid, p.target_id) from targetpmids p, proj_year_nodups_cases_ind i where p.target_id = i.target_id 
 and i.indication = 10 limit 10;
 
 create table drugpmidindications as
 select p.* from drugpmids p inner join proj_year_nodups_cases_ind i on p.drug_id = i.drug_id group by p.pmid, p.drug, 
 p.drug_id, p.pub_year, i.indication, i.drug having i.indication = 10 and i.drug = 1;
 --21512
 
 
 select p.pmid, p.drug from drugpmidprojects p inner join proj_year_nodups_cases_ind i on p.drug_id = i.drug_id group by p.pmid, p.drug, 
 i.indication, i.drug having i.indication = 10 and i.drug = 1;
 --3100
 
 create table targetpmidprojindications as
 select p.pmid, p.target from targetpmidprojects p inner join proj_year_nodups_cases_ind i on p.target_id = i.target_id 
 where i.indication = 10 and i.target_only = 1; --107 GB?? 3/4/19 --drop table targetpmidprojindications;
 
 create table targetpmidindications as
 select p.* from targetpmids p, proj_year_nodups_cases_ind i where p.target_id = i.target_id 
 and i.indication = 10 and i.target_only = 1 limit 10;
 
 select * from targetpmids where target_id = 94 and pmid = 378;
 
 
 select count(p.pmid) from targetpmidprojects p, proj_year_nodups_cases_ind i where p.target_id = i.target_id 
 and i.indication = 10 and i.target_only = 1;
 
 --Begin cardiovascular
 
 create table cvprojects as
 select * from drugtargetinfo where indication = 'cardiovascular'; --21
 
  create table drugpmidcvindications as
 select distinct drug, drug_id, pmid, pub_year from drugpmids where drug_id in (select drug_id from cvprojects);
 --18208
 
 create table targetpmidcvindications as
 select distinct target, target_id, pmid, pub_year from targetpmids where target_id in (select target_id from cvprojects);
 --176175

 --End cardiovascular
 
 --Begin Cancer
 
-- create table cancerprojects as
-- select * from proj_year_nodups_cases_ind where indication = 3;
 --115153 --INCORRECT
 
 --drop table cancerprojects;
 
 create table cancerprojects as
 select * from proj_year_nodups_cases_ind_costs where new_indication = 'antineoplastic'; --117055 --REPEAT everything below 
 
 select distinct on (t.drug_id) t.drug, t.pmid from drugpmidprojects t, cancerprojects c on c.drug_id = t.drug_id ;
 --116263
 
 --select drug, pmid from drugpmidprojects where drug_id in (select drug_id from proj_year_nodups_cases_ind where indication = 10);
 
 
 select distinct drug, drug_id, pmid from drugpmidprojects where drug_id in (select drug_id from cancerprojects where drug = 1);
 --3100
 
 
 select distinct drug, drug_id, pmid from drugpmids where drug_id in (select drug_id from cancerprojects where drug = 1);
 --21512 (drugpmidindications) --use this

 create table targetpmidcancerindications as
 select distinct target, target_id, pmid from targetpmids where target_id in (select target_id from cancerprojects where target_only = 1);
 --660,463 use this
 
 
 select distinct target, target_id, pmid from targetpmids where target_id in (select target_id from cancerprojects where target = 1);
 --the same # as above- 660,463
 
 select distinct drug_id from cancerprojects; --59
 
 
 ----drop table targetpmidindications;
 
 create table cancerprojects as
 select * from drugtargetinfo where indication = 'antineoplastic'; --59
 
 
 create table drugpmidcancerindications as
 select distinct drug, drug_id, pmid, pub_year from drugpmids where drug_id in (select drug_id from cancerprojects);
 --22343 (drugpmidindications) --use this
 
 
 --create table targetpmidcancerindications as
 select distinct target, target_id, pmid, pub_year from targetpmids where target_id in (select target_id from cancerprojects);
 --678344
 
--end cancer


 select * from ttd.target_disease where indication = 'Cancer'; --590
 
 
 select c.*, p.activity, p.core_project_num, fy from projects_2017 p, proj_year_nodups_costs c where core_project_num = project; --41037
 
 
 --redo with projects_final
 
 ----drop table proj_year_nodups_costs_activity;
 
 select p.activity, count (p.activity) from projects_final p, proj_year_nodups_costs c where core_project_num = project and p.fy = c.year
  group by p.activity order by count desc;
 
 select sum(count) from proj_year_nodups_costs_activity;
 
 select * from proj_year_nodups_imputed_costs order by project;
 
  select p.activity, count (p.activity) from projects_final p, proj_year_nodups_costs c where core_project_num = project and drug = 1 
  group by p.activity order by count desc;

 select p.activity, count (p.activity) from projects_final p, targetpmidprojects where core_project_num = project_number group by p.activity
 order by count desc;
 
select  p.activity, count (p.activity) from projects_final p group by activity order by count desc; 

 select p.activity, count (p.activity) from projects_final p, drugpmidprojects where core_project_num = project_number group by p.activity
 order by count desc;
 
 select sum(count) from proj_year_nodups_costs_activity; --R01 > P01 > M01 > P30 > Z01
 
 select distinct (activity) from projects_final where activity = 'M01';
 
 select project, substring (project from 1 for 3) "activity" from countable_projects limit 10;
 
 select count (substring (project from 1 for 3)), substring (project from 1 for 3) "activity" from countable_projects group by activity order by count desc; 
 
 --use this
 create table proj_year_nodups_costs_activity as
 select count (substring (project from 1 for 3)), substring (project from 1 for 3) "activity" from proj_year_nodups_costs group by activity order by count desc; 
 
 select substring (project from 1 for 3) "activity", count (substring (project from 1 for 3)) as count_targetonly from proj_year_nodups_costs 
 where target_only = 1 group by activity order by count_targetonly desc; 
 
 select substring (project from 1 for 3) "activity", count (substring (project from 1 for 3)) as count_drugs from proj_year_nodups_costs 
 where drug = 1 group by activity order by count_drugs desc; 
 
 select count (substring (project from 1 for 3)), substring (project from 1 for 3) "activity" from proj_year_nodups_costs 
 group by activity order by count desc; 
 
 select indication, sum(costs) as totalcosts, sum(adj_costs) as adjtotalcosts from proj_year_nodups_cases_ind_costs group by indication
 order by totalcosts;
 
 create table indicationkey (
 indkey int primary key,
 indication varchar(50)
 )
 
 insert into indicationkey (indkey, indication)
 values
 (1,'cardiovascular'),
(2,'immunologic'),
(3,'antineoplastic'),
(4,'gastrointestinal'),
(5,'endocrine'),
(6,'anti-infective'),
(7,'central nervous system'),
(8,'metabolic'),
(9,'respiratory'),
(10,'miscellaneous');

select distinct (indication) from proj_year_nodups_cases_ind;

create table projectindications (
target_id int,
drug_id varchar(10),
project_number varchar(25),
pub_year int,
project_year varchar(25),
indication varchar(50)
)

---
--PNAS check 

create table countable_projects as
select * from proj_year_nodups_costs where year > 1999 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null); --174876

select count(project_year) from countable_projects where target_only= 1 and year < 2016 and (costs is not null or lastyearscosts is not null); --150278

select count(project_year) from countable_projects where drug= 1 and year < 2016 and (costs is not null or lastyearscosts is not null); --10031

select count(project_year) from countable_projects where year < 2016 and (costs is not null or lastyearscosts is not null); --160309

select sum(costs) from countable_projects where drug= 1 and year < 2016 and (costs is not null or lastyearscosts is not null); --9,941,239,022

select sum(costs) from countable_projects where target_only = 1 and year < 2016 and (costs is not null or lastyearscosts is not null); --76,601,881,097


select count(*) from proj_year_nodups_cases where target_only = 1; --207599

select count(*) from proj_year_nodups_costs where drug = 1; --14292


select count (distinct project_year) from countable_projects where drug= 1 and year < 2016 ;

select sum(costs) from countable_projects where costs is not null and lastyearscosts is null and year < 2016; --86,543,120,119

select sum(lastyearscosts) from countable_projects where costs is null and lastyearscosts is not null and year < 2016; --18,003,395,619


select sum(costs) from countable_projects where costs is not null and lastyearscosts is null and year < 2016 and drug = 1; --9941239022
select sum(lastyearscosts) from countable_projects where costs is null and lastyearscosts is not null and year < 2016 and drug = 1; --1799406193
--total=11740645215

alter table countable_projects
add column total_costs int;

update countable_projects
SET total_costs = 
CASE
when costs is not null and lastyearscosts is null then costs
when costs is null and lastyearscosts is not null then lastyearscosts
end;

select sum(total_costs) from countable_projects where year < 2016 and drug = 1;

alter table countable_projects
add column adj_costs int;

update countable_projects
SET adj_costs = 
CASE
when year = '2000' then total_costs * 1.39
when year = '2001' then total_costs * 1.36
when year = '2002' then total_costs * 1.33
when year = '2003' then total_costs * 1.3
when year = '2004' then total_costs * 1.27
when year = '2005' then total_costs * 1.23
when year = '2006' then total_costs * 1.19
when year = '2007' then total_costs * 1.16
when year = '2008' then total_costs * 1.11
when year = '2009' then total_costs * 1.12
when year = '2010' then total_costs * 1.1
when year = '2011' then total_costs * 1.07
when year = '2012' then total_costs * 1.05
when year = '2013' then total_costs * 1.03
when year = '2014' then total_costs * 1.01
when year = '2015' then total_costs * 1.01
when year = '2016' then total_costs
end;

select sum(adj_costs) from countable_projects where year < 2016 and target_only = 1; --102818160874

select sum(adj_costs) from countable_projects where year < 2016 and drug = 1; --12531781621

select sum(adj_costs) from countable_projects where year < 2016; --115,349,942,495

select coalesce (sum(adj_costs), 0) from countable_projects where year < 2016 --same

select c.project_year, p.target_id, p.drug_id from countable_projects c, proj_year_nodups_cases_ind p where c.project_year = p.project_year; --260584

alter table proj_year_nodups_cases_ind_costs
add column new_indication varchar(50);

alter table proj_year_nodups_cases_ind_costs
add column new_indication_symbol int;

update proj_year_nodups_cases_ind_costs p
set new_indication = d.indication
from drugtargetinfo d
where d.target_id = p.target_id;

update proj_year_nodups_cases_ind_costs p
set new_indication_symbol = d.indication_symbol
from drugtargetinfo d
where d.target_id = p.target_id;

update proj_year_nodups_cases_ind_costs p
set new_indication = null;

select distinct(new_indication), target_id from proj_year_nodups_cases_ind_costs;

select * from proj_year_nodups_cases_ind_costs where new_indication = null;

select new_indication, sum(costs) as totalcosts, sum(adj_costs) as adjusted_costs from proj_year_nodups_cases_ind_costs 
where year < 2016 group by new_indication;

--targetcluster analysis - change table name to targetclusterindications

alter table targetclusters
rename to targetclusterindications;

create table targetclusters (
target_id int,
drug_id varchar(10),
project_number varchar(25),
pub_year int,
project_year varchar(25),
uni_indication varchar(50)
)

alter table targetclusters alter column uni_indication type integer USING (uni_indication::integer);

alter table targetclusters

select distinct(uni_indication) from targetclusters;

alter table targetclusters
add column total_costs int;

update targetclusters t
set total_costs = c.total_costs
from countable_projects c
where t.project_year = c.project_year;

alter table targetclusters
add column adj_costs int;

update targetclusters t
set adj_costs = c.adj_costs
from countable_projects c
where t.project_year = c.project_year;

select uni_indication, sum(total_costs) as total_costs, sum(adj_costs) as adjusted_costs from targetclusters where pub_year < 2016 
group by uni_indication order by uni_indication;

select uni_indication, indication, sum(total_costs) as total_costs, sum(adj_costs) as adjusted_costs from targetclusters, indicationkey
where indkey = uni_indication and pub_year < 2016 group by uni_indication, indication order by indication;

alter table targetclusters
add column target_only int;

update targetclusters t
set target_only = c.target_only
from proj_year_nodups_cases c
where t.project_year = c.project_year;

alter table targetclusters
add column drug int;

update targetclusters t
set drug = c.drug
from proj_year_nodups_cases c
where t.project_year = c.project_year;

select count(*) from targetclusters where target_only = 1;  --288749 (should be ~30K)

select count(*) from targetclusters where drug = 1; --31090 (should be 16770)


select t.uni_indication, i.indication, sum(t.total_costs) as total_costs, sum(t.adj_costs) as adjusted_costs from targetclusters t, indicationkey i
where i.indkey = t.uni_indication and t.pub_year < 2016 group by t.uni_indication, i.indication order by i.indication;

select t.uni_indication, i.indication, sum(t.total_costs) as total_costs, sum(t.adj_costs) as adjusted_costs from targetclusters t, indicationkey i
where i.indkey = t.uni_indication and t.pub_year < 2016 and target_only = 1 group by t.uni_indication, i.indication order by i.indication;

select t.uni_indication, i.indication, sum(t.total_costs) as total_costs, sum(t.adj_costs) as adjusted_costs from targetclusters t, indicationkey i
where i.indkey = t.uni_indication and t.pub_year < 2016 and drug = 1 group by t.uni_indication, i.indication order by i.indication;

------

alter table targetclusters
add column all_costs int;

update targetclusters t
set all_costs = c.costs
from proj_year_nodups_costs c
where t.project_year = c.project_year;

update targetclusters t
set all_costs = c.lastyearscosts
from proj_year_nodups_costs c
where t.project_year = c.project_year
and t.all_costs is null;

alter table targetclusters
add column all_adj_costs int;

update targetclusters set all_adj_costs = null;

update targetclusters
SET all_adj_costs = 
CASE
when pub_year = '2000' then all_costs * 1.39
when pub_year = '2001' then all_costs * 1.36
when pub_year = '2002' then all_costs * 1.33
when pub_year = '2003' then all_costs * 1.3
when pub_year = '2004' then all_costs * 1.27
when pub_year = '2005' then all_costs * 1.23
when pub_year = '2006' then all_costs * 1.19
when pub_year = '2007' then all_costs * 1.16
when pub_year = '2008' then all_costs * 1.11
when pub_year = '2009' then all_costs * 1.12
when pub_year = '2010' then all_costs * 1.1
when pub_year = '2011' then all_costs * 1.07
when pub_year = '2012' then all_costs * 1.05
when pub_year = '2013' then all_costs * 1.03
when pub_year = '2014' then all_costs * 1.01
when pub_year = '2015' then all_costs * 1.01
when pub_year = '2016' then all_costs
end;

select * from targetclusters where pub_year < 2000;

select t.uni_indication, i.indication, sum(t.all_costs) as total_costs, sum(t.all_adj_costs) as adjusted_costs from targetclusters t, indicationkey i
where i.indkey = t.uni_indication and t.pub_year < 2016 group by t.uni_indication, i.indication order by i.indication;

select t.uni_indication, i.indication, sum(t.total_costs) as total_costs, sum(t.adj_costs) as adjusted_costs from targetclusters t, indicationkey i
where i.indkey = t.uni_indication and t.pub_year < 2016 group by t.uni_indication, i.indication order by i.indication;

---

select * from proj_year_nodups_cases_ind_costs where project_year = '2013K05DA016752'; --no costs

select * from targetclusters where project_year = '2013K05DA016752'; --costs from countable_projects

select * from proj_year_nodups_costs where project_year = '2013K05DA016752'; --lastyearscosts

select * from proj_year_nodups_cases_ind_costs where project_year = '1996P01HL053586';

select * from proj_year_nodups_costs where project_year = '1996P01HL053586';

select distinct(indication) from proj_year_nodups_cases_ind; --do not use these indications

---starting over

create table proj_year_nodups_imputed_costs as
select * from proj_year_nodups_costs;

create table updatedindications (
target_id int,
drug_id varchar(10),
project_number varchar(25),
pub_year int,
project_year varchar(25),
uni_indication int,
drug int,
target_only int
)

alter table updatedindications alter column uni_indication type integer USING (uni_indication::integer);

alter table proj_year_nodups_imputed_costs
add column total_costs int;

update proj_year_nodups_imputed_costs
SET total_costs = 
CASE
when costs is not null and lastyearscosts is null then costs
when costs is null and lastyearscosts is not null then lastyearscosts
end;

alter table proj_year_nodups_imputed_costs
add column adj_costs int;

update proj_year_nodups_imputed_costs
SET adj_costs = 
CASE
when year = '2000' then total_costs * 1.39
when year = '2001' then total_costs * 1.36
when year = '2002' then total_costs * 1.33
when year = '2003' then total_costs * 1.3
when year = '2004' then total_costs * 1.27
when year = '2005' then total_costs * 1.23
when year = '2006' then total_costs * 1.19
when year = '2007' then total_costs * 1.16
when year = '2008' then total_costs * 1.11
when year = '2009' then total_costs * 1.12
when year = '2010' then total_costs * 1.1
when year = '2011' then total_costs * 1.07
when year = '2012' then total_costs * 1.05
when year = '2013' then total_costs * 1.03
when year = '2014' then total_costs * 1.01
when year = '2015' then total_costs * 1.01
when year = '2016' then total_costs
end;


alter table updatedindications
add column adj_costs int;

update updatedindications
set adj_costs = null;

update updatedindications i
set total_costs = c.total_costs
from proj_year_nodups_imputed_costs c
where i.project_year = c.project_year
and pub_year > 1999;

update updatedindications i
set adj_costs = c.adj_costs
from proj_year_nodups_imputed_costs c
where i.project_year = c.project_year
and pub_year > 1999;

alter table updatedindications
add column fy_minus_pubyear int;

update updatedindications i
set fy_minus_pubyear = c.fy_minus_pubyear
from proj_year_nodups_imputed_costs c
where i.project_year = c.project_year;

--updated_indications_COSTS.csv
select k.indication, sum(i.adj_costs) as adjusted_costs from updatedindications i, indicationkey k 
where k.indkey = i.uni_indication and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null) group by k.indication;

select k.indication, sum(i.adj_costs) as adjusted_costs from updatedindications i, indicationkey k 
where k.indkey = i.uni_indication and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null) and drug = 1 group by k.indication;

select k.indication, sum(i.adj_costs) as adjusted_costs from updatedindications i, indicationkey k 
where k.indkey = i.uni_indication and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null) and target_only = 1 group by k.indication;

select distinct drug_id from updatedindications where uni_indication = '2';

select distinct drug_id from proj_year_nodups_imputed_costs order by drug_id;

--stats

 select * from projects_final where fy = 1984 limit 10;
 
 select * from targetpmids order by pub_year desc limit 20;
 
 select count(*) from targetpmids where pub_year <= 2016; --1951483
 
 select count(*) from drugpmids where pub_year <= 2016;
 
 select * from reporterpublink order by pub_year desc limit 20;
 
  
 select distinct(pmid) from drugpmids where drug_id = 'drug48'; --same
 
 select * from targetpmids where target_id = '16'; --3216
 
 select * from reporterpublink r, drugpmids d where r.pmid = d.pmid and d.drug_id = 'drug48'; --504
 
 select * from reporterpublink r, drugpmids d where r.pmid = d.pmid and r.pub_year = d.pub_year and d.drug_id = 'drug48';  --435
 
 select distinct r.project_number, r.pub_year from reporterpublink r, drugpmids d where r.pmid = d.pmid and d.drug_id = 'drug48'; --373

 select distinct r.project_number, r.pub_year from reporterpublink r, drugpmids d where r.pmid = d.pmid and r.pub_year = d.pub_year and d.drug_id = 'drug48'; --329

 
 select project_year from updatedindications where drug_id = 'drug48'; ---71
 select project_year from updatedindications where target_id = '16'; ---584
 
 select sum(total_costs) from updatedindications where drug_id = 'drug48'  and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null); --84,570,563 with year filter -> 81,917,852

 select sum(total_costs), drug_id from updatedindications where (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null) group by drug_id;
 
 select p.fy, t.drug, sum(p.total_cost), p.core_project_num
from nih_grants.projects_final p, nih_grants.uniquedrugpmidprojectyear t
where p.core_project_num = t.project_number
and p.total_cost is not null
and p.fy = t.pub_year
group by p.fy, p.core_project_num, t.drug
order by t.drug
--12669

 select p.fy, t.drug, sum(p.total_cost), p.core_project_num
from nih_grants.projects_final p, nih_grants.uniquedrugpmidprojectyear t
where p.core_project_num = t.project_number
and p.total_cost is not null
and p.fy = t.pub_year - 1
group by p.fy, p.core_project_num, t.drug
order by t.drug
--13363

 select p.fy, t.drug, sum(p.total_cost), p.core_project_num
from nih_grants.projects_final p, nih_grants.uniquedrugpmidprojectyear t
where p.core_project_num = t.project_number
and p.total_cost is not null
and p.fy - 1 = t.pub_year
group by p.fy, p.core_project_num, t.drug
order by t.drug
--9865

select count(*) from reporterpublink r, projects_final p where r.project_number = p.core_project_num and p.fy = r.pub_year; --9356066

select count(*) from reporterpublink r, projects_final p where r.project_number = p.core_project_num and p.fy = r.pub_year - 1; --9761335

select count(*) from reporterpublink r, projects_final p where r.project_number = p.core_project_num and p.fy - 1 = r.pub_year; --8326701

select total_cost, core_project_num, fy from projects_final where total_cost is not null order by fy limit 5;

select * from targetpmidprojects where pub_year > 1999 order by pmid limit 100;

--select * from drugpmidprojects where pmid = 10563328;

select * from reporterpublink where pmid = 10565004;
select * from targetpmidprojects where pmid = 10565004;  --target id 128, receptors, opioid(MeSH Terms)

--R01DA002615, R01DA006241, R01DA007242, R56DA002615

select * from projects_final where core_project_num = 'R01DA002615' and fy = 2000; --1985 - 2010, N = 26

select * from projects_final where core_project_num = 'R01DA006241' and fy = 2000; --1990 - 2016, N = 27

select * from proj_year_nodups_costs where project = 'R01DA006241' and year = 2000;

select * from updatedindications where project_number = 'R01DA006241' and pub_year = 2000;

select * from projects_final where ic_name ~* 'administration for children and families';

--target cluster cost analysis
create table targetclusters (
target_id int,
target_cluster_id int,
approval_year int,
targetname varchar(200),
drug_id varchar(10),
drugname varchar(50),
pmid int,
project_number varchar(25),
pub_year int,
pubyear_appyear_diff int,
project_year varchar(25),
first_project int,
drug int,
target_only int
)

alter table targetclusters 
add column diff int;

update targetclusters
set diff = pub_year - approval_year;

select * from targetclusters where diff <> pubyear_appyear_diff; --correct

alter table targetclusters
add column adj_costs int;

alter table targetclusters
add column total_costs int;

update targetclusters i
set adj_costs = c.adj_costs
from proj_year_nodups_imputed_costs c
where i.project_year = c.project_year
and pub_year > 1999;

update targetclusters i
set total_costs = c.total_costs
from proj_year_nodups_imputed_costs c
where i.project_year = c.project_year
and pub_year > 1999;

alter table targetclusters
add column fy_minus_pubyear int;

update targetclusters i
set fy_minus_pubyear = c.fy_minus_pubyear
from proj_year_nodups_imputed_costs c
where i.project_year = c.project_year;

select sum(i.adj_costs) as adjusted_costs from targetclusters i 
where first_project = 1 and pubyear_appyear_diff <= 0 and
(fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null);
--64627762643


select sum(i.adj_costs) as adjusted_costs from targetclusters i 
where first_project = 1 and pubyear_appyear_diff <= 0 and target_only = 1 and
(fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null);
--57589039531


select sum(i.adj_costs) as adjusted_costs from targetclusters i 
where first_project = 1 and pubyear_appyear_diff <= 0 and drug = 1 and
(fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null);
--7038723112

select distinct (drug_id) from targetclusters order by drug_id; --123

select * from targetclusters where project_year = '2000P01HL051952';

select * from proj_year_nodups_imputed_costs where project_year = '2000P01HL051952';

--DB uses BLS to 2 decimal points, spreadsheet to 4
alter table targetclusters
add column readj_costs int;

update targetclusters
SET readj_costs = 
CASE
when pub_year = '2000' then total_costs * 1.3938
when pub_year = '2001' then total_costs * 1.3552
when pub_year = '2002' then total_costs * 1.3341
when pub_year = '2003' then total_costs * 1.3044
when pub_year = '2004' then total_costs * 1.2706
when pub_year = '2005' then total_costs * 1.2289
when pub_year = '2006' then total_costs * 1.1905
when pub_year = '2007' then total_costs * 1.1575
when pub_year = '2008' then total_costs * 1.1147
when pub_year = '2009' then total_costs * 1.1187
when pub_year = '2010' then total_costs * 1.1007
when pub_year = '2011' then total_costs * 1.067
when pub_year = '2012' then total_costs * 1.0454
when pub_year = '2013' then total_costs * 1.0303
when pub_year = '2014' then total_costs * 1.0138
when pub_year = '2015' then total_costs * 1.0126
when pub_year = '2016' then total_costs
end;


select sum(i.readj_costs) as readjusted_costs from targetclusters i 
where first_project = 1 and pubyear_appyear_diff <= 0 and
(fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null);
--64625180445 vs 64627762643


select sum(i.readj_costs) as readjusted_costs from targetclusters i 
where first_project = 1 and pubyear_appyear_diff <= 0 and drug = 1 and
(fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null);
--7,038,892,813 vs 7038723112

select count(distinct("Agreement_Type")) from "mit"."Agreement_Type"; --395

select sum(i.readj_costs) as readjusted_costs from targetclusters i 
where first_project = 1 and pubyear_appyear_diff <= 0 and target_only = 1 and
(fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null);
--57,586,287,632 vs 57589039531


select count (distinct target_cluster_id) from targetclusters; --77

select count (distinct t.target_cluster_id), d.targeted_phenotypic  from targetclusters t inner join drugtargetinfo d 
on t.target_id = d.target_id group by  d.targeted_phenotypic;

select distinct t.target_cluster_id, d.targeted_phenotypic  from targetclusters t inner join drugtargetinfo d 
on t.target_id = d.target_id group by  d.targeted_phenotypic, t.target_cluster_id;

select count ( project_year) from targetclusters; --270573

select count (distinct project_year) from targetclusters; --131588
select count (distinct project_year) from targetclusters where drug = 1; --10717
select count (distinct project_year) from targetclusters where target_only = 1; --120871

select distinct on (target_cluster_id)
target_cluster_id, count (project_year) as count_projectyears, count(drug) as drug, count(target_only) as drug from targetclusters 
group by  target_cluster_id, drug, target_only;
 
select count (distinct project_year) from targetclusters where target_cluster_id = '5' and first_project = 1;

SELECT
    target_cluster_id,
    count(*) filter (where drug = 1) as drug_count,
    count(*) filter (where target_only = 1) as targetonly_count
FROM
   targetclusters where first_project = 1 and target_cluster_id = '23' group by target_cluster_id;
   
 select distinct r.project_number, r.pub_year from reporterpublink r, targetpmids d where r.pmid = d.pmid and d.target_id = '23'; --11781
 select distinct r.project_number, r.pub_year from reporterpublink r, drugpmids d where r.pmid = d.pmid and drug_id = 'drug204'; --130

 select distinct r.project_number, r.pub_year from uniquetargetpmidprojectyear r where r.target_id = '23';
 
  SELECT
    t.target_cluster_id,
    count (distinct r.project_year) filter (where r.drug = 1) as drug_count,
    count (distinct r.project_year) filter (where r.target_only = 1) as targetonly_count
FROM
   targetclusters t, proj_year_nodups_costs r where r.project_year = t.project_year and t.target_cluster_id = '23' group by target_cluster_id;
   
   --for flow chart
   select d.target, r.pmid, r.project_number, r.pub_year from nih_grants.reporterpublink r, nih_grants.targetpmids d where r.pmid = d.pmid; --587996
   
   select distinct (project_number, pub_year) from nih_grants.drugpmidprojects;

   select count( distinct project_year) from proj_year_nodups_costs where costs is not null; --132348
select count(distinct project_year) from proj_year_nodups_imputed_costs where costs is not null and year between 2000 and 2015;
   
   select count(distinct project_year) from proj_year_nodups_imputed_costs where lastyearscosts is not null; --84679
   
   select count(distinct project_year) from proj_year_nodups_imputed_costs where lastyearscosts is not null and year < 2000; --16232
   
   select count(distinct project_year) from proj_year_nodups_imputed_costs where lastyearscosts is not null and year < 2000
   and fy_minus_pubyear > 0; --13643
   
   select count(distinct project_year) from proj_year_nodups_imputed_costs where fy_minus_pubyear > 0; --40055
   
select count(distinct project_year) from proj_year_nodups_imputed_costs where costs is not null and year between 2000 and 2015 and 
fy_minus_pubyear is null;

select count(*) from proj_year_nodups_costs where year between 2000 and 2015 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null); --174876

select count(project_year) from countable_projects where costs is not null; --132,348

select count(project_year) from countable_projects where lastyearscosts is not null; --40607
select count(distinct project_year) from proj_year_nodups_imputed_costs where lastyearscosts is not null; --84679

select count(project_year) from countable_projects where lastyearscosts is not null and year < 2016; --35545
select count(project_year) from countable_projects where year < 2016 and (costs is not null or lastyearscosts is not null);

select count(distinct project_year) from proj_year_nodups_imputed_costs where lastyearscosts is not null and year between 2000 and 2016; --68447

select count(distinct project_year) from proj_year_nodups_imputed_costs where lastyearscosts is not null and year between 2000 and 2015 and
(fy_minus_pubyear = -1 or fy_minus_pubyear = -2 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null); --40607

select count(distinct project_year) from proj_year_nodups_imputed_costs where lastyearscosts is null and costs is null; --4864

--new check Venetoclax
 select * from targetpmids where target = 'Bcl-2' order by pub_year desc; --57362
 select * from drugtargetinfo where target_id = '23';
 select * from drugpmids where drug_id = 'drug204' order by pub_year; --286 pmids
 
 select r.pmid from reporterpublink r, targetpmids d where r.pmid = d.pmid and d.target_id = '23'; --15241, same with r.project_number (7550 unique)
 select r.project_number from reporterpublink r, drugpmids d where r.pmid = d.pmid and drug_id = 'drug204'; --164
 
 select distinct r.project_number, r.pub_year from reporterpublink r, targetpmids d where r.pmid = d.pmid and d.target_id = '23'; --11781 X
 select distinct r.project_number, r.pub_year from reporterpublink r, drugpmids d where r.pmid = d.pmid and drug_id = 'drug204'; --130
 
select count(c.project_year) from countable_projects c inner join uniquedrugpmidprojectyear u on c.project = u.project_number and 
c.year = u.pub_year where c.year < 2016 and (costs is not null or lastyearscosts is not null) and u.drug = 'Venetoclax'; --99

select count(c.project_year) from countable_projects c inner join uniquetargetpmidprojectyear u on c.project = u.project_number and 
c.year = u.pub_year where c.year < 2016 and (costs is not null or lastyearscosts is not null) and u.target = 'Bcl-2'; --11882

select count(project_year) from targetclusterindications where all_adj_costs is not null and target_id = '23'; --8730 vs 10042
select count(project_year) from targetclusterindications where adj_costs is not null and drug_id = 'drug204'; --103 vs 111

select count(project_year) from targetclusters where adj_costs is not null and target_id = '23'; --14303 X
select count(project_year) from targetclusters where adj_costs is not null and drug_id = 'drug204'; --164 X
 

create table targetclusters_610K (
target_id int,
target_cluster_id int,
first_in_class int,
approval_year int,
targetname varchar(200),
drug_id varchar(10),
drugname varchar(50),
pmid int,
project_number varchar(25),
pub_year int,
pubyear_appyear_diff int,
project_year varchar(25),
first_project int,
drug int,
target_only int,
adj_costs int,
drug_costs int,
target_costs int
)--18

select count(project_number) from targetclusters_610K where target_id = '23';  --15405

select count(project_number) from targetclusters_610K where first_project = 1 and target_id = '23';  --11794 same for target_cluster_id = '23'
select count(project_number) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '23';  --11794

select count(project_year) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '23' and target_only = 1;  --11664 (--originally project_number count (same #))
select count(project_year) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '23' and drug = 1; --130

select count(project_year) from targetclusters_610K where target_id = '23' and first_project = 1 and adj_costs is not null; --9574 --originally project_number count (same #)

select count(project_number) from targetclusters_610K where (target_id = '23' or drug_id = 'drug204') and first_project = 1 and adj_costs is not null;

select count(project_number) from targetclusters_610K where first_project = 1 and drug_id = 'drug204'; --13

select count(project_number) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '23' 
and adj_costs is not null;  --9574

select count(project_number) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '23' 
and target_only = 1 and adj_costs is not null;  --9452

select count(project_number) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '23' 
and drug = 1 and adj_costs is not null;  --122

select count(project_number) from targetclusters_610K where first_project = 1 and drug_id = 'drug204' and adj_costs is not null; --13

select count(distinct drug_id) from drugpmidprojects;  --198
select count(distinct target_id) from targetpmidprojects;  --151

select count (distinct t.target_cluster_id), d.targeted_phenotypic  from targetclusters t inner join drugtargetinfo d 
on t.target_id = d.target_id group by  d.targeted_phenotypic;

select distinct t.target_cluster_id, d.targeted_phenotypic  from targetclusters t inner join drugtargetinfo d 
on t.target_id = d.target_id group by  d.targeted_phenotypic, t.target_cluster_id;

create table master (
drug text not null,
drug_id varchar,
target text,
target_id int,
target_cluster int,
NCE_Biologic int,
Targeted_phenotypic int,
FirstInclass_Followon int,
approval_year int,
indication text,
indication_symbol int
);

--for PNAS map viz

select f.org_state, f.org_district, count(distinct p.project_year) as unique_funding_year_count from proj_year_nodups_costs p, projects_final f where f.core_project_num = p.project
and f.fy=p.year and org_district is not null group by org_state, org_district order by org_state, org_district;

select f.org_state, count (distinct p.project_year) as unique_funding_year_count from proj_year_nodups_costs p, projects_final f where f.core_project_num = p.project
and f.fy=p.year and org_state is not null group by org_state order by unique_funding_year_count desc;

 --Update final versions
 
 --truncate table master;
 
 \copy nih_grants.master from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT-GrantSupportProject/Final_Master_12-17_inDB.csv' with csv header delimiter ',';
 
 --truncate table nih_grants.targetclusters_610K;
 
 \copy nih_grants.targetclusters_610K from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT-GrantSupportProject/Outputs/160K_targetclustercosts.csv' with csv header delimiter ',';
 
 update drugtargetinfo
 set indication = m.indication 
 from master m
 where drugtargetinfo.drug_id = m.drug_id;
 
 update drugtargetinfo
 set indication_symbol = m.indication_symbol
 from master m
 where drugtargetinfo.drug_id = m.drug_id;
 
 update drugtargetinfo
 set firstinclass_followon = m.firstinclass_followon
 from master m
 where drugtargetinfo.drug_id = m.drug_id;
 
 create table version (
 version_no varchar(100) primary key,
 download_date date not null
 )
 
 insert into version(version_no, download_date)
 values ('v1', '2017-04-01');
 
 alter table projects_final 
 add column version varchar(100);
 
 update projects_final 
 set version = 'v1';
 
 --new search VENETOCLAX (drug 204)/BCL-2 (23)
 
  select * from drugtargetinfo where target_id = '23';
  
 --PMIDS
select * from targetpmids where target = 'Bcl-2' order by pub_year desc; --57362
select * from drugpmids where drug_id = 'drug204' order by pub_year; --286 pmids
 
--# Citations with NIH funding
 select r.pmid from reporterpublink r, targetpmids d where r.pmid = d.pmid and d.target_id = '23'; --15241, same with r.project_number
 select r.project_number from reporterpublink r, drugpmids d where r.pmid = d.pmid and drug_id = 'drug204'; --164

--Unique funding years  
select count(project_number) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '23' 
and drug=1; target_only = 1;  --11664 (drug = 130)

--Costs
select count(project_number) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '23' 
and adj_costs is not null;  --9574

select count(project_number) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '23' 
and target_only = 1 and adj_costs is not null;  --9452

select count(project_number) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '23' 
and drug = 1 and adj_costs is not null;  --122

--Palbociclib (drug141)/cdk4 or cdk6 (41)

  select * from drugtargetinfo where target_id = '41';
  
   --PMIDS
select * from targetpmids where target_id = '41' order by pub_year desc; --6495
 select * from drugpmids where drug_id = 'drug141' order by pub_year; --300 pmids
 
--# Citations with NIH funding
 select r.pmid from reporterpublink r, targetpmids d where r.pmid = d.pmid and d.target_id = '41'; --2328
 select r.project_number from reporterpublink r, drugpmids d where r.pmid = d.pmid and drug_id = 'drug141'; --193

--Unique funding years  
select count(project_number) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '41' 
and target_only = 1;  --1938 (drug = 1: 184)

--Costs
select count(project_number) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '41' 
and adj_costs is not null;  --1723

select count(project_number) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '41' 
and target_only = 1 and adj_costs is not null;  --1555

select count(project_number) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '41' 
and drug = 1 and adj_costs is not null;  --168

--Vismodegib (drug207)/hedgehog signaling OR (hedgehog AND Drosophila) - 76

  select * from drugtargetinfo where target_id = '76';
  
   --PMIDS
select count(*) from targetpmids where target_id = '76'; --8633
select count(*) from drugpmids where drug_id = 'drug207'; --442 pmids
 
--# Citations with NIH funding
 select r.pmid from reporterpublink r, targetpmids d where r.pmid = d.pmid and d.target_id = '76'; --5714
 select r.project_number from reporterpublink r, drugpmids d where r.pmid = d.pmid and drug_id = 'drug207'; --214

--Unique funding years  
select count(project_number) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '76' 
and target_only = 1;  --4502 (drug = 1: 198)

--Costs
select count(project_number) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '76' 
and adj_costs is not null;  --4117

select count(project_number) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '76' 
and target_only = 1 and adj_costs is not null;  --3926

select count(project_number) from targetclusters_610K where first_project = 1 and first_in_class = 1 and target_cluster_id = '76' 
and drug = 1 and adj_costs is not null;  --181

create schema reporter;

create table reporter.patents (
Patent_ID varchar(20),
Patent_title text,
Project_ID varchar(50),
Patent_org_name varchar(200),
primary key (Patent_ID, Project_ID)
)

\copy reporter.patents from '/Users/Katniss/Dropbox (ScienceandIndustry)/CENTER - Database Files/RePORTER Patent Data/RePORTER_PATENTS_C_ALL.csv' csv header delimiter ',';
COPY 43477


select count (distinct pmid) from pubmed.citation; --26,758,794 

select count (distinct pmid) from nih_grants.reporterpublink; --1,380,121

select count (distinct project_number) from nih_grants.reporterpublink; --129,728


select table_schema, table_name from information_schema.columns where table_name LIKE '%cancer%';

select distinct(project_year) from proj_year_nodups_imputed_costs
where target = 1;  --219,586/61,753

select count(*) from proj_year_nodups_imputed_costs
where drug = 1;  --14292

select count(*) from proj_year_nodups_imputed_costs
where target_only = 1;  --207599

select count(*) from proj_year_nodups_imputed_costs
where bothdrtg = 1;  --11987

select distinct(t.project_year) from proj_year_nodups_imputed_costs p, targetclusterindications t
where p.project_year = t.project_year and p.target = 1 and t.uni_indication = 3;  --116308

select distinct(t.project_year) from proj_year_nodups_imputed_costs p, targetclusterindications t
where p.project_year = t.project_year and p.drug = 1 and t.uni_indication = 3;  --9647

select distinct(t.project_year) from proj_year_nodups_imputed_costs p, targetclusterindications t
where p.project_year = t.project_year and p.target_only = 1 and t.uni_indication = 3;  --107644

select pmid from targetpmidcancerindications;

select pmid from drugpmidcancerindications;

--select sum(adj_costs), new_indication from proj_year_nodups_cases_ind_costs group by new_indication;

select sum(adj_costs) from updatedindications where uni_indication = 3;

select sum(adj_costs), count(project_year) from updatedindications where uni_indication = 3;

--for ACSCAN
create view all_indications_costs as
select k.indication, sum(i.adj_costs) as adjusted_costs, count(roject_year) from updatedindications i, indicationkey k 
where k.indkey = i.uni_indication and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null) group by k.indication;

select sum(adjusted_costs) from all_indications_costs; --231,888,560,535

select sum(i.adj_costs) as adjusted_costs, count(project_year) from updatedindications i, indicationkey k 
where k.indkey = i.uni_indication and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null) and uni_indication = 3 group by k.indication;
--Antineoplastic 76,163,061,889 (97,853 projects)

create view cancer_indications_acscan as 
select i.adj_costs, project_number from updatedindications i, indicationkey k 
where k.indkey = i.uni_indication and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null) and uni_indication = 3;

create view cancer_indications_acscan_targetonly as
select i.adj_costs, project_number from updatedindications i, indicationkey k 
where k.indkey = i.uni_indication and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null) and target_only = 1 and uni_indication = 3;

--drop view cancer_indications_acscan;

--count each grant type
 select count (substring (project_number from 1 for 3)), substring (project_number from 1 for 3) "activity" from cancer_indications_acscan_targetonly group by activity order by count desc; 
 
 select * from master where indication_symbol = 3;
 
 select count(*) from reporterpublink r, targetpmidcancerindications t where r.pmid = t.pmid; --255,755
 
 select count(*) from reporterpublink r, drugpmidcancerindications t where r.pmid = t.pmid; --8679
 
 select distinct(target) from targetpmidcancerindications; --41
 select distinct(drug) from drugpmidcancerindications; --59
 
 select distinct(target) from uniquetargetpmidprojectyear; --151 
 select distinct(drug) from uniquedrugpmidprojectyear; --198
 
select count (distinct(project_number, pub_year)) from uniquedrugpmidprojectyear u inner join master m on m.drug = u.drug and indication_symbol = 3; --4728
 
select count (distinct(project_number, pub_year)), indication_symbol from uniquedrugpmidprojectyear u inner join master m on m.drug = u.drug 
group by indication_symbol ; --adds up to 15282
  
select count (distinct(project_number, pub_year)) from uniquetargetpmidprojectyear u inner join master m on m.target_id = u.target_id and indication_symbol = 3; 
 --115,113
 
select sum(adj_costs), count(project_number) from cancer_indications_acscan; --76,163,061,889/97,853

select * from targetclusters_610k where target_only = 1 limit 10;

select t.* from targetclusters_610k t inner join master m on m.drug_id = t.drug_id and t.target_id = m.target_id where t.drug = 1
and m.target_cluster = t.target_cluster_id and indication_symbol = 3 --3056 (10,198 w/out filter)

select count(distinct project_year), uni_indication from targetclusterindications --where drug = 1 
group by uni_indication; --9647

select sum(adj_costs), sum(all_adj_costs), uni_indication from targetclusterindications where drug = 1 group by uni_indication;

select count(distinct project_year) from targetclusterindications where target_only = 1 and uni_indication = 3; --107,644
--and adj_costs is not null

select sum(adj_costs) from targetclusterindications where drug = 1 and uni_indication = 3; --11,886,076,327

--select sum(adj_costs) from proj_year_nodups_cases_ind_costs where year < 2016;

select sum(adj_costs) from targetclusters_610k where drug = 1 and first_in_class = 1; --26,310,767,083; 19,156,613,249


 select sum(adj_costs) as costs, count(distinct project_year) as proj, uni_indication from targetclusterindications --where pub_year < 2016
 group by uni_indication order by costs desc ;
        
 select sum(adj_costs) as costs, count(distinct project_year) as proj, uni_indication from targetclusterindications --where pub_year < 2016
 group by uni_indication order by costs desc ;

select sum(adj_costs) from countable_projects where year < 2016; --115349942495

select sum(adj_costs) from updatedindications where pub_year < 2016;

select * from master where indication_symbol = 3 and firstinclass_followon = 1;  --24

select pub_year, sum(adj_costs) from updatedindications where uni_indication = 3 and pub_year > 1999 group by pub_year;

select pub_year, sum(adj_costs) from updatedindications where pub_year > 1999 group by pub_year;

select distinct(target_cluster_id), sum(target_costs) from targetclusters_610k 
where target_costs is not null group by target_cluster_id order by target_costs desc;

 --Xtandi (Enzalutamide) 12/18 (not first in class, target cluster has only 1 target)
 select count(*) from targetpmids where target = 'androgen receptor' order by pub_year desc; --24601 target PMIDs
 select * from drugtargetinfo where target_id = '17';
 select * from drugpmids where drug_id = 'drug75' order by pub_year; --987 drug pmids 

 select r.pmid from reporterpublink r, targetpmids d where r.pmid = d.pmid and d.target_id = '17'; --8133, same with r.project_number
 select r.project_number from reporterpublink r, drugpmids d where r.pmid = d.pmid and drug_id = 'drug75'; --438
 
 select count (project_year) from targetclusters_610K where first_project = 1 and target_cluster_id = '17' and target_only = 1;  --5691 (drug75) --removed first_in_class = 1 (same # with disctinct)
  select count (project_year) from targetclusters_610K where first_project = 1 and target_cluster_id = '17' and drug = 1; --330 (same # with disctinct)

 select distinct r.project_number, r.pub_year from reporterpublink r, drugpmids d where r.pmid = d.pmid and drug_id = 'drug75'; --330 --same as above 
 

select count(project_number) from targetclusters_610K where target_id = '17' and first_project = 1 and adj_costs is not null; --4997

select count(project_number) from targetclusters_610K where first_project = 1 and target_cluster_id = '17' 
and target_only = 1 and adj_costs is not null;  --4695 (--removed first_in_class = 1)

select count(project_number) from targetclusters_610K where first_project = 1 and target_cluster_id = '17' 
and drug = 1 and adj_costs is not null;  --302 (--removed first_in_class = 1)

select distinct(pub_year) from targetclusters_610K where adj_costs is not null; --2000-2016

select distinct(pub_year) from targetclusters_610K where adj_costs is null; --1980-2016

select count(project_year) from countable_projects where target_only= 1 and year < 2016 and (costs is not null or lastyearscosts is not null); --150278

select count( distinct project_year) from targetclusters_610K where target_only= 1 and adj_costs is not null; --and (pub_year < 2016) --169,284

--create view xtandi_target_costs as
select sum(adj_costs) from targetclusters_610K where first_project = 1 and target_only= 1 having count( distinct project_year) > 1; -- 370,115,206,142 X

select count(project_year) from countable_projects where drug= 1 and year < 2016 and (costs is not null or lastyearscosts is not null); --10031

select sum(adj_costs) from countable_projects where year < 2016 and target_only = 1; --102,818,160,874
select sum(adj_costs) from countable_projects where year < 2016 and drug = 1; --12,531,781,621
select sum(adj_costs) from countable_projects where year < 2016; --115,349,942,495

--LINK countable_projects and targetclusters_610K

select sum(c.adj_costs) from countable_projects c left join targetclusters_610K t on c.project_year = t.project_year and c.year = t.pub_year
and t.project_number = c.project where year < 2016 and c.target_only = 1 and first_project = 1 group by target_id;
--sum(c.adj_costs)
--and c.drug = 1
--and t.project_year is null --124,274,944,677

select sum(c.adj_costs), t.target_cluster_id from countable_projects c inner join targetclusters_610K t on c.project_year = t.project_year and c.year = t.pub_year
where year < 2016 and c.target_only = 1 and first_project = 1 group by target_cluster_id;

drop view xtandi;
create view xtandi as
select * from targetclusters_610K where target_cluster_id = '17';

select sum(adj_costs) from xtandi where target_only = 1; --5,875,302,659

select sum(c.adj_costs) from countable_projects c inner join xtandi x on c.project_year = x.project_year 
--where c.target_only = 1 --5430220149
where x.target_only = 1 --5,873,794,809
--and year < 2016 --5548349379

select sum(c.adj_costs) from countable_projects c inner join xtandi x on c.project_year = x.project_year 
--where c.target_only = 1
where x.drug = 1 --507,541,559
and year < 2016 -- 386,536,674

select sum(c.adj_costs) from countable_projects c where  c.project_year in (select x.project_year from xtandi x) and
c.target_only = 1; --4,077,633,050 X

select sum(x.adj_costs) from xtandi x where x.project_year in (select c.project_year from countable_projects c)
and x.target_only = 1 --5,875,302,659
and x.pub_year < 2016 --5,549,857,229 !

select sum(x.adj_costs) from xtandi x where x.project_year in (select c.project_year from countable_projects c)
and x.drug = 1 --508,081,704
and x.pub_year < 2016 --387,076,819 !

select c.*, t.target_id from countable_projects c left join targetpmidprojects t on c.project = t.project_number
and c.year = t.pub_year where t.project_number is null --year < 2016 and target_only = 1; 
select sum(adj_costs) from xtandi where year < 2016 and target_only = 1; --0

 
 --Daclatasvir, drug52 4/12, target: hcv ns5a; target id = 74; target cluster 203 (has 5 other hcv targets); phenotypic; follow-on
 
 select * from master where target_cluster = '203';
 
 select * from targetclusters_610K where target_cluster_id = '203'; --3898
  
 select * from targetclusters_610K t inner join master m on m.target_id = t.target_id and m.target_cluster = t.target_cluster_id where target_cluster_id = '203'; --7262
 
 --1.  PMIDs
 select count(*) from targetpmids where target_id = '74'; --1691 (3 drugs against hcv ns5a)
 select * from drugpmids where drug_id = 'drug52' order by pub_year; --618 drug pmids 
 
 --2.NIH funded citations
 
 select r.pmid from reporterpublink r, targetpmids d where r.pmid = d.pmid and d.target_id = '74'; --504
 select r.project_number from reporterpublink r, drugpmids d where r.pmid = d.pmid and drug_id = 'drug52'; --95
 
 --3. Project - year if 1 target in cluster
select count (project_year) from targetclusters_610K where first_project = 1 and target_cluster_id = '203' and target_only = 1;  --738
select count (project_year) from targetclusters_610K where first_project = 1 and target_cluster_id = '203' and drug = 1; --335
--OR--
 select distinct r.project_number, r.pub_year from reporterpublink r, drugpmids d where r.pmid = d.pmid and drug_id = 'drug52'; --75
 
  
 --3. Project - year if >1 target in cluster
-- select count (project_year) from targetclusters_610K where first_project = 1 and target_id = '74' and target_only = 1; --0 (#73 has 337)
-- select * from targetclusters_610K where first_project = 1 and target_id = '74' and drug = 1; --9
-- select distinct r.project_number, r.pub_year from reporterpublink r, drugpmids d where r.pmid = d.pmid and drug_id = 'drug52'; --75
 
--4. Costs

select count(project_number) from targetclusters_610K where target_cluster_id = '203' and first_project = 1 and adj_costs is not null; --908

select count(project_number) from targetclusters_610K where first_project = 1 and target_cluster_id = '203' and target_only = 1 and adj_costs is not null;  --609 (--removed first_in_class = 1)

select count(project_number) from targetclusters_610K where first_project = 1 and target_cluster_id = '203' and drug = 1 and adj_costs is not null;  --299 (--removed first_in_class = 1)

create view hcvns as
select * from targetclusters_610K where target_cluster_id = '203';

select sum(x.adj_costs) from hcvns x where x.project_year in (select c.project_year from countable_projects c) and x.target_only = 1 
and x.pub_year <= 2007; --733,228,314 (<2016) vs 180,183,201

select sum(x.adj_costs) from hcvns x where x.project_year in (select c.project_year from countable_projects c) and x.drug = 1 and 
x.pub_year <= 2007; --400,222,384 (<2016) vs 1,613,466

select sum(x.adj_costs), drugname, m.approval_year, firstinclass_followon from hcvns x inner join master m on x.drug_id = m.drug_id where x.project_year in 
(select c.project_year from countable_projects c) and x.drug = 1 group by drugname, m.approval_year, firstinclass_followon order by m.approval_year;

select sum(x.adj_costs), firstinclass_followon from targetclusters_610K x inner join master m on x.drug_id = m.drug_id group by firstinclass_followon;
--finc: 24,697,112,333; follow-on 16,670,296,660

select sum(x.adj_costs), first_in_class from targetclusters_610K x group by first_in_class;
--finc: 329,297,260,472; follow 336,328,389,455

select sum(x.adj_costs), approval_year, first_in_class from targetclusters_610K x group by first_in_class, approval_year 
order by first_in_class, approval_year;

select count(*) from projects_final where administering_ic = 'CA'; 
--org_name = NCI COMMUNITY ONCOLOGY RESEARCH PROGRAM and NCI-NATIONAL CANCER INSTI

select distinct org_name, count(c.project_number) as projcount from projects_final p inner join cancer_indications_acscan c on c.project_number = p.core_project_num
group by org_name order by projcount desc;

  --create table proj_year_nodups_costs_org as
select t.*, c.administering_ic, c.org_name, c.org_country, c.org_fips, c.org_state, c.org_zipcode, c.org_district, sum(c.total_cost) as costs from proj_year_nodups_cases t 
LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where t.year IS NOT NULL and administering_ic = 'CA'
group by t.project, t.year, t.first_proj, t.drug, t.target, t.target_only, t.bothdrtg, t.project_year, org_name, 
c.org_fips, c.org_state, administering_ic, c.org_zipcode, c.org_district, c.org_country order by project_year desc; 

--begin cancer

select distinct administering_ic, count(c.project_year) as projcount from projects_final p inner join cancerprojects c on c.project = p.core_project_num
group by administering_ic order by projcount desc; -- RR, CA, DK (41 total)

select distinct administering_ic, count(c.project_year) as projcount from projects_final p inner join cancerprojects c on c.project = p.core_project_num
where drug = 1 group by administering_ic order by projcount desc; --CA, RR, AI (N = 34)

select distinct administering_ic, count(c.project_year) as projcount from projects_final p inner join cancerprojects c on c.project = p.core_project_num
where target_only = 1 group by administering_ic order by projcount desc; --RR, CA, DK (N = 41)

select distinct administering_ic, year, count(c.project_year) as projcount from projects_final p inner join cancerprojects c on c.project = p.core_project_num
group by administering_ic, year order by administering_ic, year desc;

select distinct(m.drug) from cancerprojects c inner join master m on c.target_id = m.target_id where firstinclass_followon = 1
and  m.indication = 'antineoplastic'; --23 first-in-class? +31

select distinct(drug) from master where firstinclass_followon = 0 and indication = 'antineoplastic'; --24 + 35

select distinct(m.drug_id) from cancerprojects m; --43 (40 targets) --16 drugs missing?

select uni_indication, count(distinct project_year), sum(adj_costs) from targetclusterindications group by uni_indication; --USE THIS WITH Therapeutic Area Indications

select pub_year, sum(adj_costs) from targetclusterindications where uni_indication = 3 and pub_year > 1999 group by pub_year order by pub_year; --76163061889

select count(distinct project_year), sum(adj_costs) from targetclusterindications where uni_indication = 3 and pub_year between 1999 and 2016; --110,805 -doesn't match

select pub_year, sum(adj_costs) from targetclusterindications where pub_year > 1999 group by pub_year order by pub_year;

select t.pub_year, sum(t.adj_costs) from targetclusterindications t inner join targetclusters_610k c on t.project_year = c.project_year
where t.pub_year > 1999 and uni_indication = 3 group by t.pub_year order by t.pub_year; --doesn't add up

select distinct(drug_id) from targetclusterindications where uni_indication = 3 ; --39 cancer drugs

select sum(adj_costs) from targetclusters_610k where first_in_class = 1; --329297260472 (does not match Table 3)

select count(distinct drug_id) from targetclusters_610k where first_in_class = 1; --124??

select targeted_phenotypic, count(targeted_phenotypic) from master where indication_symbol = 3 group by targeted_phenotypic;

--Keytruda (drug127) - Optivo (drug149)

 select count(*) from targetpmids where target_id = 115; --2941 PMIDs

 select count(r.pmid) from reporterpublink r, targetpmids d where r.pmid = d.pmid and d.target_id = '115'; --2378
 
 select count (project_year) from targetclusters_610K where first_project = 1 and target_cluster_id = '115' and target_only = 1; --1787
 
select count(project_number) from targetclusters_610K where target_cluster_id = '105' and first_project = 1 --and adj_costs is not null; --3870 vs 3367

create view pdc as
select * from targetclusters_610K where target_cluster_id = '115';

select sum(x.adj_costs) from pdc x where x.project_year in (select c.project_year from countable_projects c) and x.target_only = 1 
and pub_year < 2016; --2,138,831,728 --use this

select sum(x.adj_costs) from pdc x where x.project_year in (select c.project_year from countable_projects c) and x.drug = 1 and pub_year < 2016; --326,737,598

select sum(c.adj_costs) from countable_projects c inner join pdc x on c.project_year = x.project_year 
where x.target_only = 1 --2,137,241,096
and year < 2016; 

--new

select * from projects_final order by fy desc limit 10; --2016 (projects_final contains 2016 data)

select * from projects_after_2012 order by fy desc limit 10; --2016

select distinct(fy) from projects_2017; --2011 - 2017

alter schema reporter rename to reporterpatents;

--NIH Reporter updated project files starting with 2012 (updated on 4/17/2018); 2014 and on have an extra column (ORG_IPF_CODE) that I deleted.

select * from projects_after_2012 order by fy limit 10;

create schema nih_grants_followup;

create table nih_grants_followup.reporterpublink (like reporterpublink including all);

create table nih_grants_followup.projects_after_2012 (like projects_after_2012 including all);

create table nih_grants_followup.version (like version including all);

create table nih_grants_followup.projects_final as
select * from projects_final;

alter table nih_grants_followup.projects_final
drop column version;


alter table projects_after_2012
--alter column support_year type int using (support_year::integer),
alter column direct_cost_amount type int using (direct_cost_amount::integer),
alter column indirect_cost_amount type int using (indirect_cost_amount::integer),
alter column total_cost type int using (total_cost::integer),
alter column total_cost_sub_project type int using (total_cost_sub_project::integer);

select * from projects_after_2012 where support_year = 'WC';

create drop table projects_final_test as
select * from projects_final limit 1000;

alter table projects_final alter column support_year type text;

insert into projects_final_test
select * from projects_after_2012
where not exists (
select * from projects_final_test
where application_id = projects_after_2012.application_id)

select count(application_id) from  projects_after_2012; --610757

select count(application_id) from  projects_final_test; --611757

select application_id from  projects_final_test order by application_id; --no dups

insert into projects_final
select * from projects_after_2012
where not exists (
select * from projects_final
where application_id = projects_after_2012.application_id)

select count(application_id) from  nih_grants.projects_final; --2,223,288

select count(application_id) from  projects_final; --2,456,846 - an additional 233, 558 app_ids added (should it be 2,834,045? - a diff of 377,199, but we expect duplicates)

alter table projects_final
add primary key (application_id) -- appears there are no duplicates

alter table reporterpublink
add primary key (pmid, project_number, pub_year)

select count(pmid) from reporterpublink; --5438233 - doubled from 2710959

create table drugpmids (
pmid int,
pub_year int,
drug_id varchar(20),
primary key (pmid, drug_id) )

\copy nih_grants_followup.drugpmids from '/Users/Katniss/Dropbox (ScienceandIndustry)/PROJECT-GrantSupportProject/2019 FOLLOW-ON/Pubmed ID data/drugs_20200205/drugscombined.csv' with csv header delimiter ',';
--removed years after 2020 and duplicates (=634,414)

select count(distinct pmid) from nih_grants_followup.drugpmids; --385,572

select count( pmid) from drugpmids; --634,414 (before: 131,092)

select count( distinct pmid) from nih_grants.targetpmids;

select count(*) from drugpmids inner join reporterpublink on drugpmids.pmid = reporterpublink.pmid; --170322

select d.drug_id, r.pmid, r.project_number, r.pub_year from reporterpublink r, drugpmids d where r.pmid = d.pmid; --170,322

create table drugpmidprojects as
select d.drug_id, r.pmid, r.project_number, r.pub_year from reporterpublink r inner join drugpmids d on r.pmid = d.pmid; --138383

--create table uniquedrugpmidprojectyear as
select distinct project_number, pub_year, pmid, drug_id from drugpmidprojects;  --170,322

 select count (distinct drug_id) from drugpmidprojects; --299
 select count (distinct drug_id) from drugpmids; --356

--select d.target, r.pmid, r.project_number, r.pub_year from reporterpublink r, targetpmids d where r.pmid = d.pmid;

create table targetpmids (
pmid float, --int was out of range for cases like 201020948845
pub_year int,
target_id varchar(20),
primary key (pmid, target_id) )

create table targetpmidprojects as
select d.target_id, r.pmid, r.project_number, r.pub_year from reporterpublink r inner join targetpmids d on r.pmid = d.pmid; --1,626,564

select count(*) from targetpmidprojects; --1626564
 select count (distinct target_id) from targetpmidprojects; --220
 select count (distinct target_id) from targetpmids; --220
 
 select count( pmid) from targetpmids; --3410840 (before: 1966481)

select distinct project_number, pub_year, pmid, drug_id from drugpmidprojects; --170,322 (vs 22,706)

select distinct project_number, pub_year, pmid, target_id from targetpmidprojects;  --1,745,694 (vs 587966)

create table uniquedrugpmidprojectyear as 
select distinct project_number, pub_year, pmid, drug_id from drugpmidprojects;

select count(distinct(project_number, pub_year)) from uniquedrugpmidprojectyear ; --76035 vs 14292

create  table uniquetargetpmidprojectyear as 
select distinct project_number, pub_year, pmid, target_id from targetpmidprojects;

select count(distinct(project_number, pub_year)) from uniquetargetpmidprojectyear ; --target - need target only


select count(pmid), pub_year, drug_id, drug from drugpmids group by pub_year, drug_id, drug order by drug_id, pub_year;

select count(pmid), pub_year from drugpmids where pub_year < 2017 group by pub_year order by pub_year;

select count(pmid), pub_year from nih_grants_followup.drugpmids where pub_year < 2017 group by pub_year order by pub_year;

select count(d1.pmid) as count_2016, count(d2.pmid) as count_2019, d1.drug_id, d1.drug from drugpmids d1 inner join nih_grants_followup.drugpmids d2 on d1.drug_id = d2.drug_id 
where d1.pub_year < 2017 group by d1.pub_year, d1.drug_id, d1.drug order by d1.pub_year;

select count(d1.pmid) as count_2016, count(d2.pmid) as count_2019, d1.drug_id, d1.drug from drugpmids d1 inner join nih_grants_followup.drugpmids d2 on d1.drug_id = d2.drug_id 
where d2.pub_year < 2017 group by d1.drug_id, d1.drug;

select count(d1.pmid) as count_2016, count(d2.pmid) as count_2019, d1.drug_id from drugpmids d1 inner join nih_grants_followup.drugpmids d2 on d1.drug_id = d2.drug_id 
where d2.pub_year < 2017 group by d1.drug_id;

select count(pmid) from drugpmids where drug_id = 'drug1'; --601

select count(pmid) from nih_grants_followup.drugpmids where drug_id = 'drug1'; --2125

select count(pmid) as count_2016, drug_id from drugpmids group by drug_id order by drug_id;

select count(pmid) as count_2019, drug_id from nih_grants_followup.drugpmids group by drug_id order by drug_id;

select count(d.pmid), count(e.pmid) as count_2016, e.drug_id from drugpmids d left join nih_grants_followup.drugpmids 
e on d.drug_id = e.drug_id group by e.drug_id;

select count(pmid) as count_2016, target_id from targetpmids group by target_id order by target_id;

select count(pmid) as count_2019, target_id from nih_grants_followup.targetpmids group by target_id order by target_id;


SELECT 'table_2016' AS table_name, COUNT(pmid), drug_id FROM drugpmids group by drug_id
UNION
SELECT 'table_2019' AS table_name, COUNT(pmid), drug_id FROM nih_grants_followup.drugpmids_beforetrimming group by drug_id

alter table drugpmids
rename to drugpmids_beforetrimming

alter table targetpmids
rename to targetpmids_beforetrimming

create table drugpmids (like drugpmids_beforetrimming including all)

create table targetpmids (like targetpmids_beforetrimming including all)

alter table drugpmidprojects
rename to drugpmidprojects_beforetrimming

alter table targetpmidprojects
rename to targetpmidprojects_beforetrimming

--after trimming: 
create table drugpmidprojects as
select d.drug_id, r.pmid, r.project_number, r.pub_year from reporterpublink r inner join drugpmids d on r.pmid = d.pmid;

select target, s.target_id, count(distinct s.pmid) as "count_2016", count(distinct n.pmid) as "count_2019", (count(distinct n.pmid) - count(distinct s.pmid)) as diff
from targetpmids s left outer join  nih_grants_followup.targetpmids n on s.pmid = n.pmid and s.target_id = n.target_id 
group by s.target_id, target order by count_2019;  --works

alter table targetpmids 
--alter column target_id type integer using (target_id::integer)
alter column target_id type varchar(20);

select target, count(pmid) from targetpmids where target_id = '124' group by target;

select target, count(pmid) from targetpmids where target_id = '124' group by target;

select target_id, count(pmid) from targetpmids where target = 'slamf7' group by target_id; --103
select target_id, count(pmid) from nih_grants_followup.targetpmids where target_id = '133' group by target_id; --95

select target_id, count(pmid) from nih_grants_followup.targetpmids where target_id = '140' group by target_id; --0 

 select distinct target_id from targetpmidprojects; --220
 
 select distinct d.target_id from reporterpublink r inner join targetpmids_beforetrimming d on r.pmid = d.pmid; --220

select count(pmid) as count_2019, target_id from nih_grants_followup.targetpmids_beforetrimming group by target_id order by target_id;

select count(pmid) as count_2019, target_id from nih_grants_followup.targetpmids group by target_id order by target_id;

create  table targetpmidprojects as
select d.target_id, r.pmid, r.project_number, r.pub_year from reporterpublink r inner join targetpmids d on r.pmid = d.pmid;


select drug, s.drug_id, count(distinct s.pmid) as "count_2016", count(distinct n.pmid) as "count_2019", (count(distinct n.pmid) - count(distinct s.pmid)) as diff
from drugpmids s left outer join  nih_grants_followup.drugpmids n on s.pmid = n.pmid and s.drug_id = n.drug_id 
group by s.drug_id, drug  order by diff; 

select pmid from nih_grants_followup.drugpmids where drug_id = 'drug191';

create table uniquedrugpmidprojectyear_trimmed as 
select distinct project_number, pub_year, pmid, drug_id from drugpmidprojects;

select count(distinct(project_number, pub_year)) from uniquedrugpmidprojectyear_trimmed; --63073

create table targetprojectyears as
select *, concat(pub_year, project_number) as project_year from targetpmidprojects;

create table drugprojectyears as
select *, concat(pub_year, project_number) as project_year from drugpmidprojects;

alter table targetprojectyears
add column dataorigin varchar(1);

update targetprojectyears
set dataorigin = 'T';

alter table drugprojectyears
add column dataorigin varchar(1);

update drugprojectyears
set dataorigin = 'D';

select count (distinct pmid) from drugprojectyears; --38826

select count (distinct pmid) from targetprojectyears; --417394

create table drugtargetprojectyears as
select pmid, project_number, pub_year, drug_id, project_year, dataorigin  from drugprojectyears
union all 
select  pmid, project_number, pub_year, target_id, project_year, dataorigin from targetprojectyears ; --stores drug and target in one row 610,702

alter table targetprojectyears
alter column target_id type varchar;

select count(distinct project_year) from drugtargetprojectyears; --221891 (updated = 564,405)
select * from drugtargetprojectyears limit 100;

select * from drugtargetprojectyears order by project_year limit 100;

alter table drugtargetprojectyears
add column drugvstarget varchar(20);

update drugtargetprojectyears
set drugvstarget = 
case when project_year not in (
select project_year from drugprojectyears)
then 'target_only'
else 'drug'
end; --works (Did not load in the larger dataset)

select count( distinct project_year) from drugtargetprojectyears where drugvstarget = 'drug'; --14292
select count( distinct project_year) from drugtargetprojectyears where drugvstarget = 'target_only'; --207599


create table uniquedrugtargetprojectyears as
select distinct on (project_year)
pmid, project_year, pub_year, drug_id as searchtermid, project_number, dataorigin from drugtargetprojectyears group by 
pmid, project_year, pub_year, drug_id, project_number, dataorigin; --221,891

select count(*) from uniquedrugtargetprojectyears; --564,405

alter table uniquedrugtargetprojectyears
add column drugvstarget varchar(20); --REPEAT

  --takes too long

select count( distinct project_year) from uniquedrugtargetprojectyears where drugvstargetonly = 'drug'; --14292 (updated:
select count( distinct project_year) from uniquedrugtargetprojectyears where drugvstargetonly = 'target_only'; --207599 (updated:

create table nih_grants_followup.uniquedrugtargetprojectyears2 as
select *,
case when 
project_year not in (
select project_year from nih_grants_followup.drugprojectyears)
then 'target_only'
else 'drug' 
end as drug_targetonly
from nih_grants_followup.uniquedrugtargetprojectyears;  --WORKS!

select count( distinct project_year) from drugprojectyears; --62145
select count( distinct project_year) from targetprojectyears; --545551

select count( distinct project_year) from uniquedrugtargetprojectyears2 where drug_targetonly = 'drug'; --14292 (updated:
select count( project_year) from uniquedrugtargetprojectyears2 where drug_targetonly = 'target_only'; --207599 (updated:

create table proj_year_nodups_costs_v2 as
select t.project_number, t.pub_year, t.project_year, t.drugvstarget, sum(c.total_cost) as sum_projects_finalcosts from uniquedrugtargetprojectyears t LEFT JOIN projects_final c 
on c.core_project_num=t.project_number and c.fy=t.pub_year group by t.project_number, t.pub_year,t.project_year, t.drugvstarget;  --221891 (15 secs) lots of costs missing


--create table countable_projects_v2 as
select count(*) from proj_year_nodups_costs_v2 where pub_year > 1999 --and (fy_minus_pubyear = -1 ); --202716 needs more filters on year diffs

select count(*) from proj_year_nodups_costs where year > 1999 --and (fy_minus_pubyear = -1 ); --202716

select sum(sum_projects_finalcosts) from proj_year_nodups_costs_v2; --92.57

select sum(costs) from proj_year_nodups_costs; --92574998042

update countable_projects_v2
SET total_costs
CASE
when costs is not null and lastyearscosts is null then costs
when costs is null and lastyearscosts is not null then lastyearscosts
end;

select t.project_number, t.pub_year, t.project_year, t.drugvstarget, (c.fy - t.pub_year) as diff, sum(c.total_cost) as preadj_total_cost 
from uniquedrugtargetprojectyears t LEFT JOIN projects_final c on c.core_project_num=t.project_number 
and c.fy=t.pub_year group by t.project_number, t.pub_year,t.project_year, t.drugvstarget, c.fy; --no diff

--select r.project, p.total_cost, r.year, p.fy, (p.fy - r.year) as diff from proj_year_nodups_cases r inner join projects_final p 
--on r.project = p.core_project_num and r.year <> p.fy group by r.project, r.year, p.fy, p.total_cost limit 100;

alter table proj_year_nodups_costs_v2
add column fy_minus_pubyear int;

update proj_year_nodups_costs_v2 r
	set fy_minus_pubyear = p.fy - r.pub_year
	from projects_final p
	where p.core_project_num = r.project_number
	and p.fy = r.pub_year; --9sec

select * from proj_year_nodups_costs_v2 limit 100; --lots of nulls

select fy, total_cost from projects_final where core_project_num = 'B01DP009010'; -- fy 2007-2013 missing costs for first 2 years


select fy, total_cost from projects_final where core_project_num = 'P01AG022074'; --lost of costs missing in last year 2012 

--select distinct project_year,
--last_value(total_cost)

select sum(sum) from proj_year_nodups_costs_v2; --92,574,998,042

create table proj_year_nodups_costs_v2 as
select t.project_number, t.pub_year, t.project_year, t.drugvstarget, sum(c.total_cost) from uniquedrugtargetprojectyears t LEFT JOIN projects_final c 
on c.core_project_num=t.project_number and c.fy=t.pub_year group by t.project_number, t.pub_year,t.project_year, t.drugvstarget;  --221891 (15 secs) lots of costs missing


alter table proj_year_nodups_costs_v2
add column infladj_costs int;

update proj_year_nodups_costs_v2
SET infladj_costs = 
CASE
when pub_year = '2000' then sum * 1.39
when pub_year = '2001' then sum * 1.36
when pub_year = '2002' then sum * 1.33
when pub_year = '2003' then sum * 1.3
when pub_year = '2004' then sum * 1.27
when pub_year = '2005' then sum * 1.23
when pub_year = '2006' then sum * 1.19
when pub_year = '2007' then sum * 1.16
when pub_year = '2008' then sum * 1.11
when pub_year = '2009' then sum * 1.12
when pub_year = '2010' then sum * 1.1
when pub_year = '2011' then sum * 1.07
when pub_year = '2012' then sum * 1.05
when pub_year = '2013' then sum * 1.03
when pub_year = '2014' then sum * 1.01
when pub_year = '2015' then sum * 1.01
when pub_year = '2016' then sum
end --sum renamed to sum_projects_finalcosts

update proj_year_nodups_costs_v2
SET infladj_costs = 
CASE
when pub_year = '2000' then sum_projects_finalcosts * 1.3938
when pub_year = '2001' then sum_projects_finalcosts * 1.3552
when pub_year = '2002' then sum_projects_finalcosts * 1.3341
when pub_year = '2003' then sum_projects_finalcosts * 1.3044
when pub_year = '2004' then sum_projects_finalcosts * 1.2706
when pub_year = '2005' then sum_projects_finalcosts * 1.2289
when pub_year = '2006' then sum_projects_finalcosts * 1.1905
when pub_year = '2007' then sum_projects_finalcosts * 1.1575
when pub_year = '2008' then sum_projects_finalcosts * 1.1147
when pub_year = '2009' then sum_projects_finalcosts * 1.1187
when pub_year = '2010' then sum_projects_finalcosts * 1.1007
when pub_year = '2011' then sum_projects_finalcosts * 1.067
when pub_year = '2012' then sum_projects_finalcosts * 1.0454
when pub_year = '2013' then sum_projects_finalcosts * 1.0303
when pub_year = '2014' then sum_projects_finalcosts * 1.0138
when pub_year = '2015' then sum_projects_finalcosts * 1.0126
when pub_year = '2016' then sum_projects_finalcosts
end;

select sum(infladj_costs) from proj_year_nodups_costs_v2; --102518684565 (102,497,091,367 with 2 decimal CPI)

select sum(sum_projects_finalcosts) from proj_year_nodups_costs_v2; --92574998042
select pub_year, sum(sum_projects_finalcosts) from proj_year_nodups_costs_v2 group by pub_year order by pub_year;


select t.pub_year, sum(c.total_cost) from uniquedrugtargetprojectyears t LEFT JOIN projects_final c on c.core_project_num=t.project_number 
and c.fy=t.pub_year group by t.pub_year

alter table proj_year_nodups_costs_v2
add column lastyearscosts int;

update proj_year_nodups_costs_v2 r
	set lastyearscosts = last_value(total_cost) OVER w
	from projects_final p
	where p.core_project_num = r.project_number
WINDOW w as (PARTITION BY project_year ORDER BY fy, total_costs
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
ORDER BY 1; --error

update proj_year_nodups_costs_v2 r
	set lastyearscosts = last_value(p.total_costs)
	from (
	select project_year  over (PARTITION BY project_year ORDER BY fy, total_costs) as total_costs
	from proj_year_nodups_costs_v2)
	as projects_final 
	where p.core_project_num = r.project_number; --do not use
	
update proj_year_nodups_costs_v2 r
	set lastyearscosts = last_value(p.total_cost) over w
	from projects_final p
	where r.project_number = p.core_project_num; --window functions are not allowed in UPDATE

--created a table of last fy's costs	
create view projectsfinal_lastyearscosts as
select distinct core_project_num,
last_value(fy) OVER w as lastfy,
last_value(total_cost) OVER w as lastyearscosts
from projects_final 
WINDOW w as (PARTITION BY core_project_num ORDER BY fy, total_cost
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
ORDER BY 1 --limit 100;  EDIT TO SAY WHERE COSTS NOT NULL??

select count(*) from projectsfinal_lastyearscosts_grt1; --269613 vs 424,865

select sum(lastyearscosts) from projectsfinal_lastyearscosts_grt1; --$111237953817

select sum(lastyearscosts) from projectsfinal_lastyearscosts; --$102106436867

SELECT sum(lastyearscosts) from proj_year_nodups_costs_v2 where pub_year between 2000 and 2015; --82444005133 (without between 97,233,979,921)
SELECT sum(sum_projects_finalcosts) from proj_year_nodups_costs_v2 where pub_year between 2000 and 2015; --86543120119 (without between 92,574,998,042)

select t.*, c.fy, sum(c.total_cost) as sum from proj_year_nodups_costs t LEFT JOIN projects_final c on c.core_project_num=t.project and c.fy=t.year where t.year IS NOT NULL 
group by t.project, t.year,t.project_year, first_proj, t.drug, t.target, t.bothdrtg, t.target_only, t.costs, t.fy_minus_pubyear, t.ifmismatch, t.lastyearscosts, c.fy; 


select fy, total_cost from projects_final where core_project_num = 'D43TW000003' order by fy desc;

select * from proj_year_nodups_costs where project = 'D43TW000003';

select * from projectsfinal_lastyearscosts where core_project_num = 'D43TW000003';

select * from lastyearscosts_uniquedrugtarget where core_project_num = 'D43CA153722' order by fy desc;

create table yearmismatches_v2 as
select r.project_number, p.total_cost, r.pub_year, p.fy, (p.fy - r.pub_year) as diff from proj_year_nodups_costs_v2 r, 
projects_final p where r.project_number = p.core_project_num and r.pub_year <> p.fy group by r.project_number, r.pub_year, p.fy, p.total_cost; --2.6M

alter table proj_year_nodups_costs_v2
add column fy_minus_pubyear int;

update proj_year_nodups_costs_v2
set fy_minus_pubyear = null;

update proj_year_nodups_costs c
set fy_minus_pubyear = m.diff
from yearmismatches_lastyearscosts m
where c.project = m.project
and c.year = m.pub_year; --set fy_minus_pubyear back from countable_projects?

--OR 
 update proj_year_nodups_costs c
set fy_minus_pubyear = m.fy_minus_pubyear
from projectyearmismatches_costs m
where c.project = m.project
and costs is null; --works!

 update proj_year_nodups_costs_v2 c
set fy_minus_pubyear = m.fy_minus_pubyear
from projectyearmismatches_costs m
where c.project_number = m.project
and sum_projects_finalcosts is null; 




--update proj_year_nodups_costs_v2 c
--set fy_minus_pubyear = m.diff
--from yearmismatches_lastyearscosts m
--from yearmismatches m
--from projectyearmismatches_withallcosts m
--from yearmismatchesnih m
--where c.project_number = m.project_number
--and m.pub_year = c.pub_year; --no change
--and m.fy = c.pub_year;

create view projectyearmismatches2 as
--select r.project, r.year, p.fy from proj_year_nodups_cases r, projects_final p where not exists (select 1 from projects_final p where r.project = p.core_project_num and r.year = p.fy);
select r.project_year, r.project_number, r.pub_year, p.fy from proj_year_nodups_costs_v2 r, projects_final p where not exists (select 1 from projects_final p where 
r.project_number = p.core_project_num and r.pub_year = p.fy);

select count(*) from projectyearmismatches2;

create view projectyearmismatches_withallcosts_v2 as
select m.*, (p.fy - m.pub_year) as diff, p.total_cost from projectyearmismatches2 m, projects_final p where m.project_number = p.core_project_num;

select count(*) from projectyearmismatches_withallcosts_v2;

create view projectyearmismatches_costs_v2 as
--select distinct on (project_number, pub_year)
select distinct on (project_year)
 --project_year, project_number, fy as last_fy, pub_year, diff as fy_minus_pubyear, total_cost as lastyearscost from projectyearmismatches_withallcosts_v2 
 where total_cost > 1
 group by project_year, project_number, total_cost, fy, pub_year, diff
 order by project_year, project_number, pub_year, fy desc, pub_year, diff, total_cost;
 
 select count(*) from projectyearmismatches_costs_v2; --too long
 
update proj_year_nodups_costs_v2 c
set fy_minus_pubyear = m.fy_minus_pubyear
from projectyearmismatches_costs_v2 m 
where c.project_year = m.project_year
and sum_projects_finalcosts is null; --too long
 

select count(*) from projectyearmismatches; --72720

select count(*) from projectyearmismatches_withallcosts_v2; --72720

update proj_year_nodups_costs_v2 r
	set lastyearscosts = p.lastyearscosts
	from projectsfinal_lastyearscosts p
	where r.project_number = p.core_project_num 
	and sum_projects_finalcosts is null; --wrong assumption
	
	select sum(lastyearscosts) from proj_year_nodups_costs_v2; --40,273,893,326

create table countable_projects_v2 as
select * from proj_year_nodups_costs_v2 where pub_year > 1999 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null); --too few rows 77K vs 174K
 
 select * from proj_year_nodups_costs where year > 1999 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null); 

select count(*) --from proj_year_nodups_costs --180350
--from projectyearmismatches_costs --24427
where (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null); 

select count(*) 
--from yearmismatches --667903
--from yearmismatches_lastyearscosts --17785
--from projectyearmismatches_withallcosts --290776
from sumyearlycosts_yearmismatches --566572
where (diff = -1 or diff = -2 or diff =-3 or diff = -4 or diff is null); 

select table_schema, table_name, column_name from information_schema.columns where column_name = 'diff';
 
 alter table countable_projects_v2
add column total_costs int;

update countable_projects_v2
SET total_costs = 
CASE
when sum_projects_finalcosts is not null and lastyearscosts is null then sum_projects_finalcosts
when sum_projects_finalcosts is null and lastyearscosts is not null then lastyearscosts
end;

 alter table countable_projects_v2
add column adj_costs int;

update countable_projects_v2
SET adj_costs = 
CASE
when pub_year = '2000' then total_costs * 1.39
when pub_year = '2001' then total_costs * 1.36
when pub_year = '2002' then total_costs * 1.33
when pub_year = '2003' then total_costs * 1.3
when pub_year = '2004' then total_costs * 1.27
when pub_year = '2005' then total_costs * 1.23
when pub_year = '2006' then total_costs * 1.19
when pub_year = '2007' then total_costs * 1.16
when pub_year = '2008' then total_costs * 1.11
when pub_year = '2009' then total_costs * 1.12
when pub_year = '2010' then total_costs * 1.1
when pub_year = '2011' then total_costs * 1.07
when pub_year = '2012' then total_costs * 1.05
when pub_year = '2013' then total_costs * 1.03
when pub_year = '2014' then total_costs * 1.01
when pub_year = '2015' then total_costs * 1.01
when pub_year = '2016' then total_costs
end

select sum(adj_costs) from countable_projects_v2 where pub_year < 2016 and (fy_minus_pubyear between -4 and 0) or (fy_minus_pubyear is null);
--and drugvstarget = 'target_only'; --too low
--129338383148 pre-filter

select distinct(year) from countable_projects order by year desc; --2000-2016
select sum(adj_costs) from countable_projects where year < 2016; --115349942495
select count(distinct project_year) from countable_projects where year < 2016; --162199
select count(distinct project_year) from proj_year_nodups_costs where year < 2016; --207781
select sum(costs) from proj_year_nodups_costs where year  < 2016; --86543120119

select distinct(pub_year) from countable_projects_v2 order by pub_year desc; --2000-2016
select distinct(pub_year) from countable_projects_v2 order by pub_year desc; --2000-2016
select sum(adj_costs) from countable_projects_v2 where pub_year < 2016; --129338383148 --too high
select count(distinct project_year) from countable_projects_v2 where pub_year < 2016; --188606
select count(distinct project_year) from proj_year_nodups_costs_v2 where pub_year < 2016; --207781 --FIX countable_projects2 number of projects
select sum(sum_projects_finalcosts) + sum(lastyearscosts) from proj_year_nodups_costs_v2 where pub_year < 2016; --86543120119 (123663254969)
select sum(unadj_costs) from proj_year_nodups_costs_v2 where pub_year between 2000 and 2015; --116202238794 -- too high

--if fy = pub_year then sum_projects_finalcosts; else lastyearscosts, the infl adj and correct on lastfy - pub_year
--GET fy_minus_pubyear FROM countable_projects or proj_year_nodups_costs

alter table proj_year_nodups_costs_v2
add column lastfy int;

update proj_year_nodups_costs_v2 c
set lastfy = m.lastfyyear
from projects_final_lastfycosts m
where c.project_number = m.core_project_num
--and c.year = m.pub_year;

alter table proj_year_nodups_costs_v2
add column unadj_costs int;

update proj_year_nodups_costs_v2
set unadj_costs =
CASE
when sum_projects_finalcosts is not null and lastyearscosts is null then sum_projects_finalcosts
when sum_projects_finalcosts is null and lastyearscosts is not null then lastyearscosts
else 1 --difference of $4290 if 0
end;

select * from proj_year_nodups_costs_v2 where lastfy = pub_year; --24877

update proj_year_nodups_costs_v2
set unadj_costs =
CASE
when lastfy = pub_year then sum_projects_finalcosts
else lastyearscosts
--else 1 --difference of $4290 if 1
end; --$64,061,265,909

select * from proj_year_nodups_costs_v2 where sum_projects_finalcosts is not null and lastyearscosts is not null; --0
select * from proj_year_nodups_costs_v2 where sum_projects_finalcosts is null and lastyearscosts is null and pub_year >= 2000; --395 grt1
--4.8K without any costs previously without total_cost > 1

update proj_year_nodups_costs_v2
set fy_minus_pubyear = lastfy-pub_year; --doesn't work

 update proj_year_nodups_costs_v2 c
set fy_minus_pubyear = m.fy_minus_pubyear
from projectyearmismatches_costs m
where c.project_number = m.project --$50,173,709,903
--and sum_projects_finalcosts is null; 

select sum(costs) from proj_year_nodups_costs where year<2016 and target_only = 1;

select sum(unadj_costs) from proj_year_nodups_costs_v2 where  pub_year between 1999 and 2015 --117469881947
and drugvstarget = 'target_only' --105163825949 
and (lastfy - pub_year >= -4) --103436649033
and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear = null); --14,998,868,967 (31,022,138,900 with grt1): 31,019,161,188 when lastfy = pub_year then sum_projects_finalcosts else lastyearscosts

select count(*) from proj_year_nodups_costs_v2 where  pub_year<2016 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear = 0);  --too few rows 55990 vs 174K

alter table proj_year_nodups_costs_v2
add column infladj_costs int;

update proj_year_nodups_costs_v2
SET infladj_costs = 
CASE
when pub_year = '2000' then unadj_costs * 1.39
when pub_year = '2001' then unadj_costs * 1.36
when pub_year = '2002' then unadj_costs * 1.33
when pub_year = '2003' then unadj_costs * 1.3
when pub_year = '2004' then unadj_costs * 1.27
when pub_year = '2005' then unadj_costs * 1.23
when pub_year = '2006' then unadj_costs * 1.19
when pub_year = '2007' then unadj_costs * 1.16
when pub_year = '2008' then unadj_costs * 1.11
when pub_year = '2009' then unadj_costs * 1.12
when pub_year = '2010' then unadj_costs * 1.1
when pub_year = '2011' then unadj_costs * 1.07
when pub_year = '2012' then unadj_costs * 1.05
when pub_year = '2013' then unadj_costs * 1.03
when pub_year = '2014' then unadj_costs * 1.01
when pub_year = '2015' then unadj_costs * 1.01
when pub_year = '2016' then unadj_costs
end; --has been overwritten 3/25

select sum(infladj_costs) from proj_year_nodups_costs_v2 where pub_year between 2000 and 2015 --129338387438
--and pub_year < fy --and (lastfy - pub_year < 1)
and (lastfy - pub_year >= -4 or lastfy = pub_year) --127376019978
and drugvstarget = 'target_only' --105163825949 

select * from proj_year_nodups_costs_v2 where lastfy - pub_year > 10 and pub_year > 2000 limit 10;


select sum(lastyearscosts) from proj_year_nodups_costs  --$47,250,508,805
where (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 ) --22899472644

select sum(lastyearscosts) from proj_year_nodups_costs_v2 --$47,250,508,805
where (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 ) --22,899,472,644 from projectyearmismatches_costs
--and pub_year > 
--$21,324,973,322 from lastfy-pub_year


update proj_year_nodups_costs_v2 c
set lastfy = m.lastfyyear
from projects_final_lastfycosts m
where c.project_number = m.core_project_num --doesn't work

update proj_year_nodups_costs_v2 set fy_minus_pubyear = lastfy - pub_year; --$21324973322 do not use (lastyearscosts)

select sum(infladj_costs) from proj_year_nodups_costs_v2 where pub_year > 1999 --$138,524,024,381
and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear = 0) --$33,460,309,820; 21,777,853,310, 103,977,808,203
and drugvstarget = 'target_only';

select * from proj_year_nodups_costs_v2 where fy_minus_pubyear <> 0;

--to try
update proj_year_nodups_costs_v2 c
set fy_minus_pubyear = m.diff
from yearmismatches_lastyearscosts m
where c.project_number = m.project
and c.pub_year = m.pub_year; --6735654510

 update proj_year_nodups_costs_v2 c
set fy_minus_pubyear = m.fy_minus_pubyear
from projectyearmismatches_costs m --works -- recreate
--from projectyearmismatches_costs_v2 m
where c.project_number = m.project
and sum_projects_finalcosts is null; 

 create table projectyearmismatches_v2 as
select r.project_number, r.pub_year, p.fy from proj_year_nodups_costs_v2 r, projects_final p where not exists 
(select 1 from projects_final p where r.project_number = p.core_project_num and r.pub_year = p.fy);

create table/view projectyearmismatches_withallcosts_v2 as
select m.*, (p.fy - m.pub_year) as diff, p.total_cost as lastyearscosts from projectyearmismatches_v2 m, projects_final p where m.project_number = p.core_project_num;

create table projectyearmismatches_costs_v2 as
select distinct on (project_number, fy)
 project_number, fy as last_fy, pub_year, diff as fy_minus_pubyear, lastyearscosts from projectyearmismatches_withallcosts_v2
 where lastyearscosts > 1
 group by project_number, fy, pub_year, diff, lastyearscosts
 order by project_number, fy desc, pub_year, diff, lastyearscosts;

select * from countable_projects c inner join proj_year_nodups_costs p on p.project_year = c.project_year where c.fy_minus_pubyear <> p.fy_minus_pubyear; --fixed overwrite issue (projectyearmismatches_costs)

select * from proj_year_nodups_costs_v2 c inner join proj_year_nodups_costs p on p.project_year = c.project_year where c.fy_minus_pubyear <> p.fy_minus_pubyear; --0

select * from proj_year_nodups_costs_v2 c inner join proj_year_nodups_costs p on p.project_year = c.project_year where c.lastyearscosts <> p.lastyearscosts limit 10;

select count(project_year) from proj_year_nodups_costs where year > 1999 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4
or fy_minus_pubyear is null) --174876 --null statement is important

select count(project_year) from proj_year_nodups_costs_v2 where pub_year > 1999 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4
or fy_minus_pubyear is null); --174876

select sum(costs) from proj_year_nodups_costs where year > 1999 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4
or fy_minus_pubyear is null); --92574998042

select sum(lastyearscosts) from proj_year_nodups_costs where year > 1999 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4
or fy_minus_pubyear is null); --20896519878

select sum(sum_projects_finalcosts) from proj_year_nodups_costs_v2 where pub_year > 1999 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4
or fy_minus_pubyear is null); --92574998042

select sum(lastyearscosts) from proj_year_nodups_costs_v2 where pub_year > 1999 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4
or fy_minus_pubyear is null); --20896519878

create table countable_projects_v2 as
select * from proj_year_nodups_costs_v2 where pub_year > 1999 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null); --174876

update proj_year_nodups_costs_v2 c
set lastyearscosts = m.total_cost
from yearmismatches_lastyearscosts m
where c.project_number = m.project
--and c.pub_year = m.pub_year;
and c.lastfy = m.last_fy
and sum_projects_finalcosts is null; 

alter table countable_projects_v2
add column total_costs int;

update countable_projects_v2
SET total_costs = 
CASE
when sum_projects_finalcosts is not null and lastyearscosts is null then sum_projects_finalcosts
when sum_projects_finalcosts is null and lastyearscosts is not null then lastyearscosts
end;

alter table countable_projects_v2
add column adjtotal_costs int;

update countable_projects_v2
SET adjtotal_costs = 
CASE
when pub_year = '2000' then total_costs * 1.39
when pub_year = '2001' then total_costs * 1.36
when pub_year = '2002' then total_costs * 1.33
when pub_year = '2003' then total_costs * 1.3
when pub_year = '2004' then total_costs * 1.27
when pub_year = '2005' then total_costs * 1.23
when pub_year = '2006' then total_costs * 1.19
when pub_year = '2007' then total_costs * 1.16
when pub_year = '2008' then total_costs * 1.11
when pub_year = '2009' then total_costs * 1.12
when pub_year = '2010' then total_costs * 1.1
when pub_year = '2011' then total_costs * 1.07
when pub_year = '2012' then total_costs * 1.05
when pub_year = '2013' then total_costs * 1.03
when pub_year = '2014' then total_costs * 1.01
when pub_year = '2015' then total_costs * 1.01
when pub_year = '2016' then total_costs
end;

select sum(total_costs) from countable_projects_v2; --$114794737340
select sum(adjtotal_costs) from countable_projects_v2; --$125995946103 too high

select sum(total_costs) from countable_projects_v2test; --113471517920 matches select sum(total_costs) from countable_projects;

alter table proj_year_nodups_costs_v2
add column testcosts int;

update proj_year_nodups_costs_v2 c
set testcosts = 
case 
when sum_projects_finalcosts is not null then sum_projects_finalcosts
when sum_projects_finalcosts is null then p.lastyearscosts 
end
from projectsfinal_lastyearscosts_grt1 p
--from projects_final_lastfycosts p
where p.core_project_num = c.project_number;

select sum(testcosts) from countable_projects_v2test where sum_projects_finalcosts is null; --$18793160913

select sum(lastyearscosts) from countable_projects where costs is null; --$20896519878

select * from proj_year_nodups_costs_v2 where unadj_costs <> testcosts; --8560

select * from countable_projects where project = 'R01AI043316'; --$38518

select fy, total_cost from projects_final where core_project_num = 'R01AI043316'; --2 records for 2008: $180127 and $38518 <- this number in countable_projects

select sum(testcosts) from proj_year_nodups_costs_v2 where pub_year between 2000 and 2015 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null); --102898040668

update proj_year_nodups_costs_v2 c
set lastfy = p.lastfyyear
from projects_final_lastfycosts p
where p.core_project_num = c.project_number
and sum_projects_finalcosts is null;

select count(*) from proj_year_nodups_costs_v2 where pub_year > 1999 and lastfy <= pub_year + 4 --147068
or lastfy = null --56522

select * from proj_year_nodups_costs_v2 where fy_minus_pubyear is null and lastfy is not null --4838
and pub_year between 2000 and 2015 --1864

select fy, total_cost from projects_final where core_project_num = 'Z01DK033007'; --2007,2008 have costs
select * from countable_projects where project = 'Z01DK033007' --null costs!
select * from countable_projects_v2 where project_number = 'Z01DK033007' --have 2008 costs
select * from yearmismatches where project = 'Z01DK033007' --2005 does not match 2006-2008
select * from proj_year_nodups_costs_v2 where project_number = 'Z01DK033007' --$339221
select * from proj_year_nodups_costs where project = 'Z01DK033007' --null

select * from proj_year_nodups_costs_v2 limit 100

create view projectyearmismatches2 as
--select r.project, r.year, p.fy from proj_year_nodups_cases r, projects_final p where not exists (select 1 from projects_final p where r.project = p.core_project_num and r.year = p.fy);
select r.project_number, r.pub_year, p.fy from proj_year_nodups_costs_v2 r, projects_final p where not exists (select 1 from projects_final p where r.project_number = p.core_project_num and r.pub_year = p.fy);


select count(*) from proj_year_nodups_costs_v2 where pub_year > 1999 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null)


alter table proj_year_nodups_costs_v2
add column ifmismatch int;

update proj_year_nodups_costs_v2
set ifmismatch = 1 where fy_minus_pubyear is not null and lastyearscosts is not null and sum_projects_finalcosts is null; --84456

select * from projects_final_lastfycosts where lastyearscosts is null and lastfyyear > 1999;

select * from proj_year_nodups_costs_v2 where sum_projects_finalcosts is null and ifmismatch = 1;

select fy, total_cost from projects_final where core_project_num = 'U01AI075466';
select * from countable_projects where project = 'U01AI075466'
select * from countable_projects_v2 where project_number = 'U01AI075466'
select * from countable_projects_v2test where project_number = 'U01AI075466'

alter table proj_year_nodups_costs_v2
add column testcostsgrt1 int;


update proj_year_nodups_costs_v2 c
set testcostsgrt1 =
case 
when sum_projects_finalcosts is not null then sum_projects_finalcosts
when sum_projects_finalcosts is null and ifmismatch = 1 then p.lastyearscosts 
end
from projectsfinal_lastyearscosts_grt1 p --($118k with the ifmismatch correction)
where p.core_project_num = c.project_number

update proj_year_nodups_costs_v2 c
set testcosts =
CASE
when sum_projects_finalcosts is not null and lastyearscosts is null then sum_projects_finalcosts
when sum_projects_finalcosts is null and lastyearscosts is not null then lastyearscosts
end;

create table countable_projects_v2test as
select * from proj_year_nodups_costs_v2 where pub_year > 1999 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 
or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 or fy_minus_pubyear is null); --174876

alter table countable_projects_v2test
add column infladj_testcostsgrt1 int; --todo

update countable_projects_v2test
SET infladj_testcostsgrt1 =
CASE
when pub_year = '2000' then testcostsgrt1 * 1.3938
when pub_year = '2001' then testcostsgrt1 * 1.3552
when pub_year = '2002' then testcostsgrt1 * 1.3341
when pub_year = '2003' then testcostsgrt1 * 1.3044
when pub_year = '2004' then testcostsgrt1 * 1.2706
when pub_year = '2005' then testcostsgrt1 * 1.2289
when pub_year = '2006' then testcostsgrt1 * 1.1905
when pub_year = '2007' then testcostsgrt1 * 1.1575
when pub_year = '2008' then testcostsgrt1 * 1.1147
when pub_year = '2009' then testcostsgrt1 * 1.1187
when pub_year = '2010' then testcostsgrt1 * 1.1007
when pub_year = '2011' then testcostsgrt1 * 1.067
when pub_year = '2012' then testcostsgrt1 * 1.0454
when pub_year = '2013' then testcostsgrt1 * 1.0303
when pub_year = '2014' then testcostsgrt1 * 1.0138
when pub_year = '2015' then testcostsgrt1 * 1.0126
when pub_year = '2016' then testcostsgrt1
end;

alter table countable_projects_v2test
add column infladj_testcosts int;

update countable_projects_v2test
SET infladj_testcosts =
CASE
when pub_year = '2000' then testcosts * 1.3938
when pub_year = '2001' then testcosts * 1.3552
when pub_year = '2002' then testcosts * 1.3341
when pub_year = '2003' then testcosts * 1.3044
when pub_year = '2004' then testcosts * 1.2706
when pub_year = '2005' then testcosts * 1.2289
when pub_year = '2006' then testcosts * 1.1905
when pub_year = '2007' then testcosts * 1.1575
when pub_year = '2008' then testcosts * 1.1147
when pub_year = '2009' then testcosts * 1.1187
when pub_year = '2010' then testcosts * 1.1007
when pub_year = '2011' then testcosts * 1.067
when pub_year = '2012' then testcosts * 1.0454
when pub_year = '2013' then testcosts * 1.0303
when pub_year = '2014' then testcosts * 1.0138
when pub_year = '2015' then testcosts * 1.0126
when pub_year = '2016' then testcosts
end;


select sum(infladj_testcosts) from countable_projects_v2test where pub_year between 2000 and 2015; --117111851282

select sum(infladj_testcostsgrt1) from countable_projects_v2test where pub_year between 2000 and 2015; --118253495090

update proj_year_nodups_costs_v2 r
	set lastyearscosts = p.lastyearscosts
	from proj_year_nodups_costs p
	--from projectsfinal_lastyearscosts p
	where r.project_year = p.project_year;
	--and sum_projects_finalcosts is null; 
	
update proj_year_nodups_costs_v2 c
set lastyearscosts = m.total_cost
from yearmismatches_lastyearscosts m
where c.project_number = m.project
--and c.pub_year = m.pub_year;
and c.lastfy = m.last_fy
and sum_projects_finalcosts is null; --114794737340


select count(project_year) from countable_projects_v2 where pub_year > 1999 and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4
or fy_minus_pubyear is null); --174876

 create table projectyearmismatches_v2 as
select r.project_number, r.pub_year, p.fy from proj_year_nodups_costs_v2 r, projects_final p where not exists 
(select 1 from projects_final p where r.project_number = p.core_project_num and r.pub_year = p.fy);

create table projectyearmismatches_withallcosts_v2 as
select m.*, (p.fy - m.pub_year) as diff, p.total_cost as lastyearscosts from projectyearmismatches_v2 m, projects_final p where m.project_number = p.core_project_num;

create table projectyearmismatches_costs_v2 as
select distinct on (project_number, fy)
 project_number, fy as last_fy, pub_year, diff as fy_minus_pubyear, lastyearscosts from projectyearmismatches_withallcosts_v2
 where lastyearscosts > 1
 group by project_number, fy, pub_year, diff, lastyearscosts
 order by project_number, fy desc, pub_year, diff, lastyearscosts;
 
 select count(*) from projectyearmismatches_costs_v2;

create table projectyearmismatches_withallcosts as
select m.*, p.fy, (p.fy - m.year) as diff, p.total_cost from projectyearmismatches m, projects_final p where m.project = p.core_project_num;


select sum(costs) from proj_year_nodups_costs where year > 1999 --92K
and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 --null
or fy_minus_pubyear = 0) --null

select sum(sum_projects_finalcosts) from proj_year_nodups_costs_v2 where pub_year > 1999 --92K
and (fy_minus_pubyear = -1 or fy_minus_pubyear = -2 or fy_minus_pubyear =-3 or fy_minus_pubyear = -4 --null
or fy_minus_pubyear = 0) --15147348762


--where lastfy - pub_year <= 4 --24,137,603,048

update proj_year_nodups_costs_v2 c
set lastyearscosts = m.total_cost
--from yearmismatches_lastyearscosts m
from yearmismatches_lastyearscosts_v2 m
where c.project_number = m.project_number
--and c.pub_year = m.pub_year
and c.lastfy = m.last_fy
and sum_projects_finalcosts is null; 


update proj_year_nodups_costs_v2 c
set lastyearscosts = m.lastyearscost
from projectyearmismatches_costs m  --costs too low
where c.project_number = m.project
and c.pub_year = m.pub_year;
        
update proj_year_nodups_costs_v2 c
set lastyearscosts = m.lastyearscosts
from proj_year_nodups_costs m
where c.project_year = m.project_year;

select sum(lastyearscosts) from proj_year_nodups_costs; --47250508805
select sum(lastyearscosts) from proj_year_nodups_costs_v2; --47250508805; -> 49964834633
    
update proj_year_nodups_costs_v2 c
set lastyearscosts = m.lastyearscosts
from projects_final_lastfycosts m 
where c.lastfy = m.lastfyyear
and c.project_number = m.core_project_num
and sum_projects_finalcosts is null; --40273893326 vs 97233979921

update proj_year_nodups_costs_v2 c
case when 

select * from proj_year_nodups_costs_v2 limit 10 where project_number = 'T32GM065085'

select * from proj_year_nodups_costs where project = 'T32GM065085'

select * from yearmismatches_lastyearscosts where project = 'T32GM065085';

select * from countable_projects where project = 'T32GM065085'
select * from countable_projects_v2 where project_number = 'T32GM065085'


create table yearmismatches_v2 as
select r.project_number, p.total_cost, r.pub_year, p.fy, (p.fy - r.pub_year) as diff from proj_year_nodups_costs_v2 r, 
projects_final p where r.project_number = p.core_project_num and r.pub_year <> p.fy group by r.project_number, r.pub_year, p.fy, p.total_cost;

create table yearmismatches_lastyearscosts_v2 as
select distinct on (project_number)
 project_number, total_cost, fy as last_fy, pub_year, diff as fy_minus_pubyear from yearmismatches_v2
 where total_cost > 1
 group by project_number, total_cost, fy, pub_year, diff
 order by project_number, fy desc;

update proj_year_nodups_costs_v2 r
	set lastyearscosts = p.lastyearscosts
	from proj_year_nodups_costs p
	where r.project_number = p.project and r.pub_year = p.year --OR
	--where r.project_year = p.project_year 
	and sum_projects_finalcosts is null; 

--create table of lastyearscosts
create view projectsfinal_lastyearscosts_grt1 as
select distinct core_project_num,
last_value(fy) OVER w as lastfy,
last_value(total_cost) OVER w as lastyearscosts
from projects_final where total_cost > 1
WINDOW w as (PARTITION BY core_project_num ORDER BY fy, total_cost
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
ORDER BY 1; 

update proj_year_nodups_costs_v2 r
	set lastyearscosts = p.lastyearscosts
	from projectsfinal_lastyearscosts_grt1 p
	where r.project_number = p.core_project_num 
	and sum_projects_finalcosts is null; 


select sum(adj_costs) from countable_projects; --124274944677
select sum(sum_projects_finalcosts) from countable_projects_v2; --92.6K

select sum(fy_minus_pubyear) from countable_projects; --61,980
select sum(fy_minus_pubyear) from countable_projects_v2; --478,175

create table lastyearscosts_uniquedrugtarget as 
select distinct searchtermid, pub_year, fy, project_year, core_project_num, drugvstarget, 
last_value(total_cost) OVER w as lastyearscosts
from projects_final p inner join uniquedrugtargetprojectyears r on p.core_project_num = r.project_number and p.fy = r.pub_year --2.4M if taken away
WINDOW w as (PARTITION BY core_project_num ORDER BY fy, total_cost
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
ORDER BY 1; --149,171

create table lastyearscosts_drugtarget as 
select searchtermid, pub_year, fy, project_year, core_project_num, drugvstarget, 
last_value(fy) OVER W as lastfyyear,
last_value(total_cost) OVER w as lastyearscosts
from projects_final p inner join uniquedrugtargetprojectyears r on p.core_project_num = r.project_number and p.fy = r.pub_year --2.4M if taken away
WINDOW w as (PARTITION BY fy, core_project_num ORDER BY fy, total_cost
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
ORDER BY 1; --377,702

create view lastyearscosts_drugtarget as --drop view lastyearscosts_uniquedrugtarget_noyearmatch
select searchtermid, pub_year, fy, project_year, core_project_num, drugvstarget, 
last_value(fy) OVER W as lastfyyear, --TO FINISH
last_value(total_cost) OVER w as lastyearscosts
--from projects_final p, uniquedrugtargetprojectyears r
from projects_final p inner join uniquedrugtargetprojectyears r on p.core_project_num = r.project_number and fy = r.pub_year
WINDOW w as (PARTITION BY core_project_num ORDER BY fy, total_cost
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
--having p.core_project_num = r.project_number and  r.pub_year = lastfyyear
ORDER BY 1; --377,702 NOT USED

select project_year, core_project_num, drugvstarget, lastyearscosts, fy, pub_year, (fy - pub_year) as diff from lastyearscosts limit 100;

select count(*) from lastyearscosts where lastyearscosts is null; --19K

--pre-inflation adj
select sum(lastyearscosts) from lastyearscosts_uniquedrugtarget where drugvstarget = 'target_only' and pub_year between 1999 and 2015; --51,082,446,830
select sum(lastyearscosts) from lastyearscosts_uniquedrugtarget where drugvstarget = 'drug' and pub_year between 1999 and 2015; --4,756,418,775

--select sum(lastyearscosts) from lastyearscosts_uniquedrugtarget_noyearmatch where drugvstarget = 'target_only' and pub_year between 1999 and 2015; --51,082,446,830
--select sum(lastyearscosts) from lastyearscosts_uniquedrugtarget_noyearmatch where drugvstarget = 'drug' and pub_year between 1999 and 2015; 

select * from proj_year_nodups_costs where project_year = '1986R01DA003628';

select sum(costs) from proj_year_nodups_costs where target_only = '1'; --81,032,833,631
select sum(lastyearscosts) from proj_year_nodups_costs where target_only = '1'; --43,210,792,938

alter table lastyearscosts_uniquedrugtarget
add column infladj_lastyearscosts int;

update lastyearscosts_uniquedrugtarget
SET infladj_lastyearscosts = 
CASE
when pub_year = '2000' then lastyearscosts * 1.39
when pub_year = '2001' then lastyearscosts * 1.36
when pub_year = '2002' then lastyearscosts * 1.33
when pub_year = '2003' then lastyearscosts * 1.3
when pub_year = '2004' then lastyearscosts * 1.27
when pub_year = '2005' then lastyearscosts * 1.23
when pub_year = '2006' then lastyearscosts * 1.19
when pub_year = '2007' then lastyearscosts * 1.16
when pub_year = '2008' then lastyearscosts * 1.11
when pub_year = '2009' then lastyearscosts * 1.12
when pub_year = '2010' then lastyearscosts * 1.1
when pub_year = '2011' then lastyearscosts * 1.07
when pub_year = '2012' then lastyearscosts * 1.05
when pub_year = '2013' then lastyearscosts * 1.03
when pub_year = '2014' then lastyearscosts * 1.01
when pub_year = '2015' then lastyearscosts * 1.01
when pub_year = '2016' then lastyearscosts
end

select sum(infladj_lastyearscosts) from lastyearscosts_uniquedrugtarget where drugvstarget = 'target_only' and pub_year between 1999 and 2015; --56063434598
select sum(infladj_lastyearscosts) from lastyearscosts_uniquedrugtarget where drugvstarget = 'drug' and pub_year between 1999 and 2015; --5007141411
select sum(infladj_lastyearscosts) from lastyearscosts_uniquedrugtarget where pub_year between 1999 and 2015; --61,070,576,009


--RECORDS MISSING because trying to match on a fy from projects_final that does not exist, but exists in reporterpublink

select * from proj_year_nodups_costs where project_year not in (
select project_year from lastyearscosts_uniquedrugtarget) limit 10;

select fy, total_cost from projects_final where core_project_num = 'R21AI101064' --2012, 2013

select * from reporterpublink where project_number = 'R21AI101064'; --2013, 2012, 2014 x 3

select * from proj_year_nodups_costs where project_year = 'R21AI101064'; --2014

select * from targetpmidprojects where project_number = 'R21AI101064'; --2014

select * from uniquedrugtargetprojectyears where project_year like '%R21AI101064';  --2014

select * from lastyearscosts_uniquedrugtarget_noyearmatch where core_project_num = 'R21AI101064'; 

select core_project_num, fy, total_cost from projects_final where core_project_num like 'R21AI%' and fy > 2000 order by core_project_num;

create table projects_final_lastfycosts as 
select distinct on (core_project_num)
core_project_num,
last_value(fy) OVER W as lastfyyear, 
last_value(total_cost) OVER w as lastyearscosts
from projects_final --where core_project_num like 'R21AI04768%'
WINDOW w as (PARTITION BY core_project_num ORDER BY fy, total_cost
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
order by 1; --UNIQUE

select count(*) from projects_final_lastfycosts; --424,865 (from 2,223,288)

select sum(lastyearscosts) from projects_final_lastfycosts p inner join uniquedrugtargetprojectyears u on p.core_project_num = u.project_number and lastfyyear = pub_year; --24877 matched 10,638,614,904

alter table projects_final_lastfycosts
add column infladj_lastyearscosts int;

update projects_final_lastfycosts
SET infladj_lastyearscosts = 
CASE
when lastfyyear = '2000' then lastyearscosts * 1.39
when lastfyyear = '2001' then lastyearscosts * 1.36
when lastfyyear = '2002' then lastyearscosts * 1.33
when lastfyyear = '2003' then lastyearscosts * 1.3
when lastfyyear = '2004' then lastyearscosts * 1.27
when lastfyyear = '2005' then lastyearscosts * 1.23
when lastfyyear = '2006' then lastyearscosts * 1.19
when lastfyyear = '2007' then lastyearscosts * 1.16
when lastfyyear = '2008' then lastyearscosts * 1.11
when lastfyyear = '2009' then lastyearscosts * 1.12
when lastfyyear = '2010' then lastyearscosts * 1.1
when lastfyyear = '2011' then lastyearscosts * 1.07
when lastfyyear = '2012' then lastyearscosts * 1.05
when lastfyyear = '2013' then lastyearscosts * 1.03
when lastfyyear = '2014' then lastyearscosts * 1.01
when lastfyyear = '2015' then lastyearscosts * 1.01
when lastfyyear = '2016' then lastyearscosts
end

select sum(infladj_lastyearscosts) from projects_final_lastfycosts p inner join uniquedrugtargetprojectyears u on p.core_project_num = u.project_number and lastfyyear = pub_year; --11032235247

select count(project_year) from uniquedrugtargetprojectyears2 where drugvstarget = 'drug'; --63073

select count(project_year) from uniquedrugtargetprojectyears2 where drugvstarget = 'target_only'; --501332

select * from uniquedrugtargetprojectyears2 limit 10;

select count(distinct pmid) from drugpmids where pub_year between 1960 and 2018; --265,300

select count(distinct pmid) from targetpmids where pub_year between 1960 and 2018; --1,998,378

select count(distinct project_year) from drugtargetprojectyears; --564405
select count(distinct pmid) from drugtargetprojectyears; --434055
select count(distinct pmid) from drugtargetprojectyears where drugvstarget = 'drug'; --110,751
select count(distinct pmid) from drugtargetprojectyears where drugvstarget = 'target_only'; --375,058
select count(distinct pmid) from drugtargetprojectyears where dataorigin = 'T'; --427,394 (D = 38826)

select count(distinct pmid), pub_year from drugtargetprojectyears group by pub_year order by pub_year; 

select count(distinct pmid) from uniquedrugtargetprojectyears; --314844
select count(distinct pmid) from uniquedrugtargetprojectyears where drugvstarget = 'drug'; --40992
select count(distinct pmid) from uniquedrugtargetprojectyears where drugvstarget = 'target_only'; --281446
select count(distinct pmid) from uniquedrugtargetprojectyears where dataorigin = 'T'; --297689

create table drugtargetpmids as
select * from drugpmids
union all 
select * from targetpmids;

select count(distinct pmid), pub_year from drugtargetpmids where pub_year between 1960 and 2018 group by pub_year order by pub_year;

create view uniquedrugtargetpmids as
select distinct on (pmid)
pmid, pub_year, drug_id as searchtermid from drugtargetpmids
group by pmid, pub_year, drug_id; --2182022

create view uniquedrugpmids as
select distinct on (pmid)
pmid, pub_year, drug_id from drugpmids
group by pmid, pub_year, drug_id; --269,952

create view uniquetargetpmids as
select distinct on (pmid)
pmid, pub_year, target_id from targetpmids
group by pmid, pub_year, target_id; --2052450

select count(pmid), pub_year from uniquedrugpmids where pub_year between 1960 and 2018 group by pub_year order by pub_year;
select count(pmid), pub_year from uniquedrugtargetpmids where pub_year between 1960 and 2018 group by pub_year order by pub_year;

select count(pmid), pub_year from reporterpublink group by pub_year; --1996 issue

create table reporterpublinkbackup as 
select * from reporterpublink;

delete from reporterpublink
where pub_year = '1996';

create view drugtargetpmids as
select * from drugpmids
union all 
select * from targetpmids;

select count(distinct project_year), pub_year from drugprojectyears group by pub_year; --61779
select count(distinct pmid) from uniquedrugpmidprojectyear group by pub_year; 

drop table uniquedrugpmidprojectyear; --138383 --same as drugprojectyears
drop table uniquedrugpmidprojectyear_trimmed;
drop table uniquetargetpmidprojectyear;

select count(distinct pmid), pub_year from drugprojectyears group by pub_year; --37754

select count(distinct pmid) from uniquedrugpmids where pub_year between 1960 and 2018; --265300

create temporary table uniquedrugtargetprojectyears as
select * from uniquedrugtargetprojectyears2;

select count(project_year) from nih_grants_followup.drugprojectyears; --138,383
select count(project_year) from nih_grants_followup.uniquedrugtargetprojectyears; --560148

update drugtargetprojectyears
set drugvstarget = 
case when project_year not in (
select project_year from drugprojectyears)
then 'target_only'
else 'drug'
end; --

select *,
case when 
project_year not in (
select project_year from nih_grants_followup.drugprojectyears)
then 'target_only'
else 'drug'
end
from nih_grants_followup.uniquedrugtargetprojectyears limit 570148; -- DID NOT TRY LIMIT, as will take ~3h
 
create view indrugprojectyears as
select u.*,
case when 
u.project_year in (
select project_year from nih_grants_followup.drugprojectyears)
then 'drug'
else 'target_only'
end as drug_targetonly
from nih_grants_followup.drugprojectyears d right join nih_grants_followup.uniquedrugtargetprojectyears u on u.project_year = d.project_year; --works to produce 636386

create view intargetprojectyears as
select u.*,
case when 
u.project_year in (
select project_year from nih_grants_followup.targetprojectyears)
then 'target_only'
else 'drug'
end as drug_targetonly
from nih_grants_followup.drugprojectyears d join nih_grants_followup.uniquedrugtargetprojectyears u on u.project_year = d.project_year; --138383 - WRONG

select count(*) from indrugprojectyears where drug_targetonly = 'target_only'; limit 1;

--select * from nih_grants_followup.drugprojectyears d  join nih_grants_followup.uniquedrugtargetprojectyears u on u.project_year = d.project_year
--and case when u.project_year in drugprojectyears then 'drug'
--else 'target_only'
--end limit 10;


https://stackoverflow.com/questions/44773500/checking-if-a-value-exists-in-another-table-within-the-select-clause

select *, 
case when d.project_year is not null
then 'drug'
else 'target_only'
end as drug_targetonly
from nih_grants_followup.uniquedrugtargetprojectyears u left join nih_grants_followup.drugprojectyears d on u.project_year = d.project_year ;
--636386 -> 560148 without duplicates

update nih_grants_followup.uniquedrugtargetprojectyears
set drugvstarget = 
case when exists (select * from nih_grants_followup.drugprojectyears d where u.project_year = d.project_year)
then 'drug'
else 'target_only'
end from nih_grants_followup.uniquedrugtargetprojectyears u; --too slow to update

create table uniquedrugtargetprojectyears_costs as --updated 5/27
select u.*,
case when exists (select * from nih_grants_followup.drugprojectyears d where u.project_year = d.project_year)
then 'drug'
else 'target_only'
end as drug_targetonly
from nih_grants_followup.uniquedrugtargetprojectyears u; --578,866 (prev 560148) WORKS!

create index project_year_index on uniquedrugtargetprojectyears (project_year); 

select count(project_year) from uniquedrugtargetprojectyears_costs where drug_targetonly = 'drug' --63687 (prev 63073)
and total_infladj_costs_2018 > 0; 

select count(project_year) from uniquedrugtargetprojectyears_costs where drug_targetonly = 'target_only' --515179 (prev 501332)
and total_infladj_costs_2018 > 0;

select * from uniquedrugtargetprojectyears_costs limit 10;

alter table uniquedrugtargetprojectyears_DTO
drop column drugvstarget;

select count(*) from uniquedrugtargetprojectyears_DTO where drug_targetonly = 'drug'; --62145

select count(*) from uniquedrugtargetprojectyears_DTO where drug_targetonly = 'target_only'; --498003

--3/25
update proj_year_nodups_costs_v2 r
	set lastyearscosts = m.lastyearscosts
	from projects_final_lastfycosts m 
	where r.project_number = m.core_project_num; --consider adding "where total_cost > 1" to projects_final_lastfycosts
	
select * from proj_year_nodups_costs_v2 where lastyearscosts is null; --23227

select * from projects_final_lastfycosts where core_project_num = 'P01AG028054';

select fy, total_cost from projects_final where core_project_num = 'P01AG028054' order by fy;

select * from projects_final where core_project_num = 'P01AG028054' and fy = 2010; --example of a grant with many subprojects

--3/26 -> 5/27
CREATE TABLE projects_final_sumcostsbyprojfy as
select core_project_num, fy, COALESCE (sum(total_cost),0) as sum_total_costs from projects_final group by core_project_num, fy;

select * from projects_final_sumcostsbyprojfy where core_project_num = 'U01AI075466'; --2007-2010
select fy, total_cost from projects_final where core_project_num = 'U01AI075466'; --2007-2010

create table uniquedrugtargetprojectyears_costs_test as
select * from uniquedrugtargetprojectyears_costs; --do not use test

alter table uniquedrugtargetprojectyears_costs
add column matched_costs int;

alter table uniquedrugtargetprojectyears_costs
add column lastyearscosts int;

alter table uniquedrugtargetprojectyears_costs
add column total_unadj_costs int; --to store matched or lastyears

alter table uniquedrugtargetprojectyears_costs
add column total_infladj_costs_2018 int;

alter table uniquedrugtargetprojectyears_costs
add column fy_minus_pubyear int;

update uniquedrugtargetprojectyears_costs
set lastyearscosts = p.lastyearscosts  
from projects_final_sumcostsbyprojfy_lastfy p 
where p.core_project_num = project_number and matched_costs is null;


when exists (select * from nih_grants_followup.drugprojectyears d where u.project_year = d.project_year)

select * from uniquedrugtargetprojectyears_costs where project_number = 'U01AI075466' limit 10; 
select fy from projects_final where core_project_num = 'T32GM007171'

create table projects_final_sumcostsbyprojfy_lastfy as
select distinct on (core_project_num)
core_project_num,
last_value(fy) OVER W as lastfyyear, 
last_value(sum_total_costs) OVER w as lastyearscosts
from projects_final_sumcostsbyprojfy
WINDOW w as (PARTITION BY core_project_num ORDER BY fy--, total_cost
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
order by 1; --6 sec

select * from projects_final_sumcostsbyprojfy_lastfy where core_project_num = 'U01AI075466'; --2010, $765673

alter table uniquedrugtargetprojectyears_costs
add column fy_minus_pubyear int;

update uniquedrugtargetprojectyears_costs
set fy_minus_pubyear = lastfyyear - pub_year from projects_final_sumcostsbyprojfy_lastfy p
where p.core_project_num = project_number;


select * from uniquedrugtargetprojectyears_costs where project_number = 'U01AI075466'

select * from uniquedrugtargetprojectyears_costs where matched_costs is null --26 to do

update uniquedrugtargetprojectyears_costs
set total_unadj_costs = 
case 
when matched_costs > -1 then matched_costs
when matched_costs = -1 and (fy_minus_pubyear between -4 and 0) then lastyearscosts
else '0'
end;



select distinct(pub_year), coalesce(sum(total_infladj_costs),0) from uniquedrugtargetprojectyears_costs group by pub_year order by pub_year; --missing costs 2000-2006

select u.*, p.lastfyyear from uniquedrugtargetprojectyears_costs u inner join projects_final_sumcostsbyprojfy_lastfy p on u.project_number = p.core_project_num where pub_year = 2000 
--order by fy_minus_pubyear; --3410

select fy, total_cost from projects_final where core_project_num = 'P01DK043785'; 
select fy, sum_total_costs from projects_final_sumcostsbyprojfy where core_project_num = 'P01DK043785'
--select * from uniquedrugtargetprojectyears_costs where project_number = ''

select sum(total_infladj_costs) from uniquedrugtargetprojectyears_costs; --41,608,480,891

--start over 3/26:


select fy from projects_final where core_project_num = 'M01RR000865' order by fy;
select fy from projects_final where core_project_num = 'P51RR000164' order by fy;

select fy, sum(sum_total_costs) from projects_final_sumcostsbyprojfy group by fy;

create table uniquedrugtargetprojectyears_costs as
select * from uniquedrugtargetprojectyears;

update uniquedrugtargetprojectyears_costs c
set matched_costs = sum_total_costs from projects_final_sumcostsbyprojfy p where p.core_project_num = c.project_number and pub_year = p.fy;

select * from uniquedrugtargetprojectyears_costs where matched_costs is not null and pub_year > 1999 limit 10;

select * from uniquedrugtargetprojectyears_costs where matched_costs is null and pub_year > 1999 limit 10;

select * from projects_final_sumcostsbyprojfy where sum_total_costs is null and fy > 1999; --no entries because sum = 0 is missing

update uniquedrugtargetprojectyears_costs
set lastyearscosts = p.lastyearscosts  
from projects_final_sumcostsbyprojfy_lastfy p 
where p.core_project_num = project_number and matched_costs is null;

update uniquedrugtargetprojectyears_costs
set total_unadj_costs = 
case 
when matched_costs is not null then matched_costs
when matched_costs is null and (fy_minus_pubyear between -4 and 0) then lastyearscosts
else '0'
end;

alter table uniquedrugtargetprojectyears_costs
add column total_infladj_costs int;

update uniquedrugtargetprojectyears_costs
SET total_infladj_costs = 
CASE
when pub_year = '2000' then total_unadj_costs * 1.3938
when pub_year = '2001' then total_unadj_costs * 1.3552
when pub_year = '2002' then total_unadj_costs * 1.3341
when pub_year = '2003' then total_unadj_costs * 1.3044
when pub_year = '2004' then total_unadj_costs * 1.2706
when pub_year = '2005' then total_unadj_costs * 1.2289
when pub_year = '2006' then total_unadj_costs * 1.1905
when pub_year = '2007' then total_unadj_costs * 1.1575
when pub_year = '2008' then total_unadj_costs * 1.1147
when pub_year = '2009' then total_unadj_costs * 1.1187
when pub_year = '2010' then total_unadj_costs * 1.1007
when pub_year = '2011' then total_unadj_costs * 1.067
when pub_year = '2012' then total_unadj_costs * 1.0454
when pub_year = '2013' then total_unadj_costs * 1.0303
when pub_year = '2014' then total_unadj_costs * 1.0138
when pub_year = '2015' then total_unadj_costs * 1.0126
when pub_year = '2016' then total_unadj_costs
end;

select distinct(pub_year), coalesce(sum(total_infladj_costs),0) from uniquedrugtargetprojectyears_costs group by pub_year order by pub_year;

select sum(total_infladj_costs) from uniquedrugtargetprojectyears_costs where pub_year < 2016; --119612158748
select sum(total_infladj_costs) from uniquedrugtargetprojectyears_costs where pub_year < 2016 and drugvstarget = 'drug'; --13,844,135,685
select sum(total_infladj_costs) from uniquedrugtargetprojectyears_costs where pub_year < 2016 and drugvstarget = 'target_only'; --105,768,023,063

select count(distinct project_year) from uniquedrugtargetprojectyears_costs where pub_year < 2016; --221891, < 2016: 207781

select count(distinct project_year) from uniquedrugtargetprojectyears_costs where total_infladj_costs is not null and pub_year < 2016; --202,71/188606

select * from uniquedrugtargetprojectyears_costs where total_infladj_costs = 0 and pub_year >= 2000 and fy_minus_pubyear = 0; --check others

select fy, sum(total_cost) from projects_final where core_project_num = 'P01AG043353' group by fy; --2013,14, 15 (no costs)

select pub_year, sum(total_infladj_costs) from uniquedrugtargetprojectyears_costs where pub_year < 2016 group by pub_year; 

insert into version (version_no, download_date)
	values (2, '2020-1-10');
	
****

CREATE TABLE projects_final_sumcostsbyprojfy as
select core_project_num, fy, COALESCE (sum(total_cost),0) as sum_total_costs from projects_final group by core_project_num, fy; --22.5 sec

CREATE view projects_final_sumcostsbyprojfy_nocoalesce as
select core_project_num, fy, sum(total_cost) as sum_total_costs from projects_final group by core_project_num, fy;

create table projects_final_sumcostsbyprojfy_lastfy as
select distinct on (core_project_num)
core_project_num,
last_value(fy) OVER W as lastfyyear, 
last_value(sum_total_costs) OVER w as lastyearscosts
from projects_final_sumcostsbyprojfy
WINDOW w as (PARTITION BY core_project_num ORDER BY fy--, total_cost
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
order by 1;

--alter table uniquedrugtargetprojectyears_dto
--rename to uniquedrugtargetprojectyears_costs;

alter table uniquedrugtargetprojectyears_costs
add column matched_costs int,
add column lastyearscosts int,
add column fy_minus_pubyear int,
add column total_unadj_costs int,
add column total_infladj_costs_2018 int; 

update uniquedrugtargetprojectyears_costs c
set matched_costs = sum_total_costs from projects_final_sumcostsbyprojfy p where p.core_project_num = c.project_number and pub_year = p.fy;


update uniquedrugtargetprojectyears_costs
set lastyearscosts = p.lastyearscosts  
from projects_final_sumcostsbyprojfy_lastfy p 
where p.core_project_num = project_number and matched_costs is null;


update uniquedrugtargetprojectyears_costs
set fy_minus_pubyear = lastfyyear - pub_year from projects_final_sumcostsbyprojfy_lastfy p
where p.core_project_num = project_number;



update uniquedrugtargetprojectyears_costs
set total_unadj_costs = 
case 
when matched_costs is not null then matched_costs
when matched_costs is null and (fy_minus_pubyear between -4 and 0) then lastyearscosts
else '0'
end;

update uniquedrugtargetprojectyears_costs
SET total_infladj_costs_2018 = 
CASE
when pub_year = '2000' then total_unadj_costs * 1.4582
when pub_year = '2001' then total_unadj_costs * 1.4179
when pub_year = '2002' then total_unadj_costs * 1.3958
when pub_year = '2003' then total_unadj_costs * 1.3647
when pub_year = '2004' then total_unadj_costs * 1.3293
when pub_year = '2005' then total_unadj_costs * 1.2858
when pub_year = '2006' then total_unadj_costs * 1.2456
when pub_year = '2007' then total_unadj_costs * 1.2111
when pub_year = '2008' then total_unadj_costs * 1.1663
when pub_year = '2009' then total_unadj_costs * 1.1705
when pub_year = '2010' then total_unadj_costs * 1.1516
when pub_year = '2011' then total_unadj_costs * 1.1163
when pub_year = '2012' then total_unadj_costs * 1.0937
when pub_year = '2013' then total_unadj_costs * 1.0779
when pub_year = '2014' then total_unadj_costs * 1.0607
when pub_year = '2015' then total_unadj_costs * 1.0594
when pub_year = '2016' then total_unadj_costs * 1.0462
when pub_year = '2017' then total_unadj_costs * 1.0244
when pub_year = '2018' then total_unadj_costs 
when pub_year = '2019' then total_unadj_costs * 0.9822
end;

select * from uniquedrugtargetprojectyears_costs where pub_year >= 2000 limit 20

select sum(total_infladj_costs_2018) from uniquedrugtargetprojectyears_costs -- $230,605,575,857 (prev 221,427,423,267)
select sum(total_infladj_costs_2018) from uniquedrugtargetprojectyears_costs where drug_targetonly = 'drug' --$35687060498 (prev 35122475464)
select sum(total_infladj_costs_2018) from uniquedrugtargetprojectyears_costs where drug_targetonly = 'target_only' --$194918515359 (prev 186304947803)

select distinct(pub_year), sum(total_infladj_costs_2018) from uniquedrugtargetprojectyears_costs group by pub_year order by pub_year desc; --1980 = 2018 (decreases after 2015)

select distinct(fy), count(core_project_num) from projects_final_sumcostsbyprojfy as project_count group by fy order by fy desc; --1985-2019 (no decrease)

select distinct(fy), count(core_project_num) from projects_final as project_count group by fy order by fy desc; --1985-2019 (decreases after 2018)

select fy, total_cost from projects_final where core_project_num = 'P01AG043353' and total_cost is not null
select pub_year, total_unadj_costs from uniquedrugtargetprojectyears_costs where project_number = 'P01AG043353'; --4525097

select fy, total_cost from projects_final where core_project_num = 'R01AI043274' and total_cost is not null
select pub_year, total_unadj_costs from uniquedrugtargetprojectyears_costs where project_number = 'R01AI043274'; 

select * from uniquedrugtargetprojectyears_costs where project_number = 'R01AI043274'; --interesting case of many publications on 1 grant

select fy, total_cost from projects_final where core_project_num = 'P01DK043785' and total_cost is not null
select pub_year, total_unadj_costs from uniquedrugtargetprojectyears_costs where project_number = 'P01DK043785';

select fy, total_cost from projects_final where core_project_num = 'Z01MH002228' and total_cost is not null;
select pub_year, total_unadj_costs from uniquedrugtargetprojectyears_costs where project_number = 'Z01MH002228';
select * from uniquedrugtargetprojectyears_costs where project_number = 'Z01MH002228';

select count(*) from reporterpatents.patents; --43477 -> 52936
select count(distinct project_id) from reporterpatents.patents; --16531 -> 19770
select count(distinct patent_id) from reporterpatents.patents; --24219 -> 28136

select * from reporterpatents.patents limit 100;

select count (distinct project_id) from uniquedrugtargetprojectyears_costs u inner join reporterpatents.patents p on p.project_id = project_number; --13669/157893

select count (distinct project_id) from drugtargetprojectyears u inner join reporterpatents.patents p on p.project_id = project_number; --same as above

select count (distinct project_id) from targetpmidprojects u inner join reporterpatents.patents p on p.project_id = project_number; --13551

select count (distinct project_id) from drugpmidprojects u inner join reporterpatents.patents p on p.project_id = project_number;  --4179

select count (distinct patent_id) from drugtargetprojectyears u inner join reporterpatents.patents p on p.project_id = project_number; --22380 (80%)

select count (distinct project_id) from reporterpublink u inner join reporterpatents.patents p on p.project_id = project_number; --18583

select count (distinct patent_id) from nih_grants.reporterpublink u inner join reporterpatents.patents p on p.project_id = project_number; --16705

alter table patents rename to patents2018;

create table reporterpatents.patents as
table patents2018 with no data; --52936 March 30, 2020 edition

select distinct patent_no from fda_db.orangebookpatents u inner join reporterpatents.patents p on p.patent_id = u.patent_no;  --52

select count ( patent_no) from fda_db.orangebookpatents u inner join reporterpatents.patents p on p.patent_id = u.patent_no; --265

select count (distinct project_number) from uniquedrugtargetprojectyears_costs; --157893
select count (distinct project) from nih_grants.proj_year_nodups_costs; --62317

create view drugtargetprojectyears_patents as
select * from drugtargetprojectyears u inner join reporterpatents.patents p on p.project_id = project_number;

select distinct patent_no from fda_db.orangebookpatents u inner join drugtargetprojectyears_patents p on p.patent_id = u.patent_no; --37

drop table countable_projects_v2;

select sum(total_infladj_costs) from uniquedrugtargetprojectyears_costs;

select count(distinct pmid) from drugpmids where pub_year = 2013;
select pub_year, count(distinct pmid) from drugpmids where pub_year between 1950 and 2019 group by pub_year order by pub_year desc;
select pub_year, count( pmid) from drugpmids where pub_year between 1950 and 2019 group by pub_year order by pub_year desc;

select pub_year, count( pmid) from targetpmids where pub_year between 1950 and 2019 group by pub_year order by pub_year desc;

select count(distinct pmid) from drugpmids where pub_year between 1950 and 2019; --269,569
select count(distinct pmid) from targetpmids where pub_year between 1950 and 2019; --2,048,295

select t.pub_year, count( d.pmid) as count_drug_pmid, count( t.pmid) as count_target_pmid from targetpmids t full outer join drugpmids d on d.pub_year = t.pub_year
 where t.pub_year between 1950 and 2019 group by t.pub_year order by t.pub_year limit 10; --repeats; use below instead

create view drugtargetpmid_count as
SELECT 'DRUG' AS search_term, COUNT(pmid) as pmid_count, count(distinct pmid) as distinct_pmid_count, pub_year FROM drugpmids group by pub_year
UNION
SELECT 'TARGET' AS search_term, COUNT(pmid) as pmid_count, count(distinct pmid) as distinct_pmid_count, pub_year FROM targetpmids group by pub_year

select search_term, sum(distinct_pmid_count) from drugtargetpmid_count  where pub_year between 1960 and 2019 group by search_term;

select sum(distinct_pmid_count) from drugtargetpmid_count where search_term = 'DRUG' and pub_year between 1960 and 2019; --268953
select sum(distinct_pmid_count) from drugtargetpmid_count where search_term = 'TARGET' and pub_year between 1960 and 2019; --2053737

--do not delete (attached to Tableau)
create view drugtargetpmidproject_count as
SELECT 'DRUG' AS search_term, COUNT(pmid) as pmid_nihfunded_count, count(distinct pmid) as distinct_nihfunded_pmid_count, pub_year FROM drugpmidprojects group by pub_year
UNION
SELECT 'TARGET' AS search_term, COUNT(pmid) as pmid_nihfunded_count, count(distinct pmid) as distinct_nihfunded_pmid_count, pub_year FROM targetpmidprojects group by pub_year

select sum(distinct_nihfunded_pmid_count) from drugtargetpmidproject_count where search_term = 'DRUG' and pub_year between 1960 and 2019; --38022 -> 39113
select sum(distinct_nihfunded_pmid_count) from drugtargetpmidproject_count where search_term = 'TARGET' and pub_year between 1960 and 2019; --412937 -> 424642

select sum(pmid_nihfunded_count) from drugtargetpmidproject_count where search_term = 'DRUG' and pub_year between 1960 and 2019; 

create view drugtargetprojectyear_count as
SELECT 'DRUG' AS search_term, COUNT(project_year) as drugprojectyear_count, count(distinct project_year) as distinct_projectyear_count, pub_year FROM drugprojectyears group by pub_year
UNION
SELECT 'TARGET' AS search_term, COUNT(project_year) as drugprojectyear_count, count(distinct project_year) as distinct_projectyear_count, pub_year FROM targetprojectyears group by pub_year

select sum(distinct_projectyear_count) from drugtargetprojectyear_count where search_term = 'DRUG' and pub_year between 1960 and 2019; --62145
select sum(distinct_projectyear_count) from drugtargetprojectyear_count where search_term = 'TARGET' and pub_year between 1960 and 2019; --545551 (NEED TARGET ONLY)

select count( distinct project_year) from uniquedrugtargetprojectyears_costs_incomplete where drug_targetonly = 'drug'; --62145 (2019 approval cutoff)
select count( distinct project_year) from uniquedrugtargetprojectyears_costs where drug_targetonly = 'target_only'; --498003 (2019 approval cutoff)

select sum(total_infladj_costs_2018) from uniquedrugtargetprojectyears_costs; -- $221427423267 -> 230605575857

select distinct(pub_year) from drugpmids where pmid = '14195460';

--4/23 (some columns are incomplete)
create table master_list_2019 (
drug_id varchar(10),
brand_name varchar(200),
approval_year int,
active_ingredients varchar(250),
generic_drug_name_Pharmaprojects varchar(250),
citeline_drug_id varchar(10),
applicant_full_name varchar(250),
--drug_synonyms_Pharmaprojects text,
target varchar(250),
target_id varchar(10),
origin_pharmaprojects varchar(250),
uni_indication varchar(100),
uni_indication_code int,
CDER_CBER int,
NCE_biologic int,
targeted_phenotypic int,
firstinclass varchar(20),
priority int,
orphan int, 
fast_track int,
accelerated int,
breakthrough varchar(20)
);       

--4/27 therapeutic areas
select new_indication, new_indication_symbol, sum(adj_costs), count(project_year)  from nih_grants.proj_year_nodups_cases_ind_costs group by new_indication, new_indication_symbol;

select uni_indication, sum(adj_costs), count(project_year)  from nih_grants.targetclusterindications group by uni_indication;

select m.uni_indication, sum(u.total_infladj_costs_2018), count(project_year) from master_list_2019 m inner join uniquedrugtargetprojectyears_costs u on m.drug_id = u.searchtermid
where approval_year < 2017 group by uni_indication; --too low

select m.uni_indication, sum(u.total_infladj_costs_2018), count(project_year) from master_list_2019 m inner join uniquedrugtargetprojectyears_costs u on m.target_id = u.searchtermid
--where approval_year < 2017 
group by uni_indication order by sum desc; --

select m.uni_indication, sum(u.total_infladj_costs_2018), count(project_year) from master_list_2019 m inner join uniquedrugtargetprojectyears_costs u on m.target_id = u.searchtermid
--where drug_targetonly = 'drug' --total: 48,542,168,152 
--where drug_targetonly = 'target_only' --total: 341,953,539,788 
where approval_year < 2017 
group by uni_indication order by sum desc; --total: 390,495,707,940 


select m.uni_indication, count(project_year) from master_list_2019 m left join drugtargetprojectyears u on m.drug_id = u.drug_id
where approval_year < 2017 group by uni_indication;

select m.uni_indication, count(project_year) from master_list_2019 m left join drugtargetprojectyears u on m.target_id = u.drug_id
where approval_year < 2017 group by uni_indication;

alter table reporterpublink rename to reporterpublink_2018;

create table reporterpublink as 
select * from covid.reporterpublink;

alter table uniquedrugtargetprojectyears_costs to uniquedrugtargetprojectyears_costs_incomplete;