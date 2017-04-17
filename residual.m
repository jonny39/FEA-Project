function [R] = residual(F_inc, LM, mesh, d, E, nu, n_int, p, q, n_dof, n_en, nodes_e)

% Initializations
r_e = zeros(n_en*n_dof+n_dof,1);
R = zeros(max(max(LM)),1);

for e = 1:length(mesh)
	r_e = r_e*0;
	
	% Assembly element r_e
	D = buildD(E, nu); 	% Inputs are material properties
	[pts, wts] = guassQuad(n_int);		% Get quadrature stuff
	
	for igpt = 1:n_int
		[N, dN_dxi, dN_deta] = lagrange2D(pts(i), p, q, n_int); 
		[dN_dx, dN_dy, detJ, x] = lagrange2Dspatial(pts(i), p, q, N, dN_dxi, dN_deta, nodes_e, n_int);
		
		sigma = computeStress(d(e), dN_dx, dN_dy);
		bf = getBodyForce(nodes_e);
		
		for a = 1:n_en
			[Ba,~] = BandStrain(a, dN_dx, dN_dy);
			for i = 1:n_dof
				r = a*n_dof + i;
				r_e(r) = r_e(r) + (bf(i)*N(a)*F_inc-Ba'*sigma)*wts(igpt)*detJ;
			end
		end
	end
	
	% Assemble global R
	for a = 1:n_en
		for i = 1:n_dof
			loc = LM(e, a, i);
			r = a*n_dof + i;
			
			if loc >= 0
				R(loc) = R(loc) + r_e(r);
			end
		end
	end
end