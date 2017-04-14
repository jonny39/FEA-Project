function [ Cex, Cey ] = Ce_define2D( p,q,e,m,n )
%This function returns the Ce to combine the Bezier curves

%the column
switch p
    
    case 1
        Cex = eye(2);
        
    case 2
        if m == 1
            Cex = eye(3);
        else
            column = mod(e-1,m);
            switch column
                case 1
                    Cex = [1 0 0;0 1 0.5;0 0 0.5];
                case m
                    Cex = [0.5 0 0;0.5 1 0;0 0 1];
                otherwise
                    Cex = [0.5 0 0;0.5 1 0.5;0 0 0.5];
            end
        end
                
    case 3
        switch m
            case 1
                Cex = eye(4);
                
            case 2
                column = mod(e-1,m);
                switch column
                    case 1
                        Cex = [1 0 0 0; 0 1 0.5 0.25;0 0 0.5 0.5;0 0 0 0.25];
                    case m
                        Cex = [0.25 0 0 0;0.5 0.5 0 0;0.25 0.5 1 0;0 0 0 1];
                    otherwise
                        error('Ce define error')
                end
                
            case 3
                column = mod(e-1,m);
                switch column
                    case 1
                        Cex = [1 0 0 0; 0 1 0.5 0.25; 0 0 0.5 7/12;0 0 0 1/6];
                    case 2
                        Cex = [0.25 0 0 0;7/12 2/3 1/3 1/6;1/6 1/3 2/3 7/12;0 0 0 1/4];
                    case 3
                        Cex = [1/6 0 0 0;7/12 0.5 0 0;0.25 0.5 1 0;0 0 0 1];
                    otherwise
                        error('Ce define error')
                end
                
            otherwise
                column = mod(e-1,m);
                switch column
                    case 1
                        Cex = [1 0 0 0;0 1 0.5 0.25;0 0 0.5 7/12;0 0 0 1/6];
                    case 2
                        Cex = [0.25 0 0 0;7/12 2/3 1/3 1/6;1/6 1/3 2/3 2/3; 0 0 0 1/6];
                    case m-1
                        Cex = [1/6 0 0 0; 2/3 2/3 1/3 1/6; 1/6 1/3 2/3 7/12; 0 0 0 0.25];
                    case m
                        Cex = [1/6 0 0 0; 2/3 2/3 1/3 1/6; 1/6 1/3 2/3 7/12; 0 0 0 0.25];
                    otherwise
                        Cex = [1/6 0 0 0; 2/3 2/3 1/3 1/6; 1/6 1/3 2/3 7/12; 0 0 0 0.25];
                end
                
        end
       
    otherwise
        error('P not defined for Ce')
end
        
     
%now for the row
switch q
    
    case 1
        Cey = eye(2);
        
    case 2
        if n == 1
            Cey = eye(3);
        else
            row = floor((e-1)/m);
            switch row
                case 1
                    Cey = [1 0 0;0 1 0.5;0 0 0.5];
                case n
                    Cey = [0.5 0 0;0.5 1 0;0 0 1];
                otherwise
                    Cey = [0.5 0 0;0.5 1 0.5;0 0 0.5];
            end
        end
                
    case 3
        switch n
            case 1
                Cey = eye(4);
                
            case 2
                row = floor((e-1)/m);
                switch row
                    case 1
                        Cey = [1 0 0 0; 0 1 0.5 0.25;0 0 0.5 0.5;0 0 0 0.25];
                    case n
                        Cey = [0.25 0 0 0;0.5 0.5 0 0;0.25 0.5 1 0;0 0 0 1];
                    otherwise
                        error('Ce define error')
                end
                
            case 3
                row = floor((e-1)/m);
                switch row
                    case 1
                        Cey = [1 0 0 0; 0 1 0.5 0.25; 0 0 0.5 7/12;0 0 0 1/6];
                    case 2
                        Cey = [0.25 0 0 0;7/12 2/3 1/3 1/6;1/6 1/3 2/3 7/12;0 0 0 1/4];
                    case 3
                        Cey = [1/6 0 0 0;7/12 0.5 0 0;0.25 0.5 1 0;0 0 0 1];
                    otherwise
                        error('Ce define error')
                end
                
            otherwise
                row = floor((e-1)/m);
                switch row
                    case 1
                        Cey = [1 0 0 0;0 1 0.5 0.25;0 0 0.5 7/12;0 0 0 1/6];
                    case 2
                        Cey = [0.25 0 0 0;7/12 2/3 1/3 1/6;1/6 1/3 2/3 2/3; 0 0 0 1/6];
                    case n-1
                        Cey = [1/6 0 0 0; 2/3 2/3 1/3 1/6; 1/6 1/3 2/3 7/12; 0 0 0 0.25];
                    case n
                        Cey = [1/6 0 0 0; 2/3 2/3 1/3 1/6; 1/6 1/3 2/3 7/12; 0 0 0 0.25];
                    otherwise
                        Cey = [1/6 0 0 0; 2/3 2/3 1/3 1/6; 1/6 1/3 2/3 7/12; 0 0 0 0.25];
                end
                
        end
       
    otherwise
        error('P not defined for Ce')
end


end

