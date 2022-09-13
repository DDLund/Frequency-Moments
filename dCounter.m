% Deterministic Counter. runs offline, exact counter
classdef dCounter
    
    properties(GetAccess = 'public', SetAccess = 'public')
        count         % maps elements to counts
    end
    
    methods
        
        %initialize
        function obj = dCounter(m)
            obj.count = zeros(m,1);
        end
        
        %count an element of data stream
        function obj = input_data(obj,d)
            obj.count(d) = obj.count(d) + 1;
        end
        
        %calculate kth moment
        function moment = get_moment(obj,k)
            moment = sum(obj.count.^k);
        end
        
    end
end

%Test code for this counter. Can be run in another file.

%{
data = [1,1,1,2,2,2];
k=2;                % the moment we are finding
m=length(data);     % length of sequence
n=2;                % number of different yypes of elements in sequence
counter = dCounter(m);

for i=1:length(data)
    counter = counter.input_data(data(i));
end
counter.get_moment(k)
%}

