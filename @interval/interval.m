classdef interval < handle
    
    properties
      a % left limit [a,b]
      b % right limit [a,b]
      width %width / length of interval
      center %center of the interval
      gfx % graphics
    end
    
    methods
        function int_obj = interval(line_segment_)
            int_obj.a = line_segment_(1);
            int_obj.b = line_segment_(2);
            int_obj.width = abs(line_segment_(2) - line_segment_(1));
            int_obj.center = int_obj.a + int_obj.width/2;
%             hold on;
%             int_obj.gfx = plot([line_segment_(1),line_segment_(2)],...
%             [line_segment_(3),line_segment_(4)],'Color','b');
%             yL = get(gca,'YLim');
%             line([line_segment_(1) line_segment_(1)],yL,'Color','b');
%             line([line_segment_(2) line_segment_(2)],yL,'Color','b');
        end
        
        function bool = point_in_interval(int_obj, point_)
            bool = (point_.value >= int_obj.a) && (point_.value <= int_obj.b);
        end
    end
    
end

