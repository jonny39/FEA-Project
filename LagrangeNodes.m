function [ Node ] = LagrangeNodes( m,M,p,n,N,q )
%Lagrange nodes define

nnx = m+1+m*(p-1);
nny = n+1+n*(q-1);

xi = 0;
yj = 0;

stepi = M/(nnx-1);
stepj = N/(nny-1);

Node = zeros(nnx*nny,2);

for j = 1:nny
    yj = j*stepj;
    for i = 1:nnx
        xi = i*stepi;
        Node(j*nnx + i,:) = [xi,yj];
    end
end

end

