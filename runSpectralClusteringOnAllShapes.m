% Run the spectral clustering on all shapes, after filtering out the 20% 
% worst users

clear all; close all;

% Load the dataset
load dataset.mat
% Load the quality scores for each team
load QualityScores.mat

if ~exist('Results')
    mkdir('Results')
end

if ~exist('Results/Spectral')
    mkdir('Results/Spectral')
end


% We want to discard the 20% worst users; we compute the quality threshold
% below which we filter out users
scores_filt = scores(~isnan(scores)); % Remove the NaN users
scores_sorted = sort(scores_filt,'ascend');
score_threshold = scores_sorted(round(20*length(scores_sorted)/100));


% Browse each shape
for ind_shape=572:length(shape)
    disp(['Shape #' int2str(ind_shape)])
    
    % Read JSON 
    s = readJSON(['JSON/' shape{ind_shape,2}]);
    
    areas_tri = computeTrianglesArea(s);

    % find all annotations for this shape
    ind_annot = triplets(triplets(:,2)==ind_shape,3);
    shape_annot = annotations(ind_annot);

    % find all users for this shape
    ind_usr = triplets(triplets(:,2)==ind_shape,1);

    % Get these users scores
    scores_usr = scores(ind_usr);

    % Filter users that are below the score threshold
    shape_annot = shape_annot(scores_usr>score_threshold);

    % Check whether annotations are of the same size. Some annotations were
    % badly saved in our database. We will just discard them.
    good = 1;
    for ind=1:length(shape_annot)-1
        if (length(shape_annot{ind})~=length(shape_annot{ind+1}))
           good = 0; 
        end
    end


    if (good==1)
        % Compute majority vote
        [clust_maj,annot_clust,ind_annot_clust] = spectralClustering(shape_annot,areas_tri);
        
        % Save results into the right folder
        save(['Results/Spectral/' shape{ind_shape,2}(1:end-4) 'mat'],'clust_maj','annot_clust','ind_annot_clust');
        
        % Clear all relevant variables
        clear clust_maj annot_clust ind_annot_clust
    end
    clear s ind_annot shape_annot ind_usr scores_usr good
end
