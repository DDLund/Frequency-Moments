% Randomized counter. Runs online randomized algorithm

classdef rGeneralCounter
    
    properties(GetAccess = 'public', SetAccess = 'public')
        m           % Total length of streamed sequence
        n           % Number of term types in streamed squence
        k           % Indicates we are finding F_k
        lambda      % Probabilistic error bound is lambda * true F_k
        epsilon     % Bound on probability aprox will deviate more than the bounds
        mk          % calculated kth moment
        s1          % Number of X variables used to form a single Y variable
        s2          % Number of Y variables
        Y           % Average of s2 X variables
        X           % X = m*(r^k - (r-1)^k)
        counter     % matrx with 1st coumn indicating where to start
                    % counting, 2nd column tracking what number is counted
                    % and thrd colum tracking how many counts
        data_count       % tracks how much data has been input
        r_count% tracks how many counters are active and counting
    end
    
    methods
        %initialize
        function obj = rGeneralCounter(k,m,n,lambda,epsilon)
            obj.k = k;
            obj.m = m;
            obj.n = n;
            obj.lambda = lambda;
            obj.epsilon = epsilon;
            obj.s1 = ceil(8*k*n^(1-1/k)/lambda^2);
            obj.s2 = ceil(2*log(1/epsilon));
            obj.Y = zeros(obj.s2,1);
            obj.X = zeros(obj.s2,obj.s1);
            obj.counter = [sort(unidrnd(obj.m,obj.s1*obj.s2,1)),...
                zeros(obj.s1*obj.s2,1), zeros(obj.s1*obj.s2,1)];
            obj.data_count = 0;
            obj.r_count = 0;
        end
        
        % Processes data-stream, storing random statistics
        function obj = input_data(obj,d)
            obj.data_count = obj.data_count + 1;
            if obj.data_count > obj.m
                ME = MException('get_moment:count', ...
                    'more than m data inputs given');
                throw(ME)
            end
            max_count = obj.s1*obj.s2;
            while obj.counter(obj.r_count+1,1)==obj.data_count
                obj.r_count = obj.r_count+1;
                obj.counter(obj.r_count,2) = d;
                if obj.r_count == max_count
                    break
                end
            end
            for i=1:obj.r_count
                if obj.counter(i,2)==d
                    obj.counter(i,3) = obj.counter(i,3)+1;
                end
            end
        end
        
        
        function moment = get_moment(obj)
            if obj.data_count < obj.m
                ME = MException('get_moment:count', ...
                    'less than m data inputs given');
                throw(ME)
            end
            r = obj.counter(:,3)' ;      %extract r from counter matrix
            r = r(randperm(length(r))) ; %scramble r since it was ordered
            r = VecToMat(r,obj.s1)    ;   %convert to matrix
            obj.X = obj.m.*(r.^obj.k-(r-1).^obj.k);
            obj.Y = mean(obj.X,2);
            obj.mk = median(obj.Y,1);
            moment = obj.mk;
        end
    end
end

%Test code for this counter. Can be run in another file.

%{
data = [1,1,1,2,2,2];
k=2;                % the moment we are finding
m=length(data);     % length of sequence
n=2;                % number of different yypes of elements in sequence
lambda=0.01;        % estimate to deviate no more than lambda*F_k
epsilon=0.01;       % probability that estimate will be within bounds
counter = rGeneralCounter(k,m,n,lambda,epsilon);

for i=1:length(data)
    counter = counter.input_data(data(i));
end
counter.get_moment()
%}


            
            
         
            
            
            
            
            
            
            
            
            
            