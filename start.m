function start(handles)
    i = 2;
    windowSize = 10;
    arraySize = 2^16;
    X = zeros(arraySize, 1);

    while (1)
        if get(handles.pause_btn, 'userdata')
            % do nothing
        else
            % execute trade
        end

        X(i) = total_pnl(portfolio());

        if i <= windowSize
            plot(handles.pnl_graph, 1:i, X(1:i));
        else
            plot(handles.pnl_graph, i-windowSize:i, X(i-windowSize:i));
        end
        
        i = i+1;
   
        pause(1);

        if get(handles.stop_btn, 'userdata') % stop condition
            cla(handles.pnl_graph);
            break;
        end
    end
end