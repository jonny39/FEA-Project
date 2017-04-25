function [ h_applied ] = getNeumannField( x,problemNumber,geoLimit,h,nodes_e )
%Given the location, define h in x and y direction

h_applied = zeros(2,1);

if problemNumber == 1
%     h = 0;
elseif problemNumber == 2
    if nodes_e(2,1) == geoLimit
        h_applied(1) = h(1);
        h_applied(2) = h(2);
    end
elseif problemNumber == 3
    radius = sqrt(x(1)^2+x(2)^2);
    if radius <= geoLimit
        theta = atan(x(2)/x(1));
        h_applied(1) = cos(theta)*sqrt(h(1)^2+h(2)^2);
        h_applied(2) = sin(theta)*sqrt(h(1)^2+h(2)^2);
    end
end

end

