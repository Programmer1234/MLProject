function [classifier] = train_classifier_for_single_snp(train_samples, train_labels, cls_method)
% RUN_CLASSIFIER_FOR_SINGLE_SNP

switch cls_method
    case 'svm-one-vs-one'
        classifier = train_svm_one_vs_one(double(train_samples), double(train_labels));
    case 'random'
        classifier = train_random_classifier(train_samples, train_labels);
	case 'adaboost'
		classifier = train_adaboost_classifier(train_samples, train_labels);
	case 'KNN'
		classifier = train_knn_classifier(train_samples, train_labels);
    otherwise
        error('Unknown classifying method');
end

end

