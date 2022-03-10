#!/bin/bash

cmdmain=(
   yad
   --center --width=800
   --height=400
   --title="sujet 5"
   --text="Choisir une option"
    --text-align=center
   --button="Exit":1
   --form
      --field="Tentatives de connexions":btn "./secure.sh -t"
      --field="Traçage du dernier  mailing":btn "./secure.sh -l"
      --field="Starting name servers":btn "./secure.sh -b"
      --field="HELP":btn "./secure.sh -h"
      --field="AFFICHER UN MENU TEXTUEL":btn "./secure.sh -m"
      --field="Alert des tentatives de tros":btn "./secure.sh -a"

)

while true; do
    "${cmdmain[@]}"
    exval=$?
    case $exval in
        1|252) break;;
    esac
done
