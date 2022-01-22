function sel = ask_selection(handles,question,options)

mensaje = 'Selection';

set(handles.text7, 'String', question);

% coloca las opciones
str = [mensaje(1:size(options,2)) ; options];
set(handles.listbox1, 'String', str);
set(handles.listbox1,'Value',1);

waitfor(handles.listbox1,'Value');
sel = get(handles.listbox1,'Value') - 1;

set(handles.listbox1, 'String', ' ');
set(handles.listbox1,'Value',1);
set(handles.text7, 'String', ' ' );