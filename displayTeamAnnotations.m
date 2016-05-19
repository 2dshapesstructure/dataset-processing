% Displays all annotations of the same team into a single plot
% shape: the name of all shapes that have been annotated by the team
% annotation: the annotation of all shapes that have been annotated by the
% team
function displayTeamAnnotations(shape,annotation)

    nbAnnot = length(annotation);
    
    m = ceil(sqrt(nbAnnot));
    n = ceil(nbAnnot/m);
    
    figure;
    for ind_a = 1:nbAnnot
       
       subplot(n,m,ind_a);
        
       % Read JSON 
       s = readJSON(['../JSON/' shape{ind_a}]);
        
       displayShape(s,annotation{ind_a});
       drawnow
    end
    

end