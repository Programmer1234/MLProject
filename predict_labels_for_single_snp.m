function [ predicted_labels ] = predict_labels_for_single_snp(test_data, classifier, cls_method)

switch cls_method
    case 'svm-one-vs-one'
        predicted_labels = predict_svm_one_vs_one(double(test_data), classifier);
    case 'random'
        predicted_labels = predict_random_classifier(double(test_data), classifier);
	case 'adaboost'
        predicted_labels = predict_adaboost_classifier(double(test_data), classifier);
    otherwise
        error('Unknown classifying method');
end

end

