function P = neumann(n_int, n_en)
	n_face = 4;
	P = n_en*n_dof+n_dof;
	for iface = 1:n_face
		[pts, wts] = guassQuad(n_int);
		for igptf = 1:n_int
			[N, dN_dxi, dN_deta] = lagrange2D(pts(igpt,:), p, q);
			[detJ, dN_dx, dN_dy] = lagrange2Dspatial(pts, p, q, N, dN_dxi, dN_deta, nodes_e);
			h = getNeumannField(pts);
			for a = 1:n_en
				for i = 1:n_dof
					P(a*n_dof + i) = P(a*n_dof + i) + N(a)*h(i)*detJ*wts(igptf);
				end
			end
		end
	end
end