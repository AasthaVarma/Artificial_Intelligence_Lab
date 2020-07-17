function copyToFinal(curr_path, final_path, n)
    for i=1:n
        final_path(i) = curr_path(i);
    end
    final_path(n+1) = curr_path(1);
end
