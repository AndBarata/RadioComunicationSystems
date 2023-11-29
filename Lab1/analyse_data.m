close all
clear all
clc

darK_yellow = 1/255*[246,190,0];
darK_yellow = 1/255*[255,165,0];

fprintf("\nStart of the program\n");


load('data/MatLab_20231102.mat');  % Load the .mat file
load('data/MatLab_20231122.mat'); 
%sinal = [sinal; sinal2];
%ruido = [ruido; ruido2];

%sinal = sinal2;
%ruido = ruido2;

% Plot the full date 
figure(1); plot(sinal.Date, sinal.Val, '.-', ruido.Date, ruido.Val, '.-'); title('Satalite Signal'); grid on; legend("signal", "noise");

t_lost_signal = []; % Mark the timestamp where signal was loss

fs = 1/20; % New sample every 20 seconds
count = 0;
% Plot moments where the channel might be compremised
window_size = 4;
ignore_counter = 0;
for i = 1:length(sinal.Date)
    if ignore_counter < window_size 
        ignore_counter = 1 + ignore_counter;
    else
        ignore_counter = 0;
        if sinal.Val(i) - ruido.Val(i) <= 6 % The threshold is an SNR of 6 dB
            count = count +1;
            %figure; plot(sinal.Date(i-window_size/2:i+window_size/2), sinal.Val(i-window_size/2:i+window_size/2), '.-', ruido.Date(i-window_size/2:i+window_size/2), ruido.Val(i-window_size/2:i+window_size/2), '.-'); title(['Loss signal no. ' + string(count)]); grid on; 
            t_lost_signal = [t_lost_signal, sinal.Date(i)];

        end
    end
    
    if i + ignore_counter > length(sinal.Date); break; end
end

fprintf(" - Number of lostes of signal: %d\n", count);


load('data/temp_and_rain_06_22_nov.mat');  % Load the .mat file
load('data/temp_and_rain_data.mat');  % Load the .mat file

snr = sinal.Val - ruido.Val;
%temp_and_rain = [temp_and_rain; rain_temp_06_22_nov];
%temp_and_rain = rain_temp_06_22_nov;
snr_rain_figure = figure;
sp(1) = subplot(1,1,1); plot(sinal.Date, sinal.Val, '.-', ruido.Date, ruido.Val, '.-'); title('Signal vs Noise: blue -> signal | red -> noise'); xlabel("date"); ylabel("Magnitude (dB"); grid on;
sp(2) = subplot(1,1,1); plot(sinal.Date, sinal.Val/abs(max(abs(sinal.Val))), '.-', temp_and_rain.datetime, temp_and_rain.precip/max(abs(temp_and_rain.precip)), '.-'); title('Percipitation Data: blue -> signal | red -> precipitation'); xlabel("date"); ylabel("Magnitude Normalized"); grid on; 
sp(3) = subplot(1,1,1); plot(sinal.Date, snr/max(abs(snr)), '-', temp_and_rain.datetime, temp_and_rain.precip/max(abs(temp_and_rain.precip)), '.-'); title('Rain vs SNR: blue -> rain | red -> snr | yellow -> signal loss'); grid on;
%yline(6, '-');
step = 0.15; % 
ignore_counter = 0;
for i = 1: length(t_lost_signal)
        xregion(sp(1), t_lost_signal(i)-step, t_lost_signal(i)+step, 'FaceColor', darK_yellow);
        xregion(sp(2), t_lost_signal(i)-step, t_lost_signal(i)+step, 'FaceColor', darK_yellow);
        xregion(sp(3), t_lost_signal(i)-step, t_lost_signal(i)+step, 'FaceColor', darK_yellow);
end

legend("Sinal", "rain"); % draw now;
%% Temperature influence plots
%temp_data_time_resampled = resample(single(temp_and_rain.datetime), 60, 1);
%temp_data_temp_resampled = resample(temp_and_rain.temp, 60, 1);
temp_signal_figure = figure;
plot(sinal.Date, -sinal.Val/max(abs(sinal.Val)), '.-', ruido.Date, -ruido.Val/max(abs(ruido.Val)), '.-' , temp_and_rain.datetime, temp_and_rain.temp/max(temp_and_rain.temp), '.-'); title('Influence of temperature in signal'); grid on; legend("signal", "noise", "Temperature");


figure; plot(temp_and_rain.datetime, temp_and_rain.temp/max(temp_and_rain.temp), '.-', temp_and_rain.datetime, temp_and_rain.precip/max(temp_and_rain.precip), '.-'); title("Temperature and rain");


% Save image
t = now;
d = datetime(t,'ConvertFrom','datenum');
txt = 'Figures/snr_vs_percipitation_' + string(d) + '.png';
%saveas(snr_rain_figure, txt);

% Making all datetime values unique (for interpolation)
[~, ~, unique_index] = unique(temp_and_rain.datetime);
first_index = accumarray(unique_index, (1:numel(temp_and_rain.datetime)).', [], @min);
dupe = ~ismember(1:numel(temp_and_rain.datetime), first_index);
temp_and_rain.datetime(dupe) = temp_and_rain.datetime(dupe) + seconds(1);

% Interpolation of rain data
interv = temp_and_rain.datetime(1):minutes(1):temp_and_rain.datetime(end);
interpol_rain = interp1(temp_and_rain.datetime, temp_and_rain.precip, interv, 'makima'); % Method used: Modified Akima
interpol_rain_figure = figure;
subplot (2,1,1); plot(temp_and_rain.datetime, temp_and_rain.precip/max(temp_and_rain.precip)); title('Original Data'); grid on;
subplot (2,1,2); plot(interv, interpol_rain/max(interpol_rain)); title('Interpolated Data'); grid on;


fprintf("End of program\n")
