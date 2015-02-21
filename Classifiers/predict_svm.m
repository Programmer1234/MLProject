function [ predicted_labels ] = predict_svm(test_data, classifier)

SVM_PREDICT_OPTIONS = '-q'; % Quiet mode - no output

test_labels = double(zeros(size(test_data,1), 1)); % This parameter is meaningless..
predicted_labels = svmpredict(test_labels, test_data, classifier, SVM_PREDICT_OPTIONS);

end

