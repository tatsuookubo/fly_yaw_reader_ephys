function [ t, vel_fwd, vel_side, vel_yaw ] = get_velocity_ephysrig( trial_time, trial_data )

settings = sensor_settings;

sensor1_x = trial_data(:,7);
sensor1_y = trial_data(:,8);
sensor2_x = trial_data(:,9);
sensor2_y = trial_data(:,10);

[ t, vel1_x ] = get_velocity_from_raw_input( sensor1_x, trial_time, settings.zero_mean_voltage_per_channel(1), settings.zero_mean_two_std_per_channel(1) );
[ t, vel1_y ] = get_velocity_from_raw_input( sensor1_y, trial_time, settings.zero_mean_voltage_per_channel(2), settings.zero_mean_two_std_per_channel(2) ); 
[ t, vel2_x ] = get_velocity_from_raw_input( sensor2_x, trial_time, settings.zero_mean_voltage_per_channel(3), settings.zero_mean_two_std_per_channel(3) );
[ t, vel2_y ] = get_velocity_from_raw_input( sensor2_y, trial_time, settings.zero_mean_voltage_per_channel(4), settings.zero_mean_two_std_per_channel(4) );

% Below is from Seelig et al. Nature Methods 2010, methods section
vel_fwd = -1*((vel1_y + vel2_y)*cos(deg2rad(45)));
vel_side    = ((vel1_y - vel2_y)*sin(deg2rad(45)));
vel_yaw     = ((vel1_x + vel2_x) ./ 2.0);

% This converts to mm/s for fwd and side. deg/s for yaw;
[v_fwd,v_side,v_yaw] = convert_velocity_TO(vel_fwd, vel_side, vel_yaw);

vel_fwd = v_fwd;
vel_side = v_side;
vel_yaw = v_yaw;
end

