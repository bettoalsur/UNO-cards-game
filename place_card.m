function [handles,game] = place_card(handles,game,sel)

num_player = game.turno;
eval(['cards = game.p',num2str(num_player),'.cards;']);

cards(sel(1,4),:) = [];
eval(['game.p',num2str(num_player),'.cards = cards;']);

game.mesa = [ sel(1,1:3) ; game.mesa ];

sel = sel(1,1:2);

if sel(1,2) == 5
    
    if game.mesa(1,1) == 13
        str = ['  ';'Ch'];
    elseif game.mesa(1,1) == 14
        str = ['  ';'+4'];
    end
    set(handles.text5,'String', str);
    set(handles.text5, 'BackgroundColor', 0.1*[1 1 1]); % carta negra
    set(handles.text5, 'ForegroundColor', [1 1 1]);
    
    set(handles.text9, 'BackgroundColor', [0.90 0 0]);
    set(handles.text10, 'BackgroundColor', [255 249 53]/255);
    set(handles.text11, 'BackgroundColor', [0 0.65 0]);
    set(handles.text12, 'BackgroundColor', [0 0 0.75]);
    
    if game.turno == 1
        question = 'Escoja un color:';
        options = ['rojo    ';'amarillo';'verde   ';'azul    '];
        color = ask_selection(handles,question,options);
    else
        str = 'Eligiendo color';
        set(handles.text7, 'String', str);
        pause(4);
        set(handles.text7, 'String', ' ');
        
        q = zeros(4,1);
        for i = 1:4
            q(i,1) = sum(cards(:,2)==i);
        end
        
        if sum(q) == 0
            color = randi([1 4],1);
        else
            [~,color] = max(q);
        end
        
    end
    
    aux_color = get(handles.text8,'BackgroundColor');
    for i = 9:12
        eval(['set(handles.text',num2str(i),',''BackgroundColor'',aux_color);'])
    end
    
    game.mesa(1,2) = color;
    
    if sel(1,1) == 13
        game = advance_turn(game);
    elseif sel(1,1) == 14
        game = give_4(game);
        game = advance_turn(game);
        game = advance_turn(game);
    end
    
elseif sel(1,1) == 10
    game.dir = -game.dir;
    game = advance_turn(game);
elseif sel(1,1) == 11
    game = advance_turn(game);
    game = advance_turn(game);
elseif sel(1,1) == 12
    game = give_2(game);
    game = advance_turn(game);
    game = advance_turn(game);
else
    game = advance_turn(game);
end
