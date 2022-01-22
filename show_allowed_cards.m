function handles = show_allowed_cards(game,allow,handles)

cards = game.p1.cards;
num_cards = size(cards,1);

for i = 1:num_cards
    j = 100 + i;
    
    eval(['aux_color = get(handles.pushbutton',num2str(j),',''BackgroundColor'');']);
    aux_color = aux_color/4;
    eval(['set(handles.pushbutton',num2str(j),',''BackgroundColor'',aux_color);']);
end

num_per = size(allow,1);

for i = 1:num_per
    id_carta = allow(i,4);
    
    j = 100 + id_carta;
    eval(['cor = get(handles.pushbutton',num2str(j),',''BackgroundColor'');']);
    eval(['set(handles.pushbutton',num2str(j),',''BackgroundColor'',cor*4);']);
    
    eval(['pos = get(handles.pushbutton',num2str(j),',''Position'');']);
    pos(2) = pos(2)*1.04;
    eval(['set(handles.pushbutton',num2str(j),',''Position'',pos);']);
    
    eval(['set(handles.pushbutton',num2str(j),',''Enable'',''on'');']);
    
    eval(['set(handles.pushbutton',num2str(j),',''Fontweight'',''bold'');']);
end




