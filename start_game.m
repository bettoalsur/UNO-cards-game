function [game] = start_game(game)

game.p1.cards = game.cards(1:4:28,:);
game.p2.cards = game.cards(2:4:28,:);
game.p3.cards = game.cards(3:4:28,:);
game.p4.cards = game.cards(4:4:28,:);

game.deck = game.cards(29:end,:);
while game.deck(1,1) >= 10
    game.deck = [ game.deck(2:end,:) ; game.deck(1,:)];
end

game.mesa = game.deck(1,:);
game.deck = game.deck(2:end,:);


