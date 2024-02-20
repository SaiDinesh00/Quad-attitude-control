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
%% Define Simulation time
Ns = 2000;
t_end = 20;
t_span = linspace(0,t_end,Ns);
dt = t_end / Ns;
%% Desired State
X_des = [0; 0; 0; 0; 0; 0]*d2r;
%% Initialize U_matrix
U = zeros(4,Ns);

%% Define Initial State
X0 = [10; 20; 10; 0; 0; 0]*d2r; % [phi, theta, psi, p, q, r]
X(:,1) = X0;

for i = 1:Ns-1
    U(:,i) = control(t_span(i), X(:, i), X_des);
    X(:, i+1) = X(:, i) + dt * quad_dynamics(t_span(i),X(:,i),U(:,i),params);
end
% [t, X] = ode45(@(t, X) quad_dynamics(t, X, control(t,X_des, X), params), t_span, X0);


%% desired state vectors
roll_des = ones(Ns,1)*X_des(1);
pitch_des = ones(Ns,1)*X_des(2);
yaw_des = ones(Ns,1)*X_des(3);

%% Plots Generation
figure
subplot(3,1,1)
plot(t_span, roll_des*r2d, LineStyle="--", Color='black', LineWidth=2)
hold on
plot(t_span, X(1,:)*r2d, LineWidth=2)
title('Roll')
xlabel('time (s)')
ylabel('phi (deg)')

subplot(3,1,2)
plot(t_span, pitch_des*r2d, LineStyle="--", Color='black', LineWidth=2)
hold on
plot(t_span, X(2,:)*r2d, LineWidth=2)
title('Pitch')
xlabel('time (s)')
ylabel('theta (deg)')

subplot(3,1,3)
plot(t_span, yaw_des*r2d, LineStyle="--", Color='black', LineWidth=2)
hold on
plot(t_span, X(3,:)*r2d, LineWidth=2)
title('Yaw')
xlabel('time (s)')
ylabel('psi (deg)')