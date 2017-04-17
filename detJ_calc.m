function detJ = detJ_calc(pts, dN, p)
	x = pts(1);
	y = pts(2);
	detJ = dx_dxi_calc(x, dN, p)*dx_dxi_calc(y, dN, p)...
	- dx_dxi_calc(y, dN, p)*dx_dxi_calc(x, dN, p);
end