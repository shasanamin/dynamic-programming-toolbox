function [S] = inventory(Bmin, Bmax, wmax, q, p, h, c, T)
%inventory Compute optimal inventory thresholds in a setup where demand
%i.e., w_t only takes on integer values
%   Input:
%       - Bmin: minimum possible inventory level
%       - Bmax: maximum possible inventory level
%       - wmax: maximum value of demand (demand takes on only 2 values {0, wmax})
%       - q: probability of demand taking on value 0
%       - p: backlog penalty
%       - h: holding cost
%       - c: production cost
%       - T: horizon length
%   Output:
%       - S: vector of thresholds

    % Assume x0 = 0 i.e. start with no stock or backlog
    gT = 0;  % no terminal cost in problem setup
    S = [];
    for i = T:1:-1
    
    end
end
