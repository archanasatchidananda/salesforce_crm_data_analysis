use project_salesforce;


-- SELECT CAST(`Expected Amount` AS unsigned) as Expected_Amount from `oppertuninty_table`;
-- desc `oppertuninty table`;

-- Total Lead
create view Total_Lead as
select count(`Lead ID`) as Total_Lead from `Lead_ID`;

select * from Total_Lead;

-- Expected Amount from converted leads
create view Amount_Converted_Leads as
select sum(`Expected Amount`) as Expected_Amount from `lead_ID` le
join `oppertunity_table` as op
on le.`Lead Application` = op.`Lead Application`
where le.`Converted`= 'TRUE';

select * from Amount_Converted_Leads;


-- Conversion Rate
create view Rate_Conversion as
select 
(count(`status`)/(select count(`status`) from `lead_ID`)) * 100 as conversion_rate 
from `lead_ID`
where status = 'Converted';

select * from Rate_Conversion;

-- Converted Accounts
create view Account_Converted as
select sum(`#Converted Accounts`) as Converted_Accounts from `lead_ID` as le 
where `#Converted Accounts` is not null;

select * from Account_Converted;

-- Converted Opportunities
create view Converted_Opp as
select sum(`# Converted Opportunities`) as Converted_Opportunities from `lead_ID` as le
where `# Converted Opportunities` is not null;

select * from Converted_Opp;

-- Lead By Source
create view Source_Lead as
select `Lead Source`, count(`Lead ID`)as Lead_By_Source from `lead_ID`
group by `Lead Source`
order by Lead_By_Source desc;

select * from Source_Lead;

-- Lead By Industry
create view Lead_Industry as
select `Industry`, count(`Lead ID`)as Lead_By_Industry from `Lead_ID`
group by `Industry`
order by Lead_By_Industry desc;

select * from Lead_Industry;



