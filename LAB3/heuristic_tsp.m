d = 1:5;
a = [-1 10 8 9 7;10 -1 10 5 6;8 10 -1 8 9;9 5 8 -1 6;7 6 9 6 -1];
p = perms(d);
n = size(d, 2);
keySet = [];
valueSet = [];

%disp(a(1, 1));

for j = 1:size(p, 1)
    d = p(j, :);
    cost = 0;
    str = "";
    str = str + num2str(d(1));
    for i = 2:n
       cost  = cost + a(d(i-1),d(i));
       str = str + num2str(d(i));
    end
    cost  = cost + a(d(n), d(1));
    str = str + num2str(d(1));
    keySet = [keySet str];
    valueSet = [valueSet cost];
end
minm = min(valueSet);
disp(minm);
for i=1:size(keySet, 2)
    if  minm==valueSet(i) 
        disp(keySet(i));
    end
end



