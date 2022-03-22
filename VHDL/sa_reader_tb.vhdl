library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sa_reader_tb is
end sa_reader_tb;

architecture behavior of sa_reader_tb is
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
	
	component fifo is -- first-in first-out (parallel-in parallel-out)
		generic(dataSize:integer:=8;addressSize:integer:=8);
        port(
            rdata: out std_logic_vector(dataSize-1 downto 0);
            wfull: out std_logic;
            rempty: out std_logic;
            wdata: in std_logic_vector(dataSize-1 downto 0);
            winc, wclk, wrst_n: in std_logic;
            rinc, rclk, rrst_n: in std_logic
    );
	end component fifo;
	
	constant systolicArraySize : integer := 8;
	constant bitSize : integer := 8;
	constant counterSize : integer := 8;
	
	signal readMatrixToFifo : std_logic;															-- control signal if this devics should work (='1')
	signal readMatrix : std_2d_vector_array(0 to systolicArraySize-1, 0 to systolicArraySize-1);	-- 2D data input (of: std_logic_vector(bitSize-1 downto 0) )
	signal wFullFIFO : std_logic;
	signal wDataToFIFO : std_logic_vector(bitSize-1 downto 0);
	signal wClkFIFO, wIncFIFO, wRstFIFO, rIncFIFO, rClkFIFO, rRstFIFO: std_logic;
	signal finished : std_logic;
	
	signal bufferFillMatrix : std_logic_vector(bitSize-1 downto 0);
	
	signal readFromFIFO : std_logic_vector(bitSize-1 downto 0);
	signal readFIFOempty: std_logic;
	
	signal c : integer := 1;
	
begin
	sa_reader1 : sa_reader generic map(systolicArraySize, 8, 8) port map(readMatrixToFifo, readMatrix, wFullFIFO, wDataToFIFO, wClkFIFO, wIncFIFO, wRstFIFO, finished);
	fifo1 : fifo generic map(bitSize, counterSize) port map(readFromFIFO, wFullFIFO, readFIFOempty, wDataToFIFO, wIncFIFO, wClkFIFO, wRstFIFO, rIncFIFO, rClkFIFO, rRstFIFO);
	
	process begin
		-- fill 2D Data
		for j in 0 to systolicArraySize-1 loop
			for i in 0 to systolicArraySize-1 loop
				bufferFillMatrix <= std_logic_vector(to_unsigned(c, bitSize));
				wait for 1 ns;
				readMatrix(i, j) <= bufferFillMatrix;	-- to the correct filling in gtkwave
				wait for 1 ns;
				c <= c+1;
				wait for 1 ns;
			end loop;
		end loop;
		
		
		
		-- write 2D Data to fifo
		readMatrixToFifo <= '1';
		wait until finished = '1';
		readMatrixToFifo <= '0';
		
		wait for 50 ns;
		
		
		
		--initialize
		rIncFIFO <= '0';
		wait for 1 ns;
		rRstFIFO <= '0';	-- reset on next clk
		wait for 1 ns;
		rClkFIFO <= '0';
		wait for 1 ns;
		rClkFIFO <= '1';
		wait for 1 ns;
		rRstFIFO <= '1';	-- do not reset anymore
		wait for 1 ns;
		rIncFIFO <= '1';	-- increment read pointer by clock
		wait for 1 ns;
		
		--read out FIFO
		for i in 0 to systolicArraySize*systolicArraySize + 1 loop
			rClkFIFO <= '0';
			wait for 1 ns;
			-- read out of fifo is parallel; watch: "readFromFIFO" for data
			rClkFIFO <= '1';
			wait for 1 ns;
		end loop;
		
		wait for 50 ns;
		
		wait;
	end process;
end behavior;
