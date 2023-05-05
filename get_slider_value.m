function [s] = get_slider_value(slider)
    s = round(get(slider, 'Value'));
end
