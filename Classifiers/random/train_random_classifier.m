function [ model ] = train_random_classifier(train_samples, train_labels)
%TRAIN_RANDOM_CLASSIFIER

weight_vector = [1,2,1]; % There is a double chance to get '1'.

model = weight_vector / sum(weight_vector);

end

