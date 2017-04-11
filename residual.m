function [R] = Residual(LM, mesh, d, E, nu, n_int, n_f, n_dof, n_en)

% Initializations

for e = 1:length(mesh)
	r_e = r_e*0;
	x_a = x_a_(mesh);
	
	% Assembly element r_e
	[D] = buildD(E, nu); 	% Inputs are material properties
	[pts, wts] = QuadratureRule(n_int, n_int);		% Get quadrature stuff
	
	for igpt = 1:n_int
		[N, dN_dxi, dN_deta] = lagrange2D(xi(igpt), eta(igpt), p, q);  % what are p and q 
		[dN_dx, dN_dy, detJ, x] = lagrange2Dspatial(xi(igpt), eta(igpt), p, q, N, dN_dxi, dN_deta, x_e);
		
		sigma = computeStress(d(e), dN_dx, dN_dy);
		bf = getBodyForce(x);
		
		for a = 1:n_en
			Ba = getB(a, dN_dx, dN_dy);
			for i = 1:n_dof
				r = a*n_dof + i;
				r_e(r) = r_e(r) + (bf(i)*N(a)-Ba'*sigma)*w[igpt]*detJ;
			end
		end
	end
	
	% Assemble global R
	for a = 1:n_en
		for i = 1:n_dof
			p = LM(e, a, i);
			r = a*n_dof + i;
			
			if p >= 0
				R(p) = R(p) + r_e(r);
			end
		end
	end
end