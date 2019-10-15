function [class] = bayesFunc(avg, testIn, classChoice, caseSrc)

% initialization of variables
classProbs = ones(10,1);
averages = zeros(64,10);
test = zeros(61,1);

%local copies of arguments
for k = 1:10
    for i = 1:64
        averages(i,k) = avg(i,k);
    end
end

for i = 1:64
    test(i,1) = testIn(i,caseSrc,classChoice);
end

% the computation of probabilites of each class
% key logic of the bayes classifier

for k = 1:10
    for c = 1:64
        one = averages(c,k)^test(c,1);
        two = (1-averages(c,k)) ^ (1-test(c,1));
        classProbs(k,1) = classProbs(k,1) * one * two ;
    end
end

maxProb = max(classProbs);
class = 0;

% selecting the class with the highest probability to be returned as our
% guess
for k = 1:10
    if (classProbs(k,1) == maxProb)
        class = k;
    end
end

end