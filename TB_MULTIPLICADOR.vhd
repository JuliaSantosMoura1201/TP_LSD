library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_MULTIPLICADOR is
end TB_MULTIPLICADOR;

architecture test of TB_MULTIPLICADOR is

component MULTIPLICADOR is
port (
	PORCENTAGEM: in std_logic_vector(15 downto 0);
	MULTA : out std_logic_vector(31 downto 0)
);
end component;

signal porcentagem: std_logic_vector(15 downto 0);
signal multa: std_logic_vector(31 downto 0);

begin

	INSTANCIA_MULTIPLICADOR: MULTIPLICADOR port map( PORCENTAGEM => porcentagem, MULTA => multa);
	porcentagem <= x"0082", x"00C8" after 50ns,  x"00E6" after 100ns;
end test;