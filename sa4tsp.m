function [bestx, optimal] = sa4tsp(Data, DIST_Function)
    len = size(Data, 1);
    % Generate Initial Route
    OldRoute = randperm(len);
    NewRoute = OldRoute;
    LocalOptimal = dist(OldRoute', Data, DIST_Function);   
    counter = 0;
    
    OriginalTemp = 500000; % Needs to be handled for different types of Optimazations.
    NowTemp = OriginalTemp;
    TargetTemp = 1e-10;
    DownSpeed = 0.999;
    
    % Change the route, use MetroPolis rules.
    while (NowTemp > TargetTemp)
        place = randperm(len, 2); place1 = min(place); place2 = max(place);
        NewRoute(place1: place2) = OldRoute(place2: -1: place1);
        NewAnswer = dist(NewRoute', Data, DIST_Function);
        D_Energy = NewAnswer - LocalOptimal;
        if D_Energy < 0  % Accept at once 
            LocalOptimal = NewAnswer;
            OldRoute = NewRoute;
        elseif (exp(-D_Energy / NowTemp) >= rand) && (exp(-D_Energy/NowTemp) <= 1) % Accept at 'temperature' prob
            LocalOptimal = NewAnswer;
            OldRoute = NewRoute;            
        else
            NewRoute = OldRoute;
        end
        NowTemp = DownSpeed * NowTemp;
        counter = counter + 1;
        tracer(counter) = LocalOptimal;
    end
    
    bestx = NewRoute;
    optimal = tracer(end);
    
    figure(1);
    plot(tracer);
    grid on;
    xlabel('Iteration');
    ylabel('Optimal Value');
    title('Simulated Annealing');
    
    % Optimal Route
    figure(2);
    title('TSP solution');
    grid on;
    plot(Data(:,1), Data(:,2), 'o')
    hold on;
    nvars = len;
    for i = 1:nvars
        plot([Data(bestx(i),1), Data(bestx(mod(i, nvars) + 1),1)], [Data(bestx(i),2), Data(bestx(mod(i, nvars) + 1),2)], 'k')
        hold on;
    end
    
end