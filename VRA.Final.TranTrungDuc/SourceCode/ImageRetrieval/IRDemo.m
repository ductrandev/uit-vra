% GUI for Image Retrieval Demo
function varargout = IRDemo(varargin)
% IRDEMO MATLAB code for IRDemo.fig
%      IRDEMO, by itself, creates a new IRDEMO or raises the existing
%      singleton*.
%
%      H = IRDEMO returns the handle to a new IRDEMO or the handle to
%      the existing singleton*.
%
%      IRDEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IRDEMO.M with the given input arguments.
%
%      IRDEMO('Property','Value',...) creates a new IRDEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IRDemo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IRDemo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IRDemo

% Last Modified by GUIDE v2.5 02-Jan-2017 14:41:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IRDemo_OpeningFcn, ...
                   'gui_OutputFcn',  @IRDemo_OutputFcn, ...
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


% --- Executes just before IRDemo is made visible.
function IRDemo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IRDemo (see VARARGIN)

% Choose default command line output for IRDemo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IRDemo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IRDemo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[baseFileName, folder, ~] = uigetfile({'*.jpg';'*.png'},'File Selector');
fullFileName = [folder baseFileName];
handles.fullFileName = fullFileName;
guidata(hObject,handles);
rgbImage = imread(fullFileName);
imshow(rgbImage, 'Parent', handles.axes1);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vl_feat = 'C:\Users\DUCTRAN\Documents\vlfeat\toolbox\vl_setup'; 
data_path = 'C:\Users\DUCTRAN\Documents\MATLAB\dataset';
dataset_image_paths = get_dataset_image_paths(data_path);

number_of_random_images = 750;
vocab_size = 700;
db_size = 1500;

path_of_query_image = handles.fullFileName;

% create an instance of IrEngine to perform query task.
IrEngine = ImageRetrievalEngine(vl_feat, data_path, vocab_size,db_size );

%build visual vocabulary and vectors for all the images in dataset
IrEngine.build_visual_vocabulary(number_of_random_images);
IrEngine.build_db_images_vectors();

% get vector of query image then search and get results by comparing query
% vector and vectors of all the image in dataset
descending_ranked_list = IrEngine.get_ranked_result_for_query(path_of_query_image);

% only get top 10 results which are the most similar images.
display_result_limit = 10; 
top_descending_ranked_list = descending_ranked_list(:, 1:display_result_limit);

% display result using MATLAB subplot()
displayResult(dataset_image_paths, top_descending_ranked_list);

