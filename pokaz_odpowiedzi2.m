function y = pokaz_odpowiedzi2(x,h)

ysiz = size(x,2)+size(h,2)-1;                                   %Ilosc probek w odpowiedzi
y = zeros(1,ysiz);                                              %Alokacja y

%psiz = 3+size(x,2)+ysiz+size(x,2)+3;                                      %Romiar pokazu
psiz = 3+size(x,2)+ysiz+3; 
izero = 3+size(x,2)+1;                                          %Indeks poczatku odpowiedzi impulsowej

x_pok = zeros(1,psiz);                                          %Alokacja x do pokazu
h_pok = [zeros(1,(izero-1)),h,zeros(1,psiz-size(h,2)-izero+1)]; %Alokacja stalego h do pokazu
    j = 0;
y_pok = zeros(1,psiz);

figure('units','normalized', 'position', [0 0 1 1]);

for i = 1:(psiz-size(x,2)+1)
    if(i < (psiz-size(x,2)+1))
        x_pok = [zeros(1,i-1), x, zeros(1,psiz-size(x,2)-i+1)];
    else
        x_pok = [zeros(1,i-1), x(1:(size(x,2)-j))];
        j = j+1;
    end
    
    U = [x_pok', h_pok'];
    
    y_pok(i+size(x,2)-1) = sum(x_pok.*h_pok);
    
    subplot(2,2,1);
    stem(U);
    axis([1 psiz -1 1]);
    grid
    title('Splot');
    xlabel('Probka');
    
    subplot(2,2,2);
    plot(1:size(x_pok,2), 20*log10(abs(fftshift(fft(x_pok)))), 1:size(x_pok,2), 20*log10(abs(fftshift(fft(h_pok)))));
    grid
    title('Widmo amplitudowe sygna³u wejœciowego i filtru');
    ylabel('Amplituda [dB]');
    xlabel('Czêstotliwoœæ');
    axis([size(x_pok,2)/2+1 inf -20 35]);
    set(gca,'XTick',[]);
   
    subplot(2,2,3);
    stem(y_pok);
    grid
    title('Sygna³ wynikowy');
    xlabel('Probka');
    axis([1 psiz -1 1]);
    
    subplot(2,2,4);
    plot(1:size(y_pok,2),  20*log10(abs(fftshift(fft(y_pok)))));
    grid
    title('Widmo amplitudowe sygna³u wynikowego');
    ylabel('Amplituda [dB]');
    xlabel('Czêstotliwoœæ');
    axis([size(x_pok,2)/2+1 inf -20 35]);
    set(gca,'XTick',[]);
    
    pause
end

 end