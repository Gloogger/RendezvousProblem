classdef MasMethod
    
    methods (Static) 
        function A = Adjacent(xs,ys,mas)
            Dist = pdist([xs,ys]);
            DistM = squareform(Dist);
            
            A = logical(DistM<mas.radius) - eye(mas.n);
        end
        
        function L = Laplacian(A)
            % calculate Laplacian
            L = diag(sum(A,2)) - A;
            
        end
        
        function ANS = Is_Connected(L)
            % Implementation of Theorem 2.8
            % The graph G is connected iff lambda_2(L) > 0
            
            % Get eigenvalues of laplacian
            lambda = eig(L);
            
            if lambda(2) > 0.00001
                ANS = 'Yes';
            else 
                ANS = 'No';
            end

        end
        
    end
end