function allow = allow_cards(game)

num_player = game.turno;

ref = game.mesa(1,:);

eval(['cards = game.p',num2str(num_player),'.cards;']);
num_cards = size(cards,1);
cards = [cards (1:num_cards)'];

allow = [];

for i = 1:num_cards
    if cards(i,2) == 5 % comodin
        allow = [allow ; cards(i,:)];
    elseif cards(i,2) == ref(1,2) % equal color
        allow = [allow ; cards(i,:)];
    elseif cards(i,1) == ref(1,1) % equal color
        allow = [allow ; cards(i,:)];
    end
end

