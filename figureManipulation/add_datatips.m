function hdtip = add_datatips( evt_times , hTarget )
    %// retrieve the datacursor manager
    cursorMode = datacursormode(gcf);
    set(cursorMode, 'UpdateFcn',@customDatatipFunction, 'NewDataCursorOnClick',false);

    xdata = get(hTarget,'XData') ;
    ydata = get(hTarget,'YData') ;

    %// add the datatip for each event
    for idt = 1:numel(evt_times)
        hdtip(idt) = cursorMode.createDatatip(hTarget) ;
        set(hdtip(idt), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');

        %// move it into the right place
        idx = find( xdata == evt_times(idt) ) ;%// find the index of the corresponding time
        pos = [xdata(idx) , ydata(idx) ,1 ];
        update(hdtip(idt), pos);
    end
