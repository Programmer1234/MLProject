function [best_classifier, best_cls_method, best_success_rate] = get_single_snp_best_classifier(train_samples, train_labels)

K = 10;  % Fold validation constant used (k-fold-validation is performed)

% Initialize
best_success_rate = 0;
best_classifier = 0;
best_cls_method = 0;

% Possible classifiers.
CLASSIFIERS = {'svm-one-vs-one'; 'adaboost'; 'KNN'};

% Run classifiers
for i = 1 : length(CLASSIFIERS)
    
    % Get the current classifier
    curr_cls_method = CLASSIFIERS{i};
    
    % Train the classifier
    curr_classifier = train_classifier_for_single_snp(train_samples, train_labels, curr_cls_method);
    
    % Calculate it's success rate
    curr_classifier_sucess_rate = k_fold_validation(train_samples, train_labels, K, curr_cls_method);
    
    fprintf('For %s, success rate is: %.2f\n', curr_cls_method, curr_classifier_sucess_rate * 100);
    
    if curr_classifier_sucess_rate > best_success_rate
        best_success_rate = curr_classifier_sucess_rate;
        best_classifier = curr_classifier;
        best_cls_method = curr_cls_method;
    end
end


end

