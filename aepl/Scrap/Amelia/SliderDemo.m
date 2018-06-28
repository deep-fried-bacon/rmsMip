function SliderDemo(MyImage)
%clc
%clear all

NumFrames = size(MyImage,ndims(MyImage)); %4; %// Check below for dummy 4D matrix/image sequence
hFig = figure('Position',[100 100 500 500],'Units','normalized');

handles.axes1 = axes('Units','normalized','Position',[.05 .2 .9 .75]);
%toop{NumFrames} = [];
% toop{NumFrames} = [];%cell(NumFrames);
% for i = 1:NumFrames
%     toop(i) = (i./NumFrames);
% end
%// Create slider and listener object for smooth visualization
%handles.SliderFrame = uicontrol('Style','slider','Position',[60 30 400 50],'Min',1,'Max',NumFrames,'Value',1,'SliderStep',[1/NumFrames 2/NumFrames],'Callback',@XSliderCallback);
handles.SliderFrame = uicontrol('Style','slider','Units','normalized','Position',[.2 .15 .6 0],'Min',1,'Max',NumFrames,'Value',1,'SliderStep',[1/NumFrames 2/NumFrames],'Callback',@XSliderCallback);

handles.SliderxListener = addlistener(handles.SliderFrame,'Value','PostSet',@(s,e) XListenerCallBack);

%handles.Text1 = uicontrol('Style','Text','Position',[180 20 60 30],'String','Current frame');
%handles.Edit1 = uicontrol('Style','Edit','Position',[250 20 100 30],'String','1');

handles.Text1 = uicontrol('Style','Text','Units','normalized','Position',[.3 .05 .2 .05],'String','Current frame');
handles.Edit1 = uicontrol('Style','Edit','Units','normalized','Position',[.5 .05 .2 .05],'String','1');
%// Create dummy image sequence, here 4D sequence of grayscale images.
%MyImage = imread();

%MyImage = cat(3,MyImage(:,:,:));
%size(MyImage,3),MyImage(:,:,:));

%// Use setappdata to store the image stack and in callbacks, use getappdata to retrieve it and use it. Check the docs for the calling syntax.

setappdata(hFig,'MyImage',MyImage); %// You could use %//setappdata(0,'MyImage',MyImage) to store in the base workspace. 

%// Display 1st frame
imshow(MyImage(:,:,1),'InitialMagnification','fit','Border','tight')

%// IMPORTANT. Update handles structure.
guidata(hFig,handles);

    %// Listener callback, executed when you drag the slider.


    function XListenerCallBack

        %// Retrieve handles structure. Used to let MATLAB recognize the
        %// edit box, slider and all UI components.
        handles = guidata(gcf);

        %// Here retrieve MyImage using getappdata.
        MyImage = getappdata(hFig,'MyImage');

        %// Get current frame
        CurrentFrame = round((get(handles.SliderFrame,'Value')));
        set(handles.Edit1,'String',num2str(CurrentFrame));

        %// Display appropriate frame.
        imshow(MyImage(:,:,CurrentFrame),'Parent',handles.axes1,'InitialMagnification','fit');

        guidata(hFig,handles);
    end


    %// Slider callback; executed when the slider is release or you press
    %// the arrows.
    function XSliderCallback(~,~)

        handles = guidata(gcf);

        %// Here retrieve MyImage using getappdata.
        MyImage = getappdata(hFig,'MyImage');

        CurrentFrame = round((get(handles.SliderFrame,'Value')));
        set(handles.Edit1,'String',num2str(CurrentFrame));

        imshow(MyImage(:,:,CurrentFrame),'Parent',handles.axes1,'InitialMagnification','fit');

        guidata(hFig,handles);
    end
end


