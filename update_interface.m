function [game,handles] = update_interface(game,handles)

% muestra la ultima carta de la mesa
if game.mesa(1,1) <= 9
    str = num2str(game.mesa(1,1));
    str = [' ';str];
elseif game.mesa(1,1) == 10
    str = ['   ';'Inv'];
elseif game.mesa(1,1) == 11
    str = ['  ';'Bl'];
elseif game.mesa(1,1) == 12
    str = ['  ';'+2'];
elseif game.mesa(1,1) == 13
    str = ['  ';'Ch'];
elseif game.mesa(1,1) == 14
    str = ['  ';'+4'];
end
set(handles.text5,'String', str);

% muestra el color de la ultima carta de la mesa
cor = game.mesa(1,2);
switch cor
    case 1 
        color_card_table = [0.90 0 0];
        color_text = [1 1 1];
    case 2 
        color_card_table = [255 249 53]/255;
        color_text = [0 0 0];
    case 3 
        color_card_table = [0 0.65 0];
        color_text = [1 1 1];
    case 4
        color_card_table = [0 0 0.75];
        color_text = [1 1 1];
    case 5
        set(handles.text5, 'BackgroundColor', 0.1*[1 1 1]); % carta negra
        color_text = [1 1 1];
end
set(handles.text5, 'BackgroundColor', color_card_table);
set(handles.text5, 'ForegroundColor', color_text);


%%

% muestra las cartas del Jugador 1 y el numero de cartas de los otros
% jugadores

for i = 1:4
    
    if i == 1
        handles = draw_cards(game,handles);
    else
        eval(['cartas = game.p',num2str(i),'.num_cards;']);
        str = num2str(cartas);
        str = ['x ', str];
        eval(['set( handles.text', num2str(i) , ',''String'', str);' ]);
    end
    
end


%%

if game.on == 1

aux_turno = game.turno;
aux_dir = game.dir;
color_block = [255 165 0]/255;

if ( game.mesa(1,1) == 11 || game.mesa(1,1) == 12 || game.mesa(1,1) == 14  ) && (  game.block == 1  ) 
    game.dir = -game.dir;
    game = advance_turn(game);
    eval(['set( handles.uipanel', num2str(game.turno) , ',''BackgroundColor'',color_block);' ]); % naranja
    game = advance_turn(game);
    eval(['set( handles.uipanel', num2str(game.turno) , ',''BackgroundColor'',[235 39 53]/255);' ]); % rojo
    pause(1.25);
end

game.dir = aux_dir;
game.turno = aux_turno;

for i = 1:4
    % muestra el turno actual
    if i == game.turno
        eval(['set( handles.uipanel', num2str(i) , ',''BackgroundColor'',[22 220 53]/255);' ]); %verde
    else
        eval(['set( handles.uipanel', num2str(i) , ',''BackgroundColor'',[235 39 53]/255);' ]); % rojo
    end
    
end

end

%%

% muestra la imagen de la direccion de giro
if game.dir > 0
    matlabImage = imread('sentido_pos.jpg');
else
    matlabImage = imread('sentido_neg.jpg');
end
axes(handles.axes7);
image(matlabImage);
axis off;
axis image;





