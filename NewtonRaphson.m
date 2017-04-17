function d = NewtonRaphson(mesh, LM, E, nu, p, q, n_dof, n_en, nodes_el)
	F_inc0 = 1;
	epsilon = 1e-8;
	i_max = 10;
	n_max = ceil(1./F_inc0);
	n = 0;
	d = zeros(size(mesh, 1)*n_dof, 1);
	n_int = ceil((p+1)/2);
	
	while n < n_max
		F_inc = Finc0*(n+1)/n_max;
		R0 = residual(F_inc, LM, mesh, d, E, nu, n_int, p, q, n_dof, n_en, nodes_el);
		R = R0;
		i = 0;
		
		while i < i_max
			K = stiffness(LM, mesh, d, E, nu, n_int, p, n_dof, n_en, nodes_el);
			delta = K/R;
			d = d + delta;
			
			R0 = residual(F_inc, LM, mesh, d, E, nu, n_int, p, q, n_dof, n_en, nodes_el);
			
			if norm(R) <= norm(R0)*epsilon
				break;
			end
			
			i = i + 1;
		end
		
		n = n + 1;
			
	end
end