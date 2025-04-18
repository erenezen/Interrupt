----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2019 16:28:44
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clk : in STD_LOGIC;
           in_port : in STD_LOGIC_VECTOR (7 downto 0);
           port_id : out STD_LOGIC_VECTOR (7 downto 0)
          );
end top;

architecture Behavioral of top is

component kcpsm6 is
  generic(                 hwbuild : std_logic_vector(7 downto 0) := X"00";
                  interrupt_vector : std_logic_vector(11 downto 0) := X"FFF";
           scratch_pad_memory_size : integer := 64);
  port (                   address : out std_logic_vector(11 downto 0);
                       instruction : in std_logic_vector(17 downto 0);
                       bram_enable : out std_logic;
                           in_port : in std_logic_vector(7 downto 0);
                          out_port : out std_logic_vector(7 downto 0);
                           port_id : out std_logic_vector(7 downto 0);
                      write_strobe : out std_logic;
                    k_write_strobe : out std_logic;
                       read_strobe : out std_logic;
                         interrupt : in std_logic;
                     interrupt_ack : out std_logic;
                             sleep : in std_logic;
                             reset : in std_logic;
                               clk : in std_logic);
  end component kcpsm6;

component BRAM0 is
    Port (      address : in std_logic_vector(11 downto 0);
            instruction : out std_logic_vector(17 downto 0);
                 enable : in std_logic;
                    clk : in std_logic);
end component BRAM0;

signal address :  std_logic_vector(11 downto 0);
signal instruction :  std_logic_vector(17 downto 0);
signal bram_enable :  std_logic;
signal write_strobe :  std_logic;
signal k_write_strobe :  std_logic;
signal read_strobe :  std_logic;
signal interrupt_ack :  std_logic;
signal out_port : STD_LOGIC_VECTOR (7 downto 0);
begin

picoblaze: kcpsm6 
generic map(
                          hwbuild => X"00",
                 interrupt_vector => X"FFF",
          scratch_pad_memory_size => 64       )
port map(
                           address => address,
                       instruction => instruction,
                       bram_enable => bram_enable,
                           in_port => in_port,
                          out_port => out_port,
                           port_id => port_id,
                      write_strobe => write_strobe,
                    k_write_strobe => k_write_strobe,
                       read_strobe => read_strobe,
                         interrupt => out_port(7),
                     interrupt_ack => interrupt_ack,
                             sleep => '0',
                             reset => '0',
                               clk => clk
);

inst_mem: BRAM0
port map(
                address => address,
            instruction => instruction,
                 enable => bram_enable,
                    clk => clk
                     );

end Behavioral;
