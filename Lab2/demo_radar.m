close all
clear all
clc

load CH_07_MoCo_5cm.mat

image(abs(ch(:,1:10:end))/1000); figure(1);

% Bandwidth = 60 MHz
% fs = 60 MHz (each sample 2.5 meters (horizontal))
% A = 0.2 m
% fc = 2340 MHz
% direct signal = -100
% sol = c = 3e8

sol = 299792458;
fs = 60e6;
fc = 2.34e9;
lambda = sol/2340e6;

R = ((0:1199)'+100)*(sol/(2*fs));
x = (-32768:32767)*0.05;
d = sqrt(R.^2*ones(1,65536) + ones(1200,1)*x.^2);

image(d/30); figure(2)

theta = atan2(ones(1200,1)*x, R*ones(1,65536)) * (180/pi);

A = sinc(theta/30) .* (abs(theta)<=40) .* (abs(theta)>=1);

image(A*50); figure(3)

CH = single([zeros(1200,(2^16-14000)/2) conj(ch) zeros(1200,(2^16-14002)/2)]);

image(abs(CH(:,:))/500); figure (4)


S = A .* exp(-4j*pi/lambda*d);

image(abs(S)*50); figure()
image(angle(S)*50); figure()

S = single(S);
image(abs(ifft(conj(fft(fftshift(S,2), [], 2)).*fft(CH, [],2), [],2)) / 50000); figure()

image(resample(double(abs(ifft(conj(fft(fftshift(S,2), [], 2)).*fft(CH, [],2), [],2))'), 1, 25)' / 50000); figure()

image(x, R, resample(double(abs(ifft(conj(fft(fftshift(S,2), [], 2)).*fft(CH, [],2), [],2))'), 1, 25)' / 50000); figure()

% Direct image
image(abs(CH) / 500); figure(1); title("The line are not perfectly horizontal");

% fft of horizontal 
image(abs(fftshift(fft( CH, [],2), 2)) / 30000); figure(2); % center os low frequencies that correspond to the plane on top of the object
image(abs(CH)/500); figure()
image(abs(fftshift(fft(CH,[],2),2))/10000); figure()


% distorce the line line in order to make them straight lines, R varies
% with an hiporbole, we want to make it staight by using an interpolation
% based on the fourier transform

w = 2*pi*(-32768:32767)/65536/0.05;

CHF = fftshift(fft([zeros(100,65536); CH; zeros(400, 65536)], [], 2),2); 
image(abs(CHF)/20000); figure()

NN = round(1300./sqrt(1-(sol/2340e6*w/(4*pi)).^2));
plot(NN, '.-'); grid; figure()

for k= 1:65536; dummy = fft(CHF(1: NN(k),k)); dummy = dummy([1:650 end-649:end]); CHF(1:1300,k) = ifft(dummy); end
image(abs(CHF)/20000); figure()

figure(19);
image(x, R, resample(double(abs(ifft(conj(fft(fftshift(S,2), [], 2)).*fftshift(CHF(101:1300,:),2), [],2))'), 1, 25)' / 50000); figure() %estamos a fazer a correlação com a linha horizontal (,2) mas na verdade esta linha é uma parábola
