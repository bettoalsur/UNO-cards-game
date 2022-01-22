function [game,handles] = animation_taking_card(game,handles)

N = 40;
time_a = 0.4;
num = game.turno;

if num == 4
    N = 27;
end

aux = get(handles.text21,'Position');
set(handles.text21,'BackgroundColor',0.1*[1 1 1]);
set(handles.text21,'String',' ');

panel1 = num;
panel2 = num + 4;
eje = num - 1;

eval(['ref1 = get(handles.uipanel',num2str(panel1),',''Position'');']);
eval(['ref2 = get(handles.uipanel',num2str(panel2),',''Position'');']);
eval(['ref3 = get(handles.axes',num2str(eje),',''Position'');']);

d = ref1 + ref2 + ref3;
o = aux;

sep = o - d ;
step = sep / (N+1);

for i = 1:N
    o(1:2) = o(1:2) - step(1:2);
    set(handles.text21,'Position',o);
    set(handles.text21,'Visible','on');
    pause(time_a/N);
end

set(handles.text21,'Visible','off');
set(handles.text21,'Position',aux);

eval(['cards = game.p',num2str(num),'.cards;']);
str = num2str(size(cards,1));
str = ['x ', str];
eval(['set(handles.text',num2str(num),',''String'',str);']);








