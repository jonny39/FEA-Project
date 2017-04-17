% 2 Dimensional FEA code
% solves for strains and displacements
clearvars
close all
clc
format compact

%convergence tolerance
epsilon = 1e-12;

%problem number
problemNumber = 1;

%basis function order
p = 1;
q = p;

%material parameters
E = 1;
nu = 0;
n_dof = 2;

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
elementType = 'rect'; %'rad' for radial, 'rect' for rectilinear

%define rectangular geometry
rectangularGeometry(1) = 1; %width
rectangularGeometry(2) = 1; %height

%define radial geometry
radialGeometry(1) = 0; %starting angle
radialGeometry(2) = pi/2; %ending angle
radialGeometry(3) = .03; %inside radius
radialGeometry(4) = .08; %outside radius

%create mesh
mesh = GenerateMesh(elementType,rectangularGeometry,radialGeometry,m,n,p,q);

%construct matrix of node locations for each element
%nodes_el has dimensions (node #,nodal locations,element #)
nodes_el = elementConstruction(p,q,mesh,IEN);
n_en = size(nodes_el,1);

%generate LM matrix
[LM,ID] = LM_creator(IEN,mesh,n_dof,rectangularGeometry(1),problemNumber);

%iterate with Newton Raphson
dSolution = NewtonRaphson(mesh, LM, ID, E, nu, p, q, n_dof, n_en, nodes_el,problemNumber,rectangularGeometry(1));

%plot solution
dSolution
plot_desired = 4;
plotter(dSolution,mesh,plot_desired,m,n,n_dof)
% % plot(dSolution)












