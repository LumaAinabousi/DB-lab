select * from doctor;
select * from patient;
select * from drug;
select * from DRUG_AMOUNTSTATUS;
select * from DRUG_SUPPLIER;

select max(bdate) as "Youngest Patient", min(bdate) as "Oldest Patient"
from patient, doctor
where patient.d_id = doctor.id and lower(doctor.name) = 'reem';

select min(price) as "Minimum price"
from drug , DRUG_AMOUNTSTATUS
where drug.amount between DRUG_AMOUNTSTATUS.lower_amount and DRUG_AMOUNTSTATUS.upper_amount
and lower(DRUG_AMOUNTSTATUS.status) = 'abundant';

select sum(price) as "Total price of drugs with price > 50 & supplier in amman"
from drug , DRUG_AMOUNTSTATUS , DRUG_SUPPLIER
where drug.amount between DRUG_AMOUNTSTATUS.lower_amount and DRUG_AMOUNTSTATUS.upper_amount
and drug.amount > 50
and drug.supplier_id = DRUG_SUPPLIER.supplier_id
and lower(DRUG_SUPPLIER.address) = 'amman';

select address "City", count(address) as "Number of suppliers"
from drug_supplier
where address is not null
group by address;

select count(distinct specialty) as "Number of different specialities"
from doctor;

select SUPPLIER_NAME as "Supplier Name", max(price) as "Max price"
from drug_supplier, drug
where drug_supplier.supplier_id = drug.SUPPLIER_ID
group by SUPPLIER_NAME
having min(price) > 15;

select drug.SUPPLIER_ID as "Supplier ID", avg(amount) as "Avg amount of drugs"
from drug_supplier, drug
where drug_supplier.supplier_id = drug.SUPPLIER_ID
and price > 20
group by drug.supplier_id;
