function handles = show_taken_card(handles,taken_card)

% muestra la ultima carta de la mesa
if taken_card(1,1) <= 9
    str = num2str(taken_card(1,1));
    str = [' ';str];
elseif taken_card(1,1) == 10
    str = ['   ';'Inv'];
elseif taken_card(1,1) == 11
    str = ['  ';'Bl'];
elseif taken_card(1,1) == 12
    str = ['  ';'+2'];
elseif taken_card(1,1) == 13
    str = ['  ';'Ch'];
elseif taken_card(1,1) == 14
    str = ['  ';'+4'];
end
set(handles.text21,'String', str);

% muestra el color de la ultima carta de la mesa
cor = taken_card(1,2);
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
        color_card_table = [0.15 0.15 0.15];
        color_text = [1 1 1];
end
set(handles.text21, 'BackgroundColor', color_card_table);
set(handles.text21, 'ForegroundColor', color_text);



