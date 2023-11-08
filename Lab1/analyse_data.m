close all

% Plot the full date
figure(1); plot(sinal.Date, sinal.Val, '.-', ruido.Date, ruido.Val, '.-'); grid on;

fs = 1/20; % New sample every 20 seconds

% Plot moments where the channel might be compremised
for i = 1:length(sinal.Date)
    if sinal.Val(i) - ruido.Val(i) < 6 % The threshold is an SNR of 6 dB
        figure; plot(sinal.Date(i-200:i+200), sinal.Val(i-200:i+200), '.-', ruido.Date(i-200:i+200), ruido.Val(i-200:i+200), '.-'); grid on;
        if i +400 > length(sinal.Date)
            break
        else
            i = i + 400;
        end
    end
end