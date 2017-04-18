% 2 Dimensional FEA code
% solves for strains and displacements
clearvars
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

%element type
elementType = 'rect'; %'rad' for radial, 'rect' for rectilinear

if strcmp(elementType,'rect') == 1
    %define rectangular geometry
    Geometry(1) = 1; %width
    Geometry(2) = 1; %height
elseif strcmp(elementType,'rad') == 1
    %define radial geometry
    Geometry(1) = .03; %inside radius
    Geometry(2) = .08; %outside radius
    Geometry(3) = 0; %starting angle
    Geometry(4) = pi/2; %ending angle
end

%create mesh
mesh = GenerateMesh(elementType,Geometry,m,n,p,q);
%initialize IEN
IEN = LagrangeIEN(m,p,n,q);
%construct matrix of node locations for each element
%nodes_el has dimensions (node #,nodal locations,element #)
nodes_el = elementConstruction(p,q,mesh,IEN);
n_en = size(nodes_el,1);

%generate LM matrix
[LM,ID] = LM_creator(IEN,mesh,n_dof,Geometry,problemNumber);

%iterate with Newton Raphson
dSolution = NewtonRaphson(mesh,LM,IEN,ID,E,nu,p,q,m,n_dof,n_en,nodes_el,problemNumber,Geometry);

%plot solution
dSolution
plot_desired = 4;
plotter(dSolution,mesh,plot_desired,m,n,n_dof)
if isnan(sum(dSolution)) == 0
    load handel.mat
    sound(y,Fs)
end











