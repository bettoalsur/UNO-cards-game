function game = get_points(game,num_player)

eval(['cards = game.p',num2str(num_player),'.cards;']);
puntos = sum(cards(:,3));
eval(['game.p',num2str(num_player),'.points = puntos;']);
