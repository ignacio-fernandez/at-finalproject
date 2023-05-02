function start(handles)
    i = 2;
    maxSize = 10;
    X = 0;
    % X initialized arbitrarily for testing
    % Will need to be replaced with PnL data
    while (1)
        if get(handles.pause_btn, 'userdata')
            X(i) = X(i-1);
        else
            X(i) = rand;
        end

        if i <= maxSize
            plot(1:i, X);
        else
            plot(i-maxSize:i, X(end-maxSize:end));
        end
        
        i = i+1;
   
        pause(1);

        if get(handles.stop_btn, 'userdata') % stop condition
            break;
        end
    end
end