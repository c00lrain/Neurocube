function [ DRAM ] = DRAM_construct( DRAM_type )
%% Constructor for DRAM depending on a given architecture


DRAM_size = 2^30;       % virtual size of DRAM (1GB) per channel

% can add any DRAM_type by setting up the corresponding access latency
if strcmp(DRAM_type, 'DDR3')
    num_channels    = 2;
    page_size       = 2^10;    % 1KB page (column size)
    word_size       = 2^2;     % 4B (equivalent to data bus-width)
    MAX_words       = DRAM_size/word_size;
    num_cols        = page_size/word_size;
    lat_access      = 20;      % DDR3-1600J: t_CAS (10) + t_RCD (10)
else
    error('DRAM TYPE NOT RECOGNIZED!');
end




% define fields required for DRAM struct
field1      = 't_access';   % DRAM access latency (in clock cycles)
field2      = 'data';       % DRAM data (READ or WRITE)
field3      = 'busy';       % 2: WRITE, 1: READ, 0: available for READ/WRITE

for idx = 1:num_channels
    value1{1,idx}   = lat_access;
    value2{1,idx}   = zeros(1,4);      % [src, dst, gen_time, packetID]; this is generated by internal packet generator (MEM_CENTRIC)
    value3{1,idx}   = 0;
end

DRAM = struct(field1,value1, field2,value2, field3,value3);

end
