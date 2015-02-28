function [best_classifier_predicted_labels, best_success_rate] = main()
% Project's entry point

% Adding folders to search path
addpath Classifiers;
addpath Classifiers\svm;
addpath Classifiers\Adaboost;

% Classifiers selected.
CLASSIFIERS = cellstr(['svm-one-vs-one']);

% load data - extracted_test, extraced_train, missing
load Data\dataforproject.mat;

% Parse input
[train_data, train_labels, test_data, ~] = parse_input(extracted_train, extracted_test);

best_success_rate = 0;
best_classifier_predicted_labels = 0;

% Run classifiers
for i = 1 : length(CLASSIFIERS)
    [test_predicted_labels_mat, success_rate] = run_classifier(train_data, train_labels, test_data, CLASSIFIERS{i});
    fprintf('Classifier %s success rate is: %.2f\n', CLASSIFIERS{i}, 100* success_rate);
    
    if success_rate > best_success_rate
        best_success_rate = success_rate;
        best_classifier_predicted_labels = test_predicted_labels_mat;
    end
end

fprintf('Best success rate is: %.2f\n', 100*best_success_rate);

end

