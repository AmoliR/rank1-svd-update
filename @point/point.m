classdef point < handle
    %POINT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        value
        type
        position
        gfx % graphics
    end
    
    methods
        function pt_obj = point(level_,point_,type_,position_)
            pt_obj.value = point_;
            pt_obj.type = type_; % 0 = x/lambda and 1 = y/mu
            pt_obj.position = position_; % position of the eigenvalue
%             C = {'c','g','y','r','m','k',[.8 .2 .6],'w'};
%             hold on;
%             pt_obj.gfx = scatter(pt_obj.value,0,C{level_+1},'filled');
            
%             pt_obj.gfx = plot([line_segment_(1),line_segment_(2)],...
%             [line_segment_(3),line_segment_(4)],pt_obj.value,0, 'bo-',...
%             'MarkerFaceColor', 'b');
        end
    end
    
end

