function [success_rate] = k_fold_validation(data, labels, k, cls_method)

perm = randperm(size(data,1));
permdata = data(perm,:);
permlabels = labels(perm,:);

group_size = floor(size(data,1) / k);
group_ranges = 1:group_size:size(data,1) - k + 1;
group_ranges = [group_ranges size(data,1)+1];
e = 0;
for i = 1:k
    train_set = permdata;
    train_labels = permlabels;
    train_set(group_ranges(i):group_ranges(i+1)-1,:) = [];
    train_labels(group_ranges(i):group_ranges(i+1)-1,:) = [];
    
	test_set = permdata(group_ranges(i):group_ranges(i+1)-1,:);
    test_labels = permlabels(group_ranges(i):group_ranges(i+1)-1,:);
    
    % Train the classifier for the given train set
    classifier = train_classifier_for_single_snp(train_set, train_labels, cls_method);
    
    % Predict the labels of the given test set
    predicted_labels = predict_labels_for_single_snp(test_set, classifier, cls_method);
    
    % Save the error rate
    e = e + mean(predicted_labels ~= test_labels);  
end

e = e / k;

success_rate = 1 - e;

end
