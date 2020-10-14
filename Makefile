.PHONY: jlcpcb% panel%.kicad_pcb all

PROJECT := at86rf233-breakout
PCB := $(PROJECT).kicad_pcb
SCHEMATIC := $(PROJECT).sch

all: jlcpcb_panel_4x2 jlcpcb_panel_5x3 panel_1x3.kicad_pcb

IGNORES :=
IGNORES += RF1
IGNORES += U1
IGNORES += J1
IGNORES += R3
IGNORES += R4

panel_4x2.kicad_pcb: $(PCB)
	kikit panelize grid \
			--space 3 \
			--htabs 1 --vtabs 2 \
			--tabwidth 3 --tabheight 3 \
			--gridsize 4 2 \
			--mousebites 0.5 1 -0.25 \
			--radius 1 \
			--panelsize 80 100 \
			--tooling 5 2.5 1.5 \
			$(PCB) \
			$@

panel_5x3.kicad_pcb: $(PCB)
	kikit panelize grid \
			--space 1 \
			--htabs 1 --vtabs 2 \
			--tabwidth 3 --tabheight 3 \
			--gridsize 5 3 \
			--mousebites 0.5 1.0 -0.2 \
			--radius 0.2 \
			--panelsize 100 100 \
			--tooling 13.5 1.5 1.5 \
			$(PCB) \
			$@

panel_1x3.kicad_pcb: $(PCB)
	kikit panelize grid \
			--space 1 \
			--htabs 1 --vtabs 2 \
			--tabwidth 3 --tabheight 3 \
			--gridsize 1 3 \
			--mousebites 0.25 0.6 -0.25 \
			--radius 0.2 \
			--panelsize 100 25 \
			--tooling 13.5 1.5 1.5 \
			$(PCB) \
			$@

null  :=
space := $(null) #
comma := ,

jlcpcb_panel_4x2: panel_4x2.kicad_pcb
	kikit fab \
			jlcpcb \
			--schematic $(SCHEMATIC) \
			--assembly \
			--ignore $(subst $(space),$(comma),$(strip $(IGNORES))) \
			$< \
			$@

jlcpcb_panel_5x3: panel_5x3.kicad_pcb
	kikit fab \
			jlcpcb \
			--schematic $(SCHEMATIC) \
			--assembly \
			--ignore $(subst $(space),$(comma),$(strip $(IGNORES))) \
			$< \
			$@

clean:
	rm -f panel_4x2.kicad_pcb panel_5x3.kicad_pcb panel_1x3.kicad_pcb
	rm -rf jlcpcb_panel_4x2 jlcpcb_panel_5x3
