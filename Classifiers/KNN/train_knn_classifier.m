function [model] = train_knn_classifier(train_samples, train_labels)

K = 10;

% The model in NN contains the train samples, labels and K
model = {train_samples(:,95:105), train_labels, K};

end

