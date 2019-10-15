%% formatting the data and finding the average values for each digit
% Averaging all of the matricies 
load('a1digits.mat');
trainAveraged = zeros(64,10);

% This loop gives us the mean mu k for each digit
for i = 1:10
    for j = 1:64
       trainAveraged(j,i)  = sum(digits_train(j,1:700,i))/700;
    end  
end
save('a1digits.mat','trainAveraged', '-append')

%% finding the variance phi^2
variance = 0; 

for k = 1:10
    for j = 1:700
       for i = 1:64
           variance = variance + (digits_train(i,j,k)-trainAveraged(i,k))^2;
       end
    end
end

variance = variance/(64*7000);

deviation = sqrt(variance);

save('a1digits.mat','variance', 'deviation', '-append')

%% displaying the average values
% this section displays all of the average matricies
for k = 1:10
    figure,imagesc(reshape(trainAveraged(1:64,k),8,8)'), colormap gray;
end

%% Calling posterior equation test

estimate = postProb(digits_train,trainAveraged, 10, 1, variance);

disp(estimate);

%% use the function on the testing data
% this section runs the postProb function for all of the training cases and
% outputs a matrix of all the classified data
% function [classEst] = postProb(digits, averageList, classSrc, caseChoice, variance)

estimatesGauss = zeros (10,3);

% putting in the number for each row
for k = 1:10
    estimatesGauss(k,3) = k;
end

for k = 1:10
    for c = 1:400
        estimate = postProb(digits_test,trainAveraged, k, c, variance);
        if (estimate == k)
%           add to the number of correct classified
            estimatesGauss (k,1) = estimatesGauss(k,1) + 1;
        else
%           add to the number of incorrect classified
            estimatesGauss (k,2) = estimatesGauss(k,2) + 1;
        end
    end
end 

save('a1digits.mat','estimatesGauss', '-append')

%% Getting statistics on the performance of our gaussian calssifier

%a matrix of the percentages of correct classifications for each data point
percentCorrectGauss = zeros(10,2);

for k = 1:10
    percentCorrectGauss(k,2) = k;
end

for k = 1:10
    percentCorrectGauss(k,1) = 100*(estimatesGauss(k,1)/400);
end

sumCorrect = 0;

for k = 1:10
    sumCorrect = sumCorrect + estimatesGauss(k,1);
end

%the percentage of correctly classified data points
totalPerformanceGauss = 100*(sumCorrect/4000);

save('a1digits.mat','percentCorrectGauss','totalPerformanceGauss', '-append')
