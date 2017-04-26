function [ h_applied ] = getNeumannField( x,problemNumber,geoLimit,h,nodes_e,iface )
%Given the location, define h in x and y direction

h_applied = zeros(2,1);

if problemNumber == 1
%     h = 0;
elseif problemNumber == 2
    if max(nodes_e(:,1)) == geoLimit
        h_applied(1) = h(1);
        h_applied(2) = h(2);
    end
elseif problemNumber == 3
    radius = sqrt(nodes_e(1,1)^2+nodes_e(1,2)^2);
    if iface == 3
        theta = zeros(sqrt(size(nodes_e,1)),1);
        
        for i = 1:sqrt(size(nodes_e,1))
            theta(i) = atan(nodes_e((i-1)*3+1,2)/nodes_e((i-1)*3+1,1));
        end
        
        x = [-1 1];
        v = [theta(1) theta(size(theta,1))];
        vq = interp1(x,v,xi(2));

        if radius <= geoLimit
            h_applied(1) = cos(vq)*sqrt(h(1)^2+h(2)^2);
            h_applied(2) = sin(vq)*sqrt(h(1)^2+h(2)^2);
        end
    end
end
end

