#!/bin/bash

# Datei erstellen
touch 2020-05-23-Dates_and_ISSNs.tsv

# Variablendefinition
Ausgabedatei="2020-05-23-Dates_and_ISSNs.tsv"

# Spalten 5 und 12 kopieren (ISSN & DATE)
cut -f 5,12 2020-05-23-Article_list_dirty.tsv > 1.tmp

# ISSN entfernen
sed 's/ISSN://gI' 1.tmp > 2.tmp

# Leerzeichen & Tabs am Anfang der Zeile entfernen
sed 's/^[ \t]*//' 2.tmp > 3.tmp

#leere Zeilen entfernen
#sed '/^$/d' 4.tmp > 5.tmp

# Alle Zeilen entfernen die nicht mit der ISSN nach dem Schema 1234-5678 beginnen
# ^ = Anfang der Zeile
# [A-Z0-9] = Großbuchstaben und Zahlen
# \{4\} = genau 4 mal
# /!d = lösche die Zeilen in denen die Zeichenfolge NICHT vorkommt (!)
sed '/^[A-Z0-9]\{4\}-[A-Z0-9]\{4\}/!d' 3.tmp > 4.tmp

# Sortieren & Duplikate entfernen
sort 4.tmp | uniq > 5.tmp

# Aufräumen (temporäre Dateien löschen)
cp 5.tmp $Ausgabedatei
rm *.tmp
