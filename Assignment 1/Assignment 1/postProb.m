%% posterior probabilities estimation
% We find the posterior probabilities for each class, the class with the
% highest probability is slected as our guess

function [ classEst] = postProb(digits, averageList, classSrc, caseChoice, variance)

% initialize the sum values and posterior probability lists for each class
classPosteriors = zeros(10,1);
differences = zeros(10,1);
averages = zeros(64,10);

% function local copy of the digits for the training case
number = zeros(64,1);
for i = 1:64
    number(i) = digits(i,caseChoice, classSrc);
end 

% making local copy of averages
for k = 1:10
    for j = 1:64
        averages(j,k) = averageList(j,k);
    end 
end 

%filling the table of the differences between our input and the averages
for k = 1:10
    for D = 1:64
        differences(k) = differences(k) + ((number(D)-averages(D,k))^2);
    end
end

% filling out the table of the probabilities of each class
for k = 1:10
    classPosteriors(k) = ((2*pi*variance))*exp((1/(-2*variance))*differences(k));
end

% finding the class with the highest probability to be returned as the
% estimate of the function
classProb = max(classPosteriors); 
for i = 1:10
    if (classProb == classPosteriors(i))
        classEst = i;
        return
    end
end

end