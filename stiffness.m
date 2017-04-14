function [K] = Stiffness(LM, mesh, d, E, nu, n_int, n_f, n_dof, n_en)

% Initializations

for e = 1:length(mesh)
	k_e = k_e*0;
	x_a = x_a_(mesh);
	
	% Assembly element k_e
	[D] = buildD(E, nu); 	% Inputs are material properties
	[pts, wts] = gaussQuad(n_int);		% Get quadrature stuff
	
	for igpt = 1:n_int
		[N, dN_dxi, dN_deta] = lagrange2D(xi(igpt), eta(igpt), p, q);  % what are p and q 
		[dN_dx, dN_dy, detJ, x] = lagrange2Dspatial(xi(igpt), eta(igpt), p, q, N, dN_dxi, dN_deta, x_e);
		
		for a = 1:n_en
			Ba = getB(a, dN_dx, dN_dy);
			
			for b = 1:n_en
				Bb = getB(b, dN_dx, dN_dy);
				
				for i = 1:n_dof
					for j = 1:n_dof
						r = a*n_dof + i;
						s = b*n_dof + j;
						k_e(r, s) = k_e(r, s) + Ba'*D*Bb*w[igpt]*detJ;
					end
				end
			end
		end
	end
	
	% Assemble global K
	for a = 1:n_en
		for i = 1:n_dof
			p = LM(e, a, i);
			r = a*n_dof + i;
			
			if p >= 0
				for b = 1:n_en
					for j = 1:n_dof
						q = LM(e, b, j);
						s = b+n_dof + j;
						
						if q >= 0
							K(p, q) = K(p, q) + k_e(r, s);
						end
					end
				end
			end
		end
	end
end