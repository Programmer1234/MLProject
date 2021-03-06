function [model] = train_adaboost_classifier(train_samples, train_labels)
% trains the adaboost with the given data. model is the output classifier.
CLASSIFIERS_NUMBER = 10;

% Create an adaboost classifier, with the main 60 SNPs of the given data
model = adaboost(train_samples(:,70:130), train_labels, CLASSIFIERS_NUMBER);

end

