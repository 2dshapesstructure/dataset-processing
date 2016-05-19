function d = annotationDistance(a1,a2,areas_tri) 

    areas_tri = areas_tri/sum(areas_tri);
    % Each triangle has a weight proportional to its size
    d = sum((a1==a2).*areas_tri);


end