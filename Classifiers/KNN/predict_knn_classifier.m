function [ predicted_labels ] = predict_knn_classifier(test_data, classifier)

test_data = test_data(:,95:105);
% Get the classifier details..
train_data = classifier{1};
train_labels = classifier{2};
K = classifier{3};

nTestSample = size(test_data, 1);

% Get the K-nn of each sample in the test set 
k_nearest_neigbours_indices_matrix = k_NN(double(train_data), double(test_data), K);

% Get the classification of the  K-nn
k_classified_nearest_neigbours_matrix = train_labels(k_nearest_neigbours_indices_matrix);

predicted_labels = zeros(nTestSample, 1);

% For each sample of the testing data, get its classification.
% Handle equalities in the pluarlity calculation:
for i = 1: nTestSample
    
    % Get all of the most common classifications.
    [~, ~, c_possible_classifications] = mode(k_classified_nearest_neigbours_matrix(:, i));
    
    possible_labels = c_possible_classifications{1};
    
    % Choose a random one between them
     possible_labels_randomed = possible_labels(randperm(length(possible_labels)));
     
    predicted_labels(i) = possible_labels_randomed(1);
end

end

