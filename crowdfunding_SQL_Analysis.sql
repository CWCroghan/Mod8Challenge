-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

select cf_id, backers_count
from campaign
where outcome = 'live'
order by cf_id desc;

---------------------------
-- |cf_id | backers_count | 
---------------------------
-- |3138	|  31           |
-- |2882	|  45           |
-- |2510	|  14           |
-- |2488	|  27           |
-- |2284	|  61           |
-- |1911	|  211          |
-- |1572	|  1111         |
-- |1114	|  708          |
-- |968	|  808          |
-- |948	|  86           |
-- |910	|  66           |
-- |563	|  1089         |
-- |238	|  278          |
-- |65	|  3640         |
---------------------------

-- -- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.

select count(backer_id), cf_id
from backers
group by cf_id
order by cf_id desc;

---------------------------
-- |cf_id | backers_count | 
---------------------------
-- |3138	| 31            |
-- |2882	| 45            |
-- |2510	| 14            |
-- |2488	| 27            |
-- |2284	| 61            |
-- |1911	| 211           |
-- |1572	| 1111          |
-- |1114	| 708           |
-- |968	| 808           |
-- |948	| 86            |
-- |910	| 66            |
-- |563	| 1089          |
-- |238	| 278           |
-- |65	| 3640          |
--------------------------- 


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

select b.cf_id, b.first_name, b.last_name, b.email, (c.goal-c.pledged) as short
from backers as b right join 
	(select cf_id, goal, pledged, (goal-pledged) as short
		from campaign
		where outcome = 'live') as c
	on b.cf_id = c.cf_id
order by b.cf_id;

-- Check the table

-- sum(backers_count) = 8175
-- number of records = 8175


-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

select b.cf_id, b.first_name, b.last_name, b.email, 
	c.company_name, c.description, c.end_date,
	(c.goal-c.pledged) as Left_of_Goal
into email_backers_remaining_goal_amount
from backers as b right join 
	(select cf_id, goal, pledged, 
	 	company_name, description, end_date
		from campaign
		where outcome = 'live') as c
	on b.cf_id = c.cf_id
order by b.cf_id;


-- Check the table

-- sum(backers_count) = 8175
-- number of records = 8175

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------     
--        | first_name   | last_name		|  email					|  company_name		| description							| end_date		| Left_of_Goal|
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------     
-- 65	| "Freeman"	|  " Gibbs"		|  "fgibbs@outlook.com"		|  "Berry-Richardson"	|  "Automated zero tolerance implementation"	|  "2021-05-29"	|   8362.00  |
-- 65	| "Loris"		|  " Goulet"		|  "lgoulet@yandex.com"		|  "Berry-Richardson"	|  "Automated zero tolerance implementation"	|  "2021-05-29"	|   8362.00  |
-- 65	| "Leigha"	|  " Wright"		|  "lwright@live.com"		|  "Berry-Richardson"	|  "Automated zero tolerance implementation"	|  "2021-05-29"	|   8362.00  |
-- 65	| "Uwe"		|  " Becker"		|  "ubecker@yahoo.com"		|  "Berry-Richardson"	|  "Automated zero tolerance implementation"	|  "2021-05-29"	|   8362.00  |
-- 65	| "Michel"	|  " Garner"		|  "mgarner@protonmail.com"	|  "Berry-Richardson"	|  "Automated zero tolerance implementation"	|  "2021-05-29"	|   8362.00  |
-- 65	| "Imen"		|  " Villeneuve"	|  "ivilleneuve@yahoo.com"	|  "Berry-Richardson"	|  "Automated zero tolerance implementation"	|  "2021-05-29"	|   8362.00  |
-- 65	| "Alcina"	|  " Bonadonna"	|  "abonadonna@yandex.com"	|  "Berry-Richardson"	|  "Automated zero tolerance implementation"	|  "2021-05-29"	|   8362.00  |
-- 65	| "Kati"		|  " Nash"		|  "knash@protonmail.com"	|  "Berry-Richardson"	|  "Automated zero tolerance implementation"	|  "2021-05-29"	|   8362.00  |
-- 65	| "Georg"		|  " Jager"		|  "gjager@yahoo.com"		|  "Berry-Richardson"	|  "Automated zero tolerance implementation"	|  "2021-05-29"	|   8362.00  |
-- 65	| "Timoteo"	|  " Dion"		|  "tdion@gmail.com"		|  "Berry-Richardson"	|  "Automated zero tolerance implementation"	|  "2021-05-29"	|   8362.00  |
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------