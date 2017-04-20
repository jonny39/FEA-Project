function dN = dN_calc(z, a, p)
    if p == 1
        if a == 1
			dN = -0.5;
        elseif a == 2
			dN = 0.5;
		end
    elseif p == 2
        if a == 1
            dN = z-0.5;
        elseif a == 2
            dN = -2*z;
        elseif a == 3
            dN = z+0.5;
        end
    elseif p == 3
        if a == 1
            dN = (-1/16)*(27*z^2-18*z-1);
        elseif a == 2
            dN = (9/16)*(9*z^2-2*z-3);
        elseif a == 3
            dN = (-9/16)*(9*z^2+2*z-3);
        elseif a == 4
            dN = (1/16)*(27*z^2+18*z-1);
        end
    end
end