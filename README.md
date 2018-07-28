# Mathematical-Modeling
For Mathematical Modeling Contest in September. These are useful tools we may use.
## ezga.m 
  * Using *Sheffield University's GA Toolbox* [http://codem.group.shef.ac.uk/index.php/ga-toolbox] to optimize minimum searching of a function.
  
### Version 1.3
  * Add multiple population GA feature. (alias: *MPGA*)
  * Fix a bug.
  * Re-organize the configuration code.
  * **NOTICE:** 
    (1) Using *SUBPOP* to change population number. 
    (2) Using *MigrationInterval* to change migration interval between different populations. 
    (3) Using *MigrationProb* to change migration probability.

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
  * First version of ezga.
