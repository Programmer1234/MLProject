function [ predicted_labels ] = predict_svm(test_data, classifier)

test_labels = zeros(size(test_data)); % This parameter is meaningless..
predicted_labels = svmpredict(test_labels, test_set, classifier);

end

