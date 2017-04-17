function detJ = detJ_calc(pts, dN_dxi, dN_deta, p)
	x = pts(:, 1);
	y = pts(:, 2);
	detJ = dx_dxi_calc(x, dN_dxi)*dx_dxi_calc(y, dN_deta)...
	- dx_dxi_calc(y, dN_dxi)*dx_dxi_calc(x, dN_deta);
end