% 2 Dimensional FEA code
% solves for strains and displacements
clearvars
clc
format compact

%convergence tolerance
epsilon = 1e-12;

%problem number
problemNumber =  3;

%displacement amount on right face
displacement = [10 0]; %x y
h = [0.001 0]; %x y
body_force = [0 0];

%element type
elementType = 'rad'; %'rad' for radial, 'rect' for rectilinear

%basis function order
p = 1;
q = p;

%material parameters
E = 1;
nu = 0.1;
n_dof = 2;

%define mesh geometry
%for radial nodes, n is radial, m is circumfirential
%for rectangular nodes, n is horizontal, m is vertical
m = 10;
n = 10;

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

%what value needs to be plotted. 1 = x displacement, 2 = y displacement, 
%3 = von mises stress, 4 = sigma x, 5 = sigma y, 6 = torsional stress
%7 = node locations
plot_desired = 7;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%create mesh
mesh = GenerateMesh(elementType,Geometry,m,n,p,q);
%initialize IEN
IEN = LagrangeIEN(m,p,n,q);
%construct matrix of node locations for each element
%nodes_el has dimensions (node #,nodal locations,element #)
nodes_e = elementConstruction(p,q,mesh,IEN);
n_en = size(nodes_e,1);

%generate LM matrix
[LM,ID,LM_plot] = LM_creator(IEN,mesh,n_dof,Geometry,displacement,problemNumber);

%iterate with Newton Raphson
dSolution = NewtonRaphson(mesh, LM, IEN, ID, E, nu,...
    p, q, m, n_dof, n_en, nodes_e,problemNumber,Geometry,displacement,h,body_force);

%plot solution
dSolution
plotter(dSolution,mesh,plot_desired,m,n,n_dof,LM_plot,E,nu,n_en,p,q,nodes_e,IEN)

if isnan(sum(dSolution)) == 0
    load handel.mat
%     sound(y,Fs)
end











