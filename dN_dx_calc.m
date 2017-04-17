function dN_dx = dN_dx_calc(y, dN_dxi, dN_deta, a, detJ)
	dN_dx = (dN_dxi(a)*dx_dxi_calc(y, dN_deta) - dN_deta(a)*dx_dxi_calc(y, dN_dxi))/detJ;
end