function varargout = GUI_teste_1(varargin)
% GUI_TESTE_1 MATLAB code for GUI_teste_1.fig
%      GUI_TESTE_1, by itself, creates a new GUI_TESTE_1 or raises the existing
%      singleton*.
%
%      H = GUI_TESTE_1 returns the handle to a new GUI_TESTE_1 or the handle to
%      the existing singleton*.
%
%      GUI_TESTE_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_TESTE_1.M with the given input arguments.
%
%      GUI_TESTE_1('Property','Value',...) creates a new GUI_TESTE_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_teste_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_teste_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_teste_1

% Last Modified by GUIDE v2.5 23-Jan-2021 15:46:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_teste_1_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_teste_1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI_teste_1 is made visible.
function GUI_teste_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_teste_1 (see VARARGIN)

% Choose default command line output for GUI_teste_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

matlabImage = imread('posterior_view.png');
for i = 1:4
    % cartas de UNO
    eval(['axes(handles.axes',num2str(i),');']);
    image(matlabImage)
    axis off
    axis image
    
    % muda cor de titulo dos painel
    eval(['set( handles.uipanel', num2str(i) , ',''ForegroundColor'',[0 0 0]);' ]); % negro
    
end

% imgaen de sentido
matlabImage = imread('sentido_pos.jpg');
axes(handles.axes7);
image(matlabImage);
axis off;
axis image;

% taken_card
set(handles.text21,'Visible','off');

% oculta los botones
handles = reset_buttons(handles);




% UIWAIT makes GUI_teste_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_teste_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB


% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton200.
function pushbutton200_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton200 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
clc;
set(handles.pushbutton200,'Enable','off');
set(handles.text7, 'String', ' ');


for i = 1:4 % muda para blanco el color de los paneles
    eval(['set( handles.uipanel', num2str(i) , ',''ForegroundColor'',[1 1 1]);' ]); % blanco
end

game.turno = randi([1 4],1);
game.dir = 1;
game.on = 1;
game.block = 1; % chance de sinal de bloqueio

game.cards = create_cards();
game.cards = shuffle_cards(game.cards);
[game] = start_game(game);

% get players information
game = update_players_information(game);

while game.on == 1 % start the loop ( the game )

% garantiza suficientes cartas en el mazo
game = guarantee_enough_cards(game);
aux_turno = game.turno;


% actualiza interface
[game,handles] = update_interface(game,handles);
game.block = 1; % chance de sinal de bloqueio


% determine allowed cards
aux = allow_cards(game);
if game.turno == 1
    handles = show_allowed_cards(game,aux,handles);
end


if size(aux,1) == 0
    
    if game.turno == 1
        str = 'Tome una carta';
        set(handles.text7, 'String', str);
        set(handles.pushbutton2,'Enable','on');
        waitfor(handles.pushbutton2,'Enable');
        
        aux_last_deck = game.deck(1,1:2);
        set(handles.text7, 'String', ' ' );
    else
        pause(3);
    end
    
    game = take_card(game, game.turno);
    aux = allow_cards(game);
    
    if game.turno == 1
        handles = show_taken_card(handles,aux_last_deck);
        set(handles.text21,'Visible','on');
    else
        [game,handles] = animation_taking_card(game,handles);
        pause(2);
    end
    
    if size(aux,1) == 0
        
        game.block = 0; % sem chance de sinal de bloqueio
        
        if game.turno == 1
            str = 'Carta no jugable';
            set(handles.text7, 'String', str);
            pause(3.5);
            set(handles.text7, 'String', ' ' );
        else
            pause(1);
        end
        
        str = 'Pasa el turno';
        set(handles.text7, 'String', str);
        pause(2.25);
        set(handles.text7, 'String', ' ');
        
        if game.turno == 1
            set(handles.text21,'Visible','off');
        end
        
        game = advance_turn(game);
        
        
    else
        
        if game.turno == 1
            
            question = 'Jugar carta? ';
            options = ['  si  ';'  no  '];
            sel = ask_selection(handles,question,options);
            
            set(handles.text21,'Visible','off');
            
            if sel == 1
                [handles,game] = place_card(handles,game,aux);
            elseif sel == 2
                game = advance_turn(game);
            end
            
        else % opcion del Bot
            pause(2);
            set(handles.text7, 'String', ' ' );
            [game,handles] = animation_placing_card(game,handles);
            [handles,game] = place_card(handles,game,aux);
        end
        
    end
    
else
    
    if size(aux,1) == 1
        
        if game.turno == 1
            selected_card = choose_card(handles);
            aux = [ game.p1.cards(selected_card,:) selected_card];
        else
            pause(4);
            set(handles.text7, 'String', ' ' );
        end
            
    else
        
        if game.turno == 1
            
            selected_card = choose_card(handles);
            aux = [ game.p1.cards(selected_card,:) selected_card];
            
        else % opcion del bot

            pause(4);
            set(handles.text7, 'String', ' ' );
            
            % seleccion de la mayor puntuacion
            id_nc = aux(:,1) < 13;
            aux_2 = aux(id_nc , :);
            if size(aux_2,1) > 0
                [~,sel]=max(aux_2(:,3));
                aux = aux_2(sel,:);
            else
                [~,sel]=min(aux(:,3));
                aux = aux(sel,:);
            end
            
        end
        
    end   
    [game,handles] = animation_placing_card(game,handles);
    [handles,game] = place_card(handles,game,aux);
end

% update information
game = update_players_information(game);


eval([' num_cards_current_player = game.p',num2str(aux_turno),'.num_cards;']);
if num_cards_current_player == 0 % si hay un ganador
    
    game.on = 0;
    [game,handles] = update_interface(game,handles);
    str = strcat(['Ganador: Jugador ',num2str(aux_turno)]);
    set(handles.text7, 'String', str);
    pause(3);
    set(handles.text7, 'String', ' ');

end


end

str = 'Gracias por jugar';
set(handles.text7, 'String', str);
set(handles.pushbutton200,'Enable','on');









% --- Executes on button press in pushbutton101.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton101 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Enable','off');










% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton101.
function pushbutton101_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton101 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Fontsize',15);
uiresume(handles.figure1);


% --- Executes on button press in pushbutton102.
function handles = pushbutton102_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton102 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Fontsize',15);
uiresume(handles.figure1);



% --- Executes on button press in pushbutton103.
function   pushbutton103_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton103 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Fontsize',15);
uiresume(handles.figure1);


% --- Executes on button press in pushbutton104.
function  pushbutton104_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton104 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Fontsize',15);
uiresume(handles.figure1);


% --- Executes on button press in pushbutton105.
function  pushbutton105_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton105 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Fontsize',15);
uiresume(handles.figure1);


% --- Executes on button press in pushbutton106.
function  pushbutton106_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton106 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Fontsize',15);
uiresume(handles.figure1);


% --- Executes on button press in pushbutton107.
function pushbutton107_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton107 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Fontsize',15);
uiresume(handles.figure1);

% --- Executes on button press in pushbutton108.
function   pushbutton108_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton108 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Fontsize',15);
uiresume(handles.figure1);


% --- Executes on button press in pushbutton109.
function   pushbutton109_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton109 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Fontsize',15);
uiresume(handles.figure1);


% --- Executes on button press in pushbutton110.
function  pushbutton110_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton110 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Fontsize',15);
uiresume(handles.figure1);


% --- Executes on button press in pushbutton111.
function   pushbutton111_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton111 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Fontsize',15);
uiresume(handles.figure1);


% --- Executes on button press in pushbutton112.
function  pushbutton112_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton112 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Fontsize',15);
uiresume(handles.figure1);


% --- Executes on button press in pushbutton113.
function  pushbutton113_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton113 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Fontsize',15);
uiresume(handles.figure1);


% --- Executes on button press in pushbutton114.
function   pushbutton114_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton114 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Fontsize',15);
uiresume(handles.figure1);


% --- Executes on button press in pushbutton115.
function   pushbutton115_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton115 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Fontsize',15);
uiresume(handles.figure1);


% --- Executes on button press in pushbutton116.
function  pushbutton116_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton116 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Fontsize',15);
uiresume(handles.figure1);
