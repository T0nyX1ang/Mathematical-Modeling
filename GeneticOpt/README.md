# Mathematical-Modeling
These are useful tools we may use.

# ezga.m
## Demonstration:
  * Using *Sheffield University's GA Toolbox* [http://codem.group.shef.ac.uk/index.php/ga-toolbox] to optimize minimum searching of a function. There are two other functions to accomplish the *elitist* method. There are *eltselect* and *eltchange*. 

## Function List:
  * ***ezga***: main function.
  * ***nlnrezga***: standalone nonlinear search of ezga function.
  * ***ezmpga***: standalone multiple population of ezga function.
  * ***ezelitga***: standalone elitist procedure of ezga function.
  * ***eltselect***: using *Elitist* methods in normal GA. This is the selection module. Please use it together with **ezga**.
  * ***eltchange***: using *Elitist* methods in normal GA. This is the substitution module. Please use it together with **ezga**.

## Changelog:
### Version 1.4
  * Add Elitist GA feature.
  * Add two modules to help with *Elitist* feature: *eltselect* and *eltchange*. You can see infomation below.
  * Performance enhanced.

### Version 1.3
  * Add multiple population GA feature. (alias: *MPGA*)
  * Fix a bug.
  * Re-organize the configuration code.
  * **NOTICE:** 
    1. Using *SUBPOP* to change population number. 
    2. Using *MigrationInterval* to change migration interval between different populations. 
    3. Using *MigrationProb* to change migration probability.

### Version 1.2
  * Enable *EnableNlnrSearch* to enhance local search.
  * Set *optimset.Display* to *'off'* to avoid extra output and time. 
  * **NOTICE:** Using *NonlinearInterval* to change local search interval in GA main search.
  * **WARNING: Total search time will be a little longer than before.**
  
### Version 1.1
  * Change *crtbp* to *crtrp* for better performance.
  * Remove *bs2rv* function and optimize bugs.
  * Execution time shortened. 

### Version 1.0
  * First version of *ezga*.

# ga4tsp.m
## Demonstration:
  * This is the first STSP (symmetric traveling salesman problem) solver that we make. We design it under **ezga** and *GA Toolbox* mentioned before. Unlike the original **ezga**, the population structure, recombination function and mutation function need to be changed. Therefore, we add three major changes in the original *GA Toolbox*. There are *crtperm*, *intercross* and *mutation*. And there is 1 template connectors to help you link those methods to the original *GA Toolbox* which is called *REC_Template*. We integrate mutation and optimization to save time. Finally, there is a file to calculate the distance called *dist*. To save time, we use a function named *gentable* to pre-calculate those distances.

## Function List:
  * ***crtpermp*** is for generating a permutational population. (*e.g.* [2 3 1 4 5 8 6 7] as an individual of 8 characters)
  * ***recombine*** is a modified version of *gatbx* to connect the *intercross* function below.
  * ***intercross*** is for generating sons by their parents. There are 6 methods available now. There are:
    * **pmx**: Partially-Mapped Crossover
    * **cx**: Cyclinic Crossover
    * **ox**: Order Crossover
    * **obx**: Order-Based Crossover
    * **pbx**: Position-Based Crossover
    * **er**: Edge Recombination (**Notice: This method is much slower than others, but it performs better.**)
  * ***optmutate*** is for mutating those sons to acquire new possibilities. There are 5 methods in mutation and 2 methods in optimization available now. There are:
    * ------------------------------------------ **mutation** ------------------------------------------
    * **mutation**: still act as a connector, but for that modified *optmutate*
    * **swap**: swap 2 characters randomly
    * **scramble**: select 2 places and shuffle all the characters between it
    * **m2opt**: mutation for 2-opt process (best-fit, default version now)
    * **m3opt**: mutation for 3-opt process
    * **m4opt**: mutation for 4-opt process
    * ---------------------------------------- **optimization** ----------------------------------------
    * **hlclb**: hill-climbing optimization (best-fit, default version now)
    * **sa**: simulated annealing optimization
  * ***gentable*** is for calculating the distance between (any) two cities. There are 4 methods available now. There are:
    * **euc**: Euclidean Distance (L2)
    * **manh**: Manhattan Distance (L1)
    * **max**: Maximum Distance (L\inf)
    * **geo**: Geographical Distance
  * ***dist*** is for calculating the distance of a tour by the table generated above.  
  * **Notice: Those algorithms are based on the paper: *Genetic algorithms for the traveling salesman problem, Jean-Yves Potvin, Annals of Operations Research 63(1996)339-370***. Deep appreciation for that.

## Changelog:
### Version 1.5.1-beta2
  * Add one testing functions: *newm3opt* to enhance search performance. 
  * To apply this update, you need to change the function call in *ga4tsp*: *MUT_Function* should be set to *newmeopt*, *OPT_Function* should be set to *newhlclb*. 
### Version 1.5-beta1
  * Add two testing functions: *newhlclb* and *newm2opt* to shorten calculation time. (17% ~ 20%)
  * **Note**:The way to calculate distances are changed here because we find out that calculating change with the nodes can be faster than calculating the solution. (less function calls)
  * **Notice:** 
    1. It's interesting to say that we are surely closer to the classical Lin-Kernighan heuristic algorithm. 
    2. There will be lots of beta test versions from now on.
    3. To apply this update, you need to change the function call in *ga4tsp*: *MUT_Function* should be set to *newm2opt*, *OPT_Function* should be set to *newhlclb*. 
### Version 1.4.1
  * Add variable *OPT_MaxIteration* to set maximum iteration for optimization. (*hlclb*)
  * Change *ga4tsp*(main), *optmutate*, *mutation*, *hlclb* parameters according to the new feature.
### Version 1.4
  * Fix a bug in *hlclb* function.
  * *REC_Template* function is deprecated from now on. And 6 crossover functions are provided instead.
  * Reduce dependency for *gatbx*
### Version 1.3
  * Modify the *dist* function and add a new function *gentable* to save time. (50%)
  * Change all the functions involving *dist* function.
### Version 1.2
  * Integrate mutation and optimization to one function. Operation time has been greatly shortened.
  * Remove these functions: **mutate.m**, **opt2.m**, etc. to save space.
  * Add 2-opt, 3-opt, 4-opt, hill-climbing, simulated annealing feature in the integration.
### Version 1.1-beta
  * Add 2-top feature.
  * Change some parameters according to the new feature.
### Version 1.0
  * First version of ga4tsp.
  * Add methods and references. Enrich demonstration.

# sa4tsp.m
## Demonstration:
  * SA (Simulated Annealing) is an algorithm to find global optimum by simulating metal temperature change during annealing. It's a variation of hill-climbing algorithm. It's very stable and it can reach global optimum theoretically. But time will surge when dimension is rising.

## Changelog:
### Version 1.0
  * First version of sa4tsp.
  
# References
  * Sheffield University's GA Toolbox: http://codem.group.shef.ac.uk/index.php/ga-toolbox
  * Genetic algorithms for the traveling salesman problem, Jean-Yves Potvin, Annals of Operations Research 63(1996)339-370
