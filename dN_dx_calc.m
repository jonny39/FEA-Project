function dN_dx = dN_dx_calc(nodes_e, dN_dxi, dN_deta, a, detJ)
	dN_dx = (dN_dxi(a)*dx_dxi_calc(nodes_e, dN_deta)...
          - dN_deta(a)*dx_dxi_calc(nodes_e, dN_dxi))/detJ;
end