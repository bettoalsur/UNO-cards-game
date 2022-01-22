function handles = reset_buttons(handles)

str = ' ';

for i = 1:16
    j = 100 + i;
    eval(['set(handles.pushbutton',num2str(j),',''Enable'',''off'');']); % inactivar
    eval(['set(handles.pushbutton',num2str(j),',''Visible'',''off'');']); % dejar invisible
    eval(['set(handles.pushbutton',num2str(j),',''Fontsize'',14);']); % tamano de fuente 14 
    eval(['set(handles.pushbutton',num2str(j),',''Fontweight'',''normal'');']); % tipo de fuente
    
    eval(['set(handles.pushbutton',num2str(j),',''String'',str);']); % borra texto
    eval(['set(handles.pushbutton',num2str(j),',''BackgroundColor'',[1 1 1]*240/255);']); % deja gris el boton
    eval(['set(handles.pushbutton',num2str(j),',''ForegroundColor'',[0 0 0]);']); % deja negro el texto 
    
    % captura posicao 
    eval(['pos = get(handles.pushbutton',num2str(j),',''Position'');']); 
    
    if i <=8
        pos(2) = 6.2;
        eval(['set(handles.pushbutton',num2str(j),',''Position'',pos);']); % ajusta la posicion
    else
        pos(2) = 1;
        eval(['set(handles.pushbutton',num2str(j),',''Position'',pos);']); % ajusta la posicion
    end
end

