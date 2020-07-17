p = 1:8;
v = perms(p); %finds all the permutations
[r, c] = size(v);
index = randperm(r, 5); % randomly chooses 100 rows which can be used as 1st gen population
pop = []; %empty vector
for i=1:range(size(index))
    vec = v(index(i), :);
    str = "";
    disp(vec)
    strcat(str, string(vec(i)));
    disp(str)
end

%disp(pop)