function [ model ] = adaboost( examples, labels, nClassifiers )
% implements the Adaboost algorithm for 3-class scenario. model is the output classifier.

nExamples = size(examples, 1);

% Initialize the model
model = struct;

% Initialize weight vector
weights_vec = ones(1, nExamples);

% Create a matrix of all possible combinations of 0,1,2 of size 3. - (000,001,002,010...)
permutations_mat = unique(nchoosek(repmat([0,1,2], 1,3), 3), 'rows');

for t = 1 : nClassifiers
    
    % Normalize the weights vector
    weights_vec = weights_vec / sum(weights_vec);
    
    % Select the best weak classifier.
    [cl_i, cl_permutation, cl_err, cl_predicted_labels] = selectwc(examples, labels, weights_vec, permutations_mat);
	% the log(K-1) addition is for multicast adaboost with K classes(SAMME algorithm)
    cl_alpha = (log((1 - cl_err) / cl_err) + log(2)); 
    
    % Update weights vector
    for i = 1 : nExamples
        if cl_predicted_labels(i) ~= labels(i)
            weights_vec(i) = weights_vec(i) * exp(cl_alpha); 
        end
    end
    
    % Save the classifier [SNP_index, permutation] and the corresponding alpha factor into the returned model.
    model(t).i = cl_i; 
    model(t).permutation = cl_permutation; 
    model(t).alpha = cl_alpha;
    
    % If alpha is 0 or Inf we must break
    if isinf(cl_alpha) || isnan(cl_alpha)
        break;
    end
    
end

