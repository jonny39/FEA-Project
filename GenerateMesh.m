function mesh = GenerateMesh(elementType,rectangularGeometry,radialGeometry)

N = rectangularGeometry(1);
M = rectangularGeometry(2);

theta1 = radialGeometry(1);
theta2 = radialGeometry(2);
r1 = radialGeometry(3);
r2 = radialGeometry(4);

    if strcmp(elementType,'rect') == 1
        mesh = LagrangeNodes(m,M,p,n,N,q);
    else
        theta1 = 0; %starting angle
        theta2 = pi/2; %ending angle
        r1 = .03; %inside radius
        r2 = .08; %outside radius

        mesh = RadialNodes(theta1,theta2,r1,r2,m,n,p,q);
    end
end