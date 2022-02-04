library ieee;
use ieee.std_logic_1164.all;

entity subtrator_tb is
end subtrator_tb;

architecture teste of subtrator_tb is

component subtrator is
port( 
     TempoA, TempoB : in std_logic_vector (15 downto 0);
     TempoDesl:  out std_logic_vector (15 downto 0)
);
end component;

signal TEMPOA, TEMPOB, TEMPO_DESL : std_logic_vector (15 downto 0);
begin
instancia_subtrator: subtrator port map(TempoA=>TEMPOA, TempoB=>TEMPOB, TempoDesl=>TEMPO_DESL);

TEMPOA <= x"0000", x"0001" after 9ns, x"0002" after 19ns;
TEMPOB <= x"0000", x"0002" after 9ns, x"0003" after 19ns;
     
end teste;