function [N_vec, dN_dxi, dN_eta] = lagrange2D(z, p, q, n_int)
	N = zeros(p+1, 1);
    dN = zeros(p+1, 1);
	
	N_vec = zeros((p+1)*(q+1),1);
	dN_dxi = N_vec;
	dN_deta = N_vec;
	
	for a = 1:p+1
		N(a) = N_calc(z(a), a, p);
		dN(a) = dN_calc(z(a), a, p);
	end
		
	[ N_vec,dN_dxi,dN_deta ] = N_define( N,dN,p,q );
	
end