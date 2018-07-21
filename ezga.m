function [bestx, optimal] = ezga(fun, nvars, lb, ub)
    % CHANGE THE FUNCTION FIRST IF YOU WANT A MAXIMUM SEARCH

    % Configuration
    PopulationNumber = 50;
    MaxGeneration = 30;
    GenerationGap = 0.95;
    CrossoverProb = 0.6;
    MutationProb = 0.1;
    SUBPOP = 1;
    InsertOption = 1; % 0 for uniform choice, 1 for fitness value, 2 for ratio value
    SEL_Function = 'rws'; % rws or sus
    REC_Function = 'xovsp'; % recdis or xovsp
    DrawEvolutionTable = 1;
    EnableNlnrSearch = 0; % enable fmincon search here
    NonlinearInterval = 5;

    % Initialization
    tracer = zeros(nvars + 1, MaxGeneration);
    FieldDescriptor = [lb; ub];
    CreatePopulation = crtrp(PopulationNumber, FieldDescriptor);
    
    % Optimization
    counter = 0;                                                                              
    X = CreatePopulation;
    ObjectValue = zeros(size(X, 1), 1);
    for i = 1:size(X, 1)
        ObjectValue(i) = fun(X(i, :)');
    end 
    
    while counter < MaxGeneration
        FitnessValue = ranking(ObjectValue); % define fitness value
        SelectPopulation = select(SEL_Function, CreatePopulation, FitnessValue, GenerationGap); % select population
        Recombination = recombin(REC_Function, SelectPopulation, CrossoverProb); % recombine
        Mutation = mutbga(Recombination, FieldDescriptor, MutationProb); % mutate        
        X = Mutation;
        
        ObjectValueNext = zeros(size(X, 1), 1);
        for i = 1:size(X, 1)
            ObjectValueNext(i) = fun(X(i, :)'); % generate son generation values
        end
        
        % nonlinear optimization using current X value for a local optimization.
        if mod(counter, NonlinearInterval) == 0 && counter > 0 && EnableNlnrSearch == 1
            tempX = zeros(size(X, 1), nvars);
            options = optimset();
            options.Display = 'off';
            for i = 1:size(X, 1)
                tempx = fmincon(fun, X(i, :)', [], [], [], [], lb, ub, [], options);
                tempX(i, :) = tempx';
            end
            X = tempX;
        end  
        
        [CreatePopulation, ObjectValue] = reins(CreatePopulation, Mutation, SUBPOP, ...
                                                InsertOption, ObjectValue, ObjectValueNext);  % reinsert son to father

        X = CreatePopulation;                                    
        counter = counter + 1; % update counter
        [Optimal, Index] = min(ObjectValue); % get minimal index
        tracer(1:nvars, counter) = X(Index, 1:nvars); % get minimal in every generation
        tracer(end, counter) = Optimal; % get optimal solution in every generation
    end

    if DrawEvolutionTable == 1
        % Evolution Value
        figure(1);
        plot(1:MaxGeneration, tracer(end, :));
        grid on;
        xlabel('Generation Number');
        ylabel('Optimal Value');
        title('Evolution Table');
    end

    % Output Value
    optimal = tracer(end, end);
    bestx = tracer(1:nvars, end);
end
