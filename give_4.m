function game = give_4(game)

next = game.turno + game.dir;
if next == 5 && game.dir == 1
    next = 1;
elseif next == 0 && game.dir == -1
    next = 4;
end

for i = 1:4
    game = take_card(game,next);
end