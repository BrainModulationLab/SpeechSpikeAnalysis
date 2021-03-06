% Play audio responses

%% Mark Response Times
%=======================================
TrialNum = 120;

EventTimes1 = [EventTimes EventTimes(end)+2];
ITI = 1; %length of ITI in sec

figure;
for trial=1:TrialNum
    StimulusEvent1 = SkipEvents + 4*trial;
    StimulusEvent2 = SkipEvents + 4*trial + 1;
    
    AudioTrials{trial} = Audio(round(30000*(EventTimes1(StimulusEvent1)-1)): ...
        round(30000*EventTimes1(StimulusEvent2)));
    
    AudioTrials{trial} = 2*(AudioTrials{trial} - mean(AudioTrials{trial}))/ ...
        (max(AudioTrials{trial}) - min(AudioTrials{trial}));
    
    thisAudioenv = AudioEnv(round(30000*(EventTimes1(StimulusEvent1)-1)): ...
        round(30000*EventTimes1(StimulusEvent2)));
    
    taud = (1:length(AudioTrials{trial}))-1;
    taud = taud/30000 - ITI;
    hold off
    plot(taud, AudioTrials{trial})
    hold on; plot(taud, thisAudioenv/100)
    hold on; text(.25, 0.75*max(AudioTrials{trial}), [num2str(trial), ': ', L{wl}{trial}], 'FontSize', 20);
    ah = gca;
    plot([0, 0], ah.YLim, 'k'); 
    xlabel('Time (sec)'); xlim([-ITI, Inf]);
    AudioStart{trial} = 1;
    button=1;
    while button == 1
        player = audioplayer(AudioTrials{trial}(AudioStart{trial}:end), 30000); play(player);
        [x,~,button] = ginput(1);
        if button == 1
            %AudioStart{trial} = round(x);
            hold on; plot(AudioStart{trial}*[1 1], ylim, 'g')
        elseif button == 32
            %AudioStart{trial} = [];
            hold on; text(30000,100,'NO RESPONSE');
        end
    end
end
