# Mathematical-Modeling
For Mathematical Modeling Contest in September. These are useful tools we may use.
# ezga.m
## Demonstration:
  * Using *Sheffield University's GA Toolbox* [http://codem.group.shef.ac.uk/index.php/ga-toolbox] to optimize minimum searching of a function. There are two other functions to accomplish the *elitist* method. There are *eltselect* and *eltchange*. 
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
  * This is the first STSP (symmetric traveling salesman problem) solver that we make. We design it under **ezga** and *GA Toolbox* mentioned before. Unlike the original **ezga**, the population structure, recombination function and mutation function need to be changed. Therefore, we add three major changes in the original *GA Toolbox*. There are *crtperm*, *intercross* and *mutation*. And there are 2 template connectors to help you link those methods to the original *GA Toolbox*. There are *REC_Template* and *MUT_Template*. Finally, there is a file to calculate the distance called *dist*.
  * **Notice: Recently we have added a 2-opt tool to optimize solution, but it will cost fairly much time. This feature is under development, please handle it with care.
  
  * ***crtperm*** is for generating a permutational population. (*e.g.* [2 3 1 4 5 8 6 7] as an individual of 8 characters)
  * ***intercross*** is for generating sons by their parents. There are 6 methods available now. There are:
    * **pmx**: Partially-Mapped Crossover
    * **cx**: Cyclinic Crossover
    * **ox**: Order Crossover
    * **obx**: Order-Based Crossover
    * **pbx**: Position-Based Crossover
    * **er**: Edge Recombination (**Notice: This method is much slower than others, but it performs better.**)
  * ***mutation*** is for mutating those sons to acquire new possibilities. There are 2 methods available now. There are:
    * **swap**: swap 2 characters randomly
    * **scramble**: select 2 places and shuffle all the characters between it.
  * ***dist*** is for calculating the distance between two cities. There are 5 methods available now. There are:
    * **euc**: Euclidean Distance (L2)
    * **manh**: Manhattan Distance (L1)
    * **max**: Maximum Distance (L\inf)
    * **geo**: Geographical Distance (**Notice: We use MATLAB's built-in function *distance* to calculate, it's time-consuming.**)
    * **custom**: Custom Distance - You should give a distance table to use this feature.
  * ***REC_Template*** is for connecting *intercross* module. Just follow the instructions inside the file.
  * ***MUT_Template*** is for connecting *mutation* module. Just follow the instructions inside the file.
  * ***opt-2*** is for optimizing solutions using a local minimum search.
  * **Notice: Those algorithms are based on the paper: *Genetic algorithms for the traveling salesman problem, Jean-Yves Potvin, Annals of Operations Research 63(1996)339-370***. Deep appreciation for that.

## Changelog:
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
