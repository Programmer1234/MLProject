function [ cl_i , cl_permutation, cl_error, cl_labels_vec ] = selectwc( examples_mat, labels_vec, weights_vec, permutations_mat )
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
cl_permutation = -Inf;
cl_i = -Inf;
cl_labels_vec = 0;


% For each feature
for f_index = 1 : nFeatures 

    % Select only the relevant feature from the data.
    feature_vec = examples_mat(f_index, :);
    
    % For each polarity (polarity is in {-1, 1})
        for permutation_index = 1: size(permutaions_mat) %TODO
			curr_permutation = permutaions_mat(permutation_index, :); %TODO
            
			% Calculate the labels the classifier [i, theta, polarity]
			% predicts.
			predicted_lables_vec = zeros(1 , nExamples);

			% TODO: change to matrix calculation
			for e_index = 1 : nExamples
				predicted_lables_vec(e_index) = curr_permutation(feature_vec(e_index) + 1); % (+1) is because matlab is 1 based
			end
			
			% Calculate the classifier's error
			curr_cl_error = calc_error(labels_vec, predicted_lables_vec, weights_vec);
			
			% TODO: choose random best classifier
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

