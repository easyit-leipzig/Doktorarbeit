6.x.24 Kontrafaktische Lehrkraftprofilwirkung auf gruppendynamische Stabilität

Reihenfolge:
1) Python Export:
   py export_6x24_lehrkraftprofil_gruppendynamik.py

2) Python Analyse + Grafiken:
   py analyze_6x24_lehrkraftprofil_gruppendynamik.py

Alternativ PHP:
1) php export_6x24_lehrkraftprofil_gruppendynamik.php
2) php analyze_6x24_lehrkraftprofil_gruppendynamik.php

Erzeugte JSON:
- 6x24_lehrkraftprofil_gruppendynamik.json

Python-Analyse erzeugt:
- 6x24_lehrkraftprofil_gruppendynamik_output/6x24_summary_by_group.csv
- 6x24_lehrkraftprofil_gruppendynamik_output/6x24_analysebericht.txt
- abb_6x24_01_distanzvergleich_profile.png
- abb_6x24_02_delta_distanz.png
- abb_6x24_03_gruppendynamik.png
- abb_6x24_04_delta_instabilitaet.png

PHP-Analyse erzeugt:
- 6x24_lehrkraftprofil_gruppendynamik_output_php/6x24_summary_by_group.csv
- 6x24_lehrkraftprofil_gruppendynamik_output_php/6x24_analysebericht.txt

Hinweis:
Die Gruppendynamik aus frzk_group_emotion enthält keine direkten 7D-Gruppenvektoren. Deshalb wird ein 7D-Proxy aus z_affektiv, kohärenz, stabilitaet und dynamik gebildet. Wenn später frzk_group_semantische_dichte mit echten 7D-Werten verwendet werden soll, muss nur die Funktion group_vector/groupVector ersetzt werden.
