function PlotFaceXY_130( input_vector_260, varargin )
% Plot a shape defined as a 260-array with 130 x-coordinates followed by
% the corresponding 130 y-coordinates
%

if isempty( varargin )
    varargin = {'b'};
end

% Hard-code contour lines
j_beg = [2, 15, 27, 39, 53, 80, 84,  104, 110];
j_end = [13,26, 38, 50, 79, 83, 103, 109, 130];
is_clo = [1, 1, 1,  1,  0,  0,  1,    1,    0];

for k = 1 : length( j_beg )
    x = input_vector_260( j_beg(k) : j_end(k) );
    y = input_vector_260( 130 + j_beg(k) : 130 + j_end(k) );
    if is_clo(k)
        x = [x; x(1)];
        y = [y; y(1)];
    end
    plot( x, y, varargin{:} );
    if k == 1
        hold on;
    end
end

if length( varargin ) == 1
    if length( varargin{:} ) == 1
        plot( input_vector_260( 1:130 ), input_vector_260( 131 : 260 ),...
            [varargin{:}, '*']);
    else
        plot( input_vector_260( 1:130 ), input_vector_260( 131 : 260 ),...
            '*', varargin{:});
    end
else
    plot( input_vector_260( 1:130 ), input_vector_260( 131 : 260 ),...
        '*', varargin{:});
end
