function [F] = plot_mas_graph(X,Y,st,mas)
% Graph Animation

% for saving video
video = VideoWriter('MAS_Graph','MPEG-4');
video.Quality = 75;
open(video);

figure;

cm = colormap('Lines');  % get a long list of RGB values 

% Main animation loop
for k = 1:size(X,1)
    xi = X(k,:);
    yi = Y(k,:);
        
    cla     % delete all objects & handles in last frame

    % add axis-Tick on all four edges of the plot
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
        
        % update the sensing range
        width = 2*mas.radius;
        height = 2*mas.radius;
        xLeft = xCenter - width/2;
        yBottom = yCenter - height/2;
        rectangle('Position', [xLeft, yBottom, width, height], ...%[x y w h]
            'Curvature', [1 1],...
            'EdgeColor', 'r', ...
            'LineWidth', 0.1);
        hold on
    end
    
    % Update the edges
    A_temp = MasMethod.Adjacent(xi',yi',mas);
    [END,START]=find(triu(A_temp));
    xstart=xi(START); % In adjacency
    ystart=yi(START);
    xend=xi(END);
    yend=yi(END);
    line([xstart; xend], [ystart; yend], ...
         'Color', 'k',...
         'LineWidth', 2);
    
    title('Animation 2: Graph')
    
    % save current frame to video
    if mod(k,st)==0
        currFrame = getframe(gcf);
        writeVideo(video,currFrame);
    end
    
    hold off;
    pause(0.01)
    
    
end

close(video);

return