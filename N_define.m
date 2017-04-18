function [ N_vec,dN_dxi,dN_deta ] = N_define( N_xi,N_eta,dN_xi,dN_eta,p,q )
%Given the xi and the eta basis functions, it returns the N vector

N_vec = zeros((p+1)*(q+1),1);
dN_dxi = N_vec;
dN_deta = N_vec;

for j = 1:q+1
    for i = 1:p+1
        N_vec((j-1)*(p+1)+i) = N_xi(i)*N_eta(j);
        dN_dxi((j-1)*(p+1)+i) = dN_xi(i)*N_eta(j);
        dN_deta((j-1)*(p+1)+i) = N_xi(i)*dN_eta(j);
    end
end


end

