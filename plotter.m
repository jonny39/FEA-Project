function [  ] = plotter( d,mesh,plot_desired,m,n,ndof,E,nu,pts,nodes_e )
%This function plots the solution

%what value needs to be plotted. 1 = x displacement, 2 = y displacement, 
%3 = von mises stress, 4 = sigma x, 5 = sigma y, 6 = torsional stress
%7 = node locations

n_loop = length(d)/2;

d_plot = zeros(n_loop,1);

switch plot_desired
    
    case 1 %x displacement
        x_displacement = zeros(size(d,1)/2);
        for i = 1:n_loop
            x_displacement(i) = d((i-1)*ndof+1);
        end
        
        x_locations = mesh(1:(m+1),1);
        y_locations = zeros(n+1,1);
        for j = 1:(n+1)
            y_locations(j) = mesh((j-1)*(m+1)+1,2);
        end

        z = zeros(length(y_locations),length(x_locations));
        for k = 1:length(y_locations)
            for m = 1:length(x_locations)
                z(k,m) = x_displacement((k-1)*length(x_locations)+m);
            end
        end
            
        [C,h] = contourf(x_locations,y_locations,z);
        clabel(C,h)
        
    case 2 %y displacement
        y_displacement = zeros(size(d,1)/2);
        for i = 1:n_loop
            y_displacement(i) = d((i-1)*ndof+2);
        end
        
        x_locations = mesh(1:(m+1),1);
        y_locations = zeros(n+1,1);
        for j = 1:(n+1)
            y_locations(j) = mesh((j-1)*(m+1)+1,2);
        end

        z = zeros(length(y_locations),length(x_locations));
        for k = 1:length(y_locations)
            for m = 1:length(x_locations)
                z(k,m) = y_displacement((k-1)*length(x_locations)+m);
            end
        end
            
        [C,h] = contourf(x_locations,y_locations,z);
        clabel(C,h)
        
    case 3 %von mises
        D = buildD(E, nu);
        for e = 1:size(LM,1)
            [pts, ~] = guassQuad(n_int);	
            for igpt = 1:n_int^2
                [N, dN_dxi, dN_deta] = lagrange2D(pts(igpt,:), p, q); 
                [~, dN_dx, dN_dy] = lagrange2Dspatial(dN_dxi, dN_deta, nodes_e(:,:,e));

                sigma = computeStress(D,dN_dx,dN_dy,d,n_dof,e,IEN,n_en);
                x = x_locator(nodes_e(:,:,e),N)
            end
        end
        
        
        
        
        for i = 1:n_loop
            sigma1 = d((i-1)*3+1);
            sigma2 = d((i-1)*3+2);
            sigma12 = 0; %fix this
            d_plot(i) = sqrt(sigma1^2 - sigma1*sigma2 + sigma2^2 + 3*sigma12^2);
        end
        
    case 4 %sigma x
        D = buildD(E, nu);
        
    case 5 %sigma y
        D = buildD(E, nu);
        
    case 6 %torsional stress
        D = buildD(E, nu);
        
    case 7 %total disp
        for i = 1:n_loop
            x_displacement(i) = d((i-1)*ndof+1);
            y_displacement(i) = d((i-1)*ndof+2);
        end
        x = mesh(:,1);
        y = mesh(:,2);

        x_plot = x+x_displacement';
        y_plot = y + y_displacement';

        figure(1)
        clf
        hold on
        for i = 1:size(x_plot,1)
            plot(x_plot(i),y_plot(i),'b*')
        end
        
end


%contourf(x,y,d_plot);

        
        


end

