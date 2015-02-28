function [predicted_labels_mat, success_rate_vec, used_classifiers_vec, avg_success_rate] = main()
% Project's entry point

% Adding folders to search path
addpath Classifiers;
addpath Classifiers\svm;
addpath Classifiers\random;
addpath Classifiers\Adaboost;

% load data - extracted_test, extraced_train, missing
load Data\dataforproject.mat;

% Parse input
[train_data, train_labels, test_data, ~] = parse_input(extracted_train, extracted_test);
nSNPs = size(train_labels, 1);

% Initialize out parameters
success_rate_vec = zeros(nSNPs, 1);
predicted_labels_mat = zeros(nSNPs, 400);
used_classifiers_vec = {nSNPs, 1};

for i = 1 : nSNPs
    fprintf('For SNP %d, selecting the best classifier\n', i);
    
    % Transpoe is made as each sample is in each row
    current_snp_train_samples = squeeze(train_data(i, : ,:))';
    current_snp_train_labels = squeeze(train_labels(i, :))';
    current_snp_test_samples = squeeze(test_data(i, : ,:))';
    
    [snp_classifier, snp_best_cls_method, snp_success_rate] = get_single_snp_best_classifier(current_snp_train_samples, current_snp_train_labels);
    
    snp_preditcted_labels = predict_labels_for_single_snp(current_snp_test_samples, snp_classifier, snp_best_cls_method);
    
    fprintf('For SNP %d, best success rate: %.2f, achieved with %s\n\n', i, 100* snp_success_rate, snp_best_cls_method);   
    
    % Save results
    success_rate_vec(i) = snp_success_rate;
    predicted_labels_mat(i, :) = snp_preditcted_labels;
    used_classifiers_vec{i} = snp_best_cls_method;
end

% Final calculations...
used_classifiers_vec = used_classifiers_vec';
avg_success_rate = mean(success_rate_vec);

fprintf('Average success rate (across different SNPs) is %.2f\n', 100 * avg_success_rate);

end
