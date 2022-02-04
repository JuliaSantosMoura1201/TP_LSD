library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_divisaoVelocidade is
end tb_divisaoVelocidade;

architecture teste of tb_divisaoVelocidade is

component divisaoVelocidade is
port
  (
    divisor: in std_logic_vector(15 downto 0);
    dividendo: in std_logic_vector(15 downto 0);
    valor : out std_logic_vector (15 downto 0)
  );
end component;

signal DIVISOR, DIVIDENDO, VALOR: std_logic_vector (15 downto 0);
begin
instancia_divisaoVelocidade: divisaoVelocidade port map(divisor=>DIVISOR, dividendo=>DIVIDENDO, valor=>VALOR);
DIVISOR <= x"000A";

DIVIDENDO <= x"0001",x"0002" after 20 ns;
     
end teste;