function [B,strain] = BandStrain(dNdx,dNdy,a,d,n_dof,e,IEN)

    B = [dNdx(a) 0;...
        0 dNdy(a);...
        dNdy(a) dNdx(a)];

    d1 = d(IEN(e,a)*n_dof-1);
    d2 = d(IEN(e,a)*n_dof);
    strain = [sum(dNdx*d1);...
              sum(dNdy*d2);...
              sum(dNdy*d1+dNdx*d2);];
%     strain = B*d(IEN(e,a)*n_dof-1:IEN(e,a)*n_dof);
end