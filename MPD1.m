clear
clear sound
clc
close all

%Sampling frequency [Hz]
fs = 44100; 

%Directory to a sound file - for best results it is recommended that it's
%free of drums, hiss or any kind of noise
dir = 'MANOID - SYNESTEZJA EP - 02 AWAY ft. Pola Rise.flac';

%-------------------------------------------------------------------------------------------%
%                                       Czytanie audio
%-------------------------------------------------------------------------------------------%
%Za³adowanie z pliku
sound_toprocess = audioread(dir);

%Zamiana na mono
sound_toprocess = (sound_toprocess(:,1) + sound_toprocess(:,2))/2;

%Odwrócenie wektora na poziomy ze wzglêdu na przyjêt¹ konwencjê
sound_toprocess = sound_toprocess';

sound_toprocess2 = sound_toprocess(fs*48:fs*62);
%-------------------------------------------------------------------------------------------%


%% Odtworzenie dŸwiêku
sound(sound_toprocess2, fs);


%% Zatrzymanie dŸwiêku
clear sound



%% Pokaz 1 - widmo amplitudowe

%Przesuniêcie w bloku
shift = 1;
figure('units','normalized', 'position', [0 0 1 1]);

for i = 1:35
    %Zamkniêcie poprzedniego okna
    %close all;
    
    %Pobranie 16384 próbek z odpowiednim przesuniêciem
    sound_toFFT = sound_toprocess2(shift : shift+16384);
    
    %Odtworzenie dŸwiêku
    sound(sound_toFFT, fs);
      
    %Pokazanie widma amplitudowego
    widmo_amplitudowe = 20*log10(abs(fftshift(fft(sound_toFFT.*hann(size(sound_toFFT,2))'))));
    widmo_amplitudowe = widmo_amplitudowe(floor(size(widmo_amplitudowe,2)./2):end);
    subplot(2,1,2);
    plot(log2(1:size(widmo_amplitudowe,2)),widmo_amplitudowe);
    axis([0 inf -20 70]); %Ustawienia osi
    grid on %W³¹czenie siatki
    tytul = sprintf('Widmo amplitudowe dla próbek od %d do %d', shift-1, shift+16384-1);
    title(tytul);
    xlabel('Czêstotliwoœæ'); ylabel('Amplituda [dB]');
    set(gca,'XTick',[]);
    
    subplot(2,1,1);
    plot(sound_toFFT);
    axis([0 inf -1 1]); %Ustawienia osi
    grid on;
    tytul = sprintf('Przebieg sygna³u dla próbek od %d do %d', shift-1, shift+16384-1);
    title(tytul);
    xlabel('Czas');
    
    %Przesuniêcie bloku audio
    shift = shift + 1764;
  
    %Naciœniêcie dowolnego klawisza spowoduje kontynuacjê pêtli
    pause
end

%% Pokaz 2 - widmo amplitudowe + widmo fazowe

% Wstêp do widma fazowego, potem gif

%Przesuniêcie w bloku
figure('units','normalized', 'position', [0 0 1 1]);

for i = 1:20
    %Zamkniêcie poprzedniego okna
    %close all;
    
    %Pobranie 16384 próbek z odpowiednim przesuniêciem
    sound_toFFT = sound_toprocess2(shift : shift+16384);
    
    %Odtworzenie dŸwiêku
    sound(sound_toFFT, fs);
      
    %Pokazanie widma amplitudowego
    widmo_amplitudowe = 20*log10(abs(fftshift(fft(sound_toFFT.*hann(size(sound_toFFT,2))'))));
    widmo_amplitudowe = widmo_amplitudowe(floor(size(widmo_amplitudowe,2)./2):end);
    subplot(2,1,1)  
    plot(log2(1:size(widmo_amplitudowe,2)),widmo_amplitudowe);
    axis([0 inf -20 70]); %Ustawienia osi
    grid on %W³¹czenie siatki
    tytul = sprintf('Widmo amplitudowe dla próbek od %d do %d', shift-1, shift+16384-1);
    title(tytul);
    xlabel('Czêstotliwoœæ'); ylabel('Amplituda [dB]');
    set(gca,'XTick',[]);
    
    %Pokazanie widma fazowego
    widmo_fazowe = angle(fftshift(fft(sound_toFFT.*hann(size(sound_toFFT,2))')));
    widmo_fazowe = widmo_fazowe(floor(size(widmo_fazowe,2)./2):end);
    subplot(2,1,2)   
    plot(log2(1:size(widmo_fazowe,2)),widmo_fazowe);
    axis([0 inf -pi pi]); %Ustawienia osi
    grid on %W³¹czenie siatki
    title('Widmo fazowe');
    xlabel('Czêstotliwoœæ'); ylabel('Faza [rad]');
    set(gca,'XTick',[]);
    
    %Przesuniêcie bloku audio
    shift = shift + 3000;
  
    %Naciœniêcie dowolnego klawisza spowoduje kontynuacjê pêtli
    pause
end

%%

%% Widmo CA£EGO utworu

%Widmo mo¿na pobraæ z ca³ego utworu!
    
figure('units','normalized', 'position', [0 0 1 1]);

%Pokazanie widma amplitudowego
widmo_amplitudowe = 20*log10(abs(fftshift(fft(sound_toprocess.*hann(size(sound_toprocess,2))'))));
widmo_amplitudowe = widmo_amplitudowe(floor(size(widmo_amplitudowe,2)./2):end);
subplot(2,1,1)
plot(log2(1:size(widmo_amplitudowe,2)),widmo_amplitudowe);
axis([0 inf -40 110]); %Ustawienia osi
grid on %W³¹czenie siatki
title('Widmo amplitudowe ca³ego utworu');
xlabel('Czêstotliwoœæ'); ylabel('Amplituda [dB]');
set(gca,'XTick',[]);

widmo_fazowe = angle(fftshift(fft(sound_toprocess.*hann(size(sound_toprocess,2))')));
widmo_fazowe = widmo_fazowe(floor(size(widmo_fazowe,2)./2):end);
subplot(2,1,2)   
plot(log2(1:size(widmo_fazowe,2)),widmo_fazowe);
axis([0 inf -pi pi]); %Ustawienia osi
grid on %W³¹czenie siatki
title('Widmo fazowe');
xlabel('Czêstotliwoœæ'); ylabel('Faza [rad]');
set(gca,'XTick',[]);
