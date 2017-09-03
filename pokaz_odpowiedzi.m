function y = pokaz_odpowiedzi(x,h)

ysiz = size(x,2)+size(h,2)-1;                                   %Ilosc probek w odpowiedzi
y = zeros(1,ysiz);                                              %Alokacja y

%psiz = 3+size(x,2)+ysiz+size(x,2)+3;                           %Romiar pokazu
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
    
    subplot(2,1,1);
    stem(U);
    axis([1 psiz -1 1]);
    grid
    title('Splot');
    xlabel('Probka');
   
    subplot(2,1,2);
    stem(y_pok);
    grid
    title('Sygna³ wynikowy');
    xlabel('Probka');
    axis([1 psiz -1 1]);
    
    pause
end

 end