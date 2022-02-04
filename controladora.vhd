library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;
use ieee.numeric_bit.rising_edge;

entity controladora is
port(
	bit_a: in std_logic;
	bit_b: in std_logic;
	bit_v: in std_logic;
	clk: in std_logic;
	clr: in std_logic;
	led_verde: out std_logic;
	led_vermelho: out std_logic;
	led_amarelo: out std_logic;
	
	-- Sinais do/para o caminho de dados
	
	c_01: in std_logic;
	c_03: in std_logic;
	reset: in std_logic;
	sr_a: out std_logic;
	sr_b: out std_logic;
	sr_v: out std_logic;
	sr_vc: out std_logic;
	sr_m: out std_logic;
	set_mux: out std_logic;
	set_count: out std_logic;
	clear: out std_logic
);
end entity;

architecture arch of controladora is
	type state is(
		inicio,
		espera_tempo_b,
		verifica_velocidade,
		reporta_problema,
		compara_velocidade,
		sem_multa,
		calcula_multa,
		multa_maxima,
		notifica_multa,
		exibe_velocidade,
		intermediario_inicio,
		intermediario_espera_tempo_b,
		intermediario_verifica_velocidade,
		intermediario_notifica_multa,
		intermediario_exibe_velocidade
	);

	-- estado_atual e proximo_estado recebe o tipo estado 
	signal estado_atual, proximo_estado: state;

	begin
	-- máquina de estados finitos 
	sequencial: process(clk, reset)
		begin
			if( clr = '1') then
				estado_atual <= inicio;
			elsif(reset = '1') then
				estado_atual <= reporta_problema;
			elsif(rising_edge(clk)) then
				estado_atual <= proximo_estado;
			end if;
	end process;

	combinacional: process(bit_a, bit_b, bit_v, c_01, c_03, estado_atual)
	begin
		
		case estado_atual is
			when inicio =>
				led_verde <= '0';
				led_vermelho <= '0';
				led_amarelo <= '0';
				sr_a <= '0';
				sr_b <= '0';
				sr_v <= '0';
				sr_vc <= '0';
				sr_m <= '0';
				set_mux <= '0';
				set_count <= '0';
				clear <= '1';
				if(bit_a = '1') then
					proximo_estado <= intermediario_inicio;
				else
					proximo_estado <= inicio;
				end if;
			
			when intermediario_inicio =>
				led_verde <= '0';
				led_vermelho <= '0';
				led_amarelo <= '0';
				sr_b <= '0';
				sr_v <= '0';
				sr_vc <= '0';
				sr_m <= '0';
				set_mux <= '0';
				set_count <= '1';
				sr_a <= '1';
				clear <= '0';
				proximo_estado <= espera_tempo_b;
				
			when espera_tempo_b =>
				led_verde <= '0';
				led_vermelho <= '0';
				led_amarelo <= '0';
				sr_a <= '0';
				sr_b <= '0';
				sr_v <= '0';
				sr_vc <= '0';
				sr_m <= '0';
				set_mux <= '0';
				clear <= '0';
				if(bit_b = '1') then
					proximo_estado <= intermediario_espera_tempo_b;
				else
					proximo_estado <= espera_tempo_b;
				end if;
					
			when intermediario_espera_tempo_b =>
				led_verde <= '0';
				led_vermelho <= '0';
				led_amarelo <= '0';
				sr_a <= '0';
				sr_b <= '1';
				sr_v <= '0';
				sr_vc <= '0';
				sr_m <= '0';
				set_mux <= '0';
				set_count <= '0';
				clear <= '0';
				proximo_estado <= verifica_velocidade;
					
			when verifica_velocidade =>
				led_verde <= '0';
				led_vermelho <= '0';
				led_amarelo <= '0';
				sr_a <= '0';
				sr_b <= '0';
				sr_v <= '0';
				sr_vc <= '0';
				sr_m <= '0';
				set_mux <= '0';
				set_count <= '0';
				clear <= '0';
				if(bit_v = '1') then
					proximo_estado <= intermediario_verifica_velocidade;
				else 
					proximo_estado <= verifica_velocidade;
				end if;
			
			when intermediario_verifica_velocidade =>
					led_verde <= '0';
					led_vermelho <= '0';
					led_amarelo <= '0';
					sr_a <= '0';
					sr_b <= '0';
					sr_v <= '1';
					sr_vc <= '1';
					sr_m <= '0';
					set_mux <= '0';
					set_count <= '0';
					clear <= '0';
					proximo_estado <= compara_velocidade;
					
			when compara_velocidade =>
				if(c_01 = '1') then
					proximo_estado <= sem_multa;
				elsif(c_01 = '0' and c_03 = '1') then
					proximo_estado <= calcula_multa;
				elsif(c_01 = '0' and c_03 = '0') then	
					proximo_estado <= multa_maxima;
				else
					proximo_estado <= compara_velocidade;
				end if;
			
			when sem_multa =>
				led_verde <= '1';
				led_vermelho <= '0';
				led_amarelo <= '0';
				sr_a <= '0';
				sr_b <= '0';
				sr_v <= '0';
				sr_vc <= '0';
				sr_m <= '0';
				set_mux <= '0';
				set_count <= '0';
				clear <= '0';
				proximo_estado <= exibe_velocidade;
				
			when calcula_multa =>
				led_verde <= '0';
				led_vermelho <= '0';
				led_amarelo <= '0';
				sr_a <= '0';
				sr_b <= '0';
				sr_v <= '0';
				sr_vc <= '0';
				sr_m <= '0';
				set_mux <= '1';
				set_count <= '0';
				clear <= '0';
				proximo_estado <= notifica_multa;
				
			when multa_maxima =>
				led_verde <= '0';
				led_vermelho <= '0';
				led_amarelo <= '0';
				sr_a <= '0';
				sr_b <= '0';
				sr_v <= '0';
				sr_vc <= '0';
				sr_m <= '0';
				set_mux <= '0';
				set_count <= '0';
				set_mux <= '0';
				clear <= '0';
				proximo_estado <= notifica_multa;
				
			when notifica_multa =>
				led_verde <= '0';
				led_vermelho <= '0';
				led_amarelo <= '0';
				sr_a <= '0';
				sr_b <= '0';
				sr_v <= '0';
				sr_vc <= '0';
				sr_m <= '0';
				set_count <= '0';
				clear <= '0';
				proximo_estado <= intermediario_notifica_multa;
				
			when intermediario_notifica_multa =>
				led_verde <= '0';
				led_vermelho <= '1';
				led_amarelo <= '0';
				sr_a <= '0';
				sr_b <= '0';
				sr_v <= '0';
				sr_vc <= '0';
				sr_m <= '1';
				set_count <= '0';
				clear <= '0';
				proximo_estado <= exibe_velocidade;
				
			when exibe_velocidade =>
				led_verde <= '0';
				led_vermelho <= '0';
				led_amarelo <= '0';
				sr_a <= '0';
				sr_b <= '0';
				sr_v <= '0';
				sr_vc <= '0';
				sr_m <= '0';
				set_count <= '0';
				clear <= '0';
				proximo_estado <= intermediario_exibe_velocidade;
				
			when intermediario_exibe_velocidade =>
					led_verde <= '0';
					led_vermelho <= '0';
					led_amarelo <= '0';
					sr_a <= '0';
					sr_b <= '0';
					sr_v <= '0';
					sr_vc <= '1';
					sr_m <= '0';
					set_count <= '0';
					sr_a <= '0';
					clear <= '0';
					proximo_estado <= inicio;
				
			when reporta_problema =>
				led_verde <= '0';
				led_vermelho <= '0';
				led_amarelo <= '1';
				sr_a <= '0';
				sr_b <= '0';
				sr_v <= '0';
				sr_vc <= '1';
				sr_m <= '0';
				set_mux <= '0';
				set_count <= '0';
				sr_a <= '0';
				clear <= '1';
				proximo_estado <= inicio;
				
			when others =>
				led_verde <= '0';
				led_vermelho <= '0';
				led_amarelo <= '0';
				sr_a <= '0';
				sr_b <= '0';
				sr_v <= '0';
				sr_vc <= '0';
				sr_m <= '0';
				set_mux <= '0';
				set_count <= '0';
				sr_a <= '0';
				clear <= '0';
				proximo_estado <= inicio;
		end case;
	end process;
end architecture;
		
			
			
		
				