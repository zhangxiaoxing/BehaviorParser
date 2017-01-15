function [ output_args ] = zGetColor(code)
switch code
    case 'b0'
        output_args=[0,180,255]./255;
    case 'b1'
        output_args=[0,65,210]./255;
    case 'b2'
        output_args=[0,50,150]./255;
    case 'k0'
        output_args=[255 255 255]./255;
    case 'k1'
        output_args=[220 220 220]./255;
    case 'k3'
        output_args=[127 127 127]./255;
    
    case 'k4'
        output_args=[50 50 50]./255;
    case 'k5'
        output_args=[0 0 0]./255;
    case 'r0'
        output_args=[188,138,218]./255;
    
        
end
end

