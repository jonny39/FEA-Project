function bf = getBodyForce(problemNumber,e,m,IEN)
if problemNumber == 1
	bf = 0;
elseif problemNumber == 2
    if mod(e-1,m)
        
        for s = 1:length(mesh)

            if mesh(s,1) == M
                d(s*2-1) = 1;
            end
        end
    end
end
end