function x = pokaz_sf( sig , widmofaz)

figure('units','normalized', 'position', [0 0 1 1]);

subplot(2,1,1);
plot(sig);
% axis([1 psiz -1 1]);
grid
title('Sygna³ wynikowy');
xlabel('Czas');

%Pokazanie widma fazowego
widmofaz = widmofaz - 2*pi*floor( (widmofaz+pi)/(2*pi) ); 
widmofaz = fftshift(widmofaz);
widmo_fazowe = widmofaz(floor(size(widmofaz,2)./2):end);
subplot(2,1,2)   
plot(log2(1:size(widmo_fazowe,2)),widmo_fazowe);
%plot(widmo_fazowe);
axis([0 inf -pi pi]); %Ustawienia osi
grid on %W³¹czenie siatki
title('Widmo fazowe');
xlabel('Czêstotliwoœæ'); ylabel('Faza [rad]');
set(gca,'XTick',[]);

end

