function [N_vec, dN_dxi, dN_deta] = lagrange2D(pts, p, q)
	N = zeros(p+1, 1);
    dN = zeros(p+1, 1);
	
	N_vec = zeros((p+1)*(q+1),1);
	
	for a = 1:p+1
		N(a) = N_calc(pts(a), a, p);
		dN(a) = dN_calc(pts(a), a, p);
    end
    
    keyboard
		
	[ N_vec,dN_dxi,dN_deta ] = N_define( N,dN,p,q );
	
    keyboard
end