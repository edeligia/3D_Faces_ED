function test_images
Screen('Preference', 'SkipSyncTests', 0);
%% params

KbName('UnifyKeyNames');
PARAMS.KEYS.STOP = KbName('Escape');
PARAMS.KEYS.NEXT = KbName('Space');
PARAMS.KEYS.BACK = KbName('BackSpace');
fprintf('\n----------------------------------------------\n (%s) advances to second set of images and (%s) errors out...\n----------------------------------------------\n\n', PARAMS.KEYS.NEXT, PARAMS.KEYS.STOP);


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

right_1 = imread('M.png');
left_1 = imread ('N.png');
right_2 = imread('P.png');
left_2 = imread ('F.png');
cover_left = imread('Cover_L.png');
cover_right = imread('Cover_R.png');
question = imread('Question.png');

% both = imread('IMG_1202-Proper_LR_Cropped_JPEG.jpg');
% h = floor(size(both, 2) / 2);
% left = both(:,h+1:end,:);
% right = both(:,1:h,:);

%Prepare to display single cover left eye image
leftTexture = Screen('MakeTexture', window, cover_left);
rightTexture = Screen('MakeTexture', window, cover_left);

[s1, s2, s3] = size(cover_left);
[s4, s5, s6] = size(cover_left);
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

%display cover left eye
Screen('SelectStereoDrawBuffer', window, 1);
Screen('DrawTexture', window, leftTexture, [], dstRectsLeft);

Screen('SelectStereoDrawBuffer', window, 0);
Screen('DrawTexture', window, rightTexture, [], dstRectsRight);

Screen('DrawingFinished', window);
Screen('Flip', window);

WaitSecs(5);

%Prepare to display letter images
leftTexture = Screen('MakeTexture', window, left_1);
rightTexture = Screen('MakeTexture', window, right_1);

[s1, s2, s3] = size(left_1);
[s4, s5, s6] = size(right_1);
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

%display first round of letter images 
Screen('SelectStereoDrawBuffer', window, 1);
Screen('DrawTexture', window, leftTexture, [], dstRectsLeft);

Screen('SelectStereoDrawBuffer', window, 0);
Screen('DrawTexture', window, rightTexture, [], dstRectsRight);

Screen('DrawingFinished', window);
Screen('Flip', window);

WaitSecs(2);

%Prepare to display single cover left eye image
leftTexture = Screen('MakeTexture', window, question);
rightTexture = Screen('MakeTexture', window, question);

[s1, s2, s3] = size(question);
[s4, s5, s6] = size(question);
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

%display question
Screen('SelectStereoDrawBuffer', window, 1);
Screen('DrawTexture', window, leftTexture, [], dstRectsLeft);

Screen('SelectStereoDrawBuffer', window, 0);
Screen('DrawTexture', window, rightTexture, [], dstRectsRight);

Screen('DrawingFinished', window);
Screen('Flip', window);

WaitSecs(5);

fprintf('\n--------\nCorrect answer is M\n-------------\n');

fprintf('\n----------------------------------------------\nWaiting for next key (%s) to display next round of images or stop key (%s) to error out...\n----------------------------------------------\n\n', PARAMS.KEYS.NEXT, PARAMS.KEYS.STOP);
while 1
    [~,keys] = KbWait(-1);
    if any(keys(PARAMS.KEYS.NEXT))
        break;
    else any(keys(PARAMS.KEYS.STOP))
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

%Prepare to display single cover right eye image
leftTexture = Screen('MakeTexture', window, cover_right);
rightTexture = Screen('MakeTexture', window, cover_right);

[s1, s2, s3] = size(cover_right);
[s4, s5, s6] = size(cover_right);
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

%display cover right eye
Screen('SelectStereoDrawBuffer', window, 1);
Screen('DrawTexture', window, leftTexture, [], dstRectsLeft);

Screen('SelectStereoDrawBuffer', window, 0);
Screen('DrawTexture', window, rightTexture, [], dstRectsRight);

Screen('DrawingFinished', window);
Screen('Flip', window);

WaitSecs(5);

%Prepare to display letter images
leftTexture = Screen('MakeTexture', window, left_2);
rightTexture = Screen('MakeTexture', window, right_2);

[s1, s2, s3] = size(left_2);
[s4, s5, s6] = size(right_2);
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

%display first round of letter images 
Screen('SelectStereoDrawBuffer', window, 1);
Screen('DrawTexture', window, leftTexture, [], dstRectsLeft);

Screen('SelectStereoDrawBuffer', window, 0);
Screen('DrawTexture', window, rightTexture, [], dstRectsRight);

Screen('DrawingFinished', window);
Screen('Flip', window);

WaitSecs(2);

%Prepare to display question image
leftTexture = Screen('MakeTexture', window, question);
rightTexture = Screen('MakeTexture', window, question);

[s1, s2, s3] = size(question);
[s4, s5, s6] = size(question);
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

%display question
Screen('SelectStereoDrawBuffer', window, 1);
Screen('DrawTexture', window, leftTexture, [], dstRectsLeft);

Screen('SelectStereoDrawBuffer', window, 0);
Screen('DrawTexture', window, rightTexture, [], dstRectsRight);

Screen('DrawingFinished', window);
Screen('Flip', window);

WaitSecs(5);

fprintf('\n--------\nCorrect answer is F\n-------------\n');

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

