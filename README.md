# Topic: Understanding the dynamics of a complex biological networks without parameter information: Case study on the cell-cycle networkof fossion-yeast (*S.pombe*)

## RACIPE Simulations (Three independent replicates for each network)

Detailed instructions about RACIPE is given [here:](https://github.com/hebbaranish/Gene_Network_Modelling/tree/master/RACIPE-1.0-master/Multithreaded_Racipe_2.28 "RACIPE Code Repo")

The information of the network and its interactions are written in a .topo file. For details, visit the above link. 
After the topo file is created, the compiled RACIPE can be run using: 
`./RACIPE <file>.topo -num_paras <number_of_parameter_sets> -num_ode <number_of_initial_conditions_for_each_parameter_set>` 
Additinal flags were used in special conditions, for those details, refer to "Methods" section or our article and visit the above mentioned repository of RACIPE.

Once the triplicates of the RACIPE simulations are done, we use the following pipelines to analyze the data in different ways.

**Important**: Keep all the triplicates of the RACIPE solutions for a same network in the same directory (preferebly, name the directory as the name of the network). For example Make a directory `/home/user1/network` and keep the replicate one inside the folder as `/home/user1/network/1` and same for replicate two and three. 

# Code definitions: 

**G/K Normalization:**  
filename: `GK_normalization.m`

This code performs G/K normalization on all the RACIPE solution files present in the Given directory and writes the output in the `*_solutions_gk_?.dat` files in the same directory. [`*` and `?` denote their standard meaning as that of UNIX command line.]

inputs: 
1. `path`: path where the RACIPE solution files i.e. `*_solution_?.dat` files are stored. 
2. `components_num`: Number of components in the network. Example: `components_num = 10` for cell-cycle network of fission-yeast 
3. `external_signal`: Always equal to Zero for all the analysis we have performed in this article. Hence, `external_signal = 0`

Example: `GK_normalization("path_to_RACIPE_simulations/network/2",10,0)`

***

**Stability State Counting** 
filenames: `MakeStabilityStateCounter.m, stabilityStateCounter.m` <-- For default RACIPE files, which performs calculations till "deca-stable" solutions. 
   `universal_stability_state_counter.m, stateCounter.m` <-- for more complex RACIPE simulations file, where we specify to calculate beyond "deca-stable solutions"

This set of codes basically reads the RACIPE solutions files (of the triplicates for a particular network) and calculates what percentage of the total number of solutions belong to mono-stable, bi-stable, tri-stable and "higher-stable" solutions. This stores this data, in the form of a .fig and .xls file, which can be later used to plot the data. 
   The data contains, the mean of the frequency of the each solution states, found in each of the triplicates and the standard deviation is calculated for the error-bar. 

---

_Main Functions:_

_For default RACIPE solutions:_ i.e. `-num_stability 10` --> `MakeStabilityStateCounter.m `

inputs: 
1. `path`: path of the directory of the network, where all the triplicates of the RACIPE simulations results are kept. 
2. `Name`: `<Name>_stability_state_counter`will be the name of the .fig and .xls file, which will be generated as the output of this code. 

Example: `MakeStabilityStateCounter('path_to_RACIPE_simulations/5cS','5cS')`

---
_For "larger" RACIPE solutions:_ e.g. `-num_stability 20` -->   `universal_stability_state_counter.m`

*Here*, "larger" RACIPE solutions are defined as those simulations with `num_stability` > 10 (default). 

inputs:
1. `p1`: path of the first replicate of the RACIPE simulation of the concerned network 
2. `p2`: path of the second replicate of the RACIPE simulation of the concerned network 
3. `p3`: path of the third replicate of the RACIPE simulation of the concerned network 
4. `name`: `<name>_stability_state_counts_full` is the name of the .fig file it generates as output. [Note, this code does not generate a separate .xls file, although the .fig file can be used to extract the mean and standard deviation data using standard MATLAB functions]

Example: `universal_stability_state_counter('path_to_larger_RACIPE_simulations/7cS/1','path_to_larger_RACIPE_simulations/7cS/2','path_to_larger_RACIPE_simulations/7cS/3','7cS')`

***

**Frequency Calculations**
filenames: 
   Main Function: `state_freq_calculator.m`
   Helper Function: `err_bar_maker.m`

Main Function: This function reads the solution files, mentioned in the inputs and output the average frequency and the standard deviation across all the triplicates of the different solution states in that solution file. The output result is stored in a .xls file, which can be later analysed using Microsoft Excel. 

inputs:

1. `p1`: path of the solution file of our choice of stability state in the first replicate of the RACIPE simulation of the concerned network 
2. `p2`: path of the solution file of our choice of stability state in the the second replicate of the RACIPE simulation of the concerned network 
3. `p3`: path of the solution file of our choice of stability state in the the third replicate of the RACIPE simulation of the concerned network 
4. `sol_num`: number of stabiliy-state. e.g. `2` for bistable states, `10` for decastable states
5. `components_num`: Number of components in the network
6. `ext_signals_num`: always = `0` for all the relevant simulations done in this study 
7. `condition`: the output will only show sates with frequency, larger than the magnitude mentioned in this variable. In our case, we used `condition = 0` universally, and then later used Microsoft Excel to pick the most dominant states later from the output .xls file. 
8. `name`: Name of the output .xls file. 

example: `make_an_errorbar_conditions_apply('/path_to_RACIPE_simulations/7c/1/7c_solution_gk_10.dat','/path_to_RACIPE_simulations/7c/2/7c_solution_gk_10.dat', '/path_to_RACIPE_simulations/7c/3/7c_solution_gk_10.dat', 10, 7, 0, 0,'7c_deca_stable')`

**Plotting the Dynamics of the network** 

filename: `dynamics_simulation.m`

These functions are primarily there to build the coupled shifted Hill function required to solve the networks in MATLAB and those results can be plotted to find out the presence of any oscillations and general dynamical time-varying properties of the network.

---

filename: `personalODEplotter.m`

This code extracts the the sampled RACIPE parameter sets for one of the *N-stable* solutions of RACIPE simulations and plots some of the solutions using Shifted Hill equations with time as x-axis present in the given solution file. This is helpful to visualize if there is any oscillation in any solutions, which could not be done from RACIPE simulation results directly. 

variables to change: 
1. `path`: path to any of the triplicates of the RACIPE simulation of the network under consideration. e.g. `path_to_the_RACIPE_simulations/TEN_SA/2`
2. `components_num`: Number of components in the network. 
3. `sol_num`: 2 for bistable solutions, 3 for tristable solutions, ... 
---
