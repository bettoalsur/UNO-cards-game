function selected_card = choose_card(handles)

uiwait(handles.figure1);
pushed_button = zeros(16,1);
for i = 1:16
    j = 100 + i;
    eval(['pushed_button(',num2str(i),') = get(handles.pushbutton',num2str(j),',''Fontsize'');']);
end

selected_card = find(pushed_button == 15);