classdef MasClass < handle

    properties (SetAccess = public)
        n;                  % number of agents
        x0;                 % agents' initial x position
        y0;                 % agents' initial y position
        radius;             % radius of sensing circle
        A;                  % Adjacent matrix
        L;                  % Laplacian matrix
    end

    methods
        % Constructor
        function mas = MasClass(n,x0,y0,radius)
            mas.n = n;
            mas.x0 = x0;
            mas.y0 = y0;
            mas.radius = radius;
        end

    end
end
