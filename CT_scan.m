function varargout = CT_scan(varargin)
% CT_SCAN MATLAB code for CT_scan.fig
%      CT_SCAN, by itself, creates a new CT_SCAN or raises the existing
%      singleton*.
%
%      H = CT_SCAN returns the handle to a new CT_SCAN or the handle to
%      the existing singleton*.
%
%      CT_SCAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CT_SCAN.M with the given input arguments.
%
%      CT_SCAN('Property','Value',...) creates a new CT_SCAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CT_scan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CT_scan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CT_scan

% Last Modified by GUIDE v2.5 03-Dec-2019 16:20:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CT_scan_OpeningFcn, ...
                   'gui_OutputFcn',  @CT_scan_OutputFcn, ...
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


% --- Executes just before CT_scan is made visible.
function CT_scan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CT_scan (see VARARGIN)

% Choose default command line output for CT_scan
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CT_scan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CT_scan_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in upload_img.
function upload_img_Callback(hObject, eventdata, handles)
[FileName,PathName]=uigetfile('*.jpg','Select Image file');
im = imread([PathName,FileName]);
% maxray = max(size(im));
% im_arr =zeros(maxray,maxray);
% im_arr = im;
im_arr = double(im(:,:,1));
handles.im=im_arr; % menyimpan nilai variabel
guidata(hObject,handles); % instruksi simpan object
axes(handles.input_img); % memasukkan nilai variabel pada axis
imshow(im_arr,[]); % menampilkan image hasil browse
% hObject    handle to upload_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function input1_Callback(hObject, eventdata, handles)
% hObject    handle to input1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input1 as text
%        str2double(get(hObject,'String')) returns contents of input1 as a double
str = get(hObject,'String');


% --- Executes during object creation, after setting all properties.
function input1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function jumlah_proyeksi_Callback(hObject, eventdata, handles)
% hObject    handle to jumlah_proyeksi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of jumlah_proyeksi as text
%        str2double(get(hObject,'String')) returns contents of jumlah_proyeksi as a double


% --- Executes during object creation, after setting all properties.
function jumlah_proyeksi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jumlah_proyeksi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

jmlh_proyeksi = str2double(get(handles.jumlah_proyeksi,'string'));
jmlh_raysome = str2double(get(handles.jumlah_raysome,'string'));
% img1 = rgb2gray(handles.im);
% img1 = img1/255;
img1 = handles.im;
img1 = imresize(img1, [jmlh_raysome jmlh_raysome]);
% maxray = max(size(img1));
% ukuran = jmlh_proyeksi/maxray;
% img1 = imresize(img1, ukuran);
% A=zeros(jmlh_proyeksi,jmlh_proyeksi);
% theta = 0:1:180;
% handles.theta = theta;
% [R,xp] = radon(img1,theta);
% sino = [R,xp];
% Z = R;
% handles.R = R;
step=180/jmlh_proyeksi;


for i=0:step:180
    axes(handles.hasil_sinogram);
    tet=0:step:i;
    [R,xp] = radon(img1,tet);
    sino = [R,xp];
    imshow(sino,[]);
%     sino_data = radon(A,tet);
%     sino_data = poissrnd(Tube_current*sino_data)/Tube_current;
%     imshow(sino_data,[]);
    title('R_{\theta} (X\prime)');
    xlabel('\theta (degrees)');
    ylabel('X\prime');
%     axis([0 180 0 Z]);
%     putar gambar
    J = imrotate(handles.im,i);
    axes(handles.input_img);
    imshow(J,[]);
    IR = iradon(R,tet);
    axes(handles.hasil_rekonstruksi);
    imshow(IR,[]);
    pause(0.001);
end
guidata(hObject, handles);




% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function jumlah_raysome_Callback(hObject, eventdata, handles)
% hObject    handle to jumlah_raysome (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of jumlah_raysome as text
%        str2double(get(hObject,'String')) returns contents of jumlah_raysome as a double


% --- Executes during object creation, after setting all properties.
function jumlah_raysome_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jumlah_raysome (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
