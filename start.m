function start(handles)
    i = 2;
    windowSize = 20;
    arraySize = 2^16;
    X = zeros(arraySize, 1);

    while (1)
        if get(handles.stop_btn, 'userdata') % stop condition
            cla(handles.pnl_graph);
            break;
        end

        if get(handles.pause_btn, 'userdata')
            % do nothing
        else
            % execute trade
        end
        
        p = portfolio();
        curr_pnl = total_pnl(p);
        set(handles.portfolio_table, 'Data', p);
        set(handles.total_pnl_text, 'String', curr_pnl);
        X(i) = curr_pnl;

        if i <= windowSize
            plot(handles.pnl_graph, 0:i-1, X(1:i));
        else
            plot(handles.pnl_graph, i-windowSize:i, X(i-windowSize:i));
        end
        
        i = i+1;
   
        pause(5);
    end
end