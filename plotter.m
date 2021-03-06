function plotter(d,mesh,plot_desired,m,n,ndof,LM_plot,E,nu,n_en,p,q,nodes_e,IEN)
%This function plots the solution

%what value needs to be plotted. 1 = x displacement, 2 = y displacement, 
%3 = von mises stress, 4 = sigma x, 5 = sigma y, 6 = torsional stress
%7 = node locations

clf

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
        
        n_int = ceil((p+1)/2);
        
        x_locations = zeros(size(LM_plot,1),n_int^2);
        y_locations = zeros(size(LM_plot,1),n_int^2);
        z = zeros(size(LM_plot,1),n_int^2);
        
        [pts, W] = guassQuad(n_int);
        
        for e = 1:size(LM_plot,1)
            for igpt = 1:n_int^2

                [N, dN_dxi, dN_deta] = lagrange2D(pts(igpt,:), p, q); 
                [~, dN_dx, dN_dy] = lagrange2Dspatial(dN_dxi, dN_deta, nodes_e(:,:,e));

                sigma = computeStress(D,dN_dx,dN_dy,d,ndof,e,IEN,n_en);
                von_mises = sqrt(sigma(1)^2 - sigma(1)*sigma(2) + sigma(2)^2 + 3*sigma(3)^2);
                
                x = [-1 1];
                if p == 1
                    nodes_x = [nodes_e(1,1,e) nodes_e(2,1,e)];
                    nodes_y = [nodes_e(1,2,e) nodes_e(3,2,e)];
                elseif p == 2
                    nodes_x = [nodes_e(1,1,e) nodes_e(3,1,e)];
                    nodes_y = [nodes_e(1,2,e) nodes_e(9,2,e)];
                end
                x_loc = interp1(x,nodes_x,pts(igpt,1));
                y_loc = interp1(x,nodes_y,pts(igpt,2));

                z(e,igpt) = von_mises;
                x_locations(e,igpt) = x_loc;
                y_locations(e,igpt) = y_loc;

            end
        end
        
        if n_int == 1
            z = [z z];
            x_locations= [x_locations x_locations*0];
            y_locations= [y_locations y_locations*0];
        end
        [C,h] = contourf(x_locations,y_locations,z);
        clabel(C,h)
        
    case 4 %sigma x
        D = buildD(E, nu);
        
        x_locations = mesh(1:(m+1),1);
        y_locations = zeros(n+1,1);
        for j = 1:(n+1)
            y_locations(j) = mesh((j-1)*(m+1)+1,2);
        end
        
        z = zeros(length(y_locations),length(x_locations));
        
        for e = 1:size(LM_plot,1)
            for node = 1:n_en
                
                switch p
                    case 1
                        pts = [-1 -1;
                               1 -1;
                               -1 1;
                               1 1];
                    case 2
                        pts = [-1 -1;
                                0 -1;
                                1 -1;
                                -1 0;
                                0 0;
                                1 0;
                                -1 1;
                                0 1;
                                1 1];
                end

                
                
                [N, dN_dxi, dN_deta] = lagrange2D(pts(node,:), p, q); 
                [~, dN_dx, dN_dy] = lagrange2Dspatial(dN_dxi, dN_deta, nodes_e(:,:,e));

                sigma = computeStress(D,dN_dx,dN_dy,d,ndof,e,IEN,n_en);
                
                loc = LM_plot(e,node)
                
                %what column it's on
                column = mod(loc-1,(m+1))+1
                %what row it's on
                row = floor((loc-1)/(1+m))+1
                
                z(row,column) = sigma(1);
            end
        end
        [C,h] = contourf(x_locations,y_locations,z);
        clabel(C,h)
        
        
    case 5 %sigma y
D = buildD(E, nu);
        
        x_locations = mesh(1:(m+1),1);
        y_locations = zeros(n+1,1);
        for j = 1:(n+1)
            y_locations(j) = mesh((j-1)*(m+1)+1,2);
        end
        
        z = zeros(length(y_locations),length(x_locations));
        
        for e = 1:size(LM_plot,1)
            for node = 1:n_en
                
                switch p
                    case 1
                        pts = [-1 -1;
                               1 -1;
                               -1 1;
                               1 1];
                    case 2
                        pts = [-1 -1;
                                0 -1;
                                1 -1;
                                -1 0;
                                0 0;
                                1 0;
                                -1 1;
                                0 1;
                                1 1];
                end

                
                
                [N, dN_dxi, dN_deta] = lagrange2D(pts(node,:), p, q); 
                [~, dN_dx, dN_dy] = lagrange2Dspatial(dN_dxi, dN_deta, nodes_e(:,:,e));

                sigma = computeStress(D,dN_dx,dN_dy,d,ndof,e,IEN,n_en);
                
                loc = LM_plot(e,node)
                
                %what column it's on
                column = mod(loc-1,(m+1))+1
                %what row it's on
                row = floor((loc-1)/(1+m))+1
                
                z(row,column) = sigma(2);
            end
        end
        [C,h] = contourf(x_locations,y_locations,z);
        clabel(C,h)
        
    case 6 %torsional stress
D = buildD(E, nu);
        
        x_locations = mesh(1:(m+1),1);
        y_locations = zeros(n+1,1);
        for j = 1:(n+1)
            y_locations(j) = mesh((j-1)*(m+1)+1,2);
        end
        
        z = zeros(length(y_locations),length(x_locations));
        
        for e = 1:size(LM_plot,1)
            for node = 1:n_en
                
                switch p
                    case 1
                        pts = [-1 -1;
                               1 -1;
                               -1 1;
                               1 1];
                    case 2
                        pts = [-1 -1;
                                0 -1;
                                1 -1;
                                -1 0;
                                0 0;
                                1 0;
                                -1 1;
                                0 1;
                                1 1];
                end

                
                
                [N, dN_dxi, dN_deta] = lagrange2D(pts(node,:), p, q); 
                [~, dN_dx, dN_dy] = lagrange2Dspatial(dN_dxi, dN_deta, nodes_e(:,:,e));

                sigma = computeStress(D,dN_dx,dN_dy,d,ndof,e,IEN,n_en);
                
                loc = LM_plot(e,node)
                
                %what column it's on
                column = mod(loc-1,(m+1))+1
                %what row it's on
                row = floor((loc-1)/(1+m))+1
                
                z(row,column) = sigma(3);
            end
        end
        [C,h] = contourf(x_locations,y_locations,z);
        clabel(C,h)
        
        
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
        xlabel('X Position')
        ylabel('Y Position')
        
        
end


%contourf(x,y,d_plot);

        
        


end

