function [K] = stiffness(LM, mesh, d, E, nu, n_int, n_f, n_dof, n_en, nodes_e)

% Initializations
k_e = zeros((n_dof+1)*n_en)
K = spalloc(max(max(LM)))

for e = 1:length(mesh)
	k_e = k_e*0;
	
	% Assembly element k_e
	[D] = buildD(E, nu); 	% Inputs are material properties
	[pts, wts] = gaussQuad(n_int);		% Get quadrature stuff
	
	for igpt = 1:n_int
		[N, dN_dxi, dN_deta] = lagrange2D(pts(i), p, q, n_int); 
		[dN_dx, dN_dy, detJ, x] = lagrange2Dspatial(pts(i), p, q, N, dN_dxi, dN_deta, nodes_e, n_int);
		
		for a = 1:n_en
			Ba = getB(a, dN_dx, dN_dy);
			
			for b = 1:n_en
				Bb = getB(b, dN_dx, dN_dy);
				
				for i = 1:n_dof
					for j = 1:n_dof
						r = a*n_dof + i;
						s = b*n_dof + j;
						k_e(r, s) = k_e(r, s) + Ba'*D*Bb*wts[igpt]*detJ;
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
						s = b*n_dof + j;
						
						if q >= 0
							K(p, q) = K(p, q) + k_e(r, s);
						end
					end
				end
			end
		end
	end
end