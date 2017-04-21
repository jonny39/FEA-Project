function [ IEN ] = LinearIEN( n,m )
%Define the IEN array for a linear basis

n_el = n*m;

%number of nodes per element
nen = 4;

%zero IEN
IEN = zeros(n_el,4);

for e = 1:n_el
    
    %what column it's on
    i_el = mod(e-1,m);
    %what row it's on
    j_el = floor((e-1)/m);

    for j = 1:sqrt(nen)
        for i = 1:sqrt(nen)
            i_c = i_el + i-1;
            j_c = j_el + j-1;
            A = j_c*(m+1) + i_c;
            a = (j-1)*(sqrt(nen))+i;
            %plus one for matlab (no zeroth index)
            IEN(e,a) = A+1;

        end
    end
        
end

end

