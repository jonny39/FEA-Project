function [ LM,ID ] = LM_creator(IEN, mesh, ndof, Geometry,displacement,problemNumber)
if length(Geometry) == 2 %rectangular mesh
    geoLimit = Geometry(1);
elseif length(Geometry) == 4 %radial mesh
    geoLimit = Geometry(2); %outside radius
end

%Define the LM

%define ID, which maps the row or column of K or F with a given node number
%and degree of freedom
ID = zeros(size(mesh,1),ndof);
for i = 1:size(mesh,1)
    for j = 1:ndof
        ID(i,j) = (i-1)*ndof + j;
    end
end

constraint = ones(size(mesh,1),ndof);

for node = 1:size(mesh,1)
    %     if mesh(node,1) == 0
%         constraint(node,:) = 0;  %constrain all left nodes in all directions      
%     end
%     
    if displacement(1) ~= 0 
        if mesh(node,1) == geoLimit
            constraint(node,1) = 0; %if a displacement in x on the right side is defined
        end
    end
    if displacement(2) ~= 0
        if mesh(node,1) == geoLimit
            constraint(node,2) = 0;%if a displacement in y on the right side is defined
        end
    end
    
    
    if mesh(node,1) == 0
        constraint(node,1) = 0;  %constrain all left nodes in x   
    end
%     if mesh(node,1) == 0
%         constraint(node,2) = 0;  %constrain all left nodes in y     
%     end
%     if mesh(node,2) == 0
%         constraint(node,1) = 0;  %constrain all bottom nodes in x      
%     end
    if mesh(node,2) == 0
        constraint(node,2) = 0;  %constrain all bottom nodes in y    
    end

end

ID = ID.*constraint;

%reset the numbers so as to increase from 1
counter = 0;
for i = 1:size(ID,1)
    for j = 1:size(ID,2)
        if ID(i,j) == 0
            counter = counter+1;
        else
        end
        ID(i,j) = ID(i,j) - counter;
        if ID(i,j) <0
            ID(i,j) = 0;
        else
        end
    end
end

%define 3D LM matrix with the rows being the element, column being the
%elemental node number, and depth being the degree of freedom at that node
LM = zeros(size(IEN,1),size(IEN,2),ndof);
for i = 1:size(IEN,1)
    for j = 1:size(IEN,2)
        for k = 1:size(LM,3)
            LM(i,j,k) = ID(IEN(i,j),k);
        end
    end
end


end

