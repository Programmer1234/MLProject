function [predicted_labels, success_rate] = run_classifier(train_data, train_labels, test_data, cls_method)

nSNPs = size(train_labels, 1);

classifiers_vec = [];
success_rate_vec = zeros(1, nSNPs);
predicted_labels = zeros(nSNPs, 400);

for i = 1 : nSNPs
    % For each snp 
    
    % Transpoe is made as each sample is in each row. as libsvm requires.
    train_samples = squeeze(train_data(i, : ,:))';
    labels = squeeze(train_labels(i, :))';
    test_samples = squeeze(test_data(i, : ,:))';
    
    [classifier, classifier_sucess_rate] = run_classifier_for_single_snp(train_samples, labels, cls_method);
    
    fprintf('For SNP %d, success rate is: %.2f\n', i, classifier_sucess_rate * 100);
    
    success_rate_vec(i) = classifier_sucess_rate;
    classifiers_vec = [classifiers_vec classifier]; % Can be removed
    
    predicted_labels(i, :) = predict_labels_for_single_snp(test_samples, cls_method, classifier);
end

success_rate = mean(success_rate_vec);

fprintf('Average success rate is: %.2f\n', success_rate * 100);

end

