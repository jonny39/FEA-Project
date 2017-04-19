function nodes_el = elementConstruction(p,q,mesh,IEN)
    n_el = size(IEN,1);
    nodes_per_el = size(IEN,2);
    nodes_el = zeros((p+1)*(q+1),2,n_el);

    for i = 1:n_el
        for j = 1:nodes_per_el
            node = IEN(i,j);
            nodes_el(j,:,i) = mesh(node,:);
        end
    end
   
end