function [detJ, dN_dx, dN_dy] = lagrange2Dspatial(pts, p, q, N, dN_dxi, dN_deta, nodes_e, n_int)
	detJ = zeros(n_int, 1);
	dN_dx = zeros(length(dN_dxi), n_int);
	dN_dy = zeros(length(dN_deta), n_int);
	for i = 1:n_int
		detJ(i) = detJ_calc(x, y, dN_dxi(:, i), dN_deta, p);
		for a = 1:length(dN_dx)
			dN_dx(a, i) = dN_dx_calc(dN_dxi(a, i), dN_deta(a, i), y, p, q);
			dN_dy(a, i) = dN_dx_calc(dN_deta(a, i), dN_dxi(a, i), x, p, q);
		end
	end
end