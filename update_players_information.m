function game = update_players_information(game)

for i = 1:4 
    game = get_points(game,i);
    game = get_num_cards(game,i);
    game = organize_cards(game,i);
end