function [occupancy] = markovSim(P,q,T)
%markovSim Simulate an n-state Markov Chain over stages t=1,2..,T
%   Input:
%       - P: nxn probability transition matrix
%       - q: n-dim (column) vector containing probability of initial condition, x(0)
%       - T: number of stages
%   Output:
%       occupancy: n-dim vector containing time percentage spent in each state

    % THEORETICAL
    P_eachstate_eachstage = [];  % contains probability of being in each state at each stage
    curr_PTM = P;
    for i = 1:T
        P_eachstate_eachstage(:,i) = q' * curr_PTM;
        curr_PTM = curr_PTM * P;
    end
    % sum across columns to find total 'likelihood' of being in each state over all stages
    % row sum = total prob = 1. T stages so have to normalize over 1*T
    % multiply result with 100 because time percentage asked for
    theoretical_occupancy = sum(P_eachstate_eachstage,2) * 100 / T
    
    % SIMULATION
    allStages_PTM = [];
    B = [];
    w = [];
    curr_PTM = P;
    num_states = size(P,1);
    for i = 1:T
        allStages_PTM(:,:,i) = curr_PTM;
        B(:,:,i) = [zeros(size(curr_PTM,1), 1) cumsum(curr_PTM,2)];  % b_{i0} = 0 for all i
        w = [w rand];
        curr_PTM = curr_PTM * P;
    end
    
    % could do this in above loop but separating for clarity
    curr_state = 1;
    w_0 = rand;
    cumsum_q = [0; cumsum(q)];
    for j = 2:length(q)
        if w_0 >= cumsum_q(j)
            curr_state = j;
        end
    end
    
    history = [curr_state]; % will keep track of all states visited
    for m = 1:T
        relevant_cum_p_leaving = B(curr_state,:,m);
        next_state = 1;
        % num_states = length(relevant_cum_p_leaving)-1; % -1 because a 0 at start
        for n = 2:num_states
            if w(m) >= relevant_cum_p_leaving(n)
                next_state = n;
            end
        end
        curr_state = next_state;
        history = [history curr_state];
    end
    
    num_occurences = zeros(num_states,1);
    for k = 1:length(history)
        num_occurences(history(k)) = num_occurences(history(k)) + 1;
    end
    
    occupancy = zeros(num_states,1);
    for n = 1:num_states
        occupancy(n) = num_occurences(n)/(T+1); % T+1 == sum(num_occurences) really
    end
    occupancy = occupancy*100;
end
