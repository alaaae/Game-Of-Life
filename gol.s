.section ".word"
   /* Game state memory locations */
  .equ CURR_STATE, 0x90001000       /* Current state of the game */
  .equ GSA_ID, 0x90001004           /* ID of the GSA holding the current state */
  .equ PAUSE, 0x90001008            /* Is the game paused or running */
  .equ SPEED, 0x9000100C            /* Current speed of the game */
  .equ CURR_STEP,  0x90001010       /* Current step of the game */
  .equ SEED, 0x90001014             /* Which seed was used to start the game */
  .equ GSA0, 0x90001018             /* Game State Array 0 starting address */
  .equ GSA1, 0x90001058             /* Game State Array 1 starting address */
  .equ CUSTOM_VAR_START, 0x90001200 /* Start of free range of addresses for custom vars */
  .equ CUSTOM_VAR_END, 0x90001300   /* End of free range of addresses for custom vars */
  .equ RANDOM, 0x40000000           /* Random number generator address */
  .equ LEDS, 0x50000000             /* LEDs address */
  .equ SEVEN_SEGS, 0x60000000       /* 7-segment display addresses */
  .equ BUTTONS, 0x70000004          /* Buttons address */

  /* States */
  .equ INIT, 0
  .equ RAND, 1
  .equ RUN, 2

  /* Colors (0bBGR) */
  .equ RED, 0x100
  .equ BLUE, 0x400

  /* Buttons */
  .equ JT, 0x10
  .equ JB, 0x8
  .equ JL, 0x4
  .equ JR, 0x2
  .equ JC, 0x1
  .equ BUTTON_2, 0x80
  .equ BUTTON_1, 0x20
  .equ BUTTON_0, 0x40

  /* LED selection */
  .equ ALL, 0xF

  /* Constants */
  .equ N_SEEDS, 4           /* Number of available seeds */
  .equ N_GSA_LINES, 10       /* Number of GSA lines */
  .equ N_GSA_COLUMNS, 12    /* Number of GSA columns */
  .equ MAX_SPEED, 10        /* Maximum speed */
  .equ MIN_SPEED, 1         /* Minimum speed */
  .equ PAUSED, 0x00         /* Game paused value */
  .equ RUNNING, 0x01        /* Game running value */

.section ".text.init"
  .globl main

main:
  li sp, CUSTOM_VAR_END /* Set stack pointer, grows downwards */ 
  
  # call reset_game

/* BEGIN:clear_leds */
clear_leds:
  la x10, LEDS
  sw x0, 0(x10)
  ret
/* END:clear_leds */

/* BEGIN:set_pixel */
set_pixel:
  la x10, LEDS
  lw x11, 0(x10)
  or x11, x11, a0
  slli x12, a1, 4
  or x11, x11, x12
  ori x11, x11, RED
  li x13, 0x10000
  or x11, x11, x13
  sw x11, 0(x10)
  ret 
/* END:set_pixel */

/* BEGIN:wait */
wait: 
     
/* END:wait */

/* BEGIN:set_gsa */
set_gsa:
  /*Getting the GSA ID*/
  la x10, GSA_ID
  lw x11, 0(x10)
  
  /*Going to the current GSA*/
  beqz x11, current_GSA0

  current_GSA1:
    li x12, GSA1
    lw x13, 0(x12)
    j end1

  current_GSA0:
    li x12, GSA0
    lw x13, 0(x12)

  end1:
    /*getting the wanted address*/
    slli a1, a1, 2
    add a1, a1, x13
    sw a0, 0(a1)
    ret
/* END:set_gsa */

/* BEGIN:get_gsa */
get_gsa:
  /*Getting the GSA ID*/
  la x10, GSA_ID
  lw x11, 0(x10)
  
  /*Going to the current GSA*/
  beqz x11, currentGSA0

  currentGSA1:
    li x12, GSA1
    lw x13, 0(x12)
    j end

  currentGSA0:
    li x12, GSA0
    lw x13, 0(x12)

  end:
    /*getting the wanted address*/
    slli a0, a0, 2 
    add a0, a0, x13
    lw a0, 0(a0)
    ret
/* END:get_gsa */

/* BEGIN:draw_gsa */
draw_gsa:
  /*Getting the GSA ID*/
  la t0, GSA_ID
  lw t1, 0(t0)
  
  /*Going to the current GSA*/
  beqz t1, currentGSA_0

  currentGSA_1:
    li t2, GSA1
    lw t3, 0(t2)
    j end

  currentGSA_0:
    li t2, GSA0
    lw t3, 0(t2)

  end:
    /*row value and counter for the loop*/
    li t5, 0

    loop:
      mv a0, t5 #argument for get_gsa

      jal get_gsa
      /*put the values of the leds in the right place of the representation*/
      slli a0, a0, 16
      /*put the row num in the right place*/
      slli t6, t5, 4
      /*select the right row*/
      or a0, a0, t6
      /*red leds*/
      ori a0, a0, RED
      /*put it in address LEDS*/
      la a1, LEDS
      sw a0, 0(a1)
      /*next row */
      addi t5, t5, 1
      /*end of loop*/
      li a2, N_GSA_LINES
      ble t5, a2, loop
    ret 

/* END:draw_gsa */

/* BEGIN:random_gsa */
random_gsa:           
/* END:random_gsa */

/* BEGIN:change_speed */
change_speed:
/* END:change_speed */

/* BEGIN:pause_game */
pause_game:
/* END:pause_game */

/* BEGIN:change_steps */
change_steps:           
/* END:change_steps */

/* BEGIN:set_seed */
set_seed:
/* END:set_seed */

/* BEGIN:increment_seed */
increment_seed:                
/* END:increment_seed */

/* BEGIN:update_state */
update_state:
/* END:update_state */

/* BEGIN:select_action */
select_action:
/* END:select_action */

/* BEGIN:cell_fate */
cell_fate:
/* END:cell_fate */

/* BEGIN:find_neighbours */
find_neighbours:
/* END:find_neighbours */

/* BEGIN:update_gsa */
update_gsa:
/* END:update_gsa */

/* BEGIN:get_input */
get_input:
/* END:get_input */

/* BEGIN:decrement_step */
decrement_step:
/* END:decrement_step */

/* BEGIN:reset_game */
reset_game:
/* END:reset_game */

/* BEGIN:mask */
mask:
/* END:mask */

/* 7-segment display */
font_data:
  .word 0x3F
  .word 0x06
  .word 0x5B
  .word 0x4F
  .word 0x66
  .word 0x6D
  .word 0x7D
  .word 0x07
  .word 0x7F
  .word 0x6F
  .word 0x77
  .word 0x7C
  .word 0x39
  .word 0x5E
  .word 0x79
  .word 0x71

  seed0:
	.word 0xC00
	.word 0xC00
	.word 0x000
	.word 0x060
	.word 0x0A0
	.word 0x0C6
	.word 0x006
	.word 0x000
  .word 0x000
  .word 0x000

seed1:
	.word 0x000
	.word 0x000
	.word 0x05C
	.word 0x040
	.word 0x240
	.word 0x200
	.word 0x20E
	.word 0x000
  .word 0x000
  .word 0x000

seed2:
	.word 0x000
	.word 0x010
	.word 0x020
	.word 0x038
	.word 0x000
	.word 0x000
	.word 0x000
	.word 0x000
  .word 0x000
  .word 0x000

seed3:
	.word 0x000
	.word 0x000
	.word 0x090
	.word 0x008
	.word 0x088
	.word 0x078
	.word 0x000
	.word 0x000
  .word 0x000
  .word 0x000


# Predefined seeds
SEEDS:
  .word seed0
  .word seed1
  .word seed2
  .word seed3

mask0:
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
  .word 0xFFF
  .word 0xFFF

mask1:
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0x1FF
	.word 0x1FF
	.word 0x1FF
  .word 0x1FF
  .word 0x1FF

mask2:
	.word 0x7FF
	.word 0x7FF
	.word 0x7FF
	.word 0x7FF
	.word 0x7FF
	.word 0x7FF
	.word 0x7FF
	.word 0x7FF
  .word 0x7FF
  .word 0x7FF

mask3:
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0x000
  .word 0x000
  .word 0x000

mask4:
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0xFFF
	.word 0x000
  .word 0x000
  .word 0x000

MASKS:
  .word mask0
  .word mask1
  .word mask2
  .word mask3
  .word mask4
