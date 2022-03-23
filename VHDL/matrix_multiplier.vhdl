library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity matrix_multiplier is
	generic (
		systolicArraySize : integer := 8;
		bitSize : integer := 8;
		dataSize : integer := 8;
		counterSize : integer := 8;
		addressSize : integer := 8
		
		-- ?
	);
	port (
		-- controller ports
		
		top_fifo_w_full : out std_logic;
		top_fifo_data_in : in std_logic_vector(dataSize-1 downto 0);
		top_fifo_w_inc, top_fifo_w_clk, top_fifo_w_rst : in std_logic;
		
		left_fifo_w_full : out std_logic;
		left_fifo_data_in : in std_logic_vector(dataSize-1 downto 0);
		left_fifo_w_inc, left_fifo_w_clk, left_fifo_w_rst : in std_logic;
		
		result_fifo_data_out : out std_logic_vector(dataSize-1 downto 0);
		result_fifo_r_empty : out std_logic;
		result_fifo_r_inc, result_fifo_r_clk, result_fifo_r_rst : in std_logic
		
		-- ?
	);
end matrix_multiplier;

architecture behavior of matrix_multiplier is
	component controller is
		-- ?
	end component controller;
	
	component fifo is generic(dataSize:integer:=8;addressSize:integer:=8);
		port(
			rdata: out std_logic_vector(dataSize-1 downto 0);   --Bitvector to be read
			wfull: out std_logic;                               --Bitvector to be written
			rempty: out std_logic;                              --Active High when FiFo empty
			wdata: in std_logic_vector(dataSize-1 downto 0);    --Active high when FiFo fill
			winc, wclk, wrst_n: in std_logic;                   --winc: increments pointer to writeaddress when clock goes high, wclk: clock-signal for writing operations, wrst_n: resets writepointer active LOW
			rinc, rclk, rrst_n: in std_logic                    --rinc: increments pointer to readaddress when clock goes high, rclk: clock-signal for reading operations, rrst_n: resets readpointer active LOW
		);
	end component fifo;
	
	component sa_filler is
		generic (
			systolicArraySize : integer := 8;                           --Maximum size of systolic array
			bitSize : integer := 8;                                     --Bitvectorsize of values from FiFo
			counterSize : integer := 24                                 --Size of counter for comparision 
		);
		port (
			numVals : in std_logic_vector ((counterSize-1) downto 0);   --Size of matrix to be multiplied (can be smaller than maximum systolic array size)
			clk : in std_logic;                                         --Clock
			r_bar_w : in std_logic;                                     --Active HIGH read and active LOW write (write to stacks and read out values from the stacks)
			rst : in std_logic;                                         --Active HIGH reset, resets all counters and stacks
			fifoOut : in std_logic_vector((bitSize-1) downto 0);        --Inputvector from FiFo
			rinc : out std_logic;                                       --Indicates that the next value can be read
			rdy : out std_logic;                                        --Active HIGH when last row is fully filled
			saIn : out std_1d_vector_array(0 to systolicArraySize-1)    --Outputvector to systolic array
		);
	end component sa_filler;
	
	component sa_reader is
		generic (
			systolicArraySize:integer := 8;	-- for setting the size of the calculation matrix
			bitSize:integer := 8;			-- fixed to 8 for this project
			counterSize : integer := 8		-- how large is the matrix that was calculated
		);    
		port (
			readMatrixToFifo : in std_logic;															-- control signal if this devics should work (='1')
			readMatrix : in std_2d_vector_array(0 to systolicArraySize-1, 0 to systolicArraySize-1);	-- 2D data input (of: std_logic_vector(bitSize-1 downto 0) )
			wFullFIFO : in std_logic;
			wDataToFIFO : out std_logic_vector(bitSize-1 downto 0);
			wClkFIFO, wIncFIFO, wRstFIFO : out std_logic;
			finished : out std_logic	-- reqired: "readMatrixToFifo <= '1'; wait until finished = '1'; readMatrixToFifo <= '0';"
		);
	end component sa_reader;
	
	component sa is	-- systolic array
		generic (
			systolicArraySize:integer := 8;                                             -- for setting the size of the calculation matrix
			bitSize:integer := 8                                                        -- fixed to 8 for this project
		);    
		port (
			upperInputVectors : in std_1d_vector_array(0 to systolicArraySize-1);		-- input 1: (top)	1-dimensional array of: 8-bit signed (2k) data
				leftInputVectors : in std_1d_vector_array(0 to systolicArraySize-1);		-- input 2: (left)	1-dimensional array of: 8-bit signed (2k) data
				clk : in std_logic;                                                         				-- clock
				reset : in std_logic;                                                       				-- reset (each cell (-> d) to "00000000")
				outMatrix : out std_2d_vector_array(0 to systolicArraySize-1, 0 to systolicArraySize-1)  		 -- output: (back)	2-dimensional array of: 8-bit signed (2k) data
		);
	end component sa;
	
	-- controller signals
	
	signal sa_clk, sa_rst : std_logic;
	signal sa_in_top, sa_in_left : std_1d_vector_array(0 to systolicArraySize-1);
	signal sa_out : std_2d_vector_array(0 to systolicArraySize-1, 0 to systolicArraySize-1);
	
	signal reader_doYourJob, reader_finished : std_logic;
	
	signal result_fifo_data_in : std_logic_vector(dataSize-1 downto 0);
	signal result_fifo_w_full, result_fifo_w_inc, result_fifo_w_clk, result_fifo_w_rst : std_logic;
	
	-- sa_filler signals
	
	signal top_fifo_data_out : std_logic_vector(dataSize-1 downto 0);
	signal top_fifo_r_empty, top_fifo_r_inc, top_fifo_r_clk, top_fifo_r_rst : std_logic;
	
	signal left_fifo_data_out : std_logic_vector(dataSize-1 downto 0);
	signal left_fifo_r_empty, left_fifo_r_inc, left_fifo_r_clk, left_fifo_r_rst : std_logic;
	
	-- ?
	
begin
	--control : controller generic map () port map ();
	
	systolic_array : sa generic map (systolicArraySize, bitSize) port map (sa_in_top, sa_in_left, sa_clk, sa_rst, sa_out);
	
	--top_filler : sa_filler generic map (systolicArraySize, bitSize, counterSize) port map ();
	
	--left_filler : sa_filler generic map (systolicArraySize, bitSize, counterSize) port map ();
	
	array_reader : sa_reader generic map (systolicArraySize, bitSize, counterSize) port map (reader_doYourJob, sa_out, result_fifo_w_full, result_fifo_data_in, result_fifo_w_clk, result_fifo_w_inc, result_fifo_w_rst, reader_finished);
	
	top_fifo : fifo generic map (dataSize, addressSize) port map (top_fifo_data_out, top_fifo_w_full, top_fifo_r_empty, top_fifo_data_in, top_fifo_w_inc, top_fifo_w_clk, top_fifo_w_rst, top_fifo_r_inc, top_fifo_r_clk, top_fifo_r_rst);
	
	left_fifo : fifo generic map (dataSize, addressSize) port map (left_fifo_data_out, left_fifo_w_full, left_fifo_r_empty, left_fifo_data_in, left_fifo_w_inc, left_fifo_w_clk, left_fifo_w_rst, left_fifo_r_inc, left_fifo_r_clk, left_fifo_r_rst);
	
	result_fifo : fifo generic map (dataSize, addressSize) port map (result_fifo_data_out, result_fifo_w_full, result_fifo_r_empty, result_fifo_data_in, result_fifo_w_inc, result_fifo_w_clk, result_fifo_w_rst, result_fifo_r_inc, result_fifo_r_clk, result_fifo_r_rst);
	
	-- ?
	
end behavior;
