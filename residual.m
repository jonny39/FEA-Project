function [R] = residual(F_inc, LM, IEN, d, D, n_int,...
                        p, q, n_dof, n_en, nodes_e,problemNumber,h,geoLimit,body_force)

% Initializations
r_e = zeros(n_en*n_dof+n_dof,1);
R = zeros(max(max(max(LM))),1);

for e = 1:size(LM,1)
	r_e = r_e*0;
	
	% Assembly element r_e
	[pts, wts] = guassQuad(n_int);		% Get quadrature stuff
	
	for igpt = 1:n_int^2
		[N, dN_dxi, dN_deta] = lagrange2D(pts(igpt,:), p, q); 
		[detJ, dN_dx, dN_dy] = lagrange2Dspatial(dN_dxi, dN_deta, nodes_e(:,:,e));
        
        sigma = computeStress(D,dN_dx,dN_dy,d,n_dof,e,IEN,n_en);
		
        for a = 1:n_en
			Ba = Bcalc(dN_dx,dN_dy,a);
            ba = Ba'*sigma;
            for i = 1:n_dof
                bf = body_force(i);
				r = (a-1)*n_dof + i;
				r_e(r) = r_e(r) + (bf*N(a)*F_inc - ba(i))*wts(igpt)*detJ;
            end
        end
	end
    
    %now add Neumann
    if problemNumber == 2
        r_e = r_e + neumann(n_int, n_en, n_dof,p,q,h,nodes_e,problemNumber,geoLimit);
%         r_e2 = neumann(n_int, n_en, n_dof,p,q,h,nodes_e,problemNumber,geoLimit);
%     else
%         r_e2 = zeros(size(r_e));
    end
    
%     r_e = r_e + r_e2;
    	
	% Assemble global R
	for a = 1:n_en
        for i = 1:n_dof
			loc = LM(e, a, i);
            if loc > 0 

                r = (a-1)*n_dof + i;
                R(loc) = R(loc) + r_e(r);
            end
        end
	end
end