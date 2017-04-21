function D = buildD(E, nu)
	lambda = nu*E/((1+nu)*(1-2*nu));
	mu = E/(2*(1+nu));
	
<<<<<<< HEAD
	lambda_bar = 2*mu*lambda/(lambda + 2*mu);
	
	D = [2*mu+lambda_bar    lambda_bar          0;
		 lambda_bar         2*mu+lambda_bar     0;
		 0             		0               	mu];
=======
	D = [lambda + 2*mu    lambda            0;
		 lambda           lambda + 2*mu     0;
		 0                0               mu];
>>>>>>> 39f8306049c5ee058190227b838280b22a88c5ad
end