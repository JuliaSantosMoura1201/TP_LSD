library ieee;
use ieee.std_logic_1164.all;

entity FFD_tb is
end FFD_tb;

architecture teste of FFD_tb is

component FFD is
port( 
	D: in std_logic_vector (15 downto 0);
	registra,rst: in std_logic;
	clock: in std_logic;
	Q: out std_logic_vector (15 downto 0)
);
end component;

signal entradaD, saidaQ : std_logic_vector (15 downto 0);
signal entradaClock, entradaRst, entradaRegistra: std_logic;
begin
instancia_FFD: FFD port map(D=>entradaD, clock=>entradaClock, rst=>entradaRst, registra=>entradaRegistra, Q=>saidaQ);

entradaD <=  x"0000", x"0001" after 9ns;
entradaClock <= '1','0' after 5 ns, '1' after 10 ns, '0' after 15ns, '1' after 20 ns;
entradaRst <= '0', '0' after 10 ns;          
entradaRegistra <=  '0', '1' after 10 ns;
                    
end teste;