# include <gb/gb.h>
# include <stdio.h>
# include "font.h"
# include "Schwein.c"
# include "Hintergrund1.c"
# include "Hintergrundsachen1.c"
# include "windowmap.c"

void main() {
    UINT8 currentspriteindex = 0;                                            // variable zur bewegung des Sprites
    font_t min_font;
    font_init();
    min_font = font_load(font_min);                                          //36 tiles
    font_set(min_font);
    set_bkg_data(37, 7, TileLabel1);                                         //initaliesiurung des Hintergrundes
    set_bkg_tiles(0, 0, 40, 18, Nice);
    set_win_tiles(0, 0, 5, 1, WNice);
    move_win(7, 120);
    NR52_REG = 0x80;
    NR50_REG = 0x77;
    NR51_REG = 0xFF;
    SHOW_BKG;
    SHOW_WIN;
    DISPLAY_ON;
    set_sprite_data(0, 2, TileLabel);                                       //setzt die sprite daten fest und Initialisiert sie
    set_sprite_tile(0, 0);
    move_sprite(0, 88, 78);
    SHOW_SPRITES;


    while (1) {                                                              // Schleife für die Animation und bewegung
        UBYTE joypad_state = joypad();
        if (joypad_state) {
            NR10_REG = 0x16;
            NR11_REG = 0x40;
            NR12_REG = 0x73;
            NR13_REG = 0x00;
            NR14_REG = 0xC3;
            delay(100);
        }
        if (currentspriteindex == 0) {
            currentspriteindex = 1;
        }
        else {
            currentspriteindex = 0;
        }
        delay(10);
        scroll_bkg(1, 0);
        set_sprite_tile(0, currentspriteindex);
        //scroll_sprite(0, -10, 0);
        switch (joypad()) {                                                // für die bewegung per Pfeiltasten
        case J_LEFT:
            scroll_sprite(0, -5, 0);
            break;
        case J_RIGHT:
            scroll_sprite(0, 5, 0);
            break;
        case J_UP:
            scroll_sprite(0, 0, -5);
            break;
        case J_DOWN:
            scroll_sprite(0, 0, 5);
            break;

        }
        delay(100);
    }
}