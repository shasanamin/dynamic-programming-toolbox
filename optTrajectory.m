function [route] = optTrajectory(L, LS, LT)
% Dynamic Programming based function to compute minimum cost trajectory
% from a starting node S to a terminal node T
%   Input:
%       - L: a 3-D matrix s.t. L(i,j,k) is cost from node i to j at stage k
%       - LS: vector expressing cost from start node S in first stage
%       - LT: vector expressing cost to terminal node T in last stage
%   Output:
%       - route: sequence of nodes in optimal trajectory

    [from, to, stages] = size(L);

    % initialization
    num_nodes_last_stage = size(L(:,:,stages), 2);
    for i = 1:num_nodes_last_stage
        % L does not contain paths for last stage (they are in LT), so +1.
        % another +1 to add info from LS
        minPathCumCost(i, stages+2) = LT(i);
        minPathParent(i, stages+2) =  i;
    end
    
    for j = stages:-1:1
        for m = 1:size(L(:,:,j), 1)
            for n = 1:size(L(:,:,j), 2)
                pathLength(n) = L(m, n, j) + minPathCumCost(n, j+2);
            end
            [minP, minP_index] = min(pathLength);
            minPathCumCost(m, j+1) = minP;
            minPathParent(m, j+1) = minP_index;
            % important to clear when different number of nodes in each layer
            clear pathLength;
        end
    end
    
    % add information from LS
    for o = 1:size(LS,2)
        pathLength(o) = LS(o) + minPathCumCost(o,2);
    end
    [minP, minP_index] = min(pathLength);
    minPathCumCost(1,1) = minP;
    minPathParent(1,1) = minP_index;
    
    optTraj = minPathCumCost;
    optTraj(:,:,2) = minPathParent;
    
    route(1) = minPathParent(1,1);
    for p = 2:stages+2
        route(p) = minPathParent(route(p-1) ,p);
    end
end
