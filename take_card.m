function game = take_card(game,num_player)

eval(['cards = game.p',num2str(num_player),'.cards;']);
cards = [cards ; game.deck(1,:)];
game.deck = game.deck(2:end,:);
eval(['game.p',num2str(num_player),'.cards = cards;']);