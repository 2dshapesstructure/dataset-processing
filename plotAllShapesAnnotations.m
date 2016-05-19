function plotAllShapesAnnotations(shape,annotations,layout)

    figure;
    
    for i = 1:length(annotations)
        subplot(layout(1),layout(2),i)
        displayShape(shape,annotations{i})
        drawnow
    end
        
end