## TimeNet

Ein Projekt für das Wahlpflichtmodul: "Animationsprogrammierung mit Processing".

---

### Features:
 - Countdown am Anfang
 - Gegner verschiedener Farbe erzeugen sich selbst (Kreise?)
 - Gegner suchen nach anderen Punkten der selben Farbe
 - Gegner vergrößern ihren Radius (width, heigt), sobald sie einen "Node" eingesammelt haben
 - Gegner lassen sich zerstören
 - Musik interaktiv?
 - Spiel verloren sobald ein Gegner mehr wie 100 Gegner eingesammelt hat
 - Spiel gewonnen sobald der Spieler 100 Punkte hat
 - Anzahl der Punkte eines Gegners anzeigen?
 - Gegner sind mit gleicher Farbe mit Linie verbunden?
 - Hintergrund ändert die Farbe von Weiß nach Schwarz jenachdem wie weit das Zeitlimit ist
 - Punkte ziehen sich schneller zum Gegner umsogrößer er ist?
 - Menü?
 - Gegner kann die Farbe ändern?
 - Zeitlimit?
 - Boni?
 - Max. Vier Gegner (Vier verschiedene Farben: "R, G, B, Y"?)
 - Gegner starten mit einem Punkt (Radius: 10px) + 10px bei einsammeln
 - Gegner starten mit zehn Gegnern zum einsammeln
 - Gegner alle "Transparent" darstellen? Wenn hover auf Gegner/Node, dann voll sichtbar?
 - Sobald ein Gegner alle "Nodes" eingesammelt hat, werden Zehn neue Nodes gespawnt
 
---
 
Um einen Gegner zu zerstören, müssen der Gegner und einen "Node", der selben Farbe angeklickt werden.
Hat ein Gegner bereits Vier andere Gegner der selben Farbe "gegessen"
muss man den Gegner anklicken und danach einen Punkt der seine Farbe hat (x4), um ihn zu "zerstören"
Wenn ein Gegner angeklickt wird, wird er mit einem Kreis markiert. (Farbe: Hintergrund invertiert).

---

### ToDo:
 - ~~Gegner in ArrayList speichern~~
 - Hintergrund nach Zeitlimit ändern
 - ~~Gegner erzeugen~~
 - Menü
 - ~~Sounds einbauen~~
 - Countdown
 - Scoresystem
 - Highscores?
 - Spielernamen?
 - Gegner suchen sich gegenseitig
 - ~~Gegnerobjekt erstellen (Hat attribute: name, farbe, punkte (größe), speed, cordX, cordY)~~
 - Zeit und Punktestand anzeigen (UI)

---

#### Genutzte Libraries:
 - ProccesingJS (v1.4.8)
 - BuzzJS (v1.2.1)
 - jQuery?



#### Musik genutzt von:

https://www.youtube.com/audiolibrary/music

Density & Time - Venetian




#### 07.02.19, Tom Haupt (FDAI3784)