library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DivisaoVelocidade is

	port
	(
	divisor: in std_logic_vector(15 downto 0);
	dividendo: in std_logic_vector(15 downto 0);
	valor : out std_logic_vector (15 downto 0)
	);

end entity;

architecture rtl of DivisaoVelocidade is
signal resultado : std_logic_vector (15 downto 0);
begin
resultado <= std_logic_vector(unsigned(divisor)/ unsigned(dividendo));
valor <= std_logic_vector(resize(unsigned(resultado), valor'length));
end rtl;