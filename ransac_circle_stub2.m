
% Problem specific settings
data_file = 'ransac_circle_points';
minimal_solver = @solver_circle_2pt;       % Minimal solver function
inlier_calculation = @inliers_circle_2pt;  % Inlier calculation function
illustrate_solution = @illustrate_circle_2pt;    % Inlier calculation function
minimal_solver_n = 2;         % Minimal solver neads 2 data points

% plot settings
plot_and_pause_after_each_try = 0;

%% Load data

load([ 'data' filesep data_file]);

%% Plot data without a solution

illustrate_solution(data);
title('Data points. Where is the circle. Press a key to continue');
pause;
%% RANSAC STUB

% Ransac settings
ransac_n = 100;               % Number of iterations in RANSAC loop
ransac_t = 0.01;              % Inlier threshold

%% Generate a random solution

a_solution = randn(2,1); 
nr_of_inliers = inlier_calculation(data,a_solution,ransac_t);

%% Plot data with a solution

illustrate_solution(data,a_solution,ransac_t);
title(['Data points and random circle. ' num2str(nr_of_inliers) ' inliers. Press a key to continue']);
pause;

%% Write your ransac code here and illustrate the solution

disp('Now, start writing the RANSAC algorithm');
title('Now, start writing the RANSAC algorithm');

