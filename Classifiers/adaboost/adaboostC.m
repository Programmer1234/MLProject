function [ labels_vec, res_vec ] = adaboostC( data, model )
%ADABOOSTC Summary of this function goes here
%   Detailed explanation goes here

[~, nExamples] = size(data);
[~, nClassifiers] = size(model);

% Initalize labels and results vectors.
res_vec = zeros(1, nExamples);

for i = 1 : nExamples
    
    curr_example = data(:,i);
    curr_res = 0;
    
    for t = 1 : nClassifiers
        wc_t_res = model(t).alpha * (2 * (curr_example(model(t).i) > model(t).theta) - 1 ) * model(t).pol;
        curr_res = curr_res + wc_t_res ;
    end
    
    res_vec(i) = curr_res;
end

labels_vec = sign(res_vec);
end

