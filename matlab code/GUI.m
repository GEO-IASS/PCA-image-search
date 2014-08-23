function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 23-Apr-2014 11:11:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUI_OpeningFcn, ...
    'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;
handles.featureData = load('..\\vectors\\features.mat');

handles.centroidData = load('..\\vectors\\clustering\\centroids.mat');
handles.clusteredVectorsData = load('..\\vectors\\clustering\\clusteredVectors.mat');

handles.reducedCentroidData = load('..\\vectors\\clustering\\ReducedCentroids.mat');
handles.reducedClusteredVectorsData = load('..\\vectors\\clustering\\ReducedClusteredVectors.mat');

handles.dpcaReducedCentroidData = load('..\\vectors\\clustering\\dpcaReducedCentroids.mat');
handles.dpcaReducedClusteredVectorsData = load('..\\vectors\\clustering\\dpcaReducedClusteredVectors.mat');

handles.kpcaReducedCentroidData = load('..\\vectors\\clustering\\kpcaReducedCentroids.mat');
handles.kpcaReducedClusteredVectorsData = load('..\\vectors\\clustering\\kpcaReducedClusteredVectors.mat');

handles.multiplierData = load('..\\vectors\\reduction\\Multiplier.mat');
handles.reducedData = load('..\\vectors\\reduction\\ReducedVectors.mat');

handles.dpcaMultiplierData = load('..\\vectors\\reduction\\dpcaMultiplier.mat');
handles.dpcaReducedData = load('..\\vectors\\reduction\\dpcaReducedVectors.mat');

handles.kpcaMultiplierData = load('..\\vectors\\reduction\\kpcaMultiplier.mat');
handles.kpcaReducedData = load('..\\vectors\\reduction\\kpcaReducedVectors.mat');

handles.reduce = 0;
handles.cluster = 0;
handles.thresh = 1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(~, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_BrowseImage.
function btn_BrowseImage_Callback(hObject, ~, handles)
% hObject    handle to btn_BrowseImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[query_fname, query_pathname] = uigetfile('*.jpg; *.png; *.bmp', 'Select query image');

if (query_fname ~= 0)
    query_fullpath = strcat(query_pathname, query_fname);
    [pathstr, name, ext] = fileparts(query_fullpath); % fiparts returns char type
    
    if ( strcmpi(ext, '.jpg') == 1 || strcmpi(ext, '.png') == 1 ...
            || strcmpi(ext, '.bmp') == 1 )
        
        queryImage = imread( fullfile( pathstr, strcat(name, ext) ) );
%         handles.queryImage = queryImage;
%         guidata(hObject, handles);
        disp('Extracting query image features');
        % extract query image features
        queryImage = imresize(queryImage, [384 256]);
        % construct the queryImage feature vector
        queryImageFeature = [getFeatures(queryImage) str2num(name)];

        % update handles
        handles.queryImageFeature = queryImageFeature;
        guidata(hObject, handles);
        %helpdlg('Proceed with the query by executing the green button!');
        disp('Query image features extraction done');
        % Clear workspace
        clear('query_fname', 'query_pathname', 'query_fullpath', 'pathstr', ...
            'name', 'ext', 'queryImage', 'hsvHist', 'autoCorrelogram', ...
            'color_moments', 'img', 'meanAmplitude', 'msEnergy', ...
            'wavelet_moments', 'queryImageFeature');
    else
        errordlg('You have not selected the correct file type');
    end
else
    return;
end


% --- Executes on selection change in popupmenu_DistanceFunctions.
function popupmenu_DistanceFunctions_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_DistanceFunctions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_DistanceFunctions contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_DistanceFunctions

handles.DistanceFunctions = get(handles.popupmenu_DistanceFunctions, 'Value');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu_DistanceFunctions_CreateFcn(hObject, ~, ~)
% hObject    handle to popupmenu_DistanceFunctions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnExecuteQuery.
function btnExecuteQuery_Callback(~, ~, handles)
% hObject    handle to btnExecuteQuery (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% check for image query
if (~isfield(handles, 'queryImageFeature'))
    errordlg('Please select an image first, then choose your similarity metric and num of returned images!');
    return;
end

% set variables
if (~isfield(handles, 'DistanceFunctions'))
    metric = get(handles.popupmenu_DistanceFunctions, 'Value');
else
    metric = handles.DistanceFunctions;
end


if (~isfield(handles, 'numOfClusters'))
    numOfClusters = get(handles.popupmenu_numOfClusters, 'Value');
else
    numOfClusters = handles.numOfClusters;
end
%get initial cpu time.
then = cputime;

vectors = handles.featureData.features;
queryVector = handles.queryImageFeature;

% deal with request to reduce the data.
pca_method = 1;
if(get(handles.dpcaRadioButton, 'Value') == get(handles.dpcaRadioButton, 'Max'))
    pca_method = 2;
elseif(get(handles.kpcaRadioButton, 'Value') == get(handles.kpcaRadioButton, 'Max'))
    pca_method = 3;
end;
if(handles.reduce == 1)
    %check for pca or dpca
    if(pca_method == 1)
        vectors = handles.reducedData.ReducedVectors;
        queryVector = pcaReduction(queryVector, handles.multiplierData.Multiplier);
        disp('doing direct pca');
    elseif(pca_method == 2)
        vectors = handles.dpcaReducedData.dpcaReducedVectors;
        queryVector = dpcaReduction(queryVector, handles.dpcaMultiplierData.dpcaMultiplier);
        disp('doing dual pca');
    elseif(pca_method == 3)
        vectors = handles.kpcaReducedData.kpcaReducedVectors;
        queryVector = kpcaReduction(queryVector, handles.kpcaMultiplierData.kpcaMultiplier, handles.featureData.features);
        disp('doing kernel pca');
    end
end
% done with reducing the data.

% deal with request to cluster vectors.
if(handles.cluster == 1)
    if(handles.reduce == 0)
        vectors = getClusterVectors(handles.centroidData.centroids, handles.clusteredVectorsData.clusteredVectors, queryVector, numOfClusters);
    elseif(pca_method == 1)
        vectors = getClusterVectors(handles.reducedCentroidData.ReducedCentroids, handles.reducedClusteredVectorsData.ReducedClusteredVectors, queryVector, numOfClusters);
    elseif(pca_method == 2)
        vectors = getClusterVectors(handles.dpcaReducedCentroidData.dpcaReducedCentroids, handles.dpcaReducedClusteredVectorsData.dpcaReducedClusteredVectors, queryVector, numOfClusters);
    elseif(pca_method == 3)
        vectors = getClusterVectors(handles.kpcaReducedCentroidData.kpcaReducedCentroids, handles.kpcaReducedClusteredVectorsData.kpcaReducedClusteredVectors, queryVector, numOfClusters);
    end
end
% choose the metric.
if (metric == 1)
    [sortedImgs, sortedDist] = L1(queryVector, vectors);
elseif (metric == 2 || metric == 3 || metric == 4)
    [sortedImgs, sortedDist] = L2(queryVector, vectors, metric);
end
%calculate cpu time.
time = cputime - then;
% display elapsed time.
set(handles.timeText, 'String', ['Time Taken: ', num2str(time)]);
% display the image
displayImage(queryVector(:, end), sortedImgs, sortedDist, handles.thresh);
set(handles.resultTag, 'HandleVisibility', 'on');
helpdlg('Results are generated');



% --- Executes on button press in chkReducedVectors.
function chkReducedVectors_Callback(hObject, ~, handles)
% hObject    handle to chkReducedVectors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkReducedVectors

if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.pcaRadioButton,'Enable','on');
    set(handles.dpcaRadioButton,'Enable','on');
    set(handles.kpcaRadioButton,'Enable','on');
    handles.reduce = 1;
else
    set(handles.pcaRadioButton,'Enable','off');
    set(handles.dpcaRadioButton,'Enable','off');
    set(handles.kpcaRadioButton,'Enable','off');
    handles.reduce = 0;
end
guidata(hObject, handles);



% --- Executes on button press in chkClustering.
function chkClustering_Callback(hObject, ~, handles)
% hObject    handle to chkClustering (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkClustering

if (get(hObject,'Value') == get(hObject,'Max'))
    set(handles.popupmenu_numOfClusters,'Enable','on');
    handles.cluster = 1;
else
    set(handles.popupmenu_numOfClusters,'Enable','off');
    handles.cluster = 0;
end
guidata(hObject, handles);


% --- Executes on selection change in popupmenu_numOfClusters.
function popupmenu_numOfClusters_Callback(hObject, ~, handles)
% hObject    handle to popupmenu_numOfClusters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_numOfClusters contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_numOfClusters
handles.numOfClusters = get(handles.popupmenu_numOfClusters, 'Value');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu_numOfClusters_CreateFcn(hObject, ~, ~)
% hObject    handle to popupmenu_numOfClusters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
if (get(hObject,'Value') == get(hObject,'Max'))
    handles.thresh = 0;
else
    handles.thresh = 1;
end
guidata(hObject, handles);
