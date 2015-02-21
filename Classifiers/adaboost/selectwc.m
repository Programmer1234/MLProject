function [ cl_i , cl_theta, cl_pol, cl_error, cl_labels_vec ] = selectwc( examples_mat, labels_vec, weights_vec )
%{
Selects the best weak classifier of the form [i, theta, p], for the given 
examples set. The classifier error, and predicted labels are returned as
well.

'examples_mat' is a matrix of the size dXn.
A row stands for a feature (coordinate), there are d features for each
sample.
A column stands for a single example. There are n examples.

labels_vec is a vector of the size 1Xn.
The j'th element is the label of the j'th example in the 'examples'
matrix.

weights_vec is a vector of the size 1Xn.
The j'th element is the weight of the j'th element in the
examples_mat.

The error is calcaulated as such:

Error = 0
for predicted_lable in predicted_labels:
    if predicted_lable != real_label:
        Error += w(element)
%}

% Initialization
[nFeatures, nExamples] = size(examples_mat);

cl_error = sum(weights_vec);
cl_theta = -Inf;
cl_pol = -Inf;
cl_i = -Inf;
cl_labels_vec = 0;


% For each feature
for f_index = 1 : nFeatures 

    % Select only the relevant feature from the data.
    feature_vec = examples_mat(f_index, :);
    
    % Sort it.
    [sorted_feature_vec, ~] = sort(examples_mat(f_index, :));
    
    % Calculate the relevant thresholds vec.
    theta_vec = zeros(1, nExamples);
    theta_vec(1) = -Inf;
    for exmpl_index = 2 : nExamples
        theta_vec(exmpl_index) = mean([sorted_feature_vec(exmpl_index), sorted_feature_vec(exmpl_index-1)]);
    end
    
    % For each theta (threshold)...
    for thresh_index = 1: nExamples
        
        curr_theta = theta_vec(thresh_index);

        % For each polarity (polarity is in {-1, 1})
        for polarity = -1: 2: 1
            
            % Calculate the labels the classifier [i, theta, polarity]
            % predicts.
            predicted_lables_vec = zeros(1 , nExamples);

            for e_index = 1 : nExamples
                predicted_lables_vec(e_index) = (2 * (feature_vec(e_index) > curr_theta) - 1) * polarity;
            end
            
            % Calculate the classifier's error
            curr_cl_error = calc_error(labels_vec, predicted_lables_vec, weights_vec);
            
            % Check if the current classifier is the best we encountered so far.
            if cl_error > curr_cl_error
                
                % Update our returned classifier.
                cl_error = curr_cl_error;
                cl_theta = curr_theta;
                cl_pol = polarity;
                cl_i = f_index;
                cl_labels_vec = predicted_lables_vec;
            end
        end % Iterating polarity
    end % Iterating theta
end % Iterating features

end % function

