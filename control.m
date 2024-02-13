function u = control(t,X, X_des)
    %% Feed forward input
    u_ff = 1;
    %% Simple PID Controller
    %PD controller
    kp_rpy = [500; 500; 3000];
    kd_rpy = [300; 300; 2000];
    %current errors
    ang_error = X_des(1:3) - X(1:3);
    ang_rate_error = X_des(4:6) - X(4:6);    
    r_cnt = kp_rpy(1)*ang_error(1) + kd_rpy(1) * ang_rate_error(1);
    p_cnt = kp_rpy(2)*ang_error(2) + kd_rpy(2) * ang_rate_error(2);
    y_cnt = kp_rpy(3)*ang_error(3) + kd_rpy(3) * ang_rate_error(3);

    %% Motor Mixing Algorithm
    m(1) = p_cnt + r_cnt + y_cnt + u_ff;
    m(2) = p_cnt - r_cnt - y_cnt + u_ff;
    m(3) = -p_cnt - r_cnt + y_cnt + u_ff;
    m(4) = -p_cnt + r_cnt - y_cnt + u_ff;
    u = [m(1); m(2); m(3); m(4)];
end