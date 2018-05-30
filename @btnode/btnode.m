classdef btnode < handle
   % btnode A class to represent a binary tree node.
   % Link multiple btnode objects together to create binary tree.
   properties
       line_segment % line segment [-1,1,0,0] from [-1,0] to [1,0]
       capacity % maximum nodes allowed i.e 2
       level % current level at which the node is
       index % index /edge route
       node_number % starts with 0 and 2^(level) elements
       partitioned %node partitioned or not
       geometry % stores detail for interval
       point_count % number of points
       points = point.empty(1,0)% each point
       far_field
       near_field

   end
   properties(SetAccess = private)
      left = btnode.empty; %left child
      right = btnode.empty; % right child
      parent = btnode.empty; % parent (backtrack)
   end
   
   methods
      function node = btnode(line_segment_,level_,capacity_,index_,p_)
         % Construct a btnode object
         if nargin > 0
            node.line_segment = line_segment_; % line segment from (-1,0) to (1,0)
            node.level = level_;
            node.capacity = capacity_;
            node.index = index_;
            node.node_number = base2dec([node.index{:}],2);
            node.partitioned = false;
            node.geometry = interval(node.line_segment);
            node.point_count = 0;
            node.points = point.empty(1,0);% each point
            node.far_field = zeros(p_,1); %far-field vector initially zero
            node.near_field = zeros(p_,1); %near-field vector initially zero
            %node.far_field = {}; %far-field vector initially empty
            %node.near_field = {}; %near-field vector initially empty
            
         end
      end
            
      function bool = insert_point(node, point_)
          bool = false;
         if(node.geometry.point_in_interval(point_))
             if(node.point_count < node.capacity) % if the max points limit is not excedeed
                    % then insert the point in the point array of the given
                    % object with the index incremented initial index is 0
                   node.points(node.point_count+1) = point_; 
                    bool = true;
                    node.point_count = node.point_count+1; % increase the point count
             else % if the number of points per node exceeds threshold then do following
                    if(~node.partitioned) % if the object is not partitioned yet then
                        %call the partition quad function
                        node.partitioned = node.partition_interval();
                    end
                    
                    if(node.partitioned)% if the object is partioned then 
                        %
                        bool = node.push_down_point(point_);
                    end
             end
         end
         
      end
      
     
      function bool = partition_interval(node)
           sub_interval = node.geometry; % assign geometry object of object to sub interval
           ind = node.index;
                ind{end+1} = '0';
                sub_linesegment = [sub_interval.a, sub_interval.a + sub_interval.width/2,0,0];
                node.left = btnode(sub_linesegment, node.level+1, node.capacity,ind,length(node.far_field));
                node.left.parent = node;
                
                
                ind = node.index;
                ind{end+1} = '1';
                sub_linesegment = [sub_interval.a + sub_interval.width/2,sub_interval.b,0,0];
                node.right = btnode(sub_linesegment, node.level+1, node.capacity,ind,length(node.far_field));
                node.right.parent = node;
                
                
                for i=1:length(node.points) % 1 to length of point inserted(2)
                    bool = node.push_down_point(node.points(i)); %first x then y
                    if(~bool)
                        error('something is not right');
                    end
                end
      end
        %% this function inserts point into the interval
        
        function bool = push_down_point(node, point_)
        % adding for all the interval(2) if the bool is false for a
        % interval. The bool will be false because it will not 
        % enter the point_in_interval function.
            bool = false;
            bool = node.left.insert_point(point(node.left.level, point_.value, point_.type, point_.position));
            if(bool) % break when the intended quadrant is found.
                return;
            end
            bool = node.right.insert_point(point(node.right.level,point_.value, point_.type, point_.position));
            if(bool) % break when the intended quadrant is found.
                return;
            end
       
        end
       
        %% find height of the tree
        function h = height(node)
            if(isempty(node))
                h = 0;
            else
    
                %/* compute the height of each subtree */
                lheight = height(node.left);
                rheight = height(node.right);
 
                %/* use the larger one */
                if (lheight > rheight)
                    h = lheight+1;
                else
                    h = rheight+1;
                end
            end
        end
        
      %% function to print level order traversal of tree
      function [node_arry, node_count] = LevelOrderTraversal(root, node_arry, node_count)
        h = height(root);
        for i=1:h
            [node_arry, node_count] = printVisitedLevel(root, i, node_arry, node_count);
        end
      end
      %% print given level
      function [node_arry, node_count] = printVisitedLevel(root ,level_, node_arry, node_count)
        if(isempty(root))
            return;
        end
        if (level_ == 1)
            %disp(strcat('Visited___ ',[root.index{:}]));
            [node_arry, node_count] = storenode(root, node_arry, node_count);
        elseif (level_ > 1)
            [node_arry, node_count] = printVisitedLevel(root.left, level_-1, node_arry, node_count);
            [node_arry, node_count] = printVisitedLevel(root.right, level_-1, node_arry, node_count);
        end
      end
      
      %% find leaf nodes
      function [leaf, leaf_count] = printLeafNodes(root,leaf,leaf_count) 
          if(isempty(root)) 
              return; 
          end
          
          if(isempty(root.left) && isempty(root.right)) 
              %disp(strcat('LeafNode___ ',[root.index{:}]))
              [leaf, leaf_count] = storenode(root,leaf,leaf_count);
         end
            [leaf, leaf_count] = printLeafNodes(root.left,leaf,leaf_count);
            [leaf, leaf_count] = printLeafNodes(root.right,leaf,leaf_count); 
             
      end
     
      
      %% store leaf nodes and count in an array
      function [leaf, leaf_count] =  storenode(root,leaf,leaf_count)
        leaf(leaf_count) = root;
        leaf_count = leaf_count + 1;    
      end
      
      %% far filed bottom up approach  (post order traversal)
     function BottomUp(root,ML,MR)

        if(isempty(root))
            return;
        end
        % first recurse on left subtree
        BottomUp(root.left,ML,MR);
 
        % then recurse on right subtree
        BottomUp(root.right,ML,MR);
 
        % now deal with the node
        % disp(strcat('Node___ ',[root.index{:}]))
        if(~isempty(root.parent))
            if(root.index{end} == '0') %left
                root.parent.far_field = root.parent.far_field + ...
                                        (ML * root.far_field) ;
            end
            if(root.index{end} == '1') %right
                root.parent.far_field = root.parent.far_field + ...
                                        (MR * root.far_field) ;
            end
        end
     end
     
    %% find interaction list of the node 
    function interactionList = interactionList(node)
        node_number_ = node.node_number;
        % because we start node count with zero so shiftin (0 to 1)
        node_number_ = node_number_ + 1; 
        parent_index = ceil(node_number_/2);
        parent_adjacent_index = max(parent_index - 1,1):min(parent_index + 1,2^(node.level -1));
        adjacent_index = (2 * parent_adjacent_index(1) - 1):(2 * parent_adjacent_index(end));
        interactionList = adjacent_index(adjacent_index < node_number_ - 1  | adjacent_index > node_number_ + 1);
        % because we start node count with zero so shifting back ( 1 to 0)
        interactionList = interactionList - 1; 
    end 
    
    
    %% CHANGES DONE TO REDUCE TIME OF THE PROCESS
    
    %% Alternative Data Matrix Creation
    function [data_mat_, node_count] = findAllNodes(root, data_mat_, node_count,p_)
        h = height(root);
        for i=1:h % height = level + 1, so height = 1 means 2nd level i.e level 1
            [data_mat_, node_count] = printAllNodes(root, i, data_mat_, node_count,p_);
        end
    end
      %% Print all nodes
      function [data_mat_, node_count] = printAllNodes(root ,level_, data_mat_, node_count,p_)
        if(isempty(root))
            return;
        end
        if (level_ == 1)
            %disp(strcat('Visited___ ',[root.index{:}]));
            [data_mat_, node_count] = storematrix(root, data_mat_, node_count,p_);
        elseif (level_ > 1)
            [data_mat_, node_count] = printAllNodes(root.left, level_-1, data_mat_, node_count,p_);
            [data_mat_, node_count] = printAllNodes(root.right, level_-1, data_mat_, node_count,p_);
        end
      end
      %% store matrix
      function [data_mat_, node_count] =  storematrix(root,data_mat_,node_count,p_)
          
        data_mat_{node_count,1} = root.node_number; % #1 node_number
        data_mat_{node_count,2} = root.level; % #2 level
        data_mat_{node_count,3} = zeros(p_,1); % #3 far_field
        data_mat_{node_count,4} = zeros(p_,1); % #4 near field
        data_mat_{node_count,5} = ~root.partitioned; % #5 leaf_node or not
       
        if(data_mat_{node_count,5} == 1) %leaf node
            data_mat_{node_count,6} = root.geometry.center; % #6 center of the interval
            data_mat_{node_count,7} = root.geometry.width/2;% #7 radius of interval
            
            if(~isempty(root.points)) % if it contains point
            x_pt = [];
            y_pt = [];
                for i = 1:length(root.points)
                    if(root.points(i).type == 0) %type 0/x/lambda
                        x_pt(end+1) = root.points(i).value;
                    else %type 1 /y/mu
                        y_pt(end+1) = root.points(i).value;
                    end
                end
                data_mat_{node_count,8} = x_pt; % #8 x points
                data_mat_{node_count,9} = y_pt; % #9 y points
            end
        end
        if(~isempty(root.parent))
            data_mat_{node_count,10} = root.parent.node_number; % #10 parent node_number
        else 
            data_mat_{node_count,10} = -1;
        end
        %data_mat_{node_count,11} = zeros(p_,1); % #11 parent's far-field
        %data_mat_{node_count,12} = zeros(p_,1); % #12 parent's near-field
        node_count = node_count + 1; 
       
      end
      
   end %end methods
      
      
end%class def end


