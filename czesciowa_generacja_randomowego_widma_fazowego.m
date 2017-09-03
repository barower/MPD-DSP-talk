function [ wynik ] = czesciowa_generacja_randomowego_widma_fazowego(wid , max)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    wynik = zeros(size(wid));

    size(wid, 2)

    %Srodek widma
    srodek = size(wid, 2)./2 + 1;

    %Jesli rozmiar sygnalu jest parzysty
    if(mod(size(wid,2), 2) == 0) 
        index_start = srodek + 1;
        index_stop = srodek - 1;
    else %Jesli jednak nieparzysty
        index_start = ceil(srodek);
        index_stop = floor(srodek);
    end

    %Generacja 0.662
    for i = index_start:size(wid,2)
        if(i > (index_start+size(wid,2))*0.63)
            wynik(i) = wid(i);
        else
            wynik(i) = -1*wid(i);
        end
    end

    %Odbicie od srodka
    for i = 2:index_stop
        wynik(i) = -1 * wynik(size(wid,2) - i + 2);  
    end

end

