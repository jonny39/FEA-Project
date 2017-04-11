function [B,strain] = BandStrain(dNdxi,dNdeta,a,u)
    B = zeros(3,2,a);
    strain = zeros(3,1);
    for i = 1:length(a)
        B(:,:,i) = [dNdxi(a) 0;...
                    0 dNdeta(a);...
                    dNdeta(a) dNdxi(a)];

        strain = strain + B*u;
    end
end