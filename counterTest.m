
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

% runs test for the two counter and the k counter

for i = 1:numTrials
    counter = dCounter(m);
    tCounter = rTwoCounter(m,n,lambda,epsilon);
    kCounter = rGeneralCounter(k,m,n,lambda,epsilon);
    data = unidrnd(n,m,1);
    for j=1:length(data)
        counter = counter.input_data(data(j));
        tCounter = tCounter.input_data(data(j));
        kCounter = kCounter.input_data(data(j));
    end
    tMoment = counter.get_moment(2);
    tMomentApprox = tCounter.get_moment();
    kMoment = counter.get_moment(k);
    kMomentApprox = kCounter.get_moment();
    
    if abs(tMomentApprox-tMoment)<epsilon*tMoment
        numSuccesses(1) = numSuccesses(1)+1;
    end
    
    if abs(kMomentApprox-kMoment)<epsilon*kMoment
        numSuccesses(2) = numSuccesses(2)+1;
    end
end
