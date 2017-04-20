function N = N_calc(z, a, p)
    if p == 1
        if a == 1
			N = (1-z)/2;
        elseif a == 2
			N = (z+1)/2;
		end
    elseif p == 2
        if a == 1
			N = 0.5*z*(z-1);
        elseif a == 2
			N = 1-z^2;
        elseif a == 3
            N = 0.5*z*(z+1);
        end
    elseif p == 3
        if a == 1
            N = (-1/16)*(9*z^3-9*z^2-z+1);
        elseif a == 2
            N = (9/16)*(3*z^3-z^2-3*z+1);
        elseif a == 3
            N = (-9/16)*(3*z^3+z^2-3*z-1);
        elseif a == 4
            N = (1/16)*(9*z^3+9*z^2-z-1);
        end
    end
end