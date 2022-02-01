library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity subtrator is
port( 
     TempoA, TempoB : in std_logic_vector (15 downto 0);
     TempoDesl:  out std_logic_vector (15 downto 0)
);
end entity;

architecture bhv of subtrator is
signal resultado : std_logic_vector (15 downto 0);
begin
process (TempoA,resultado,TempoB) is 
begin
resultado <= std_logic_vector(unsigned(TempoB)- unsigned(TempoA));
TempoDesl <= std_logic_vector(resize(unsigned(resultado), TempoDesl'length));
end process;
end bhv;