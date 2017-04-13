function dx_dxi = dx_dxi_calc(x, dN_dxi)
	dx_dxi = 0;
	for a = 1:length(dN_xi)
		dx_dxi = dx_dxi + x(a)*dN_xi(a);
	end
end