
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Local Parent Functions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function N = N_(xi, n, n_f):
    if n_f == 2
        if n == 1
			N = (1.-xi)/2.
        elseif n == 2
			N = (xi+1.)/2.
		end
	end		
end

function dN_dxi = dN_dxi_(xi, n, n_f):
    if n_f == 2
        if n == 1
			dN_dxi = -0.5;
        elseif n == 2
			dN_dxi = 0.5;
		end
	end
end

function N, dN_dxi, dN_deta, J = LocalParent(xi, eta, n_f, n_int, dim)
	N = zeros(n_f, n_int, d)
    dN_dxi = zeros(n_f, n_int)
	dN_deta = zeros(n_f, n_int)
	for i = 1:n_int
		for a = 1:n_f
			for d = 1:dim
				if d == 1
					N(a, i, d) = N_(xi(i), a);
				elseif d == 2
					N(a, i, d) = N_(eta(i), a);
				end
			end
			dN_dxi(a, i) = dN_dxi_(xi(i), a);
			dN_deta(a, i) = dN_dxi_(eta(i), a);
		end
	end	
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% End Local Parent Functions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Global Shape Functions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function x_xi = x_xi_(x_a, N, i)
	x_xi = zeros(n_int, 1);
	for a = 1:n_f
		x_xi = x_xi + x_a*N(a, i);
	end
end

function dx_dxi = dx_dxi_(x_a, dN_dxi, n_f, i)
	dx_dxi = 0;
	for a = 1:n_f
		dx_dxi = dx_dxi + x_a(a)*dN_dxi(a, i);
	end
end

function dN_dx = dN_dx_(dN_dxi, dN_deta, y_a, n_f, i)
	dN_dx = dN_dxi*dx_dxi_(y_a, dN_deta, n_f, i) - dN_deta*dx_dxi_(y_a, dN_dxi, n_f, i);
end

function detJ = detJ_(x_a, y_a, dN_dxi, dN_deta, n_f, i)
	detJ(i) = dx_dxi_(x_a, dN_dxi(:, i), n_f, n_int)*dx_dxi_(y_a, dN_deta(:, i), n_f, n_int)...
	- dx_dxi_(y_a, dN_dxi(:, i), n_f, n_int)*dx_dxi(x_a, dN_deta(:, i), n_f, n_int);
end

function detJ, dN_dx, dN_dy = GlobalShape(x_a, y_a, dN_dxi, dN_deta, n_f, n_int, i)
	detJ = zeros(n_int, 1);
	dN_dx = zeros(n_f, n_int);
	dN_dy = zeros(n_f, n_int);
	for i = 1:n_int
		detJ(i) = detJ_(x_a, y_a, dN_dxi, dN_deta, n_f, i);
		dN_dx(i) = dN_dx_(dN_dxi, dN_deta, y_a, n_f, i);
		dN_dy(i) = dN_dx_(dN_deta, dN_dxi, x_a, n_f, i);
	end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% End Global Shape Functions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%