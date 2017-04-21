function mesh = GenerateMesh(elementType,Geometry,m,n,p,q)
    if strcmp(elementType,'rect') == 1
    M = Geometry(1);
    N = Geometry(2);
    elseif strcmp(elementType,'rad') == 1
    theta1 = Geometry(1);
    theta2 = Geometry(2);
    r1 = Geometry(3);
    r2 = Geometry(4);
    end

    if strcmp(elementType,'rect') == 1
        mesh = LagrangeNodes(m,M,p,n,N,q);
    elseif strcmp(elementType,'rad') == 1
        mesh = RadialNodes(theta1,theta2,r1,r2,m,n,p,q);
    end
end