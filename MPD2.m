clear
clear sound
clc
close all

%Sampling frequency [Hz]
fs = 44100; 

%Directory to a sound file - for best results it is recommended that it's
%free of drums, hiss or any kind of noise
dir = 'Lone_-_Lying_In_The_Reeds.wav';

%-------------------------------------------------------------------------------------------%
%                                       Czytanie audio
%-------------------------------------------------------------------------------------------%
%Za³adowanie z pliku
sound_toprocess = audioread(dir);

%Zamiana na mono
sound_toprocess = (sound_toprocess(:,1) + sound_toprocess(:,2))/2;

%Odwrócenie wektora na poziomy ze wzglêdu na przyjêt¹ konwencjê
sound_toprocess = sound_toprocess';

sound_toprocess1 = sound_toprocess(1*fs:11*fs);

sound_toprocess2 = audioread('Lone - Dolphin.mp3');
sound_toprocess2 = (sound_toprocess2(:,1) + sound_toprocess2(:,2))/2;
sound_toprocess2 = sound_toprocess2';
sound_toprocess2 = sound_toprocess2(65*fs:75*fs);
%-------------------------------------------------------------------------------------------%

%% Pokaz widma fazowego orygina³u
pokaz_sf(sound_toprocess1, angle(fft(sound_toprocess1)));
sound(sound_toprocess1, fs);

%% Wyznaczenie widma fazowego
close all
clc

WIDMO = fft(sound_toprocess1);
WIDMO_FAZOWE = angle(WIDMO);
WIDMO_AMPLITUDOWE = abs(WIDMO);

%% Przypadek 1: Przeskalowanie widma fazowego
% Pokazaæ dla wartoœci: 0.75, 1.5, 1.75, 2

WIDMO_FAZOWE1 = 100*WIDMO_FAZOWE;

WIDMO_WYNIK = abs(WIDMO_AMPLITUDOWE) .* exp(1j*WIDMO_FAZOWE1);    %Przywrócenie widma
sygnal_wynik = real(ifft(WIDMO_WYNIK));                           %Rekonstrukcja sygna³u z widma
sygnal_wynik = sygnal_wynik(1+14:end-14);                         %Uciecie koñcówek sygna³u które wariuj¹
pokaz_sf(sygnal_wynik, WIDMO_FAZOWE1);                                     %
sound(sygnal_wynik, fs);                                    %Odtworzenie wyniku

%% Przypadek 2: wyzerowanie widma fazowego
close all
clc

WIDMO_FAZOWE1 = 0*WIDMO_FAZOWE;

WIDMO_WYNIK = abs(WIDMO_AMPLITUDOWE) .* exp(1j*WIDMO_FAZOWE1);    %Przywrócenie widma
sygnal_wynik = real(ifft(WIDMO_WYNIK));                           %Rekonstrukcja sygna³u z widma
sygnal_wynik = sygnal_wynik(2000:end-2000);                        
pokaz_sf(sygnal_wynik, WIDMO_FAZOWE1);                                     %
sound(sygnal_wynik, fs);                                    %Odtworzenie wyniku


%% Przypadek 3 - ulosowienie widma fazowego
close all
clc

WIDMO_FAZOWE1 = generacja_randomowego_widma_fazowego(WIDMO_FAZOWE, pi);

WIDMO_WYNIK = abs(WIDMO_AMPLITUDOWE) .* exp(1j*WIDMO_FAZOWE1);    %Przywrócenie widma
sygnal_wynik = real(ifft(WIDMO_WYNIK));                           %Rekonstrukcja sygna³u z widma
pokaz_sf(sygnal_wynik, WIDMO_FAZOWE1);                            %
sound(sygnal_wynik, fs);                                          %Odtworzenie wyniku

%% Przypadek 4 - odwrócenie widma fazowego
close all
clc

WIDMO_FAZOWE1 = -1*WIDMO_FAZOWE;

WIDMO_WYNIK = abs(WIDMO_AMPLITUDOWE) .* exp(1j*WIDMO_FAZOWE1);    %Przywrócenie widma
sygnal_wynik = real(ifft(WIDMO_WYNIK));                           %Rekonstrukcja sygna³u z widma
sygnal_wynik = sygnal_wynik(2000:end-2000);                          %Uciecie koñcówek sygna³u które wariuj¹
pokaz_sf(sygnal_wynik, WIDMO_FAZOWE1);                            %
sound(sygnal_wynik, fs);                                          %Odtworzenie wyniku

%% Przypadek 5 - odwrócenie widma fazowego ALE NIE WSZÊDZIE
close all
clc

WIDMO_FAZOWE1 = czesciowa_generacja_randomowego_widma_fazowego(WIDMO_FAZOWE, pi);

WIDMO_WYNIK = abs(WIDMO_AMPLITUDOWE) .* exp(1j*WIDMO_FAZOWE1);    %Przywrócenie widma
sygnal_wynik = real(ifft(WIDMO_WYNIK));                           %Rekonstrukcja sygna³u z widma
pokaz_sf(sygnal_wynik, WIDMO_FAZOWE1);                            %
sound(sygnal_wynik, fs);                                          %Odtworzenie wyniku

%% Przypadek 6 - przeskalowanie widma ale niejednorodnie, np sinusem
close all
clc

%Dobre parametry:
%A) Wersja 1, skala 100000, faza pi*0.75;
%B) Wersja 1, skala 10000, faza pi/2.5
%C) Wersja 1, skala 1000, faza pi/1.5
%D) Wersja 1, skala 10, faza 0
WIDMO_FAZOWE1 = modulacja_widma_fazowego(WIDMO_FAZOWE, 10, 0);

WIDMO_WYNIK = abs(WIDMO_AMPLITUDOWE) .* exp(1j*WIDMO_FAZOWE1);    %Przywrócenie widma
sygnal_wynik = real(ifft(WIDMO_WYNIK));                           %Rekonstrukcja sygna³u z widma
sygnal_wynik = sygnal_wynik(2000:end-2000);                       %Uciecie koñcówek sygna³u które wariuj¹
pokaz_sf(sygnal_wynik, WIDMO_FAZOWE1);                            %
sound(sygnal_wynik, fs);                                          %Odtworzenie wyniku


%% Przypadek 7 - podmiana widma fazowego z innego fragmentu muzycznego

pokaz_sf(sound_toprocess2, angle(fft(sound_toprocess2)));
sound(sound_toprocess2, fs);

%% Podmiana
WIDMO_FAZOWE1 = angle(fft(sound_toprocess2));

WIDMO_WYNIK = abs(WIDMO_AMPLITUDOWE) .* exp(1j*WIDMO_FAZOWE1);    %Przywrócenie widma
sygnal_wynik = real(ifft(WIDMO_WYNIK));                           %Rekonstrukcja sygna³u z widma
sygnal_wynik = sygnal_wynik(2000:end-2000);                       %Uciecie koñcówek sygna³u które wariuj¹
pokaz_sf(sygnal_wynik, WIDMO_FAZOWE1);                            %
sound(sygnal_wynik, fs);                                          %Odtworzenie wyniku