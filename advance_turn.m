function game = advance_turn(game)

game.turno = game.turno + game.dir;
if game.turno == 5 && game.dir == 1
    game.turno = 1;
elseif game.turno == 0 && game.dir == -1
    game.turno = 4;
end
