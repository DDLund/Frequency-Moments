
k=2;                    % the frequency moment we are finding
m=100;                  % length of sequence
n=7;                    % number of different types of elements in sequence

lambda=0.1;             % estimate to deviate no more than lambda*F_k
epsilon=0.1;            % probability that estimate will be within bounds
numTrials = 10;          % for running multiple trials
numSuccesses = [0,0];   % counts successes of rTwoCounter and rGeneralCounter
twoMoment = 0;
kMoment = 0;
Moment = 0;

for i = 1:numTrials
    counter = dCounter(m);
    tCounter = rTwoCounter(m,n,lambda,epsilon);   %comment out/ignore if k !=2
    kCounter = rGeneralCounter(k,m,n,lambda,epsilon);
    data = unidrnd(n,m,1);  % generate data
    for j=1:length(data)
        counter = counter.input_data(data(j));
        tCounter = tCounter.input_data(data(j));  %comment out/ignore if k !=2
        kCounter = kCounter.input_data(data(j));
    end
    Moment = counter.get_moment(k);
    tMoment = tCounter.get_moment();              %comment out/ignore if k !=2
    kMoment = kCounter.get_moment();
    
    if abs(tMoment-Moment)<epsilon*Moment         %comment out/ignore if k !=2
        numSuccesses(1) = numSuccesses(1)+1;
    end
    if abs(kMoment-Moment)<epsilon*Moment
        numSuccesses(2) = numSuccesses(2)+1;
    end
end


