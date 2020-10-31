function [route, cost] = shortestpath(A, method)
% shortestpath Using Label Correcting Algorithm to solve shortest path 
% problem from node 1 to N
%   Input:
%       - A: NxN matrix s.t. A_i_j >= 0 is distance from i to j,
%       while A_i_j = -1 means absence of link
%       - method: flag to indicate the solution method to select nodes from OPEN 
%       - with available methods being 1 (FIFO), 2 (LIFO), 3 (Minimum Label)
%   Output:
%       - route: sequence of nodes in shortest path starting from 1 and
%       terminating at N
%       - cost: cost of shortest path
    
    % initialization
    S = 1;
    T = size(A,2);
    d = Inf([1 size(A,2)]);
    d(S) = 0;
    OPEN = [S];
    
    parent = zeros(1,size(A,2));
    
    while(size(OPEN,2) > 0)
        % OPEN
        i = OPEN(1);
        OPEN(1) = [];
        
        child_i = [];
        for j = 1:size(A,1)
            if A(i,j) ~= -1  % -1 indicates absence of link
                child_i = [child_i j];
            end
        end
        
        for j = 1:size(child_i,2)
           d_j_hat = d(i) + A(i,j);
           if d_j_hat < d(j) && d_j_hat < d(T)
               d(j) = d_j_hat;
               parent(j) = i;
               if j ~= T
                   if method == 1  % FIFO (Bellman-Ford)
                       OPEN = [OPEN j];
                   elseif method == 2  % LIFO (DFS)
                       OPEN = [j OPEN];
                   elseif method == 3  % minimum label (Dijkstra)
                       % since adding in particular way, OPEN would have
                       % elements sorted by associated d
                       if size(OPEN,2) > 0
                           if d(j) < d(OPEN(1))
                               OPEN = [j OPEN];
                           elseif d(j) > OPEN(size(OPEN,2))
                               OPEN = [OPEN j];
                           else
                               for k = 2:size(OPEN,2)
                                   elemOPEN = OPEN(k);
                                   if d(j) < d(elemOPEN)
                                       OPEN = [OPEN(1:k) j OPEN(k+1:size(OPEN,2))];
                                   end
                               end
                           end
                       else  % OPEN is empty so can insert anyway
                           OPEN = [OPEN j];
                       end    
                   end
               end
           end    
        end
    end
    
    cost = d(T);
    
    next_index = T;
    route = [];
    while(next_index ~= S)
        route = [next_index route];
        next_index = parent(next_index);
    end
    route = [S route];
end
