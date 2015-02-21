function [ labels_vec, res_vec ] = adaboostC( data, model )
%ADABOOSTC Summary of this function goes here
%   Detailed explanation goes here

[~, nExamples] = size(data);
[~, nClassifiers] = size(model);

% Initalize labels and results vectors.
labels_vec = zeros(1, nExamples);

for i = 1 : nExamples
    
    curr_example = data(:,i);
    curr_res = 0;
    results = zeros(3, 1);
    for t = 1 : nClassifiers
		wc_t_prediction = (model(t).permutation(curr_example(model(t).i) + 1));
        results(wc_t_prediction + 1) = results(wc_t_prediction + 1) + model(t).alpha;
    end
    
    [~, labels_vec(i)] = max(results);
	labels_vec(i) = labels_vec(i) -1; % zero basing
end


end

