function [ predicted_labels ] = predict_adaboost_classifier(test_data, classifier)
%PREDICT_RANDOM_CLASSIFIER

% use the main 60 SNPs of each sample for the prediction
test_data = test_data(:,70:130);
nExamples = size(test_data, 1);
nClassifiers = size(classifier, 2);

% Initalize labels and results vectors.
predicted_labels = zeros(1, nExamples)';

for i = 1 : nExamples
    
    curr_example = test_data(i,:);
    results = zeros(3, 1);
    for t = 1 : nClassifiers
		wc_t_prediction = classifier(t).permutation(curr_example(classifier(t).i) + 1);
        results(wc_t_prediction + 1) = results(wc_t_prediction + 1) + classifier(t).alpha;
    end
    
    [~, predicted_labels(i)] = max(results);
	predicted_labels(i) = predicted_labels(i) -1; % zero basing
end
end

