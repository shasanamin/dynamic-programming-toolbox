% some basic examples to see provided functions in action
% input, output and/or algorithm details inside respective function file

%% optTrajectory
% [route] = optTrajectory(L, LS, LT)
L = [2 5 12; 7 6 3; 18 2 10];
L(:,:,2) = [4 2 1; 6 4 7; 9 5 8];
L(:,:,3) = [6 4 13; 12 5 4; 4 3 6];
LS = [3 8 5];
LT = [10 7 5];

route = optTrajectory(L, LS, LT)

%% shortestpath
% [route, cost] = shortestPath(A, method)
% using any method would give same (minimum) cost but 
% route and algorithm (1: Bellman-Ford, 2: DFS, 3: Dijkstra) are different
A = [0 6 0.5 5 7;
    6 0 5 2 2; 
    0.5 5 0 1 5;
    5 2 1 0 -1;
    7 2 5 -1 0];

[route, min_cost] = shortestPath(A,2)

%% markovSim
% [occupancy] = markovSim(P,q,T)
P = [0.3 0.48 0.22;
     0.2 0.6 0.2;
     0.25 0.75 0];
q = [1/7; 2/7; 4/7]; 
T = 1000;

% as T increases theoretical and simulated occupancy should come close
% for 3-state Markov Chain, even T=100 good enough to see this
occupancy = markovSim(P,q,T)

%% markovDP
% [J0, mu0] = markovDP(P,g,gT,T)
P{1} = [0.2 0.4 0.4;
        0.1 0.5 0.4;
        0.6 0.1 0.3];
P{2} = [0 0.5 0.5;
        0.25 0.55 0.2;
        0.3 0.1 0.6];
g = [2 10; 5 4; 2 1];
g(:,:,2) = [4 1; 3 2; 1 1];
g(:,:,3) = [6 3; 3 4; 4 2];
gT = [1; 5; 3];
T = 2; % 3 stages including 0th stage

[J0, mu0] = markovDP(P,g,gT,T)

%% valueIteration
% [J, mu] = valueIteration(P,g,alpha,max_iter)
P = zeros(2,2,2);
P(:,:,1) = [0.8 0.2;
            0.7 0.3];
P(:,:,2) = [0.5 0.5; 
            0.4 0.6];
g = [4 6;
    -5 -3];
alpha = 0.9;
max_iter = 1000;

[J, mu] = valueIteration(P,g,alpha,max_iter)

%% policyIteration
% [J, mu] = policyIteration(P,g,alpha,max_iter)
P = zeros(2,2,2);
P(:,:,1) = [0.8 0.2;
            0.7 0.3];
P(:,:,2) = [0.5 0.5; 
            0.4 0.6];
g = [4 6;
    -5 -3];
alpha = 0.9;
max_iter = 1000;

[J, mu] = policyIteration(P,g,alpha,max_iter)

%% inventory
% [S] = inventory(Bmin, Bmax, wmax, q, p, h, c, T)
Bmin = 10;
Bmax = 10;
wmax = 1;
q = 0.25;
p = 5;
h = 2;    
c = 2;
T = 100;

S = inventory(Bmin, Bmax, wmax, q, p, h, c, T)