function final_path = TSPRec(a,n,final_path,vis,final_res,curr_bound,curr_weight,level,curr_path)
    if (level == (n+1))
        if (a( curr_path(level-1),curr_path(1) ) ~= 0)
            curr_res = curr_weight + a(curr_path(level-1), curr_path(1));
            
            if(curr_res < final_res)
                for i=1:n
                    final_path(i) = curr_path(i);
                end
                final_path(n+1) = curr_path(1);
                final_res = curr_res;
            end
        end
        return;
    end
    
    for i=1:n
       if (a(curr_path(level-1), i)~=0 && vis(i)==0)
          temp = curr_bound;
          curr_weight = curr_weight + a(curr_path(level-1), i);
          if(level == 1)
             curr_bound = curr_bound - (firstMin(a,n,curr_path(level-1))+firstMin(a, i)/2);
          else
              curr_bound = curr_bound - (secondMin(a,n,curr_path(level-1))+firstMin(a, i)/2);
          end
          
          if(curr_bound+curr_weight < final_res)
              curr_path(level) = i;
              vis(i) = 1;
              final_path = TSPRec(a,n,final_path,vis,final_res,curr_bound,curr_weight,level+1,curr_path);
          end
          
          curr_weight = curr_weight-a(curr_path(level-1), i);
          curr_bound = temp;
          
          for k=1:n
              vis(k) = 0;
          end
             
          for j=1:level-1
              vis(curr_path(j)) = 1;
          end
       end
    end
end