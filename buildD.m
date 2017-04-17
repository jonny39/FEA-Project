function D = buildD(E, nu)
	lambda = nu*E/((1+nu)*(1-2*nu));
	mew = E/(2*(1*nu));
	
	D = [2*mew+lambda 0 0;
		 0 2*mew+lambda 0;
		 0 0 mew];
end