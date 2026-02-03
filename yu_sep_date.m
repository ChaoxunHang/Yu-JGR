function A_sep = yu_sep_date(A,date)

% date: 时间，需为 datetime 格式。/ time, need to be datetime type. 


winter_start = find(date == datetime("2019-12-27 12:50"));      
spring_start = find(date == datetime("2020-04-13 04:20:00")); 
summer_start = find(date == datetime("2020-06-27 09:20:00")); 
autumn2_start = find(date == datetime("2020-09-06 14:30:00"));

winter = winter_start:spring_start-1;
spring = spring_start:summer_start-1;
summer = summer_start:autumn2_start-1;
autumn = [autumn2_start:38880,1:winter_start-1];

season_list = ["spring";"summer";"autumn";"winter"];
season_idx = {spring,summer,autumn,winter};

totalAmount = length(find(~isnan(A)));

for i = 1:4
    A_sep(i).season = season_list(i,1);
    z_1 = season_idx{i};
    z_2 = A(z_1,:);
    A_sep(i).dataAmount = length(z_1);
    A_sep(i).nonNaN = length(find(~isnan(z_2)));
    A_sep(i).percentage = A_sep(i).nonNaN./totalAmount;
    z_3(i,1) = length(z_1);
    A_sep(i).idx = z_2; 
end

