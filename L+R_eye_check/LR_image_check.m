function test_images
%Screen('Preference', 'SkipSyncTests', 0);
%% params

KbName('UnifyKeyNames');
PARAMS.KEYS.STOP = KbName('Escape');
PARAMS.KEYS.NEXT = KbName('Space');
PARAMS.KEYS.BACK = KbName('BackSpace');

PARAMS.SCREEN.POSITION = []; %[] means fullscreen, otherwise [min-x min-y max-x max-y]
PARAMS.SCREEN.BACKGROUND_COLOUR = [0 0 0];
PARAMS.SCREEN.TEXT_COLOUR = [255 255 255];
PARAMS.SCREEN.NUMBER = max(Screen('Screens'));
PARAMS.SCREEN.STEREO_TYPE = 1; %1 or 11 for shutter glasses (1 seems to work better)
PARAMS.SCREEN.PIPELINE_MODE = kPsychNeedFastBackingStore;
PARAMS.SCREEN.MAX_ATTEMPTS_OPEN_SCREEN = 5;
PARAMS.SCREEN.TEXT_SIZE_MAIN = 30;

%% run
% Get the screen numbers
screens = Screen('Screens');

%prepare stereo screen
sca;
AssertOpenGL();

% Enable PROPixx RB3D Sequencer
Datapixx('Open'); 
Datapixx('EnableVideoStereoBlueline');


[window, window_rect] = Screen('OpenWindow', PARAMS.SCREEN.NUMBER, PARAMS.SCREEN.BACKGROUND_COLOUR, PARAMS.SCREEN.POSITION, [], [], 1, [], PARAMS.SCREEN.PIPELINE_MODE);
%[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% img_degamma = imadjust(img, [], [], 1/log(2.2));
%  imshowpair(img,img_degamma,'montage')

right = imread('M.png');
left = imread ('S.png');

% both = imread('IMG_1202-Proper_LR_Cropped_JPEG.jpg');
% h = floor(size(both, 2) / 2);
% left = both(:,h+1:end,:);
% right = both(:,1:h,:);

leftTexture = Screen('MakeTexture', window, left);
rightTexture = Screen('MakeTexture', window, right);

[s1, s2, s3] = size(left);
[s4, s5, s6] = size(right);
aspectRatioLeft = s2 / s1;
aspectRatioRight = s5 / s4;
heightScalers = 1
imageLeftHeights = screenYpixels * heightScalers;
imageLeftWidths = imageLeftHeights * aspectRatioLeft;
imageRightHeights = screenYpixels * heightScalers;
imageRightWidths = imageRightHeights * aspectRatioRight;
numImages = 1 

dstRectsLeft = zeros(4, numImages);
theRectLeft = [0 0 imageLeftWidths(1) imageLeftHeights(1)];
dstRectsLeft(:, 1) = CenterRectOnPointd(theRectLeft, screenXpixels/2 ,...
    screenYpixels/2 );

dstRectsRight = zeros(4, numImages);
theRectRight = [0 0 imageRightWidths(1) imageRightHeights(1)];
dstRectsRight(:, 1) = CenterRectOnPointd(theRectRight, screenXpixels/2 ,...
    screenYpixels/2 );
%display
Screen('SelectStereoDrawBuffer', window, 1);
Screen('DrawTexture', window, leftTexture, [], dstRectsLeft);

Screen('SelectStereoDrawBuffer', window, 0);
Screen('DrawTexture', window, rightTexture, [], dstRectsRight);

Screen('DrawingFinished', window);
Screen('Flip', window);

while true
    [~,~,keys] = KbCheck(-1);
    if keys(PARAMS.KEYS.STOP)
        % Set the PROPixx back to normal sequencer
        Datapixx('SetPropixxDlpSequenceProgram', 0);
        Datapixx('RegWrRd');

        % Done. Close the onscreen window:
        Screen('CloseAll')
        Datapixx('Close');
        sca;
        error("Manual stop.");    
    end
    
end


function DrawFormattedTextStereo(window, text, x, y, colour)
for i = 0:1
    Screen('SelectStereoDrawBuffer', window, i);
    DrawFormattedText(window, text, x, y, colour);
end

