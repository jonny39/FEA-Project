function [detJ, dN_dx, dN_dy] = lagrange2DspatialFace(pts, p, q, N, dN_dxi, dN_deta, nodes_e,iface)

    switch iface
        case 1
            dy_deta = dx_dxi_calc(nodes_e(:,2), dN_deta);
            detJ = norm(dy_deta);
        case 2
            dx_dxi = dx_dxi_calc(nodes_e(:,1), dN_dxi);
            detJ = norm(dx_dxi);
        case 3
            dy_deta = dx_dxi_calc(nodes_e(:,2), dN_deta);
            detJ = norm(dy_deta);
        case 4
            dx_dxi = dx_dxi_calc(nodes_e(:,1), dN_dxi);
            detJ = norm(dx_dxi);
    end
    dN_dx = zeros(length(dN_dxi),1);
	dN_dy = zeros(length(dN_deta),1);

	for a = 1:length(dN_dx)
		dN_dx(a) = dN_dx_calc(nodes_e(:,2), dN_dxi, dN_deta, a, detJ);
		dN_dy(a) = dN_dx_calc(nodes_e(:,1), dN_deta, dN_dxi, a, detJ);
    end
end