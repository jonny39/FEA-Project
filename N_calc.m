function N = N_calc(z, a, p)
    if p == 1
        if a == 1
			N = (1.-z)/2.;
        elseif a == 2
			N = (z+1.)/2.;
		end
	end		
end