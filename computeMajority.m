% For a given set of annotations, compute the annotation that takes for 
% each triangle the most cited annotation
function majority = computeMajority(annotations)

    % Create a matrix of annotations
    A = annotations{1};
    for ind_a = 2:length(annotations)
       A = [A ; annotations{ind_a}]; 
    end

    majority = mode(A);

end