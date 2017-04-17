function [detJ, dN_dx, dN_dy] = lagrange2Dspatial(pts, p, q, N, dN_dxi, dN_deta, nodes_e, n_int)
	dN_dx = zeros(length(dN_dxi));
	dN_dy = zeros(length(dN_deta));
	detJ = detJ_calc(pts, dN_dxi, dN_deta, p);
	for a = 1:length(dN_dx)
		dN_dx(a) = dN_dx_calc(dN_dxi(a), dN_deta(a), y, p, q);
		dN_dy(a) = dN_dx_calc(dN_deta(a), dN_dxi(a), x, p, q);
	end
end