clc; clear
close all

%% Paramteters
mass = 0.468; % kg
length = 0.225; % Arm Length (m)
I = diag([4.856e-3, 4.856e-3, 8.801e-3]); % Inertia matrix
k_t = 2.980e-6; % Thrust coefficient
k_d = 1.140e-7; % drag coefficient
g = 9.81; % gravity
params = containers.Map({'mass','length', 'Inertia', 'k_t', 'k_d', 'g'},{mass, length, I, k_t, k_d, g});
d2r = pi/180; %degree to radians conversion
r2d = 180/pi; %radians to degree conversion