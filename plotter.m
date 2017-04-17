function [  ] = plotter( d,mesh,plot_desired,m,n )
%This function plots the solution

n_el = m*n;

d_plot = zeros(n_el,1);

switch plot_desired
    
    case 1 %x stress
        for i = 1:n_el
            d_plot(i) = d((i-1)*3+1);
        end
        
    case 2 %y stress
        for i = 1:n_el
            d_plot(i) = d((i-1)*3+2);
        end
        
    case 3 %shear stress
        for i = 1:n_el
            d_plot(i) = d((i-1)*3+3);
        end
        
    case 4 %von mises
        for i = 1:n_el
            sigma1 = d((i-1)*3+1);
            sigma2 = d((i-1)*3+2);
            sigma12 = d((i-1)*3+3);
            d_plot(i) = sqrt(sigma1^2 - sigma1*sigma2 + sigma2^2 + 3*sigma12^2);
        end
        
end

x = mesh(:,1);
y = mesh(:,2);

contourf(x,y,d_plot);
        
        


end

