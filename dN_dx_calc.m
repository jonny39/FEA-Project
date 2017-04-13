function dN_dx = dN_dx_calc(dN_dxi, dN_deta, y, p)
	dN_dx = dN_dxi*dx_dxi_(y, dN_deta, n_f, i) - dN_deta*dx_dxi_(y, dN_dxi, n_f, i);
end