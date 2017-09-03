clear
clear sound
clc
close all

%Odpowiedz impulsowa filtru
h = [ 
1873
-4803
2958
2243
-2276
-3502
2157
6475
-2237
-20712
35009
-20712
-2237
6475
2157
-3502
-2276
2243
2958
-4803
1873
]';

%Normalizacja
h = h./max(h);

figure('units','normalized', 'position', [0 0 1 1]);
stem(h); grid; title('OdpowiedŸ impulsowa mojego filtru'); xlabel('Próbka'); ylabel('Wartoœæ'); axis([0 22 -1 1]);

%% Przypadek 1: delta Kroneckera przez odpowiedz impulsowa
close all;
clc;

x = 1;  %Delta Kroneckera
pokaz_odpowiedzi(x,h);

close all;
clc;
%% Przypadek 2: dwie delty Kroneckera oddalone od siebie
x = [1 0 0 0 0 0 0 1];
pokaz_odpowiedzi(x,h);

close all;
clc;

%Omówiæ ten przypadek poraz drugi
%% Przypadek 3: sinus wolny
x = sin((1:50)/2);
pokaz_odpowiedzi(x,h);

clc
close all

%% Przypadek 3 raz jeszcze z widmem

%Pokazaæ to samo w abletonie

x = sin((1:50)/2);
pokaz_odpowiedzi2(x,h);

clc
close all

%% Przypadek 4: sinus szybki
x = sin((1:50)*1.75)*0.35;
pokaz_odpowiedzi2(x,h);

clc
close all

%% Pokaz nowej odpowiedzi

h = sin((1:125)/1.75)*0.5;
stem(h); grid; title('OdpowiedŸ impulsowa mojego filtru'); xlabel('Próbka'); ylabel('Wartoœæ');
axis([0 inf -1 1]);

%% Przypadek 1: inny sinus
x = sin((1:50)*2.8)*0.35;
pokaz_odpowiedzi2(x,h);

clc
close all

%% Przypadek 2: SZUM
x = randn(1,200) .* 0.1;
pokaz_odpowiedzi2(x,h);

clc
close all;