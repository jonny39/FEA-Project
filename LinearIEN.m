function [ IEN ] = LinearIEN( e,m )
%Define the IEN array for a linear basis

nen = 4;

i_el = mod(e,m);
j_el = e/m;

for j = 1:sqrt(nen)+1
    for i = 1:sqrt(nen)+1
        i_c = i_el + i;
        j_c = j_el + j;
        A = j_c*(m+1) + i_c;
        a = j*(sqrt(nen))+i;
        IEN(e,a) = A;
        
    end
end
        


end

