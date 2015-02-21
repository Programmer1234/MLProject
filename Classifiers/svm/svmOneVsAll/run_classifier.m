function [test_predicted_labels, success_rate] = run_classifier(train_data, train_labels, test_data)

nSNPs = length(missing_vec);

% Step 1 - Calculate all classifiers
% Allocate memory for array of classifiers (for each SNP) - TODO
classifiers_vec = [];

% For each SNP...
for i = 1 : nSNPs
    % Train model
    samples = train_data(i, :, :);
    labels = train_labels(i, :, :);
    model = train_classifier(samples, labels);
    classifiers_vec = [classifiers_vec model];
end

% Step 2 - Calculate success rate

% For each SNP...
success_rate_vec = zeros(nSNPs);
for i = 1 : nSNPs
    samples = train_data(i, :, :);
    labels = train_labels(i, :, :);
    
    % Perform k-cross-validation
    success_rate_vec[i] = k_cross_validate(samples, labels, classifiers_vec(i));
end

% Calculate average success rate
success_rate = sum(success_rate_vec) / length(success_rate_vec);

% Step 3 - Calculate preditcted labels for the test data

% For each SNP...


