
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

%% Plot data without a solution

illustrate_solution(data);
title('Data points. Where is the line. Press a key to continue');
pause;
%% RANSAC STUB

% Ransac settings
ransac_n = 100;               % Number of iterations in RANSAC loop
ransac_t = 0.15;              % Inlier threshold

%% Generate a random solution

a_solution = randn(3,1); 
nr_of_inliers = inlier_calculation(data,a_solution,ransac_t);

%% Plot data with a solution

illustrate_solution(data,a_solution,ransac_t);
title(['Data points and random line. ' num2str(nr_of_inliers) ' inliers. Press a key to continue']);
pause;

%% Write your ransac code here and illustrate the solution

disp('Now, start writing the RANSAC algorithm');
title('Now, start writing the RANSAC algorithm');

