function P = neumann(n_int, n_en, n_dof,p,q,h,nodes_e,problemNumber,geoLimit)
	n_face = 4;
	P = zeros(n_en*n_dof+n_dof,1);
    
    for iface = 1:n_face
		[pts, wts] = gaussQuad1D(n_int,iface);
		for igptf = 1:n_int
			[N, dN_dxi, dN_deta] = lagrange2D(pts(igptf,:), p, q);
			[detJ, ~, ~] = lagrange2DspatialFace(pts, p, q, N, dN_dxi, dN_deta, nodes_e,iface);
			h_applied = getNeumannField(pts(igptf,:),problemNumber,geoLimit,h,nodes_e,iface);
			for a = 1:n_en
				for i = 1:n_dof
					P((a-1)*n_dof + i) = P((a-1)*n_dof + i) + N(a)*h_applied(i)*detJ*wts(igptf);
				end
			end
		end
    end
end