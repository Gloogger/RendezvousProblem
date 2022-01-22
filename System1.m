function [F]= System1(t,Fo,mas)
global A_sep count
% Adjacency matrix
xs = Fo(1:mas.n);
ys = Fo(mas.n+1:end);

mas.A = MasMethod.Adjacent(xs,ys,mas);
mas.L = MasMethod.Laplacian(mas.A);
Lxy = blkdiag(mas.L,mas.L);  % Use laplacian twice for X and Y coordinates

A_sep{count} = mas.A;
count = count + 1;

s = Fo;
ds = -Lxy*s;    % GTMMN p.43, Eqn.(3.2)

F = ds;
end