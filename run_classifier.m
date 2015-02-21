function [] = run_classifier(train_data, train_labels, test_data, classifier)

% Chosse the classifier
if strcmp('svm-one-vs-all', classifier)
    addpath 'Classifiers\svm\svmOneVsAll';
    run_classifier(train_data, train_labels, test_data);
    rmppath('Classifiers\svm\svmOneVsAll');
% More classifiers
end

end

