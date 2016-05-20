function [clust_maj,annot_clust,ind_annot_clust] = spectralClustering(shape_annot,areas_tri)

    nbAnnot = length(shape_annot);

    % Compute the affinity matrix of the annotations
    aff = eye(nbAnnot);
    for ind_ann = 1:length(shape_annot)
        for ind_ann2 = ind_ann+1:length(shape_annot)
            d = annotationDistance(shape_annot{ind_ann},shape_annot{ind_ann2},areas_tri); 
            aff(ind_ann,ind_ann2) = d;
            aff(ind_ann2,ind_ann) = d;
        end
    end

    % Compute the optimal number of clusters using the Calinski-Harabasz
    % criteria (not defined 
    VRC(1) = 0;
    for nbClust = 2:nbAnnot
        clust =  ngJordanWeissSpectralClustering(aff,nbClust);
        VRC(nbClust) = computeCalinskiHarabasz(shape_annot,clust,areas_tri);
    end
    [aux,nbClust] = max(VRC);
    
    % Cluster the annotations using the Jordan-Weiss method
    clust =  ngJordanWeissSpectralClustering(aff,nbClust);
    
    ind_aux = 1;
    for ind_clust = 1:nbClust
        % Only keep the clusters that have at least 3 annotations
        if (length(find(clust==ind_clust)) > 2)
            % For each cluster, get the corresponding annotations
            annot_clust{ind_aux} = shape_annot(clust==ind_clust);
            ind_annot_clust{ind_aux} = find(clust==ind_clust);
            % Compute the majority of the annotations from this cluster
            clust_maj{ind_aux} = computeMajority(annot_clust{ind_aux});
            
            ind_aux = ind_aux + 1;
        end
    end

end

function VRC = computeCalinskiHarabasz(annotations,idx,areas_tri)

    % Nuber of annotations
    N = length(idx);
    % Number of clusters
    nbClust = max(idx);
    
    majority = computeMajority(annotations); 

    SSw = 0; % Within cluster variance
    SSb = 0; % Between cluster variance
    
    for ind_c = 1:nbClust
        % For each cluster, get the corresponding annotations
        annot_ind_c = annotations(idx==ind_c);
        
        % Number of annotations in the cluster
        N_ind_c = sum(idx==ind_c);
        
        % Compute cluster Majority
        if (length(annot_ind_c)>1)	
            majority_ind_c = computeMajority(annot_ind_c);
        else
            majority_ind_c = cell2mat(annot_ind_c);
        end
        
        % Updating SSb
        SSb = SSb + N_ind_c*annotationDistance(majority,majority_ind_c,areas_tri);
        
        % Updating SSw
        for i = 1:N_ind_c
           SSw = SSw + annotationDistance(annot_ind_c{i},majority_ind_c,areas_tri);
        end
            
    end
   
    VRC = SSb/SSw;

    % Using this criteria changes the results and usually provides less
    % clusters (one or two)
%     VRC = SSb*(N-nbClust)/(SSw * (nbClust));
   
end

% Implements the spectral clustering described in 
% Ng, A., Jordan, M., and Weiss, Y. (2002). On spectral clustering: 
% analysis and an algorithm
% Takes an affinity matrix as an input and the desired number of clusters k
function indices = ngJordanWeissSpectralClustering(A,k)

    % Define D to be the diagonal matrix whose (i, i)-element is the 
    % sum of A's i-th row
    for i=1:size(A,1)
        D(i,i) = sum(A(i,:));
    end

    L = zeros(size(A));
    % construct the matrix L = D^(-1/2) A D^(-1/2) 
    for i=1:size(A,1)
        for j=1:size(A,2)
            L(i,j) = A(i,j) / (sqrt(D(i,i)) * sqrt(D(j,j)));  
        end
    end
    
    % Find x1, x2, ..., xk, the k largest eigenvectors of L ...
    [x,aux] = eig(L);

    % ... and form the matrix X = [X1 X2 ... Xk] by stacking the eigenvectors 
    % in columns. 
    X = x(:,(size(x,1)-(k-1)): size(x,1));

    % Form the matrix Y from X by renormalizing each of X's rows to have 
    % unit length 
    for i=1:size(X,1)
        n = sqrt(sum(X(i,:).^2));    
        Y(i,:) = X(i,:) ./ n; 
    end

    % Treating each row of Y as a point in Rk, cluster them into k 
    % clusters via K-means or any other algorithm
    [indices,aux] = kmeans(Y,k); 

end
