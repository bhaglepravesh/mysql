use world;
select * from city;


delete c1 from city c1, city c2
where c1.countryCode=c2.countryCode and c1.id>c2.id;
