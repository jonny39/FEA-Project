%returns Guass Quadrature locations and weights
function [xi,W] = guassQuad(nInt)
    switch nInt
        case 2
            xi = [-sqrt(3)/3 sqrt(3)/3];
            W = [1 1];
        case 3
            xi = [-sqrt(3/5) 0 sqrt(3/5)];
            W = [5/9 8/9 5/9];
    end
end