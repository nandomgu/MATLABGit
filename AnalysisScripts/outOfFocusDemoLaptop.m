%% we obtain statistics from the time averages of the brightfield image
%[med, mn, sd, mx, miin]=experimentTimeAverageOmero(d.cExperiment, 'Brightfield_3')

%% now we plot the median of each image vs the standard deviation. turns out that the standard deviation
%% shows very well the timepoints at which there was a problem with the focus.

figure; subplot(2,3,1);
plot(sd(1,:)) %% plotting standard deviation over time for the first  position
ylim([200, 600])
xlim([0, 300])
title('standard deviation of brightfield over time')
subplot(2,3,4);

im=d.cExperiment.returnTimelapse(1).returnSingleTimepointRaw(117,6);

imshow(im, [])
title('image 117')
subplot(2,3,5);

im=d.cExperiment.returnTimelapse(1).returnSingleTimepointRaw(109,6);
imshow(im, [])
title('image 109')

subplot(2,3,2)
scatter(mn(:), sd(:)); xlim([2400, 2600]), xlabel('image mean'), ylabel(['image standard deviation'])
%% point and click on the scatterplot to paint a coordinate of the scatterplot red
positiveset=[];
negativeset=[];
hp={};
j=1;


while j<20
    disp(j)
    subplot(2,3,2)
    title('PLEASE SELECT EXAMPLES OF ONE GROUP')
    
    [positiveset(j,1), positiveset(j,2),button]=ginput(1);
    if button==1
    ind=find(pdist2([mn(:) sd(:)],positiveset(j,:))==min(pdist2([mn(:) sd(:)],positiveset(j,:))));
    [I,J]=ind2sub(size(sd), ind)
    hold on; hp{j}=scatter(mn(ind),sd(ind), [],[1,0,0])
    subplot(2,3,6)
    im=d.cExperiment.returnTimelapse(I).returnSingleTimepointRaw(J,6);
    imshow(im, [])
    title('last clicked image')
    j=j+1

    else 
        if button ==3 && numel(hp)>0 && j>1 %if there is more than one entry, remove the last one and trace back
            delete(hp{j-1});
            try
            hp=hp(1:j-1)
            positiveset=positiveset(1:j-1,:);
            
            j= j-1;
            end
        end
        if button==3 && j== 1 %% if there is only one entry left, just empty the arrays
            hp=[];
            positiveset=[];
        end
            
    end
   
end

while j<20
    disp(j)
    subplot(2,3,2)
    title('NOW SELECT SAMPLES FROM THE OTHER GROUP')
    
    [positiveset(j,1), positiveset(j,2),button]=ginput(1);
    if button==1
    ind=find(pdist2([mn(:) sd(:)],positiveset(j,:))==min(pdist2([mn(:) sd(:)],positiveset(j,:))));
    [I,J]=ind2sub(size(sd), ind)
    hold on; hp{j}=scatter(mn(ind),sd(ind), [],[1,0,0])
    subplot(2,3,6)
    im=d.cExperiment.returnTimelapse(I).returnSingleTimepointRaw(J,6);
    imshow(im, [])
    title('last clicked image')
    j=j+1

    else 
        if button ==3 && numel(hp)>0 && j>1 %if there is more than one entry, remove the last one and trace back
            delete(hp{j-1});
            try
            hp=hp(1:j-1)
            positiveset=positiveset(1:j-1,:);
            
            j= j-1;
            end
        end
        if button==3 && j== 1 %% if there is only one entry left, just empty the arrays
            hp=[];
            positiveset=[];
        end
            
    end
   
end




for j=1:20
    title('NOW SELECT EXAMPLES OF OUT OF THE OTHER GROUP')
    [negativeset(j,1), negativeset(j,2),button]=ginput(1)  
    ind=find(pdist2([mn(:) sd(:)],negativeset(j,:))==min(pdist2([mn(:) sd(:)],negativeset(j,:))));
    hold on; hn(j)=scatter(mn(ind),sd(ind), [],[.8,.8,0])
end



subplot(2,3,3)
plot(histogram(sd(:), 'Normalization', 'Probability')); xlabel('Standard deviation of image'); ylabel('Probability');title('two modes in the standard deviation')



