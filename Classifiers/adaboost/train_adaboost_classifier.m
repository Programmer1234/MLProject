function [model] = train_adabost_classifier(train_samples, train_labels)
%ADABOOSTC Summary of this function goes here
%   Detailed explanation goes here

CLASSIFIERS_NUMBER = 15;

% Create an adaboost classifier, with the given data
model = adaboost(train_samples, train_labels, CLASSIFIERS_NUMBER);

end

