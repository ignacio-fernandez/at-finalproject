function [p] = get_params(handles)
    p = struct( ...
        'slow', get_slider_value(handles.slow_slider), ...
        'fast', get_slider_value(handles.fast_slider), ...
        'macd', get_slider_value(handles.macd_slider), ...
        'upper', get_slider_value(handles.up_slider), ...
        'lower', get_slider_value(handles.low_slider));
end