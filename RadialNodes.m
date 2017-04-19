function [ Nodes ] = RadialNodes( theta1,theta2,r1,r2,m,n,p,q )
%Inputs: Theta1: start angle, Theta2: end angle, r1: inside radius, r2:
%outside radius, m: #nodes radial direction, n: #nodes in theta direction,
%p: degree in radial direction, q: degree in theta direction

nnx = m+1+m*(p-1);
nny = n+1+n*(q-1);

theta_step = (theta2-theta1)/(nny-1);
r_step = (r2-r1)/(nnx-1);

Nodes = zeros(nnx*nny,2);

for j = 1:nny
    theta_j = theta1+(j-1)*theta_step;
    for i = 1:nnx
        r_i = r1+(i-1)*r_step;
        x = r_i*cos(theta_j);
        y = r_i*sin(theta_j);
        Nodes((j-1)*nnx + i,:) = [x,y];
    end
end

end

