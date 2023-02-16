
select sum(backers_count)
from campaign
where outcome = 'live'
;


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

select * from email_backers_remaining_goal_amount;
