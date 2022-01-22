function game = guarantee_enough_cards(game)

num_cards_deck = size(game.deck,1);

if num_cards_deck <= 5
    aux = game.mesa(2:end,:);
    ind = aux(:,3) == 50 ;
    aux(ind,2) = 5;
    aux = shuffle_cards(aux);
    game.deck = [ game.deck ; aux ];
    game.mesa = game.mesa(1,:);
end



