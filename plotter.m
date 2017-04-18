function [  ] = plotter( d,mesh,plot_desired,m,n,ndof )
%This function plots the solution

n_loop = length(d)/2;

d_plot = zeros(n_loop,1);

switch plot_desired
    
    case 1 %x displacement
        for i = 1:n_loop
            d_plot(i) = d((i-1)*ndof+1);
        end
        
    case 2 %y displacement
        for i = 1:n_loop
            d_plot(i) = d((i-1)*ndof+2);
        end
        
    case 3 %von mises
        for i = 1:n_loop
            sigma1 = d((i-1)*3+1);
            sigma2 = d((i-1)*3+2);
            d_plot(i) = sqrt(sigma1^2 - sigma1*sigma2 + sigma2^2 + 3*sigma12^2);
        end
        
    case 4 %total disp
        for i = 1:n_loop
            x_displacement(i) = d((i-1)*ndof+1);
            y_displacement(i) = d((i-1)*ndof+2);
        end
        
        
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
hold off
%contourf(x,y,d_plot);

        
        


end

