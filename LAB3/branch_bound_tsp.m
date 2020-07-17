n = 4;
a = [0, 10, 15, 20; 10, 0, 35, 25; 15, 35, 0, 30; 20, 25, 30, 0];
final_path = zeros(1, n+1);
vis = zeros(1, n);
final_res = 1000;
final_path = TSP(a, n, final_path, vis, final_res);
