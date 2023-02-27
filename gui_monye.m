function varargout = gui_monye(varargin)
% GUI_MONYE MATLAB code for gui_monye.fig
%      GUI_MONYE, by itself, creates a new GUI_MONYE or raises the existing
%      singleton*.
%
%      H = GUI_MONYE returns the handle to a new GUI_MONYE or the handle to
%      the existing singleton*.
%
%      GUI_MONYE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_MONYE.M with the given input arguments.
%
%      GUI_MONYE('Property','Value',...) creates a new GUI_MONYE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_monye_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_monye_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_monye

% Last Modified by GUIDE v2.5 25-Feb-2023 16:23:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_monye_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_monye_OutputFcn, ...
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


% --- Executes just before gui_monye is made visible.
function gui_monye_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_monye (see VARARGIN)

% Choose default command line output for gui_monye
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_monye wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_monye_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton3


% --- Executes on button press in browse_btn.
function browse_btn_Callback(hObject, eventdata, handles)
% hObject    handle to browse_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.*', 'Pick a MATLAB code file');
    if isequal(filename,0) || isequal(pathname,0)
       disp('User pressed cancel')
    else
       filename=strcat(pathname,filename);
       br_file = imread(filename);
       axes(handles.axes1);
       imshow(br_file);
       
       handles.image_1 = br_file;
       guidata(hObject, handles);
    end


% --- Executes on button press in check_btn.
function check_btn_Callback(hObject, eventdata, handles)
% hObject    handle to check_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    % Read input image
        a = handles.image_1;
        
        


% Convert image to grayscale
Igray = rgb2gray(a);

% Threshold the image
level = graythresh(Igray);
Ithresh = im2bw(Igray, level);
    
% Edge detection
Iedge = edge(Ithresh, 'canny');

% Dilate the edges
se = strel('rectangle',[5 5]);
Idilate = imdilate(Iedge,se);

% Find the boundaries of the document
boundaries = bwboundaries(Idilate);
b = boundaries{1};
x = b(:,2);
y = b(:,1);

% Calculate width and height of the document
width = max(x) - min(x);
height = max(y) - min(y);

% Convert to cm
conversion_factor = 2.54 / 96;
width_cm = width * conversion_factor;
height_cm = height * conversion_factor;

% Display the output
axes(handles.axes2);
imshow(a);
hold on;
plot(x, y, 'LineWidth', 2, 'Color', 'r');
text(min(x), min(y), sprintf('Width: %.2f cm\nHeight: %.2f cm', width, height), ...
    'Color', 'r', 'VerticalAlignment', 'top', 'HorizontalAlignment', 'left', 'FontSize', 14);
hold off;

        
   

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset_btn.
function reset_btn_Callback(hObject, eventdata, handles)
% hObject    handle to reset_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in exit_btn.
function exit_btn_Callback(hObject, eventdata, handles)
% hObject    handle to exit_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);



function doc_size_Callback(hObject, eventdata, handles)
% hObject    handle to doc_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of doc_size as text
%        str2double(get(hObject,'String')) returns contents of doc_size as a double


% --- Executes during object creation, after setting all properties.
function doc_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to doc_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function browse_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to browse_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
