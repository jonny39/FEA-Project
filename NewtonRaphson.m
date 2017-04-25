function [d] = NewtonRaphson(mesh, LM, IEN, ID, E, nu,...
    p, q, m, n_dof, n_en, nodes_e,problemNumber,Geometry,displacement,h,body_force)

	if length(Geometry) == 2 %rectangular mesh
        geoLimit = Geometry(1);
    elseif length(Geometry) == 4 %radial mesh
        geoLimit = Geometry(1); %outside radius
    end
    
    D = buildD(E, nu); 	% Inputs are material properties
    
    F_inc0 = 1;
	epsilon = 1e-8;
	i_max = 10;
	n_max = ceil(1./F_inc0);
	n = 0;
	d = zeros(size(mesh, 1)*n_dof, 1);
    if problemNumber == 1
        for s = 1:length(mesh)
            if mesh(s,1) == geoLimit
                d(s*2-1) = displacement(1);
                d(s*2) = displacement(2);
            end
        end
    end
	n_int = ceil((p+1)/2);
	
	while n < n_max
		F_inc = F_inc0*(n+1)/n_max;
		R0 = residual(F_inc, LM, IEN, d, D, n_int,...
                        p, q, n_dof, n_en, nodes_e,problemNumber,h,geoLimit,body_force);
		R = R0;
		i = 0;
		
		while i < i_max
			K = stiffness(LM, D, n_int, p, q, n_dof, n_en, nodes_e);
			delta = K\R;
            delta_i = 1;
            for L = 1:size(ID, 1)
                for k = 1:n_dof
                    if ID(L,k) ~= 0
                        d((L-1)*(n_dof)+k) = d((L-1)*(n_dof)+k) + delta(delta_i);
                        delta_i = delta_i + 1;
                    end
                end
            end
            
            R = residual(F_inc, LM, IEN, d, D, n_int,...
                        p, q, n_dof, n_en, nodes_e,problemNumber,h,geoLimit,body_force);
			                    
			if norm(R) <= norm(R0)*epsilon
				break;
			end
			
			i = i + 1;
		end
		
		n = n + 1;
			
	end
end