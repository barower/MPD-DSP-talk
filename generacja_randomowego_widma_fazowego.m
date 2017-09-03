function [ wynik ] = generacja_randomowego_widma_fazowego( sig , max)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    wynik = zeros(size(sig));

    size(sig, 2)

    %Srodek widma
    srodek = size(sig, 2)./2 + 1;

    %Jesli rozmiar sygnalu jest parzysty
    if(mod(size(sig,2), 2) == 0) 
        index_start = srodek + 1;
        index_stop = srodek - 1;
    else %Jesli jednak nieparzysty
        index_start = ceil(srodek);
        index_stop = floor(srodek);
    end

    %Generacja
    for i = index_start:size(sig,2)
        wynik(i) = rand()*2*max - max;
    end

    %Odbicie od srodka
    for i = 2:index_stop
        wynik(i) = -1 * wynik(size(sig,2) - i + 2);  
    end

end

