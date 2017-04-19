function [ Node ] = LinearNodes( m,M,n,N )
%Given the node numbers and size, create a node array

xi = 0;
yj = 0;

stepi = M/m;
stepj = N/n;

Node = zeros((n+1)*(m+1),2);

for j = 1:n+1
    yj = (j-1)*stepj;
    for i = 1:m+1
        xi = (i-1)*stepi;
        Node((j-1)*(m+1)+i,:) = [xi,yj];
    end
end


end

