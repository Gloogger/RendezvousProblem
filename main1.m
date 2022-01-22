%% Definition of Question
% Rendezvous problem 
%   Undirected & unweighted graph
%   Agents have omni-directional sensing range
%   bi-directional information exchange (which enables symmetric adjacency)
%   dynamic graph case
%% initialize
clear;
clc

%% Initial Conditions
n = 10;      % number of agents
% x0 = rand(10,1)./2;
% y0 = rand(10,1)./2;
x0 = [0.1; 0.1; 0.2; 0.2; 0.4; 0.6; 0.6; 0.5; 0.2; 0.35];    % agents' initial x position
y0 = [0.5; 0.4; 0.4; 0.5; 0.5; 0.5; 0.74; 0.85; 0.7; 0.85];    % agents' initial y position
radius = 0.25;               % radius of sensing circle
mas = MasClass(n,x0,y0,radius);

%% solving using ode45
tspan = [0, 10];                    % timespan
Fo = [x0; y0];
options = odeset('RelTol',1e-12);  	% ODE solver error
[t,F] = ode45(@(t,F) System1(t,F,mas),tspan,Fo,options);
X = F(:,1:n);
Y = F(:,n+1:end);

%% animation of trajectories
st = 1;                    % video recording step (the larger, the faster)
plot_mas_traj(X,Y,st,mas)

%% Animation of graph
st = 1;
plot_mas_graph(X,Y,st,mas)




    