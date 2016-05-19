clear all; close all;
addpath('../')

% Load the dataset
load dataset.mat
% Load the gold standard expert annotations
load goldstandard.mat

% Initialize variable to save team scores
for ind_usr = 1:length(team)
    teams_score{ind_usr} = [];
end

% Go through each goldstandard image
for ind_GS = 1246:1249
   % Select all triplets relative to this image
   triplets_sel = triplets(triplets(:,2)==ind_GS,:);
   
   % Read JSON 
   s = readJSON(['JSON/' shape{ind_GS,2}]);
   
   areas_tri = computeTrianglesArea(s);
   
   % Experts annotations for this gold standard shape
   annot_exp = annotationsGS(tripletsGS(tripletsGS(:,2)==ind_GS,3));
   
     
   % Go through each team annotation
   for ind_t=1:size(triplets_sel,1)
      a_aux = annotations{triplets_sel(ind_t,3)};
      ind_team = triplets_sel(ind_t,1);
      
      % The score for this team is the one that has the highest resemblance
      % with one of the expert annotations
      max_score = -Inf;
      for ind_e=1:length(annot_exp)
        if  annotationDistance(a_aux,annot_exp{ind_e},areas_tri)>max_score
            max_score = annotationDistance(a_aux,annot_exp{ind_e},areas_tri);
        end
      end
      
      teams_score{ind_team} = [teams_score{ind_team} max_score];
   end
   
end


% Post process team scores
scores = NaN*ones(1,length(teams_score));

% All the teams that did not annotate any Gold Standard shape get a NaN
% score
for ind_team = 1:length(scores)
   if (length(teams_score{ind_team})>=1) 
       scores(ind_team) = mean(teams_score{ind_team});
   end
end
    
save('QualityScores','scores')
