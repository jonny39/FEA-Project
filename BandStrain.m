function [B,strain] = BandStrain(dNdx,dNdy,a,u,n_dof)
%     B = zeros(3,2);
%     strain = zeros(3,1);

    B = [dNdx(a) 0;...
        0 dNdy(a);...
        dNdy(a) dNdx(a)];

    strain = B*u(a*n_dof-1:a*n_dof);

end