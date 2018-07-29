function [bestx, optimal] = ezga(fun, nvars, lb, ub)
    % CHANGE THE FUNCTION FIRST IF YOU WANT A MAXIMUM SEARCH

    % Configuration.Basics
    PopulationNumber = 50;
    MaxGeneration = 50;
    GenerationGap = 0.95;
    
    % Configuration.Selection
    SEL_Function = 'rws'; % rws or sus
    CrossoverProb = 0.7;
    %Elitist = SUBPOP;
    
    % Configuration.Recombination
    REC_Function = 'xovsp'; % recdis or xovsp
    InsertOption = 1; % 0 for uniform choice, 1 for fitness value, 2 for ratio value
    
    % Configuration.Mutation
    MUT_Function = 'mutbga'; % mutate or mut
    MutationProb = 0.1;
    
    % Configuration.Migration
    SUBPOP = 10;
    MigrationProb = 0.2;
    MigrationInterval = 10;
    
    % Configuration.NonlinearSearch
    EnableNlnrSearch = 0; % enable fmincon search here
    NonlinearInterval = 5;
    
    % Configuration.PlotFigure
    DrawEvolutionTable = 1;

    % Initialization
    tracer = zeros(nvars + 1, MaxGeneration);
    FieldDescriptor = [lb; ub];
    PopulationInfo = crtrp(PopulationNumber * SUBPOP, FieldDescriptor);
    
    % Optimization
    counter = 0;    
    GlobalMaxFitnV = -inf * ones(SUBPOP, 1);
    X = PopulationInfo;
    ObjectValue = zeros(size(X, 1), 1);
    for i = 1:size(X, 1)
        ObjectValue(i) = fun(X(i, :)');
    end 
        
    while counter < MaxGeneration
        FitnessValue = ranking(ObjectValue, 2, SUBPOP); % define fitness value        
        [LocalMaxFitnV, LocalBestObjV, LocalBestIndividual] = eltselect(FitnessValue, PopulationInfo, ObjectValue, SUBPOP); % elitist selection    
        SelectPopulation = select(SEL_Function, PopulationInfo, FitnessValue, GenerationGap, SUBPOP); % select population
        Recombination = recombin(REC_Function, SelectPopulation, CrossoverProb, SUBPOP); % recombine
        Mutation = mutate(MUT_Function, Recombination, FieldDescriptor, MutationProb, SUBPOP); % mutate        
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
        
        [PopulationInfo, ObjectValue] = ...
            reins(PopulationInfo, X, SUBPOP, InsertOption, ObjectValue, ObjectValueNext);  % reinsert son to father
                                            
        if (mod(counter,MigrationInterval) == 0)
            [PopulationInfo, ObjectValue] = ...
                migrate(PopulationInfo, SUBPOP, [MigrationProb, 1, 0], ObjectValue); % migration
        end
       
        [GlobalMaxFitnV, PopulationInfo, ObjectValue] = ...
            eltchange(PopulationInfo, ObjectValue, GlobalMaxFitnV, LocalMaxFitnV, ...
            LocalBestObjV, LocalBestIndividual, SUBPOP); % elitist substitution
        
        X = PopulationInfo;                                    
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
