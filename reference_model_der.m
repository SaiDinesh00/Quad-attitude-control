clc; clear
close all

A = [0 0 0 1 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1;
    0 0 0 0 1 1; 0 0 0 1 0 1; 0 0 0 1 1 0];
B = [0 0 0; 0 0 0; 0 0 0;
    1 0 0; 0 1 0; 0 0 1];

C = [eye(3) zeros(3)];
D = zeros(3,3);
des_poles = [-2 -3 -4 -5 -6 -7];
K = place(A, B, des_poles);

A_cl = A - B*K;

sys = ss(A_cl, B, C, D, 0.001);

pole(sys)