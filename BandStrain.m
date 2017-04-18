function [B,strain] = BandStrain(dNdx,dNdy,a,d,n_dof,e,IEN)

    B = [dNdx(a) 0;...
        0 dNdy(a);...
        dNdy(a) dNdx(a)];

    strain = B*d(IEN(e,a)*n_dof-1:IEN(e,a)*n_dof);
end