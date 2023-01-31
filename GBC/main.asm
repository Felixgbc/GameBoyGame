;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #13350 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _set_sprite_data
	.globl _set_win_tiles
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _joypad
	.globl _delay
	.globl _WNice
	.globl _TileLabel1
	.globl _Nice
	.globl _TileLabel
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_TileLabel::
	.ds 32
_Nice::
	.ds 720
_TileLabel1::
	.ds 128
_WNice::
	.ds 5
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:9: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
;main.c:10: UINT8 currentspriteindex = 0;                                            // variable zur bewegung des Sprites
	ldhl	sp,	#0
	ld	(hl), #0x00
;main.c:12: font_init();
	call	_font_init
;main.c:13: min_font = font_load(font_min);                                          //36 tiles
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
;main.c:14: font_set(min_font);
	push	de
	call	_font_set
	pop	hl
;main.c:15: set_bkg_data(37, 7, TileLabel1);                                         //initaliesiurung des Hintergrundes
	ld	de, #_TileLabel1
	push	de
	ld	hl, #0x725
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:16: set_bkg_tiles(0, 0, 40, 18, Nice);
	ld	de, #_Nice
	push	de
	ld	hl, #0x1228
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;main.c:17: set_win_tiles(0, 0, 5, 1, WNice);
	ld	de, #_WNice
	push	de
	ld	hl, #0x105
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_win_tiles
	add	sp, #6
;c:/gbdk/include/gb/gb.h:1468: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
	ld	a, #0x78
	ldh	(_WY_REG + 0), a
;main.c:19: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;main.c:20: NR50_REG = 0x77;
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;main.c:21: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;main.c:22: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:23: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;main.c:24: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:25: set_sprite_data(0, 2, TileLabel);                                       //setzt die sprite daten fest und Initialisiert sie
	ld	de, #_TileLabel
	push	de
	ld	hl, #0x200
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:/gbdk/include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:1675: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1676: itm->y=y, itm->x=x;
	ld	a, #0x4e
	ld	(hl+), a
	ld	(hl), #0x58
;main.c:28: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:31: while (1) {                                                              // Schleife für die Animation und bewegung
00112$:
;main.c:32: UBYTE joypad_state = joypad();
	call	_joypad
;main.c:33: if (joypad_state) {
	or	a, a
	jr	Z, 00102$
;main.c:34: NR10_REG = 0x16;
	ld	a, #0x16
	ldh	(_NR10_REG + 0), a
;main.c:35: NR11_REG = 0x40;
	ld	a, #0x40
	ldh	(_NR11_REG + 0), a
;main.c:36: NR12_REG = 0x73;
	ld	a, #0x73
	ldh	(_NR12_REG + 0), a
;main.c:37: NR13_REG = 0x00;
	xor	a, a
	ldh	(_NR13_REG + 0), a
;main.c:38: NR14_REG = 0xC3;
	ld	a, #0xc3
	ldh	(_NR14_REG + 0), a
;main.c:39: delay(100);
	ld	de, #0x0064
	call	_delay
00102$:
;main.c:41: if (currentspriteindex == 0) {
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	NZ, 00104$
;main.c:42: currentspriteindex = 1;
	ld	(hl), #0x01
	jr	00105$
00104$:
;main.c:45: currentspriteindex = 0;
	ldhl	sp,	#0
	ld	(hl), #0x00
00105$:
;main.c:47: delay(10);
	ld	de, #0x000a
	call	_delay
;c:/gbdk/include/gb/gb.h:1222: SCX_REG+=x, SCY_REG+=y;
	ldh	a, (_SCX_REG + 0)
	inc	a
	ldh	(_SCX_REG + 0), a
;c:/gbdk/include/gb/gb.h:1602: shadow_OAM[nb].tile=tile;
	ld	de, #(_shadow_OAM + 2)
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
;main.c:51: switch (joypad()) {                                                // für die bewegung per Pfeiltasten
	call	_joypad
	ld	c, a
	dec	a
	jr	Z, 00107$
	ld	a,c
	cp	a,#0x02
	jr	Z, 00106$
	cp	a,#0x04
	jr	Z, 00108$
	sub	a, #0x08
	jr	Z, 00109$
	jr	00110$
;main.c:52: case J_LEFT:
00106$:
;c:/gbdk/include/gb/gb.h:1691: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
;c:/gbdk/include/gb/gb.h:1692: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	add	a, #0xfb
	ld	(bc), a
;main.c:54: break;
	jr	00110$
;main.c:55: case J_RIGHT:
00107$:
;c:/gbdk/include/gb/gb.h:1691: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1692: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	add	a, #0x05
	ld	(bc), a
;main.c:57: break;
	jr	00110$
;main.c:58: case J_UP:
00108$:
;c:/gbdk/include/gb/gb.h:1691: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1692: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	add	a, #0xfb
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	ld	(bc), a
;main.c:60: break;
	jr	00110$
;main.c:61: case J_DOWN:
00109$:
;c:/gbdk/include/gb/gb.h:1691: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1692: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	add	a, #0x05
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	ld	(bc), a
;main.c:65: }
00110$:
;main.c:66: delay(100);
	ld	de, #0x0064
	call	_delay
	jp	00112$
;main.c:68: }
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__TileLabel:
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xbd	; 189
	.db #0x81	; 129
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0xdb	; 219
	.db #0x24	; 36
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0x42	; 66	'B'
	.db #0xbd	; 189
	.db #0x81	; 129
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0xdb	; 219
	.db #0x24	; 36
	.db #0xc3	; 195
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
__xinit__Nice:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x2b	; 43
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
__xinit__TileLabel1:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0x10	; 16
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xaa	; 170
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x55	; 85	'U'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
__xinit__WNice:
	.db #0x12	; 18
	.db #0x0b	; 11
	.db #0x16	; 22
	.db #0x16	; 22
	.db #0x19	; 25
	.area _CABS (ABS)
