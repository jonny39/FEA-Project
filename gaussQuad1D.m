%returns Guass Quadrature locations and weights
function [pts,W] = gaussQuad1D(nInt,iface)
    switch nInt
        case 1
            switch iface
                case 1
                    pts = [1 0];
                    W = 4;
                case 2
                    pts = [0 1];
                    W = 4;
                case 3
                    pts = [-1 0];
                    W = 4;
                case 4
                    pts = [0 -1];
                    W = 4;
            end
        case 2
            switch iface
                case 1
                    pts = [1 sqrt(3)/3;...
                            1 -sqrt(3)/3];
                    W = [1; 1];
                case 2
                    pts = [sqrt(3)/3 1;...
                           -sqrt(3)/3 1];
                    W = [1; 1];
                case 3
                    pts = [-1 sqrt(3)/3;...
                            -1 -sqrt(3)/3];
                    W = [1; 1];
                case 4
                    pts = [sqrt(3)/3 -1;...
                            -sqrt(3)/3 -1];
                    W = [1; 1];
            end
        case 3
            switch iface
                case 1
                    pts = [1 sqrt(3/5);...
                           1 0;...
                           1 -sqrt(3/5)];
                    W = [5/9; 8/9; 5/9];
                case 2
                    pts = [sqrt(3/5) 1;...
                           0 1;...
                           -sqrt(3/5) 1];
                    W = [5/9; 8/9; 5/9];
                case 3
                    pts = [-1 sqrt(3/5);...
                           -1 0;...
                           -1 -sqrt(3/5)];
                    W = [5/9; 8/9; 5/9];
                case 4
                    pts = [sqrt(3/5) -1;...
                           0 -1;...
                           -sqrt(3/5) -1];
                    W = [5/9; 8/9; 5/9];
            end
    end
end