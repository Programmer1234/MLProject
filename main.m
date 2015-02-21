function [] = main()
% Project's entry point

% Classifiers selected.
CLASSIFIERS = cellstr(['svm-one-vs-all', 'svm-one-vs-one']);

% load data - extracted_test, extraced_train, missing
load dataforproject.mat;

% Parse input
[train_data, train_labels, test_data, ~] = parse_input(extracted_train, extraced_test);

% Run classifiers
for i = 1 : length(CLASSIFIERS)
    runClassifier(train_data, train_labels, test_data, CLASSIFIERS(i));
end

end

