function [detJ, dN_dx, dN_dy] = lagrange2Dspatial(pts, p, q, N, dN_dxi, dN_deta, nodes_e)

    detJ = detJ_calc(pts, dN_dxi, dN_deta, p, nodes_e, N);
	dN_dx = zeros(length(dN_dxi),1);
	dN_dy = zeros(length(dN_deta),1);

	for a = 1:length(dN_dx)
		dN_dx(a) = dN_dx_calc(nodes_e(:,2), dN_dxi, dN_deta, a, detJ);
		dN_dy(a) = dN_dx_calc(nodes_e(:,1), dN_deta, dN_dxi, a, detJ);
    end
end