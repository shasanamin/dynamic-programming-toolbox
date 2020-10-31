function [J0, mu0] = markovDP(P,g,gT,T)
%markovDP Generic DP solver for finite-state Markov chains
%   Input:
%       - P: a cell matrix (P{1}, P{2}, ..., P{M}), where M is the number 
%       of control actions, and each P{m} is an NxN probability transition 
%       matrix under the control action m, where N is the number of states. 
%       Accordingly, P{m}(i,j) is the probability of transitioning from 
%       state i to state j under control action m.
%       - g: NxMxN stage cost, where g(i,m,j) is the cost of using control
%       action m at state i if the next state is j
%       - gT: n-dim vector of terminal costs
%       - T: termination time
%   Output:
%       - J0: N-dim vector of the optimal cost-to-go starting at initial
%       time t = 0 for each state
%       - mu0: N-dim vector of the optimal control action at initial time
%       t = 0 for each state

    M = size(P, 2);
    J = []; % contains J* for each stage
    mu = []; % contains mu* for each stage
    % J and mu stored for completeness and any future analysis 
    % (although only J0 and mu0 required)
    
    J_curr = gT;
    for t=T:-1:1
        % J_next contains all possible J_nexts (i.e. for all controls) and 
        % min is later taken to get minimum J_next which is then set equal to J_curr
        J_next = [];
        for u = 1:M
            % squeeze function to change g from 3D (Nx1xN) to 2D (NxN)
            Ju = diag(P{u}*squeeze(g(:,u,:))') + P{u}*J_curr;
            J_next = [J_next Ju];
        end
        [J_next, mu_next] = min(J_next, [], 2);
        J = [J_next J];
        mu = [mu_next mu];
        J_curr = J_next;
    end
    
    J0 = J(:,1);
    mu0 = mu(:,1);
end
