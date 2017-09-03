clear
clear sound
clc
close all

fs = 44100;

%-------------------------------------------------------------------------------------------%
%                       Sound to process taken from real audio 
%-------------------------------------------------------------------------------------------%
%Read audio from a file
sound_toprocess = audioread('Lone - Dolphin.mp3');

%Change signal to mono
sound_toprocess = sound_toprocess(:,1);

%Invert vector because of convention
sound_toprocess = sound_toprocess';
%-------------------------------------------------------------------------------------------%
%Dlugosc h
M = 8192;

%Dlugosc X
N = 2048;

%Shift w utworze (poczatek)
%S = floor(fs*50.5);
S = fs*19;

%Shift w utworze (miedzy kazdym nowym blokiem)
%0 lub 750
K = 750;

%Wynik splotu
y = [];

%Filtr
h = sound_toprocess(1,S:S+M-1);

%% Algorytm
%Pokazaæ jeszcze dla 750

for i = 1:225
    %Filtr
    h = sound_toprocess(1,S+i*K:S+M-1+i*K);
    
    %Sygnal wejsciowy (szum)
    x = 0.001*randn(1, N);
    %Dopelnienie zerami
    x = [x, zeros(1, M-N)];

    %Filtracja przez fft
    X = fft(x);
    H = fft(h);
    Y = X.*H;
    odwrotna = ifft(Y);
    y = [y, odwrotna(1,N+1:end)];
end

y = y./max(y);

sound(y, fs);