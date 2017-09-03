clear
clear sound
clc
close all

%Czêstotliwoœæ próbkowania
fs = 44100;

%-------------------------------------------------------------------------------------------%
%                       Sound to process taken from real audio 
%-------------------------------------------------------------------------------------------%
%Read audio from a file
sound_toprocess = audioread('Lone - Dolphin.mp3', [fs*19, fs*19+2^15-1]);
sound_toprocess2 = audioread('Lone - Dolphin.mp3', [fs*17, fs*25]);

%Change signal to mono
sound_toprocess = (sound_toprocess(:,1) + sound_toprocess(:,2))/2;

%Invert vector because of convention
sound_toprocess = sound_toprocess';
%-------------------------------------------------------------------------------------------%

%Generacja szumu
noise = 0.01*randn(1, 1500000);

%% Czêœæ 1: Sinus jako odpowiedŸ impulsowa
h = sin((1:10000)/3);         % OdpowiedŸ impulsowa

result = filter(h, 1, noise); % Filtracja
result = result./max(result); % Normalizacja

sound(result, fs);

%% Stop
clear sound; clc

%% Czêœæ 2: Prawdziwe audio jako odpowiedŸ impulsowa
sound(sound_toprocess2,fs)

%% Króciutki fragmencik który bêdzie odpowiedzi¹
clear sound;
sound(sound_toprocess,fs);

%% Widmo

%Pokazanie widma amplitudowego
widmo_amplitudowe1 = 20*log10(abs(fftshift(fft(sound_toprocess.*hann(size(sound_toprocess,2))'))));
widmo_amplitudowe1 = widmo_amplitudowe1(floor(size(widmo_amplitudowe1,2)./2):end);
noise2 = noise(1:size(sound_toprocess,2));
widmo_amplitudowe2 = 20*log10(abs(fftshift(fft(noise2.*hann(size(noise2,2))'))));
widmo_amplitudowe2 = widmo_amplitudowe2(floor(size(widmo_amplitudowe2,2)./2):end);
plot(log2(1:size(widmo_amplitudowe1,2)),widmo_amplitudowe1, log2(1:size(widmo_amplitudowe2,2)),widmo_amplitudowe2);
axis([0 inf -60 70]); %Ustawienia osi
grid on %W³¹czenie siatki
title('Widmo amplitudowe sygna³u muzycznego i szumu');
xlabel('Czêstotliwoœæ'); ylabel('Amplituda [dB]');
set(gca,'XTick',[]);
legend('Muzyka', 'Szum');

%% Wynik
close all
clc

%Ograniczenia

result = filter(sound_toprocess, 1, noise);
result = result./max(result);
sound(result,fs);

%Wykres
result2 = result(1:size(sound_toprocess,2));
widmo_amplitudowe3 = 20*log10(abs(fftshift(fft(result2.*hann(size(result2,2))'))));
widmo_amplitudowe3 = widmo_amplitudowe3(floor(size(widmo_amplitudowe3,2)./2):end);
plot(log2(1:size(widmo_amplitudowe1,2)),widmo_amplitudowe1, log2(1:size(widmo_amplitudowe2,2)),widmo_amplitudowe2, log2(1:size(widmo_amplitudowe3,2)),widmo_amplitudowe3);
axis([0 inf -60 70]); %Ustawienia osi
grid on %W³¹czenie siatki
title('Widmo amplitudowe sygna³u muzycznego i szumu');
xlabel('Czêstotliwoœæ'); ylabel('Amplituda [dB]');
set(gca,'XTick',[]);
legend('Muzyka', 'Szum', 'Wynik');

%% Stop
clear sound; clc