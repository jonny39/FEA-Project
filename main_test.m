clc
clearvars
close all

M = 3;
m = 3;
N = 5;
n = 5;

p = 2;
q = 2;

NodeLin = LinearNodes( m,M,n,N );
NodeLag = LagrangeNodes( m,M,p,n,N,q );