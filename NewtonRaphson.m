function [d] = NewtonRaphson(mesh, LM, ID, E, nu, p, q, n_dof, n_en, nodes_el,problemNumber,M)
	F_inc0 = 1;
	epsilon = 1e-8;
	i_max = 10;
	n_max = ceil(1./F_inc0);
	n = 0;
	d = zeros(size(mesh, 1)*n_dof, 1);
    if problemNumber == 1
        for s = 1:length(mesh)

            if mesh(s,1) == M
                d(s*2-1) = 1;
            end
        end
    end
	n_int = ceil((p+1)/2);
	
	while n < n_max
		F_inc = F_inc0*(n+1)/n_max;
		R0 = residual(F_inc, LM, mesh, d, E, nu, n_int, p, q, n_dof, n_en, nodes_el);
		R = R0;
		i = 0;
		
		while i < i_max
			K = stiffness(LM, mesh, d, E, nu, n_int, p, q, n_dof, n_en, nodes_el);
			delta = K\R;
            delta_i = 1;
            for L = 1:size(ID, 1)
                for k = 1:n_dof
                    if ID(L,k) ~=0
                        d((L-1)*(n_dof)+k) = d((L-1)*(n_dof)+k) + delta(delta_i);
                        delta_i = delta_i + 1;
                    end
                end
            end
            
			R0 = residual(F_inc, LM, mesh, d, E, nu, n_int, p, q, n_dof, n_en, nodes_el);
			
			if norm(R) <= norm(R0)*epsilon
				break;
			end
			
			i = i + 1;
		end
		
		n = n + 1;
			
	end
end