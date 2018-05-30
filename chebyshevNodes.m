function t = chebyshevNodes(order)
angle = ( ( 2 * order - 1 ) : -2 : 1 ) * pi / ( 2 * order );
angle = angle';
t = cos(angle); % from polynomial order = order to 1
t = flipud(t); % from polynomial order = 1 to order
return
end