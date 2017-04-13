% 2 Dimensional FEA code
% solves for strains and displacements
clear all
format compact

%convergence tolerance
epsilon = 1e-12;

%define mesh
%for radial nodes, n is radial, m is circumfirential
%for rectangular nodes, n is horizontal, m is vertical
n = 10;
m = 10;
he_n = 1/n;
he_m = 1/m;

%element type
elementType = 'rect'; %'rad'

