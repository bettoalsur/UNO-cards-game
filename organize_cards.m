function game = organize_cards(game,num_player)

eval(['cards = game.p',num2str(num_player),'.cards;']);
id = cards(:,2) == 5 ;
aux = cards(id,:) ;
aux(:,1) = sort(aux(:,1),'descend');
org = aux;

for i = 1:4
    id = cards(:,2) == i ;
    aux = cards(id,:) ;
    aux(:,1) = sort(aux(:,1),'ascend');
    aux(:,3) = sort(aux(:,3),'ascend');
    org = [org ; aux];
end

eval(['game.p',num2str(num_player),'.cards = org;']);



