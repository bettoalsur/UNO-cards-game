function [game,handles] = animation_placing_card(game,handles)


N = 10;
time_a = 0.5;
num = game.turno;

if num > 1

aux = get(handles.text21,'Position');

d = get(handles.text5,'Position');
tam = d(3:4);

set(handles.text21,'BackgroundColor',0.1*[1 1 1]);
set(handles.text21,'String',' ');


panel1 = num;
panel2 = num + 4;
eje = num - 1;

eval(['ref1 = get(handles.uipanel',num2str(panel1),',''Position'');']);
eval(['ref2 = get(handles.uipanel',num2str(panel2),',''Position'');']);
eval(['ref3 = get(handles.axes',num2str(eje),',''Position'');']);

o = ref1 + ref2 + ref3;

sep = o - d ;
step = sep / (N+1);

o(3:4) = tam;



for i = 1:N-1
    o(1:2) = o(1:2) - step(1:2);
    set(handles.text21,'Position',o);
    set(handles.text21,'Visible','on');
    pause(time_a/N);
end

set(handles.text21,'Visible','off');
set(handles.text21,'Position',aux);


end


