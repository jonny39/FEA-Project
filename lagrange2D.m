function [N_vec, dN_dxi, dN_deta] = lagrange2D(pts, p, q)
N_xi = zeros(p+1,1);
N_eta = zeros(p+1,1);
dN_xi = zeros(p+1,1);
dN_eta = zeros(p+1,1);
	
	for a = 1:(p+1)
		N_xi(a) = N_calc(pts(1), a, p);
        N_eta(a) = N_calc(pts(2),a, p);
		dN_xi(a) = dN_calc(pts(1), a, p);
        dN_eta(a) =  dN_calc(pts(2), a, p);
    end
    
[N_vec,dN_dxi,dN_deta] = N_define(N_xi,N_eta,dN_xi,dN_eta,p,q);
	
end