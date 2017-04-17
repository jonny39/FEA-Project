function dN_dx = dN_dx_calc(y, dN_dxi, dN_deta)
	dN_dx = dN_dxi*dx_dxi_calc(y, dN_deta) - dN_deta*dx_dxi_calc(y, dN_dxi);
end