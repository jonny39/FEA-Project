function [ N_vec,dN_dxi,dN_deta ] = N_define( N,dN,p,q )
%Given the xi and the eta basis functions, it returns the N vector

N_vec = zeros((p+1)*(q+1),1);
dN_dxi = N_vec;
dN_deta = N_vec;

keyboard

for j = 1:q+1
    for i = 1:p+1
        N_vec((j-1)*(p+1)+i) = N(i)*N(j);
        dN_dxi((j-1)*(p+1)+i) = dN(i)*N(j);
        dN_deta((j-1)*(p+1)+i) = N(i)*dN(j);
        
    end
end


end

