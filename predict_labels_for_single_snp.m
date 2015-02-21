function [ predicted_labels ] = predict_labels_for_single_snp(test_data, cls_method, classifier)

if strcmp(cls_method, 'svm-one-vs-one')
    predicted_labels = predict_svm(double(test_data), classifier);
end

end

