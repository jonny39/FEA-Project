% 2 Dimensional FEA code
% solves for strains and displacements
clearvars
clc
format compact

%convergence tolerance
epsilon = 1e-12;

%problem number
problemNumber =  1;

%displacement amount on right face
displacement = [0.01 0]; %x y
h = [0.01 0]; %x y
body_force = [0 0];

%element type
elementType = 'rect'; %'rad' for radial, 'rect' for rectilinear

%basis function order
p = 2;
q = p;

%material parameters
E = 1;
nu = 0.3;
n_dof = 2;

%define mesh geometry
%for radial nodes, n is radial, m is circumfirential
%for rectangular nodes, n is horizontal, m is vertical
n = 5;
m = 5;
he_n = 1/n;
he_m = 1/m;

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
nodes_e = elementConstruction(p,q,mesh,IEN);
n_en = size(nodes_e,1);

%generate LM matrix
[LM,ID] = LM_creator(IEN,mesh,n_dof,Geometry,problemNumber);

%iterate with Newton Raphson
dSolution = NewtonRaphson(mesh, LM, IEN, ID, E, nu,...
    p, q, m, n_dof, n_en, nodes_e,problemNumber,Geometry,displacement,h,body_force);

%plot solution
dSolution
plot_desired = 4;
plotter(dSolution,mesh,plot_desired,m,n,n_dof)

if isnan(sum(dSolution)) == 0
    load handel.mat
%     sound(y,Fs)
end











