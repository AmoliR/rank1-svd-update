function f_value = FMM2(alpha_,lambda_,mu_,p,s,t,u,ML,MR,SL,SR,T1,T2,T3,T4)

muN = mu_;
lambdaN = lambda_;
alpha_const = alpha_';

min_range = min([muN;lambdaN]);
max_range = max([muN;lambdaN]);

%% Construct the 2d tree

%declare empty cell for root index
index_ = {}; 
% append 0 as index of parent
index_{end+1} = '0';

root = btnode([min_range,max_range,0,0],0,s,index_,p);

% insert lambda/x points on the number line
% type_ 0 = x/lambda 
for i = 1:numel(lambdaN)
    root.insert_point(point(0,lambdaN(i),0,i)); %level,point,type,position
end

% insert mu/y points on the number line
% type_ 1 = y/mu
for i = 1:numel(muN)
    root.insert_point(point(0,muN(i),1,i)); %level,point,type,position
end


%%  find data of all the nodes level wise (level-order traversal)
% Store all the nodes of the tree by level order traversal
node_array = btnode.empty();
node_count = 1;
[node_array,node_count] = root.LevelOrderTraversal(node_array,node_count);
node_count = node_count - 1;

%% find all leaf nodes 

% using traversal
leaf_nodes = btnode.empty();
[leaf_nodes,leaf_count] = root.printLeafNodes(leaf_nodes,1);
leaf_count = leaf_count - 1;


%% STEP 2 :: far-field expansion at finest level for lambda points

phi = zeros(p,length(leaf_nodes));

for i = 1:length(leaf_nodes)
    
    % only x/lambda points, type = 0
    lambda_points = findobj(leaf_nodes(i).points,'type',0);
    pt_count = length(lambda_points);
    
    % take x_0/lambda_0 as center of the interval i.e a + width/2
    lambda_zero = leaf_nodes(i).geometry.center;
    
    % take r as the radius of the interval i.e half of width
    r = leaf_nodes(i).geometry.width/2;
    
    lambda_i = zeros(pt_count,1);
    alpha_i = zeros(pt_count,1);
    % pt_count = length(leaf_nodes(i).points);
    
    for j = 1:pt_count 
        lambda_i(j) = lambda_points(j).value;
         alpha_i(j) = alpha_const(lambda_points(j).position);
    end

    phi(:,i) = farField(phi(:,i),t,r,lambda_i,lambda_zero,alpha_i);
    
    % updates far-field of child (leaf-nodes)
    leaf_nodes(i).far_field = leaf_nodes(i).far_field + phi(:,i);
end
    
 
%% STEP 3 :: from finest level move to root (bottom-up) and update far-field for all.

% updates far-field of parents based on child
root.BottomUp(ML,MR);

%% STEP 4 :: Update local expansion (top to bottom)
% Start from levels with four nodes at least, i.e. level 2(starting from 0)

% near field for root = no parent node so zero (assuming)
% for second level SL * zero vector and  SR * zero vector so both zero
% vector.
for i = 1:length(node_array)
    
    if(node_array(i).level > 1) % we need minimum four nodes
       
        interaction_list = node_array(i).interactionList();
        il_len = length(interaction_list);
        
        if(il_len ~= 0)
            far_field_ = zeros(p,il_len);
        
            for j = 1:il_len
                % far_field for three nodes 2i -3, 2i + 1/ 2i- 2, 2i + 2
                present = findobj(node_array,'level',node_array(i).level,...
                          'node_number',interaction_list(j));
                if(~isempty(present))
                    far_field_(:,j) =  present.far_field;
                end
                if(isempty(present))
                    far_field_(:,j) =  zeros(p,1);
                end
            end
        if(node_array(i).index{end} == '0') %left
        switch il_len
            
            case 1
                 node_array(i).near_field = SL * node_array(i).parent.near_field ...
                    + T1 * far_field_(:,1);
               
                
            case 2
                    node_array(i).near_field = SL * node_array(i).parent.near_field ...
                    + T3 * far_field_(:,1) + T4 * far_field_(:,2);
                
                
            case 3
                   node_array(i).near_field = SL * node_array(i).parent.near_field ...
                    + T1 * far_field_(:,1) + T3 * far_field_(:,2)...
                    + T4 * far_field_(:,3);
                
        end
        end
                
            
            if(node_array(i).index{end} == '1') %right
                switch il_len
                    
                    case 1
                    node_array(i).near_field = SR * node_array(i).parent.near_field ...
                        + T4 * far_field_(:,1);
                    
                    case 2
                    node_array(i).near_field = SR * node_array(i).parent.near_field ...
                        + T1 * far_field_(:,1) + T2 * far_field_(:,2);    
                    
                    case 3
                    node_array(i).near_field = SR * node_array(i).parent.near_field ...
                        + T1 * far_field_(:,1) + T2 * far_field_(:,2)...
                        + T4 * far_field_(:,3);    
                end
            end 
           
        end % if il_len ~=0
    end % level >1
end %for end
% TopDown = tic

%% STEP 5.1 :: Evaluate near-field for y at finest level

y_evaluate = zeros(length(muN),1);
y_direct = zeros(length(muN),1);
for i = 1:length(leaf_nodes) %interval
    
    % only y/mu points, type = 1
    mu_points = findobj(leaf_nodes(i).points,'type',1);
       
    if(~isempty(mu_points)) % interval has mu/y points
        r = leaf_nodes(i).geometry.width/2;
        mu_zero = leaf_nodes(i).geometry.center;
        
        for k = 1:length(mu_points) % mu/y point
            mu_value_k = mu_points(k).value;
            f2_yk = 0;
            for j = 1:p
                f2_yk = f2_yk + (leaf_nodes(i).near_field(j) * ...
                    (polyval(u{j},((mu_value_k - mu_zero)/r))));
            end
            y_evaluate(mu_points(k).position) = f2_yk;
        end
    end
    
    % STEP 6 :: Direct computation of interaction at leaf nodes
    
    mu_points_i = findobj(leaf_nodes(i).points,'type',1);
    % if mu/y is present in that interval i.e not empty
    if(~isempty(mu_points_i)) 
        adjacent_i = adjacentList(i,length(leaf_nodes)); 
        adj_lambda = [];
        adj_alpha = [];
        % find lambda/x in adjacent intervals
        for j = 1:length(adjacent_i)
            lambda_points_j = findobj(leaf_nodes(adjacent_i(j)).points,'type',0);
            % if adjacent intervals have lambda/x
            if(~isempty(lambda_points_j)) 
                for k = 1:length(lambda_points_j)
                    adj_lambda(end+1) = lambda_points_j(k).value;
                    adj_alpha(end+1) = alpha_const(lambda_points_j(k).position);
                end
            end
        end
        
        %current_mu = zeros(length(mu_points_i),1);
        for l = 1:length(mu_points_i)
           current_mu = mu_points_i(l).value;
            if(~isempty(adj_lambda)) % if there are lambda/x
                y_direct(mu_points_i(l).position) = direct_interaction(current_mu,adj_lambda,adj_alpha);
            else
                y_direct(mu_points_i(l).position) = 0;
            
            end
        end
    end
end % for end


%% STEP 7 :: Final summation
f_value = y_evaluate + y_direct;

% f_value_direct = direct_compute(muN,lambdaN,alpha);
% final = [f_value f_value_direct (abs(f_value) - abs(f_value_direct))]





end

