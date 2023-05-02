function varargout = graph_test(varargin)
% GRAPH_TEST MATLAB code for graph_test.fig
%      GRAPH_TEST, by itself, creates a new GRAPH_TEST or raises the existing
%      singleton*.
%
%      H = GRAPH_TEST returns the handle to a new GRAPH_TEST or the handle to
%      the existing singleton*.
%
%      GRAPH_TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRAPH_TEST.M with the given input arguments.
%
%      GRAPH_TEST('Property','Value',...) creates a new GRAPH_TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before graph_test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to graph_test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help graph_test

% Last Modified by GUIDE v2.5 01-May-2023 20:30:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @graph_test_OpeningFcn, ...
                   'gui_OutputFcn',  @graph_test_OutputFcn, ...
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


% --- Executes just before graph_test is made visible.
function graph_test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to graph_test (see VARARGIN)

% Choose default command line output for graph_test
handles.output = hObject;
set(handles.pause_btn, 'visible', 'off');
set(handles.stop_btn, 'visible', 'off');
p = portfolio();
set(handles.portfolio_table, 'Data',p);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes graph_test wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = graph_test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
   


% --- Executes on button press in start_btn.
function start_btn_Callback(hObject, eventdata, handles)
% hObject    handle to start_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pause_btn, 'userdata', 0, 'string', 'Pause Trading', 'visible', 'on');
set(handles.stop_btn, 'userdata', 0, 'visible', 'on');
set(handles.start_btn, 'visible', 'off');
start(handles);


% --- Executes on button press in pause_btn.
function pause_btn_Callback(hObject, eventdata, handles)
% hObject    handle to pause_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prevState = get(handles.pause_btn, 'userdata');

if prevState
    message = 'Pause Trading';
else
    message = 'Resume Trading';
end

set(handles.pause_btn, 'string', message, 'userdata', not(prevState));


% --- Executes on button press in stop_btn.
function stop_btn_Callback(hObject, eventdata, handles)
% hObject    handle to stop_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.stop_btn, 'userdata', 1); % will be used to close position
set(handles.start_btn, 'Enable', 'on', 'visible', 'on');
set(handles.stop_btn, 'visible', 'off');
set(handles.pause_btn, 'visible', 'off');
