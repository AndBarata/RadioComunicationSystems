

B = 5000; % Largura de Banda
c = 340; % Velocidade do som 
T = 0.005; % Duração do pulso
fs = 48000; % frequencia de amostragem

t = [0:1/fs:T-1/fs]';


phi = 2*pi*(-B/2*t + B/(2*T)*t.^2); % definir os limites em frequencia do chirp
ch = exp(1j*phi); % sinal chirp
figure(3); plot(t, [real(ch) imag(ch)], '.-'); % Plot Chirp

[H, w] = freqz(ch, 1, 512, "whole", fs);
figure(4); %plot(((0:1023)'-512)/1024*fs/1000, abs(fftshift(fft([ch]))) % Incompleto deveria ser o chirp em frequencia

subplot(1,2,1); plot([-t(end:-1:2); t], xcorr(ch), '.-') % plot correlação

ch = exp(1j*phi) .* kaiser(length(ch), 2.5);
subplot(1,2,2); plot([-t(end:-1:2); t], xcorr(ch), '.-') % plot correlação apos chanela

% Para ter a resolução é dividir por 2c
figure(5); plot([-t(end:-1:2); t]/2*c, xcorr(ch)/140.751, '.-') % plot correlação em resolução de tempo

% Passar para banda base
fc = 6000;
ch_c = ch.*exp(2j*pi*fc*(0:length(ch)-1)'/fs);



%sound(ch_c, fs); % repoduz o chirp


chir_many = repmat([ch_c; zeros(fs/10-length(ch_c),1)], 100, 1); % repeats the chirp many times with zeros in between, 100 time to be exact

%sound(chir_many, fs);

% Gravar os ecos
r = audiorecorder(fs, 16, 1);
record(r); pause(0.5); sound(chir_many*[1 0], fs); pause(10.5); stop(r); %chirp_many * [1 0] é para apenas reproduzir numa das colunas do PC

y = getaudiodata(r);
figure(6); plot(y, '.-')


y_b = ch.*exp(-2j*pi*fc*(0:length(y)-1)'/fs); % Passar para banda base
y_b = filter(fir1(256, 3000/(fs/2)), 1, y_b); % Aplicar um passa baixo (opcional)

y_c = filter(conj(ch(end:-1:1)), 1, y_b); % APlicar a autocorrelação
figure(7);
subplot(2,1,1); plot(abs(y_c), '.-');
%subplot(2,1,2); plot(abs[y_c y_b/164], '.-'); % plot emissão e receção 

% Anotar o primeiro eco 
%  -> 18406

Y_c = reshape(y_c((0:fs/10*100-1) + 18406 -100), fs/10, 100); % Colocar os 100 chirps em matrizes -> cortar o sinal em 100 partes, porque são 100 chirps

figure(8); plot(abs(Y_c), '.-'); % plot de todos os picos

% Verificou-se se a fase era constante de modo a ver se a receção e a emissão estão sincronizados
mean_y = mean(Y_c,2); % coerente, para ser não coerente deveria ser mean(abs(Y_c),2)


figure(9); image(abs(Y_c)'*2); % samples pelo número de eco
figure(10); image((1:4800)-101/fs*c*2,(1:100), abs(Y_c)'*2); % samples pelo número de eco







