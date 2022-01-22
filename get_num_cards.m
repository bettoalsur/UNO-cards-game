function game = get_num_cards(game,num_player)

eval(['cards = game.p',num2str(num_player),'.cards;']);
num_cards = size(cards,1);
eval(['game.p',num2str(num_player),'.num_cards = num_cards;']);
