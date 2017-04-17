clc
clearvars
close all

M = 3;
m = M;
N = 3;
n = N;

theta1 = 0;
theta2 = pi/2;
r1 = 0.03;
r2 = 0.08;

ndof = 3;

p = 1;
q = p;
%q = 1;

n_el = m*n;

%use all functions
IEN = LagrangeIEN( m,p,n,q );
mesh = LagrangeNodes( m,M,p,n,N,q );
NodeRad = RadialNodes( theta1,theta2,r1,r2,m,n,p,q );

LM = LM_creator(IEN,mesh,ndof );

%these would be defined by Tyler's stuff

%[ N_vec,dN_dxi,dN_deta ] = N_define(N,dN,p,q);

for e = 1:n_el
    [Cex,Ce] = Ce_define2D( p,q,e,m,n );    
end