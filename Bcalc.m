function [B] = Bcalc(dNdx,dNdy,a,d,n_dof,e,IEN)

    B = [dNdx(a) 0;...
        0        dNdy(a);...
        dNdy(a)  dNdx(a)];

end