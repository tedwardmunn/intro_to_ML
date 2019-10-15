function [classProb] = bayesProb(avg, testIn, classChoice, caseSrc, avgCase)
% initialization of variables
classProb = 1;
averages = ones(64,1);
test = ones(61,1);

%local copies of arguments

for i = 1:64
   averages(i,1) = avg(i,avgCase);
end
% fprintf('averages');
% disp(averages)


for i = 1:64
    test(i,1) = testIn(i,caseSrc,classChoice);
end
% fprintf('case in');
% disp(test);

%the computation of probabilites of each class
%key logic of the bayes classifier

testProb = classProb* averages(6,1)^(test(6,1)) * 1-averages(6,1) ^ (1-test(6,1));
% fprintf('test prob');
% disp(testProb);

for c = 1:64
    one = averages(c,1)^test(c,1);
    two = (1-averages(c,1)) ^ (1-test(c,1));
    classProb = classProb * one * two ;
end

% fprintf('classProb');
% disp(classProb);

end