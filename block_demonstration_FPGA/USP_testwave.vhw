--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 10.1
--  \   \         Application : ISE
--  /   /         Filename : USP_testwave.vhw
-- /___/   /\     Timestamp : Mon Apr 08 14:45:59 2013
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: USP_testwave
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY USP_testwave IS
END USP_testwave;

ARCHITECTURE testbench_arch OF USP_testwave IS
    COMPONENT USP
        PORT (
            CLK : In std_logic;
            MOSI : In std_logic;
            SCLK : In std_logic;
            CS : In std_logic;
            AddrBus : In std_logic_vector (3 DownTo 0);
            RGB : Out std_logic_vector (47 DownTo 0);
            vkl_str : Out std_logic_vector (15 DownTo 0)
        );
    END COMPONENT;

    SIGNAL CLK : std_logic := '0';
    SIGNAL MOSI : std_logic := '0';
    SIGNAL SCLK : std_logic := '0';
    SIGNAL CS : std_logic := '0';
    SIGNAL AddrBus : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL RGB : std_logic_vector (47 DownTo 0) := "000000000000000000000000000000000000000000000000";
    SIGNAL vkl_str : std_logic_vector (15 DownTo 0) := "0000000000000000";

    constant PERIOD_CLK : time := 100 ns;
    constant DUTY_CYCLE_CLK : real := 0.5;
    constant OFFSET_CLK : time := 100 ns;
    constant PERIOD_SCLK : time := 1000 ns;
    constant DUTY_CYCLE_SCLK : real := 0.5;
    constant OFFSET_SCLK : time := 100 ns;

    BEGIN
        UUT : USP
        PORT MAP (
            CLK => CLK,
            MOSI => MOSI,
            SCLK => SCLK,
            CS => CS,
            AddrBus => AddrBus,
            RGB => RGB,
            vkl_str => vkl_str
        );

        PROCESS    -- clock process for CLK
        BEGIN
            WAIT for OFFSET_CLK;
            CLOCK_LOOP : LOOP
                CLK <= '0';
                WAIT FOR (PERIOD_CLK - (PERIOD_CLK * DUTY_CYCLE_CLK));
                CLK <= '1';
                WAIT FOR (PERIOD_CLK * DUTY_CYCLE_CLK);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS    -- clock process for SCLK
        BEGIN
            WAIT for OFFSET_SCLK;
            CLOCK_LOOP : LOOP
                SCLK <= '0';
                WAIT FOR (PERIOD_SCLK - (PERIOD_SCLK * DUTY_CYCLE_SCLK));
                SCLK <= '1';
                WAIT FOR (PERIOD_SCLK * DUTY_CYCLE_SCLK);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS    -- Process for CLK
            BEGIN
                -- -------------  Current Time:  100ns
                WAIT FOR 100 ns;
                AddrBus <= "0001";
                -- -------------------------------------
                -- -------------  Current Time:  553435ns
                WAIT FOR 553335 ns;
                AddrBus <= "0010";
                -- -------------------------------------
                WAIT FOR 947565 ns;

            END PROCESS;

            PROCESS    -- Process for SCLK
                BEGIN
                    -- -------------  Current Time:  3585ns
                    WAIT FOR 3585 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  4585ns
                    WAIT FOR 1000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  6585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  9585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  10585ns
                    WAIT FOR 1000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  12585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  14585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  17585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  21585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  23585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  26585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  29585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  32585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  33585ns
                    WAIT FOR 1000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  36585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  39585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  41585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  43585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  46585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  49585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  51585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  57585ns
                    WAIT FOR 6000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  65585ns
                    WAIT FOR 8000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  69585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  74585ns
                    WAIT FOR 5000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  77585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  81585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  85585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  88585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  91585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  94585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  98585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  102585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  106585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  109585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  111585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  114585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  117585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  120585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  122585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  125585ns
                    WAIT FOR 3000 ns;
                    CS <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  565585ns
                    WAIT FOR 440000 ns;
                    CS <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  567585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  570585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  575585ns
                    WAIT FOR 5000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  577585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  580585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  584585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  587585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  589585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  593585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  597585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  600585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  603585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  606585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  609585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  612585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  614585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  618585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  620585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  624585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  628585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  632585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  635585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  640585ns
                    WAIT FOR 5000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  644585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  648585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  650585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  652585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  653585ns
                    WAIT FOR 1000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  656585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  659585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  662585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  666585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  669585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  671585ns
                    WAIT FOR 2000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  676585ns
                    WAIT FOR 5000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  677585ns
                    WAIT FOR 1000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  682585ns
                    WAIT FOR 5000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  686585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  691585ns
                    WAIT FOR 5000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  697585ns
                    WAIT FOR 6000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  702585ns
                    WAIT FOR 5000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  707585ns
                    WAIT FOR 5000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  712585ns
                    WAIT FOR 5000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  717585ns
                    WAIT FOR 5000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  723585ns
                    WAIT FOR 6000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  727585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  731585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  735585ns
                    WAIT FOR 4000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  738585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  741585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  744585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '1';
                    -- -------------------------------------
                    -- -------------  Current Time:  747585ns
                    WAIT FOR 3000 ns;
                    MOSI <= '0';
                    -- -------------------------------------
                    -- -------------  Current Time:  749585ns
                    WAIT FOR 2000 ns;
                    CS <= '1';
                    -- -------------------------------------
                    WAIT FOR 751415 ns;

                END PROCESS;

        END testbench_arch;

