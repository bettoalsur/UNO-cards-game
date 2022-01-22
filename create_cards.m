function cards = create_cards()

aux = ones(1,24);

design = [zeros(1,4) repmat(1:12,1,8) reshape(repmat(13:14,4,1),1,8)]';
colors = [(1:4) aux 2*aux 3*aux 4*aux 5*ones(1,8)]';
cards = [design colors];

% asignar puntos a las cartas
N = size(cards,1);
puntos = zeros(N,1);
id_c = cards(:,2) == 5 ;
puntos(id_c) = 50;
id_p = (id_c==0) + ( cards(:,1) >= 10) == 2 ;
puntos(id_p) = 20;
id_n = (id_c==0) + (id_p==0) == 2;
puntos(id_n) = cards(id_n,1);

cards = [cards puntos];


