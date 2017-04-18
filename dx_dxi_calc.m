function dx_dxi = dx_dxi_calc(nodes_e, dN_dxi)
	dx_dxi = 0;
	for a = 1:length(dN_dxi)
		dx_dxi = dx_dxi + nodes_e(a)*dN_dxi(a);
	end
end