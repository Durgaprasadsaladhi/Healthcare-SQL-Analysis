create database Hospital;
drop database hospital;
create database Hospital;
use Hospital;
select * from admissions;
select * from doctors;
select * from patients;
select * from province_names;
desc admissions;
desc doctors;
desc patients;
desc province_names;
  
alter table doctors add primary key(doctor_id);
alter table patients add primary key(patient_id);
alter table province_names modify province_id char(2);
alter table patients modify province_id char(2); 
alter table province_names add primary key(province_id); 
alter table admissions add primary key(admission_id);

alter table admissions add foreign key(patient_id) references patients(patient_id);
alter table admissions add foreign key(doctor_id) references doctors(doctor_id);
alter table patients add foreign key(province_id) references province_names(province_id);


-- 1. Show first name, last name, and gender of patients who's gender is 'M'
select first_name,last_name,gender from patients where gender = 'M';

-- 2. Show first name and last name of patients who does not have allergies.
select first_name,last_name,allergies from patients where allergies is NULL;
 
-- 3. Show first name of patients that start with the letter 'C' 
select first_name from patients where first_name like 'C%';

-- 4. Show first name and last name of patients that weight within the range of 100 
-- to 120 (inclusive)
select first_name,last_name,weight from patients where weight >100 and weight <=120; 
 
-- 5. Update the patients table for the allergies column. If the patient's allergies is 
-- null then replace it with 'NKA'
update patients set allergies = "NKA" Where allergies is null; 
 
-- 6. Show first name and last name concatenated into one column to show their 
-- full name.
select *,concat(first_name ,"  ", last_name) as full_name from patients;
 
-- 7. Show first name, last name, and the full province name of each patient.
select p.first_name,p.last_name,pn.province_name from patients as p join province_names as pn 
on p.province_id = pn.province_id;

-- 8. Show how many patients have a birth_date with 2010 as the birth year.
select *from patients where birth_date like '%2010%';
 
-- 9. Show the first_name, last_name, and height of the patient with the greatest 
-- height.
select first_name,last_name,height from patients order by height desc;
select first_name,last_name,height from patients order by height desc limit 1;

-- 10. Show all columns for patients who have one of the following patient_ids: 
-- 1,45,534,879,1000 
select * from patients where patient_id in (1,45,534,879,1000);

-- 11. Show the total number of admissions
select count(*) as total_adimissions from admissions;
 
-- 12. Show all the columns from admissions where the patient was admitted and 
-- discharged on the same day. 
select* from admissions where admission_date = discharge_date;

-- 13. Show the total number of admissions for patient_id 579.
select admission_date,count(*) as Total_admissions from admissions where patient_id = 579 group by admission_date; 
 
-- 14. Based on the cities that our patients live in, show unique cities that are in 
-- province_id 'NS'? 
select distinct(city),province_id from patients where province_id = 'NS';

-- 15. Write a query to find the first_name, last name and birth date of patients 
-- who have height more than 160 and weight more than 70 
select first_name,last_name,birth_date,height,weight from patients where height > 160 and weight >70;

-- 16. Show unique birth years from patients and order them by ascending. 
select distinct(birth_date) from patients order by (birth_date) asc;
-- 17. Show unique first names from the patients table which only occurs once in 
-- the list.
select distinct(first_name)from patients;
 
-- For example, if two or more people are named 'John' in the first_name column 
-- then don't include their name in the output list. If only 1 person is named 'Leo' 
-- then include them in the output. Tip: HAVING clause was added to SQL 
-- because the WHERE keyword cannot be used with aggregate functions.
select distinct(first_name) from patients group by first_name having count(*)=1;

-- 18. Show patient_id and first_name from patients where their first_name start 
-- and ends with 's' and is at least 6 characters long.
select patient_id,first_name from patients where first_name  like 's%s' and length(first_name)>=6;

-- 19. Show patient_id, first_name, last_name from patients whos diagnosis is 
-- 'Dementia'.   Primary diagnosis is stored in the admissions table.
select p.patient_id, p.first_name, p.last_name, ad.diagnosis from patients as p 
join 
admissions as ad 
on p.patient_id = ad.patient_id 
where diagnosis = 'Dementia';
 
-- 20. Display every patient's first_name. Order the list by the length of each name 
-- and then by alphbetically.
select * from patients order by length(first_name),first_name asc;

-- 21. Show the total amount of male patients and the total amount of female 
-- patients in the patients table. Display the two results in the same row.
select
sum(case
when gender = 'M' then 1 else 0
end) as male_patients,
sum(case
when gender = 'F' then 1 else 0
end) as female_patients from patients;
 
-- 22. Show the total amount of male patients and the total amount of female 
-- patients in the patients table. Display the two results in the same row.
select 
sum(case
when gender = 'M' then 1 else 0
end) as male_patients,
sum(case
when gender = 'F' then 1 else 0 
end) as female_patients from patients;
 
-- 23. Show patient_id, diagnosis from admissions. Find patients admitted 
-- multiple times for the same diagnosis.
select patient_id,diagnosis from admissions group by patient_id,diagnosis having count(*)>1;
 
-- 24. Show the city and the total number of patients in the city. Order from most 
-- to least patients and then by city name ascending.
select city,count(*) as Total_number_patients from patients group by city order by Total_number_patients desc,city asc;
 
-- 25. Show first name, last name and role of every person that is either patient or 
-- doctor.The roles are either "Patient" or "Doctor" 
select first_name,last_name,'patients' as role from patients union select first_name,last_name,'doctors' as role from doctors;

-- 26. Show all allergies ordered by popularity. Remove NULL values from query.
select allergies,count(*) as popularity from patients where allergies != 'NKA' group by allergies order by popularity desc ;
 
-- 27. Show all patient's first_name, last_name, and birth_date who were born in 
-- the 1970s decade. Sort the list starting from the earliest birth_date.
select first_name,last_name,birth_date from patients where year(str_to_date(birth_date,'%d-%m-%Y')) between 1970 and 1979;

-- 28. We want to display each patient's full name in a single column. Their 
-- last_name in all upper letters must appear first, then first_name in all lower case 
-- letters. Separate the last_name and first_name with a comma. Order the list by 
-- the first_name in decending order    EX: SMITH,jane 
select lower(first_name),upper(last_name),concat(upper(last_name),',',lower(first_name)) as full_name from patients order by first_name desc;

-- 29. Show the province_id(s), sum of height; where the total sum of its patient's 
-- height is greater than or equal to 7,000.
select province_id,sum(height) from patients group by province_id having sum(height) >= 7000;
 
-- 30. Show the difference between the largest weight and smallest weight for 
-- patients with the last name 'Maroni' 
select weight from patients where last_name = 'Maroni'; 
select (max(weight)-min(weight)) as weight_difference from patients where last_name = "Maroni";

-- 31. Show all of the days of the month (1-31) and how many admission_dates 
-- occurred on that day. Sort by the day with most admissions to least admissions.
select day(str_to_date(admission_date,'%d-%m-%Y')) as day_of_month,count(*) as Total_admissions from admissions 
group by day(str_to_date(admission_date,'%d-%m-%Y')) order by Total_admissions desc;
 
-- 32. Show all of the patients grouped into weight groups. Show the total amount 
-- of patients in each weight group. Order the list by the weight group decending. 
-- e.g. if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 
-- 110 weight group, etc. 
select
case
when weight between 1 and 10 then "1 to 10"
when weight between 10 and 20 then '11 to 20'
when weight between 20 and 30 then "20 to 30"
when weight between 30 and 40 then "30 to 40"
when weight between 40 and 50 then "40 to 50"
when weight between 50 and 60 then "50 to 60"
when weight between 60 and 70 then "60 to 70"
when weight between 70 and 80 then "70 to 80"
when weight between 80 and 90 then "80 to 90"
when weight between 90 and 100 then "90 to 100"
when weight between 100 and 110 then "100 to 110"
when weight between 110 and 120 then "110 to 120"
when weight between 120 and 130 then "120 to 130"
when weight between 130 and 150 then "130 to 150"
else 'other'
end as weight_group ,
count(*) as Total_application 
from patients group by weight_group order by weight_group desc;


-- 33. Show patient_id, weight, height, isObese from the patients table. Display 
-- isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m). Weight 
-- is in units kg. Height is in units cm. 
select patient_id,weight,height,
case
when weight/power(height/100,2)>=30 then 1 else 0
end as isobese from patients;

-- 34. Show patient_id, first_name, last_name, and attending doctor's specialty. 
-- Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first 
-- name is 'Lisa'. Check patients, admissions, and doctors tables for required 
-- information.
select p.patient_id,p.first_name,p.last_name,d.specialty from patients as p 
join admissions as ad on p.patient_id = ad.patient_id
join doctors as d on ad.doctor_id = d.doctor_id
where ad.diagnosis = 'Epilepsy' and d.first_name = 'Lisa';


