function [model, success_rate] = train_svm_one_vs_one(train_samples, train_labels)
% TRAIN_SVM_ONE_VS_ONE
K = 10;
SVM_TRAIN_OPTIONS = '-s 0 -t 0 -q';

% Train classifier of SVM, return it
model = svmtrain(train_labels, train_samples, SVM_TRAIN_OPTIONS);

% Calculate the success rate of that classifier using 10-fold validation
e = svm_k_fold_validation(train_samples, train_labels, K, SVM_TRAIN_OPTIONS);
success_rate = 1 - e;

end

function [e] = svm_k_fold_validation(data, labels, k, svm_train_options)

SVM_PREDICT_OPTIONS = '-q';

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
    
    model = svmtrain(train_labels, train_set, svm_train_options);
    predicted_labels = svmpredict(test_labels, test_set, model, SVM_PREDICT_OPTIONS);
    
    % Save
    e = e + mean(predicted_labels ~= test_labels);  
end

e = e / k;

end

