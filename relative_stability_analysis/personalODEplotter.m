% ODE Solver RACIPE solution files 

path = '../data/fission_yeast_cc_normal/2';
components_num = 10;
external_signal = 0;
sol_num = 10;

%% Finding the solution files from the given paths
[topo_file_info, parameter_names] = parameter_generator(path);

path = strrep(path,'\','/');
x = strcat(path,"/*solution_gk_*.dat");
y = strcat(path,"/*parameters.dat");

solution_path_dir = dir(x);
parameter_value_file_dir = dir(y);

paramater_value_path = strcat(parameter_value_file_dir(1).folder,"/",parameter_value_file_dir(1).name);
paramater_value_path = strrep(paramater_value_path,'\','/');
parameter_values = readtable(paramater_value_path);


solution_paths = strings(length(solution_path_dir),1);

for i = 1:length(solution_path_dir)
    
    s = strcat(solution_path_dir(i).folder,"/",solution_path_dir(i).name);
    solution_paths(i,1) = strrep(s,'\','/');
    
end
%% Extracting the parameter set files I want from the parameter_values table 
for i = 1:size(parameter_names,1)
    parameters(1,i) = convertCharsToStrings(parameter_names(i,1:size(parameter_names,2)));
end

parameter_values_newfilenames = cellstr(parameters);

parameter_values.Properties.VariableNames = ["S_no" "States_number" parameter_values_newfilenames];

clear i

j = 1;
for i=1:size(parameter_values,1)
    if parameter_values.States_number(i) == 20
        parameter_sets_for_simulating(j,:) = parameter_values(i,:);
        j=j+1;
    end
end

%% Now its time to solve ans ODE and plot the solutions 
run_time = 0:1:200; % run time for ode solver
num_initials = 10; %100;

for ii = 500:520    %size(parameter_sets_for_simulating,1)
    ga = parameter_sets_for_simulating.Prod_of_Start(ii);
    gb = parameter_sets_for_simulating.Prod_of_SK(ii);
    gc = parameter_sets_for_simulating.Prod_of_Ste9(ii);
    gd = parameter_sets_for_simulating.Prod_of_Rum1(ii);
    ge = parameter_sets_for_simulating.Prod_of_Cdc2/Cdc13(ii);
    gf = parameter_sets_for_simulating.Prod_of_Cdc2/Cdc13*(ii);
    gg = parameter_sets_for_simulating.Prod_of_Wee1/Mik1(ii);
    gh = parameter_sets_for_simulating.Prod_of_Cdc25(ii);
    gi = parameter_sets_for_simulating.Prod_of_PP(ii);
    gj = parameter_sets_for_simulating.Prod_of_Slp1(ii);
    
    ka = parameter_sets_for_simulating.Deg_of_Start(ii);
    kb = parameter_sets_for_simulating.Deg_of_SK(ii);
    kc = parameter_sets_for_simulating.Deg_of_Ste9(ii);
    kd = parameter_sets_for_simulating.Deg_of_Rum1(ii);
    ke = parameter_sets_for_simulating.Deg_of_Cdc2/Cdc13(ii);
    kf = parameter_sets_for_simulating.Deg_of_Cdc2/Cdc13*(ii);
    kg = parameter_sets_for_simulating.Deg_of_Wee1/Mik1(ii);
    kh = parameter_sets_for_simulating.Deg_of_Cdc25(ii);
    ki = parameter_sets_for_simulating.Deg_of_PP(ii);
    kj = parameter_sets_for_simulating.Deg_of_Slp1(ii);
    
   figure
   for jj = 1:num_initials
       [ii,jj]
       Startjj = (ga/ka)*rand;
       SKjj = (gb/kb)*rand;
       Ste9jj = (gc/kc)*rand;
       Rum1jj = (gd/kd)*rand;
       Cdc2byCdc13jj = (ge/ke)*rand;
       Cdc2byCdc13Starjj = (gf/kf)*rand;
       Wee1byMik1jj = (gg/kg)*rand;
       Cdc25jj = (gh/kh)*rand;
       PPjj = (gi/ki)*rand;
       Slp1jj = (gj/kj)*rand;

       I = [Startjj SKjj Ste9jj Rum1jj Cdc2byCdc13jj Cdc2byCdc13Starjj Wee1byMik1jj Cdc25jj PPjj Slp1jj];

       [t,y] = ode45(@(t,y)dynamic_simulation_TEN_SA(t,y,parameter_sets_for_simulating(ii,:)),run_time,I);
       plot(t,y); hold on;
   end
   hold off
end


