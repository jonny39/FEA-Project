function x_xi = x_xi_calc(x, N, n_int)
	x_xi = zeros(n_int, 1);
	for a = 1:n_f
		x_xi(a) = x_xi + x*N(a, i);
	end
end