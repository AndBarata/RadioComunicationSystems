close all
clear all
clc

fprintf("\nStart of the program\n");


load('MatLab_20231102.mat');  % Load the .mat file
% Plot the full date
figure(1); plot(sinal.Date, sinal.Val, '.-', ruido.Date, ruido.Val, '.-'); grid on;

fs = 1/20; % New sample every 20 seconds
count = 0;
% Plot moments where the channel might be compremised
window_size = 800; % Corresponds to window_size/fs seconds -> 800/20 = 40 seconds
ignore_counter = 0;
for i = 1:length(sinal.Date)
    if ignore_counter < window_size 
        ignore_counter = 1 + ignore_counter; 
    else
        ignore_counter = 0;
        if sinal.Val(i) - ruido.Val(i) < 6 % The threshold is an SNR of 6 dB
            count = count +1;
            figure; plot(sinal.Date(i-window_size/2:i+window_size/2), sinal.Val(i-window_size/2:i+window_size/2), '.-', ruido.Date(i-window_size/2:i+window_size/2), ruido.Val(i-window_size/2:i+window_size/2), '.-'); grid on;     
        end
    end

    if i + ignore_counter > length(sinal.Date); break; end
end



fprintf("Number of lostes of signal: %d\n", count);