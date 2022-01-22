function [str,color_card,color_text] = draw_card(card2draw)

if card2draw(1,1) <= 9
    str = num2str(card2draw(1,1));
elseif card2draw(1,1) == 10
    str = 'Inv';
elseif card2draw(1,1) == 11
    str = 'Bl';
elseif card2draw(1,1) == 12
    str = '+2';
elseif card2draw(1,1) == 13
    str = 'Ch';
elseif card2draw(1,1) == 14
    str = '+4';
end

% muestra el color de la ultima carta de la mesa
cor = card2draw(1,2);
switch cor
    case 1 
        color_card = [0.90 0 0];
        color_text = [1 1 1];
    case 2 
        color_card = [255 249 53]/255;
        color_text = [0 0 0];
    case 3 
        color_card = [0 0.65 0];
        color_text = [1 1 1];
    case 4
        color_card = [0 0 0.75];
        color_text = [1 1 1];
    case 5
        color_card = [0.15 0.15 0.15];
        color_text = [1 1 1];
end



