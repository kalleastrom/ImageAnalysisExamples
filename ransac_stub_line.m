%% Ransac illustration. Fit circles of known radius to points


%% Settings

% Problem specific settings
data_file = 'ransac_line_points';
minimal_solver = @solver_line_2pt;       % Minimal solver function
inlier_calculation = @inliers_line_2pt;  % Inlier calculation function
illustrate_solution = @illustrate_line_2pt;    % Inlier calculation function
minimal_solver_n = 2;         % Minimal solver neads 2 data points

% plot settings
plot_and_pause_after_each_try = 0;

%% Load data

load([ 'data' filesep data_file]);

%% Plot data

illustrate_solution(data);

%% RANSAC STUB

% Ransac settings
ransac_n = 100;               % Number of iterations in RANSAC loop
ransac_t = 0.15;              % Inlier threshold

% Initialize variables
max_nr_inliers=0;      % Current maximum number of inliers is 0
best_sol = NaN;        % Current best solution (no solution yet)

% Start iterating ransac_n times
for k = 1:ransac_n,
    
    % Choose a minimal random subset
    isel = randperm(size(data,2),minimal_solver_n);
    
    % Use minimal solver to obtain potential solutions
    [n_real_sol,realsols,allsols] = minimal_solver(data(:,isel));
    
    % Check all solutions (if any)
    if n_real_sol>0,
        for k = 1:n_real_sol,
            a_solution = realsols(:,k);
            
            nrinl = inlier_calculation(data,a_solution,ransac_t);
            if plot_and_pause_after_each_try,
                illustrate_solution(data,a_solution,ransac_t);
                title(['Number of inliers: ' num2str(nrinl)]);
                pause;
            end
            if nrinl>max_nr_inliers,
                max_nr_inliers = nrinl;
                best_sol = a_solution;
                bestisel = isel;
            end
        end
    end
end

%% Illustrate the best solution found

illustrate_solution(data,best_sol,ransac_t);
title(['Maximum number of inliers: ' num2str(max_nr_inliers)]);




