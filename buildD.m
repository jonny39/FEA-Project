function D = buildD(E, nu)
	lambda = nu*E/((1+nu)*(1-2*nu));
	mu = E/(2*(1+nu));
	
	D = [lambda + 2*mu    lambda            0;
		 lambda           lambda + 2*mu     0;
		 0                0               mu];
end