function cards = shuffle_cards(cards)

num_cards = size(cards,1);
orden = randperm(num_cards)';

cards = cards(orden,:);





