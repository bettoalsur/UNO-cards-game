function handles = draw_cards(game,handles)

handles = reset_buttons(handles);

cards = game.p1.cards;
num_cards = size(cards,1);

for i = 1:num_cards
    card2draw = cards(i,:);
    [str,color_card,color_text] = draw_card(card2draw);
    
    j = 100 + i;
    eval(['set(handles.pushbutton',num2str(j),',''String'',str);']);
    eval(['set(handles.pushbutton',num2str(j),',''BackgroundColor'',color_card);']);
    eval(['set(handles.pushbutton',num2str(j),',''ForegroundColor'',color_text);']);
    eval(['set(handles.pushbutton',num2str(j),',''Visible'',''on'');']);
end
