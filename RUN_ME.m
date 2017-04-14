% 2 Dimensional FEA code
% solves for strains and displacements
clear all
format compact

%convergence tolerance
epsilon = 1e-12;

%basis function order
p = 1;
q = p;

%define mesh
%for radial nodes, n is radial, m is circumfirential
%for rectangular nodes, n is horizontal, m is vertical
n = 2;
m = 2;
he_n = 1/n;
he_m = 1/m;

%initialize IEN
IEN = LagrangeIEN(m,p,n,q);

%element type
elementType = 'rad'; %'rad' for radial, 'rect' for rectilinear

%set geometry sizes and create mesh
if strcmp(elementType,'rect') == 1
    N = 1; %width
    M = 1; %height
    
    mesh = LagrangeNodes(m,M,p,n,N,q);
else
    theta1 = 0; %starting angle
    theta2 = pi/2; %ending angle
    r1 = .03; %inside radius
    r2 = .08; %outside radius
    
    mesh = RadialNodes(theta1,theta2,r1,r2,m,n,p,q);
end

%construct matrix of node locations for each element
%nodes_el has dimensions (node #,nodal locations,element #)
nodes_el = elementConstruction(p,q,mesh,IEN);











