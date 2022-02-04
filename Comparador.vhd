library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity COMPARADOR is 
	port (
				PORCENTAGEM_VELOCIDADE : in std_logic_vector(15 downto 0);
				PORCENTAGEM: in std_logic_vector(15 downto 0);
				MENOR_IGUAL: out std_logic );
end COMPARADOR;

architecture BEHAVIOR of COMPARADOR is

begin
	MENOR_IGUAL <= '1' when ((signed(PORCENTAGEM_VELOCIDADE) < signed(PORCENTAGEM)) or ( signed(PORCENTAGEM_VELOCIDADE) = signed(PORCENTAGEM))) else '0';
end BEHAVIOR;
	