function [K] = stiffness(LM, IEN, d, D, n_int, p, q, n_dof, n_en, nodes_e)

% Initializations
k_e = zeros((n_dof)*(n_en-1) + n_dof);
K = zeros(max(max(max(LM))),max(max(max(LM))));

    for e = 1:size(LM,1)
        k_e = k_e*0;

        % Get quadrature stuff
        [pts, W] = guassQuad(n_int);

        % Assembly element k_e
        for igpt = 1:n_int
            [N, dN_dxi, dN_deta] = lagrange2D(pts(igpt,:), p, q); 
            [detJ, dN_dx, dN_dy] = lagrange2Dspatial(pts, p, q, N, dN_dxi, dN_deta, nodes_e);

            for a = 1:n_en
                [Ba,~] = BandStrain(dN_dx,dN_dy,a,d,n_dof,e,IEN);

                for b = 1:n_en
                    [Bb,~] = BandStrain(dN_dx,dN_dy,a,d,n_dof,e,IEN);

                    for i = 1:n_dof
                        for j = 1:n_dof
                            r = (a-1)*n_dof + i;
                            s = (b-1)*n_dof + j;
                            temp = Ba'*D*Bb;
                            k_e(r,s) = k_e(r,s) + temp(i,j)*W(igpt)*detJ;
                        end
                    end
                end
            end
        end

        % Assemble global K
        for a = 1:n_en
            for i = 1:n_dof
                P = LM(e, a, i);
                r = (a-1)*n_dof + i;

                if P > 0
                    for b = 1:n_en
                        for j = 1:n_dof
                            Q = LM(e, b, j);
                            s = (b-1)*n_dof + j;
                            if Q > 0
                                K(P, Q) = K(P, Q) + k_e(r, s);
                            end
                        end
                    end
                end
            end
        end
    end
keyboard

end



