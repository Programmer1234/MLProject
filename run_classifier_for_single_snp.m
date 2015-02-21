function [classifier, success_rate] = run_classifier_for_single_snp(samples, labels, cls_method)
% RUN_CLASSIFIER_FOR_SINGLE_SNP

if strcmp(cls_method, 'svm-one-vs-one')
    [classifier, success_rate] = train_svm_one_vs_one(double(samples), double(labels));
end
end

