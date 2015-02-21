function [best_classifier_predicted_labels, best_success_rate] = main()
% Project's entry point

% Classifiers selected.
%CLASSIFIERS = cellstr(['svm-one-vs-all', 'svm-one-vs-one']);
CLASSIFIERS = cellstr(['svm-one-vs-one']);

% load data - extracted_test, extraced_train, missing
load dataforproject.mat;

% Parse input
[train_data, train_labels, test_data, ~] = parse_input(extracted_train, extraced_test);

best_success_rate = 0;
best_classifier_predicted_labels = 0;

% Run classifiers
for i = 1 : length(CLASSIFIERS)
    [test_predicted_labels_mat, success_rate] = run_classifier(train_data, train_labels, test_data, CLASSIFIERS(i));
    sprintf('Classifier %s success rate is: %d', CLASSIFIERS(i), success_rate);
    
    if success_rate > best_success_rate
        best_success_rate = success_rate;
        best_classifier_predicted_labels = test_predicted_labels_mat;
    end
end

sprintf('Best success rate is: %d', best_success_rate);

end

