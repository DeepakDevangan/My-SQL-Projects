/* database - triggers - script */

delimiter $$
create trigger before_movie_insert_movieRuntime before insert on movie
for each row 
begin
	if new.movieRuntime <= 25 then
    signal sqlstate '42000'
    set message_text = 'check constraint on movieRuntime in table movie failed. Runtime too short';
    end if;
end$$
delimiter ;


delimiter $$
create trigger before_movie_insert_movieCertificate before insert on movie 
for each row
begin
	if new.movieCertificate not in ('N/A','PG','12','12A','15','15A','16','18') then
    signal sqlstate '41000'
    set message_text = 'check constraint in movie certificate in table movie failed. only Irish ratings';
	end if;
end $$
delimiter ;


delimiter $$
create trigger before_movie_insert_movieRating before insert on movie
for each row
begin
	if (new.movieRating < 1) or (new.movieRating > 5) then
    signal sqlstate '42000'
    set message_text = 'check constraint in movie rating in table movie failed. Outrageous rating my good sir/madam'; 
	end if;
end $$
delimiter ;