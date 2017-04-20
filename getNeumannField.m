function [ h ] = getNeumannField( x,problemNumber,geoLimit,t_magnitude )
%Given the location, define h in x and y direction

h = zeros(2,1);

if problemNumber == 1
    h = 0;
elseif problemNumber == 2
    if x(1) == geoLimit
        h = t_magnitude;
    end
elseif problemNumber == 3
    radius = sqrt(x(1)^2+x(2)^2);
    if radius <= geoLimit
        theta = atan(x(2)/x(1));
        h(1) = cos(theta)*t_magnitude;
        h(2) = sin(theta)*t_magnitude;
    end
end

end

