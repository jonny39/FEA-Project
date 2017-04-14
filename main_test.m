clc
clearvars
close all

M = 5;
m = 7;
N = 5;
n = 10;

theta1 = 0;
theta2 = pi/2;
r1 = 0.03;
r2 = 0.08;

p = 1;
q = p;
%q = 1;

n_el = m*n;

%use all functions
IENLin = LinearIEN( n,m );
IENLag = LagrangeIEN( m,p,n,q );
NodeLin = LinearNodes( m,M,n,N );
NodeLag = LagrangeNodes( m,M,p,n,N,q );
NodeRad = RadialNodes( theta1,theta2,r1,r2,m,n,p,q );

plot(NodeRad(:,1),NodeRad(:,2),'*')

%these would be defined by Tyler's stuff

%[ N_vec,dN_dxi,dN_deta ] = N_define(N,dN,p,q);

for e = 1:n_el
    [Cex,Ce] = Ce_define2D( p,q,e,m,n );    
end