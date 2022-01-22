function [F] = plot_mas_traj(X,Y,st,mas)
% Trajectory Animation

% for saving video
video = VideoWriter('MAS_Traj','MPEG-4');
video.Quality = 75;
open(video);

figure;

cm = colormap('Lines');  % get a long list of RGB values 

% Main animation loop
for k = 1:size(X,1)
    xi = X(k,:);
    xs = X(1:k,:);
    yi = Y(k,:);
    ys = Y(1:k,:);
        
    % delete all objects & handles in last frame
    cla
    
    % Draw axis-tick on all four edges of the plot
    h1 = gca;   % get the axis handle
    set(h1, 'XTick', 0:0.1:1);
    set(h1, 'YTick', 0:0.1:1);
    
    h2 = axes ('Position', get (h1, 'Position'));
    set (h2, 'YAxisLocation', 'right', 'XAxisLocation', 'top', ...
             'Color', 'None')
    set (h2, 'XTick', 0:0.1:1);
    set (h2, 'YTick', 0:0.1:1);
    
    axis([h1, h2], 'square');
    axis([h1, h2], [0 1 0 1])
    
    
    hold on
    
    % terminate the animation if no visible change
    % Known bug: if there are two centroids of network, it terminates the
    % animation unexpectedly
    if all(abs(xi - xi(1)) < 0.0001) && all(abs(yi - yi(1)) <= 0.0001)
        close(video)
        return
    end

    % Loop for updating each agent
    for i=1:mas.n
        xCenter=xi(i);      % to draw node on center
        yCenter=yi(i);      % to draw node on center
        width = 0.04;
        height = 0.04;
        xLeft = xCenter - width/2;
        yBottom = yCenter - height/2;
        
        % update the points in current frame
        rectangle('Position', [xLeft, yBottom, width, height], ...%[x y w h]
            'Curvature', [1 1],...
            'FaceColor', cm(i,:), ...
            'EdgeColor', 'k', ...
            'LineWidth', 1);
        hold on
        
        % update the trajectories in current frame
        plot(xs(:,i),ys(:,i), ...
             'Color', cm(i,:), ...
             'LineWidth', 2)
        hold on
    end
    title('Animation 1: Trajectories')
    
    % save current frame to video
    if mod(k,st)==0
        currFrame = getframe(gcf);
        writeVideo(video,currFrame);
    end
    
    hold off;
    pause(0.03)
    
    
end

close(video);

return