function [bestx, optimal] = ezga(fun, nvars, lb, ub, lbin, ubin)
    %         CHANGE THE FUNCTION FIRST IF YOU WANT A MAXIMUM SEARCH

    % Configuration
    PopulationNumber = 400;
    MaxGeneration = 100;
    GenerationGap = 0.95;
    CrossoverProb = 0.7;
    MutationProb = 0.01;
    PersonLength = 200;
    SUBPOP = 1;
    InsertOption = 1; % 0 for uniform choice, 1 for fitness value, 2 for ratio value
    SEL_Function = 'sus'; % rws or sus
    REC_Function = 'xovsp'; % recdis or xovsp
    PersonMatrix = PersonLength * ones(1, nvars);
    CodingMethod = 1 * ones(1, nvars); % 0 for Gray code; 1 for binary code
    ScaleMethod = 0 * ones(1, nvars); % 0 for numeric code; 1 for logarithm code
    DrawEvolutionTable = 1;

    % Initialization
    tracer = zeros(nvars + 1, MaxGeneration);
    FieldDescriptor = [PersonMatrix; lb; ub; CodingMethod; ScaleMethod; lbin; ubin];
    CreatePopulation = crtbp(PopulationNumber, PersonLength * nvars);
    
    % Optimization
    counter = 0;                                                                              
    X = bs2rv(CreatePopulation, FieldDescriptor); % base change
    ObjectValue = zeros(size(X, 1), 1);
    for i = 1:size(X, 1)
        ObjectValue(i) = fun(X(i, :)');
    end 
    
    while counter < MaxGeneration
        FitnessValue = ranking(ObjectValue); % define fitness value
        SelectPopulation = select(SEL_Function, CreatePopulation, FitnessValue, GenerationGap); % select population
        Recombination = recombin(REC_Function, SelectPopulation, CrossoverProb); % recombine
        Mutation = mut(Recombination, MutationProb); % mutate
        X = bs2rv(Mutation, FieldDescriptor); % base change
        ObjectValueNext = zeros(size(X, 1), 1);
        for i = 1:size(X, 1)
            ObjectValueNext(i) = fun(X(i, :)');
        end
        [CreatePopulation, ObjectValue] = reins(CreatePopulation, Mutation, SUBPOP, ...
                                                InsertOption, ObjectValue, ObjectValueNext);  % reinsert
        X = bs2rv(CreatePopulation, FieldDescriptor); % update X
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