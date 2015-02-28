function [classifier] = train_classifier_for_single_snp(train_samples, train_labels, cls_method)
% RUN_CLASSIFIER_FOR_SINGLE_SNP

if strcmp(cls_method, 'svm-one-vs-one')
    [classifier] = train_svm_one_vs_one(double(train_samples), double(train_labels));
end

end

