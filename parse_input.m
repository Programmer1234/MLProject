function [train_data, train_labels, test_data, test_labels] = parse_input(extracted_train, extraced_test)

train_data = extracted_train;
train_data(:, 101, :) = [];
train_labels = extracted_train(:, 101, :);

test_data = extraced_test;
test_data(:, 101, :) = [];
test_labels = extraced_test(:, 101, :);

% Sanity check that we didn't make a mistake extracting the data
assert (min(min(test_labels)) == max(max(test_labels)));
assert (min(min(test_labels)) == -1);

end

