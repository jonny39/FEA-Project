function d = NewtonRaphson(mesh, LM, )
	F_inc0 = 1;
	conv = 1e-8;
	i_max = 10;
	n_max = 1./F_inc0;
	n = 0;
	d = I dont know
	
	while n < n_max
		F_inc = Finc0*(n+1)/n_max;
		R0 = residual(F_inc, LM, mesh, d, E, nu, n_int, p, q, n_dof, n_en, nodes_e);
		R = R0;
		i = 0;
		
		while i < i_max
			K = stiffness(LM, mesh, d, E, nu, n_int, n_f, n_dof, n_en, nodes_e);
			delta = K/R
			d = d + delta;
			
			R0 = residual(F_inc, LM, mesh, d, E, nu, n_int, p, q, n_dof, n_en, nodes_e);
			
			if norm(R) < norm(R0)
				break;
			end
			
			i = i + 1
		end
		
		n = n + 1
			
	end
end