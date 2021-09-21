select g.name, count(s.name) from genre g 
	left join genre_and_artist gaa on g.id = gaa.genre_id 
	left join songwriter s on gaa.songwriter_id = s.id 
	group by g.name
	order by count(s.id) desc
;

select count(t.track_id) from album 
	join track t on t.track_id = album.id 
	where album.year_of_issue between 2019 and 2020
;

select a.name , avg(t.duration) from album a 
	left join track t on t.track_id  = a.id 
	group by a.name
	order by avg(t.duration)
;

select distinct s.name from songwriter s 
	where s.name not in (
		select distinct s.name from songwriter s 
		left join songwriter_album sa on s.id = sa.songwriter_id 
		left join album a on a.id = sa.album_id 
		where a.year_of_issue  = 2020
		)
	order by s.name
;

select c.name from collection c 
	join track_and_collection tac on c.id = tac.track_id 
	left join track t on tac.collection_id = t.id 
	left join album a on t.track_id = a.id 
	join songwriter_album sa on sa.album_id = a.id 
	left join songwriter s on s.id = sa.songwriter_id 
	where s.name like '%%Ramones%%'
	;
	
select a.name from album a 
	left join songwriter_album sa on a.id = sa.album_id 
	left join songwriter s on s.id = sa.songwriter_id 
	left join genre_and_artist gaa on s.id = gaa.songwriter_id 
	left join genre on genre.id = gaa.genre_id 
	group by a.name
	having count(distinct genre.name) > 1
	;
	
select t.name from track t 
	left join track_and_collection tac on t.id = tac.track_id 
	where tac.track_id  is null
;

select s.name, t.duration from track t 
	left join album a on a.id = t.track_id 
	left join songwriter_album sa on sa.album_id = a.id 
	left join songwriter s on s.id = sa.songwriter_id 
	group by s.name , t.duration 
	having t.duration = (
		select min(duration) from track)
	order by s.name
;

select distinct a.name from album a 
	left join track t on t.track_id = a.id 
	where t.track_id in (
		select track_id from track 
		group by track_id
		having count(id) = (
			select count(id) from track 
			group by track_id
			order by count
			limit 1
		)
	)
	order by a.name
;
	