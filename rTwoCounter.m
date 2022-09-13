% randomized counter for second moment

classdef rTwoCounter
    % Runs the algorithm for finding the 2nd requency moment
    
    properties(GetAccess = 'public', SetAccess = 'public')
        m           % Total length of streamed sequence
        n           % Number of term types in streamed squence
        k           % Used for the size of the count matrix
        nStar       % Used for the counting matrix
        lambda      % Probabilistic error bound is lambda * true F_k
        epsilon     % Bound on probability aprox will deviate more than the bounds
        mk          % calculated kth moment
        s1          % Number of X variables used to form a single Y variable
        s2          % Number of Y variables
        Y           % Average of s2 X variables
        X           % X = Z^2
        Z           % Counting variable
        countIndex  % Holds "index" of counting variable
        r_count     % tracks how many counters are active and counting
        data_count  % counts data inputs
    end
    
    methods
        
        % Initialize
        function obj = rTwoCounter(m,n,lambda,epsilon)
            obj.m = m;
            obj.n = n;
            obj.lambda = lambda;
            obj.epsilon = epsilon;
            obj.s1 = ceil(16/lambda^2);
            obj.s2 = ceil(2*log(1/epsilon));
            obj.Y = zeros(obj.s2,1);
            obj.X = zeros(obj.s2,obj.s1);
            obj.Z = zeros(obj.s2*obj.s1,1);
            obj.k = ceil(log2(n+1));
            obj.nStar = 2^obj.k -1;
            obj.countIndex = unidrnd(2,length(obj.Z),obj.k*2+1)-1;
            obj.data_count = 0;
        end
        
        % Processes data-stream, storing Z statsistic
        function obj = input_data(obj,d)
            obj.data_count = obj.data_count + 1;
            if obj.data_count > obj.m
                ME = MException('get_moment:count', ...
                    'more than m data inputs given');
                throw(ME)
            end
            for i = 1:length(obj.Z)
                obj.Z(i) = obj.Z(i) + findCount(obj,d,obj.countIndex(i,:));
            end
                
        end
        
        % Used to make Z statistic
        function count = findCount(obj,d,index)
            countVec = [1;Num2Bi(d,obj.k);Num2Bi(d^3,obj.k)];
            count = mod(index*countVec,2)*2-1;
        end
        
        % Processes randomized statistics (Z) to get approximate two-moment.
        function moment = get_moment(obj)
            if obj.data_count < obj.m
                ME = MException('get_moment:count', ...
                    'less than m data inputs given');
                throw(ME)
            end
            obj.X = reshape(obj.Z,[ceil(length(obj.Z)/obj.s1),obj.s1]);
            obj.X = obj.X.^2;
            obj.Y = mean(obj.X,2);
            moment = median(obj.Y);
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
