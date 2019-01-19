function [bestx, optimal] = ezmpga(fun, nvars, lb, ub)
    % CHANGE THE FUNCTION FIRST IF YOU WANT A MAXIMUM SEARCH

    % Configuration
    PopulationNumber = 50;
    MaxGeneration = 50;
    GenerationGap = 0.95;
    CrossoverProb = 0.7;
    MutationProb = 0.1;
    MigrationProb = 0.2;
    SUBPOP = 10;
    InsertOption = 1; % 0 for uniform choice, 1 for fitness value, 2 for ratio value
    SEL_Function = 'rws'; % rws or sus
    REC_Function = 'xovsp'; % recdis or xovsp
    MUT_Function = 'mutbga'; % mutate or mut
    DrawEvolutionTable = 1;
    MigrationInterval = 10;

    % Initialization
    tracer = zeros(nvars + 1, MaxGeneration);
    FieldDescriptor = [lb; ub];
    CreatePopulation = crtrp(PopulationNumber * SUBPOP, FieldDescriptor);
    
    % Optimization
    counter = 0;                                                                              
    X = CreatePopulation;
    ObjectValue = zeros(size(X, 1), 1);
    for i = 1:size(X, 1)
        ObjectValue(i) = fun(X(i, :)');
    end 
    
    while counter < MaxGeneration
        FitnessValue = ranking(ObjectValue, 2, SUBPOP); % define fitness value
        SelectPopulation = select(SEL_Function, CreatePopulation, FitnessValue, GenerationGap, SUBPOP); % select population
        Recombination = recombin(REC_Function, SelectPopulation, CrossoverProb, SUBPOP); % recombine
        Mutation = mutate(MUT_Function, Recombination, FieldDescriptor, MutationProb, SUBPOP); % mutate        
        X = Mutation;
        
        ObjectValueNext = zeros(size(X, 1), 1);
        for i = 1:size(X, 1)
            ObjectValueNext(i) = fun(X(i, :)'); % generate son generation values
        end
        
        [CreatePopulation, ObjectValue] = reins(CreatePopulation, X, SUBPOP, ...
                                                InsertOption, ObjectValue, ObjectValueNext);  % reinsert son to father
                                            
        if (mod(counter,MigrationInterval) == 0)
            [CreatePopulation, ObjectValue] = migrate(CreatePopulation, SUBPOP, ...
                                                      [MigrationProb, 1, 0], ObjectValue); % migration
        end
        
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