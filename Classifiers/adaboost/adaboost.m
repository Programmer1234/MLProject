function [ model ] = adaboost( examples, labels, nClassifiers )
%ADABOOST Summary of this function goes here
%   Detailed explanation goes here

nExamples = size(examples, 2);

% Initialize the model
model = struct;

% Initialize weight vector
weights_vec = ones(1, nExamples);

for t = 1 : nClassifiers
    
    % Normalize the weights vector
    weights_vec = weights_vec / sum(weights_vec);
    
    % Select the best weak classifier.
    [cl_i, cl_theta, cl_p, cl_err, cl_predicted_labels] = selectwc(examples, labels, weights_vec);
    
    cl_alpha = 0.5 * log((1 - cl_err) / cl_err); 
    
    % Update weights vector
    for i = 1 : nExamples
        if cl_predicted_labels(i) == labels(i)
            weights_vec(i) = weights_vec(i) * exp(cl_alpha); % p_y(j) = y(j)
        else
            weights_vec(i) = weights_vec(i) * exp(-1 * cl_alpha); % p_y(j) != y(j)
        end
    end
    
    % Save the classifier [i, theta, pol], and the corresponding alpha factor into the returned model.
    model(t).i = cl_i; 
    model(t).theta = cl_theta; 
    model(t).pol = cl_p; 
    model(t).alpha = cl_alpha;
    
    % If alpha is 0 or Inf we must break
    if isinf(cl_alpha) || isnan(cl_alpha)
        break;
    end
    
end

