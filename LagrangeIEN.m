function [ IEN ] = LagrangeIEN( m,p,n,q )
%Define IEN for lagrange basis up to cubic

    n_el = m*n;

    nnx = m+1+m*(p-1);
    nny = n+1+n*(q-1); %not sure if needed

    IEN = zeros(n_el,q*(p+1)+p+1);

    for e = 1:n_el

        %what column it's on
        i_el = mod(e-1,m);
        %what row it's on
        j_el = floor((e-1)/m);

        i_el_s = i_el*p;
        j_el_s = j_el*q;

        for j = 1:1:q+1
            for i = 1:p+1
                i_c = i_el_s + i-1;
                j_c = j_el_s + j-1;
                A = j_c*(nnx) + i_c;
                a = (j-1)*(p+1)+i;
                IEN(e,a) = A+1;

            end
        end

    end

end

