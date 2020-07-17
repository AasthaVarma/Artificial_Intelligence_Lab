function final_path = TSP(a, n, final_path, vis, final_res)
    curr_path = zeros(1, n+1);
    curr_bound = 0;
    for i=1:size(curr_path)
        curr_path(1, i) = -1;
    end
    for i=1:size(curr_path)
        vis(1, i) = 0;
    end
    
    for i=1:n
       curr_bound = curr_bound+firstMin(a,n,i)+secondMin(a,n,i);
    end
    if(mod(curr_bound, 2))
        curr_bound = curr_bound/2;
    else
        curr_bound = curr_bound/2+1; 
    end
    
    vis(1) = 1;
    curr_path(1) = 0;
    curr_weight = 0;
    final_path = TSPRec(a,n,final_path,vis,final_res,curr_bound,curr_weight,2,curr_path);
end
