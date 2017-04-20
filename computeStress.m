function sigma = computeStress(D,dNdx,dNdy,d,n_dof,e,IEN,n_en)

strain = zeros(3,1);

for a = 1:n_en
    B = [dNdx(a) 0;...
        0        dNdy(a);...
        dNdy(a)  dNdx(a)];

    strain = strain + B*d(IEN(e,a)*n_dof-1:IEN(e,a)*n_dof);
end

	sigma = D*strain;
end