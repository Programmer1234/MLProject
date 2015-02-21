function [ model ] = train_classifier(train_samples, train_labels)

% Multi-Class classification, linear kernel, quiet
LIBSVM_OPTIONS = '- s 0 -t 0 -q';
model = svmtrain(train_labels, train_samples, LIBSVM_OPTIONS);
end

