use project_salesforce;

alter table `oppertuninty table csv` rename to `oppertuninty_table`;
alter table `opportunity product` rename to `opportunity_product`;
alter table `user table` rename to `user_table`;


-- Expected Amount
create view Exp_Amount as
select sum(`Expected_Amount`) as Expected_Amount from `oppertunity_table`;

select * from Exp_Amount;

-- Active Opportunities
create view Active_Opportunities as
select count(`Opportunity_ID`) as Active_Opportunities from `oppertunity_table`
where `Stage` not in ('Closed Won', 'Closed Lost');

select * from Active_Opportunities;

-- Conversion Rate
create view Conversion_Rate as
select 
(count(`stage`)/(select count(`stage`) from `oppertunity_table`)) * 100 as conversion_rate 
from  `oppertunity_table`
where `Stage` in ('Qualified Opportunity','Decision to Purchase');

select * from Conversion_Rate;

-- Win Opportunities
create view Win_Opportunities as
select count(Stage) from `oppertunity_table`
where Stage in ('Closed Won');

select * from Win_Opportunities;

-- Loss  Opportunities
create view Loss_Opportunities as
select count(Stage) from `oppertuninty_table`
where Stage in ('Closed Lost');

select * from Loss_Opportunities;

-- Running Total Expected V Commit Forecast Amount over time
create view Running_Total_Forecast_Amount as
select `Fiscal_Year`, `Expected_Amount`, sum(`Expected_Amount`) over (order by `Fiscal_Year`) as Running_Total_Expected 
from `oppertunity_table`
group by `Fiscal_Year`
order by  Running_Total_Expected;

select * from Running_Total_Forecast_Amount;

-- Running Total Active V Total Opportunity over time
create view Running_Total_Opportunities as
select `Fiscal Year`, `Stage`, count(`Opportunity ID`) as Total_Opportunity, count(`Opportunity ID`)  over (order by `Fiscal Year') as'Running_Total_Active FROM' 'oppertunity_table`
where `Stage` not in ('Closed Won', 'Closed Lost')
group by`Fiscal Year`;

select * from Running_Total_Opportunities;

-- Closed Won V Total Opportunity over time
create view Closed_Won_Total_Opportunities as
select `Fiscal_Year`, stage, count(`Opportunity_ID`) as Total_Opportunities_Over_Time from `oppertunity_table`
where `Stage` in ('Closed Won')
group by `Fiscal_Year`
order by Total_Opportunities_Over_Time;

select * from Closed_Won_Total_Opportunities;


-- Closed Won V Total closed over time
create view Closed_Won_Total_Closed as
select `Fiscal Year`, Stage, count(`Closed`) as Total_Closed_Over_Time from `oppertuninty_table`
where `Stage` in ('Closed Won')
group by `Fiscal Year`
order by Total_Closed_Over_Time;

select * from Closed_Won_Total_Closed;

-- Expected Amount by opportunities Type
create view Exp_Amount_Opportunities_Type as
select `Opportunity_Type`, sum(`Expected_Amount`) as Expected_Amount from `oppertunity_table`
group by `Opportunity_Type`
order by `Expected_Amount`;

select * from Exp_Amount_Opportunities_Type;

-- Opportunities By Industry
create view opportunities_by_Industry as
select `Industry`, count(`Opportunity_ID`) as Opportunity_ID from `oppertunity_table`
group by `Industry`
order by `Opportunity_ID`;

select * from opportunities_by_Industry ;
