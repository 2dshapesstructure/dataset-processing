% Read JSON files that contain points and triangles describing the shapes
function shape = readJSON(path)
    
    fileID = fopen(path,'r');
    
    % 1e ligne : {"points":[
    a = fgets(fileID);
    
    a = fgets(fileID);
    
    

    points = [];
    % Go through the points
    while (isempty(strfind(a,'triangles')))
        % Get x
        x = str2double(a(10:end-2));
        
        a = fgets(fileID);
        % Get y
        if a(end-2)==']'
            y = str2double(a(10:end-4));
        else
            y = str2double(a(10:end-3));
        end
        points = [points ; x y];
        
        a = fgets(fileID);
    end
    
    
    a = fgets(fileID);
    
    triangles = [];
    % Go through the triangles
    while (a(1)~='}')
        % Get p1
        p1 = str2double(a(11:end-2));
        a = fgets(fileID);
        % Get p2
        p2 = str2double(a(11:end-2));
        
        
        a = fgets(fileID);
        % Get p3
        if a(end-2)==']'
            p3 = str2double(a(11:end-4));
        else
            p3 = str2double(a(11:end-3));
        end
        
        triangles = [triangles ; p1 p2 p3];
        
        a = fgets(fileID);
    end
    triangles = triangles + 1;
      
    fclose(fileID);
    
    shape.points = points;
    shape.triangles = triangles;

end