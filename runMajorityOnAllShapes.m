% Run the majority vote on all shapes, after filtering out the 20% worst
% users

clear all; close all;

% Load the dataset
load dataset.mat
% Load the quality scores for each team
load QualityScores.mat

if ~exist('Results')
    mkdir('Results')
end

if ~exist('Results/Majority')
    mkdir('Results/Majority')
end


% We want to discard the 20% worst users; we compute the quality threshold
% below which we filter out users
scores_filt = scores(~isnan(scores)); % Remove the NaN users
scores_sorted = sort(scores_filt,'ascend');
score_threshold = scores_sorted(round(20*length(scores_sorted)/100));


% Browse each shape
for ind_shape=1:length(shape)
%         disp(int2str(ind_shape))
    % Read JSON 
    s = readJSON(['JSON/' shape{ind_shape,2}]);

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
        majority = computeMajority(shape_annot);
        
        % Save results into the right folder
        save(['Results/Majority/' shape{ind_shape,2}(1:end-4) 'mat'],'majority');
        
        % Clear all relevant variables
        clear majority
    end
    clear s ind_annot shape_annot ind_usr scores_usr good
end
