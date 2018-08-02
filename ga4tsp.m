function [bestx, optimal] = ga4tsp(Data)

    % Configuration.Basics
    PopulationNumber = 60;
    MaxGeneration = 100;
    GenerationGap = 0.95;
    
    % Configuration.DistanceAlgorithm
    DIST_Function = 'euc';
    
    % Configuration.Selection
    SEL_Function = 'sus'; % rws or sus
    CrossoverProb = 0.7;
    %Elitist = SUBPOP;
    
    % Configuration.Recombination
    REC_Function = 'ox'; % pmx, cx, ox, obx, pbx, er
    InsertOption = 1; % 0 for uniform choice, 1 for fitness value, 2 for ratio value
    
    % Configuration.Mutation
    MUT_Function = 'scramble'; % swap, scramble
    MutationProb = 0.1;
    Opt_Iteration = 200;
    
    % Configuration.Migration
    SUBPOP = 20;
    MigrationProb = 0.2;
    MigrationInterval = 10;
    
    % Configuration.PlotFigure
    DrawEvolutionTable = 1;

    % Initialization
    nvars = size(Data, 1);
    tracer = zeros(nvars + 1, MaxGeneration);
    PopulationInfo = crtpermp(PopulationNumber * SUBPOP, nvars);
    
    % Optimization
    counter = 0;    
    GlobalMaxFitnV = -inf * ones(SUBPOP, 1);
    X = PopulationInfo;
    ObjectValue = zeros(size(X, 1), 1);
    for i = 1:size(X, 1)
        ObjectValue(i) = dist(X(i, :)', Data, DIST_Function);
    end 
        
    while counter < MaxGeneration
        FitnessValue = ranking(ObjectValue, 2, SUBPOP); % define fitness value        
        [LocalMaxFitnV, LocalBestObjV, LocalBestIndividual] = eltselect(FitnessValue, PopulationInfo, ObjectValue, SUBPOP); % elitist selection    
        SelectPopulation = select(SEL_Function, PopulationInfo, FitnessValue, GenerationGap, SUBPOP); % select population
        Recombination = recombin(REC_Function, SelectPopulation, CrossoverProb, SUBPOP); % recombine
        Mutation = mutate(MUT_Function, Recombination, [], MutationProb, SUBPOP); % mutate
        for i = 1:size(Mutation, 1)
            Opts(i, :) = opt2(Mutation(i, :), Opt_Iteration, Data, DIST_Function);
        end
        X = Opts;
        
        ObjectValueNext = zeros(size(X, 1), 1);
        for i = 1:size(X, 1)
            ObjectValueNext(i) = dist(X(i, :)', Data, DIST_Function); % generate son generation values
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
    
    % Optimal Route
    figure(2);
    title('TSP solution');
    grid on;
    plot(Data(:,1), Data(:,2), 'o')
    hold on;
    for i = 1:nvars
        plot([Data(bestx(i),1), Data(bestx(mod(i, nvars) + 1),1)], [Data(bestx(i),2), Data(bestx(mod(i, nvars) + 1),2)], 'k')
        hold on;
    end
    
end
