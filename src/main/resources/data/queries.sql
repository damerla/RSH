insert into users (username,password,enabled) values('kisor','$2a$10$ahtSpfTTVuIYhDpX4GPaieLeoUH7XKwem3LdwKWP1tFPL84QtaQlS',true);
insert into users (username,password,enabled) values('minto','$2a$10$ahtSpfTTVuIYhDpX4GPaieLeoUH7XKwem3LdwKWP1tFPL84QtaQlS',true);
insert into users (username,password,enabled) values('admin','$2a$10$ahtSpfTTVuIYhDpX4GPaieLeoUH7XKwem3LdwKWP1tFPL84QtaQlS',true);

insert into user_roles(username,role) values('kisor','ROLE_RECRUITER');
insert into user_roles(username,role) values('admin','ROLE_ADMIN');
insert into user_roles(username,role) values('minto','ROLE_JOBSEEKER');

insert into industry(name) values('IT');
insert into industry(name) values('Finance');


insert into education_level (name) values('Post Graduate');
insert into education_level (name) values('Graduate');

insert into seniority (name) values('Intern');
insert into seniority (name) values('Mid Level');
insert into seniority (name) values('Expert');