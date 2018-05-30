function list = adjacentList(i,n) % node number and total leaf nodes

if(n == 1) % only leaf node
    list = i;

else % not the only leaf node
    if(i == 1) % first node 
        list = [i,i+1];
    end
    if(i == n) %last node and 
        list = [i-1,i];
    end
    if(i>1 && i<n) % intermediate nodes
        list = [i-1,i,i+1];
    end
end

end