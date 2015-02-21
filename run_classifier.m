function [predicted_labels, success_rate] = run_classifier(train_data, train_labels, test_data, cls_method)

nSNPs = size(train_labels, 1);
classifiers_vec = [];
success_rate_vec = zeros(nSNPs);
predicted_labels = zeros(nSNPs, 400);

for i = 1 : nSNPs
    % For each snp
    samples = train_data(i, :, :);
    labels = train_labels(i, :, :);
    [classifier, classifier_sucess_rate] = run_classifier_for_single_snp(samples, labels, cls_method);
    
    success_rate_vec(i) = classifier_sucess_rate;
    classifiers_vec = [classifiers_vec classifier]; % Can be removed
    
    predicted_labels(i, :) = predict_labels_for_single_snp(test_data, cls_method, classifier);
end

success_rate = mean(success_rate_vec);

end

