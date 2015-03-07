function [ cl_i , cl_permutation, cl_error, cl_labels_vec ] = selectwc( examples_mat, labels_vec, weights_vec, permutations_mat )
%{
Selects the best weak classifier of the form [SNP number, permutation], for the given 
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
[nExamples, nFeatures] = size(examples_mat);

cl_error = sum(weights_vec);
cl_permutation = -Inf;
cl_i = -Inf;
cl_labels_vec = 0;


% For each feature
for f_index = 1 : nFeatures 

    % Select only the relevant feature from the data.
    feature_vec = examples_mat(:,f_index);
    
    % For each permutation
        for permutation_index = 1: size(permutations_mat) 
			curr_permutation = permutations_mat(permutation_index, :);
            
			% Calculate the labels the classifier 
			% predicts.
			predicted_lables_vec = curr_permutation(feature_vec(:) + 1); % (+1) is because matlab is 1 based
			
			% Calculate the classifier's error
			error_vec = (labels_vec' ~= predicted_lables_vec);
            weighted_vec = error_vec .* weights_vec;
            curr_cl_error = sum(weighted_vec);
			
			% Check if the current classifier is the best we encountered so far.
			if cl_error > curr_cl_error
				% Update our returned classifier.
				cl_error = curr_cl_error;
				cl_permutation = curr_permutation;
				cl_i = f_index;
				cl_labels_vec = predicted_lables_vec;
		end % Iterating permutations
end % Iterating features
end % function

