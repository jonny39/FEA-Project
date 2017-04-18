function x = x_locator(nodes_e, N)
    x = 0;
    for i = 1:length(nodes_e)
        x = x + nodes_e(i)*N(i);
    end
end