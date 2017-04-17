function [N_vec, dN_dxi, dN_eta] = lagrange2D(z, p, q, n_int)
	N = zeros(p+1, n_int);
    dN = zeros(p+1, n_int);
	
	N_vec = zeros((p+1)*(q+1),1);
	dN_dxi = N_vec;
	dN_deta = N_vec;
	
	for i = 1:n_int
		for a = 1:p+1
			N(a, i) = N_calc(z(i), a, p);
			dN(a, i) = dN_calc(z(i), a, p);
		end
		
		[ N_vec(:, i),dN_dxi(:, i) ,dN_deta(:, i) ] = N_define( N(:, i),dN(:, i),p,q );
		
	end	
end