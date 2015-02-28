function [ predicted_labels ] = predict_labels_for_single_snp(test_data, classifier, cls_method)

if strcmp(cls_method, 'svm-one-vs-one')
    predicted_labels = predict_svm_one_vs_one(double(test_data), classifier);
else
    error('Unknown classifying method');
end

end

