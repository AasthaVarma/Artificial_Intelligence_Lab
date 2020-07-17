function m = secondMin(a, n, i)
    a2 = unique(a(i, :));
    m = a2(2);
end