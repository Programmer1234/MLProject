function [model] = train_svm_one_vs_one(train_samples, train_labels)
% TRAIN_SVM_ONE_VS_ONE
K = 10;
SVM_TRAIN_OPTIONS = '-s 0 -t 2 -q -c 100000'; % Options with the best results

% Train classifier of SVM, return it
model = svmtrain(train_labels, train_samples, SVM_TRAIN_OPTIONS);
end

