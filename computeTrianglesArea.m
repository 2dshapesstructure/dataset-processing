function areas = computeTrianglesArea(sha)

    pts= sha.points;
    tri = sha.triangles;
    
    areas = zeros(1,size(tri,1));
    
    for ind_t = 1:length(areas)
       X = pts(tri(ind_t,:),1);
       Y = pts(tri(ind_t,:),2); 
       
       areas(ind_t) = polyarea(X,Y);
    end

end