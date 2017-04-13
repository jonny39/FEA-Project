function detJ = detJ_calc(x, y, dN, p)
	detJ = dx_dxi_calc(x, dN, p)*dx_dxi_calc(y, dN, p)...
	- dx_dxi_calc(y, dN, p)*dx_dxi_calc(x, dN, p);
end