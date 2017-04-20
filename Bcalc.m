function [B] = Bcalc(dNdx,dNdy,a)

    B = [dNdx(a) 0;...
        0        dNdy(a);...
        dNdy(a)  dNdx(a)];

end