%% Reformatting the testing data to binary values
load('a1digits.mat')

testAdjusted = zeros(64, 400, 10);

for i = 1:10
    for j = 1:400
        for k = 1:64
            if (digits_test(k,j,i)>0.5)
                testAdjusted(k,j,i) = 1;
            else 
                testAdjusted(k,j,i) = 0;
            end
        end 
    end
end

save('a1digits.mat','testAdjusted', '-append')

%% Reformatting the training data to binary values

trainAdjusted = zeros(64, 400, 10);

for i = 1:10
    for j = 1:700
        for k = 1:64
            if (digits_train(k,j,i)>0.5)
                trainAdjusted(k,j,i) = 1;
            else 
                trainAdjusted(k,j,i) = 0;
            end
        end 
    end
end

save('a1digits.mat','trainAdjusted','-append')

%% Finding the average of the binary data sets

bayesAverages = zeros(64,10);

for k = 1:10
    for c = 1:64
        bayesAverages(c,k) = sum(trainAdjusted(c,1:700,k))/700;
    end
end

save('a1digits.mat','bayesAverages', '-append');

%% Display the averages

for k = 1:10
    figure,imagesc(reshape(bayesAverages(1:64,k),8,8)'), colormap gray;
end

%% using the built function on testing data for predictions

estimatesBayes = zeros(10,3);

for k = 1:10
    estimatesBayes(k,3) = k;
end

for k = 1:10
    for c = 1:400
        estimate = bayesFunc(bayesAverages, testAdjusted, k, c);
        if (estimate == k)
%           add to the number of correct classified
            estimatesBayes (k,1) = estimatesBayes(k,1) + 1;
        else
%           add to the number of incorrect classified
            estimatesBayes (k,2) = estimatesBayes(k,2) + 1;
        end
    end
    
end
save('a1digits.mat','estimatesBayes', '-append')

%% getting prediction statistics for the bayes classifier

%a matrix of the percentages of correct classifications for each data point
percentCorrectBayes = zeros(10,2);

for k = 1:10
   percentCorrectBayes(k,2) = k; 
end

for k = 1:10
    percentCorrectBayes(k,1) = 100*(estimatesBayes(k,1)/400);
end

sumCorrect = 0;

for k = 1:10
    sumCorrect = sumCorrect + estimatesBayes(k,1);
end

%the percentage of correctly classified data points
totalPerformanceBayes = 100*(sumCorrect/4000);
save('a1digits.mat','percentCorrectBayes','totalPerformanceBayes', '-append')