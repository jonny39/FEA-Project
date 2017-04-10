clc
clearvars
close all

M = 5;
m = 10;
N = 5;
n = 5;

theta1 = 0;
theta2 = pi/2;
r1 = 0.03;
r2 = 0.08;

p = 1;
q = 1;

n_el = m*n;

IENLin = LinearIEN( n_el,m );
IENLag = LagrangeIEN( m,p,n,q,n_el );
NodeLin = LinearNodes( m,M,n,N );
NodeLag = LagrangeNodes( m,M,p,n,N,q );
NodeRad = RadialNodes( theta1,theta2,r1,r2,m,n,p,q );