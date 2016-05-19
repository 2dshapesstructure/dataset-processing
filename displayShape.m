% plot the shape, colored with annotations in case the annot input is
% indicated
function displayShape(shape,annot)


    for k = 1:size(shape.triangles,1)
       % Get the triangle coordinates
       coord = [shape.points(shape.triangles(k,1),:) ; 
                shape.points(shape.triangles(k,2),:) ; 
                shape.points(shape.triangles(k,3),:)];
            
       if nargin > 1
           switch(annot(k))
               case '0' 
                   col = 'k';
               case '1' 
                   col = 'm';
               case '2' 
                   col = 'g';
               case '3'
                   col = 'r';
           end
           fill(coord(:,1),coord(:,2),col,'EdgeColor','None');
       else
           fill(coord(:,1),coord(:,2),'w','EdgeColor','Black');
       end
       hold on;
    end
    axis equal
    axis off

end