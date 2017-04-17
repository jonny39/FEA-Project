function dN = dN_calc(z, a, p)
    if p == 1
        if a == 1
			dN = -0.5;
        elseif a == 2
			dN = 0.5;
		end
	end
end