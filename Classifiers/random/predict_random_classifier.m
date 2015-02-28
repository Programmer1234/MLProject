function [ predicted_labels ] = predict_random_classifier(test_data, classifier)
%PREDICT_RANDOM_CLASSIFIER

a = 0:2;               % possible lables
w = classifier;        % corresponding weights
N = size(test_data,1); % how many numbers to generate

predicted_labels = a( sum( bsxfun(@ge, rand(N,1), cumsum(w./sum(w))), 2) + 1 )';

end

