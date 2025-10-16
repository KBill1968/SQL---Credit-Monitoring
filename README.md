Abschlussprojekt für das Modul „Datenbanken und SQL“ (16.01.2025) 
Allgemeine Hinweise 
Liebe(r) Teilnehmer(in), für das Zwischenprojekt stehen Dir zwei Themenalternativen zur 
Auswahl, das geführte Projekt A und das freie Projekt B. Wähle bitte ein Projekt. Beide Pro
jekte werden nachfolgend vorgestellt. Für beide Projekte gelten die folgenden grundsätzlichen 
Vorgaben: 
Bearbeitung:  
• Wichtig: Bearbeite das Projekt mit SQL in MySQL und verwende dabei die im Kurs 
vermittelten Inhalte.  
• Bearbeite das Projekt bitte allein (Gruppenarbeiten sind nicht möglich!). Behalte dabei 
bitte immer Deine Zielsetzung bzw. Aufgabenstellung im Kopf. 
Abgabe:  
• Erstelle für die Abgabe bitte eine kurze (min. 5 Slides umfassende) Powerpoint-Prä
sentation.  
• Gib bitte auch ein Skript mit Deinem SQL-Code ab. Kommentiere in dem Skript die 
wichtigsten Code-Elemente/Bausteine. 
• In der Präsentation solltest Du auf die Aufgabenstellung, Deine Vorgehensweise zur 
Bearbeitung, und Deine erzeugten Ergebnisse eingehen.  
• Gib Deine Unterlagen (Präsentation + Skript) bitte spätestens bis Mittwoch, 
22.01.2025, 12:00 Uhr ab. 
Präsentation der Projektarbeit 
• Präsentiere Deine Projektarbeit auf Basis der eingereichten Unterlagen bitte im Rah
men eines eigenständigen Vortrags im Umfang von ca. 15 Minuten. Verwende dabei 
Deine erstellte Powerpoint-Präsentation.  
• Gehe in der Präsentation präzise auf Deine gewählte Vorgehensweise ein und erläutere 
klar und verständlich die von Dir im Hinblick auf die Aufgabenstellung erzeugten Er
gebnisse. 
• Sei darauf vorbereitet, dass das Teaching Team u.U. Verständnisfragen etc. stellt.  
1 
Projekt A: Datenanalyse für einen Finanzdienstleister 
Hintergrund: 
Stell Dir bitte folgendes Szenario vor: Nach dem erfolgreichen Abschluss der Daten Analyst 
Weiterbildung arbeitest Du festangestellt bei einem Finanzdienstleistungsunternehmen. Ein 
Geschäftsfeld dieses Unternehmens ist die Vergabe von (Konsumenten-)Krediten an Privat
personen. Der für dieses Geschäftsfeld zuständige Bereichsvorstand ist unzufrieden mit den 
folgenden zwei Prozessen: 
• Kreditüberwachung:  
Bei diesem Prozess geht es um die nach der erfolgten Kreditvergabe periodisch durchgeführte 
(dynamische) Kreditwürdigkeitsprüfung. Ziel ist es hierbei so rechtzeitig wie möglich festzu
stellen, ob sich die Bonität (das Kreditausfallrisiko) des Kreditnehmers verändert hat, insbe
sondere ob es wahrscheinlicher geworden ist, dass der Kreditnehmer ausfällt (d.h., seinen 
Kredit nicht mehr rechtzeitig und in voller Höhe zurückzahlen kann). Aktuell ist der Kredit
überwachungsprozess nicht an Kredit- oder Kreditnehmercharakteristiken geknüpft. Das 
heißt, jeder Kredit bzw. Kreditnehmer durchläuft den gleichen dynamischen Überwachungs
prozess. Der Vorstand hält diesen Prozess für ineffizient und zu kostenintensiv! Der Prozess 
soll in einen kreditnehmer- bzw. kreditspezifischen Prozess verändert werden.  
Ziel: eine kreditnehmerspezifische Kreditüberwachung implementieren, d.h. Kredite bzw. 
Kreditnehmer mit einem höheren Risiko sollen intensiver und die mit einem geringerem Ri
siko sollen weniger intensiv überwacht werden! 
Deine Aufgabe 1: Wie kann Deine Datenanalyse bei der Umsetzung dieses Ziels helfen? 
• Kreditvergabe, Kreditvolumen und Kreditpricing 
Der Vorstand ist auch mit der Umsetzung des Kreditvergabe- und Pricingprozesses unzufrie
den. Im Unternehmen gibt es genaue Vorgaben, die festlegen, welche Kunden mit welchen Ei
genschaften einen Kredit zu welchen Konditionen (Kreditsumme und Kreditzins) bekommen. 
Speziell vermutet der Verstand hier, dass sich aber nicht alle Kundenbetreuer an diese Vorga
ben halten und Kredite nach eigenen Kriterien vergeben. Insbesondere ist der Vorstand dar
über besorgt, dass das Pricing der Kredit u.U. nicht risikosensitiv ist und das zum Beispiel ris
kante Kreditnehmer zu große Kredite bekommen. 
2 
3 
 
 
 
 
Deine Aufgabe 2: Wie kann Deine Datenanalyse dabei unterstützen, die Vermutungen 
des Vorstands zu überprüfen? Sind die Sorgen des Vorstands begründet anhand der Da
ten? 
 
 
Datensatz 
Für die Analyse erhältst Du den Datensatz „credit_risk_dataset.csv“. Er beinhaltet die folgen
den Informationen in 12 Spalten zu vergebenen Krediten und deren Kreditnehmern.  
Lade den Datensatz als SQL-Tabelle und beginne mit Deinen Auswertungen! 
 
Variable Beschreibung 
person_age Age 
person_income Annual Income 
person_home_ownership Home ownership 
person_emp_length Employment length (in years) 
loan_intent Loan intent 
loan_grade Loan grade 
loan_amnt Loan amount 
loan_int_rate Interest rate 
loan_status Loan status (0 is non default 1 is default) 
Variable 
Beschreibung 
loan_percent_income 
Percent income 
cb_person_default_on_file 
Historical default 
cb_preson_cred_hist_length 
Credit history length 
Projekt B: Das freie Projekt 
Grundsätzlich bist Du bei diesem Projekt frei in der Wahl der Aufgabenstellung (Projektziele), 
der Art des Kontexts (Use Case) und der verwendeten Daten. Insbesondere muss der Hinter
grund des Projekts nicht auf Geschäfts- und/oder Unternehmensprozessen und deren Optimie
rung basieren. Es gelten aber die folgenden Rahmenbedingungen: 
• Formuliere bitte mindestens zwei klare Projektziele, zu deren Erreichung Deine Ana
lyse einen signifikanten Beitrag leisten kann.  
• Stelle sicher, dass Deine verwendeten Daten geeignet sind, die mit dem Projekt ver
bundene Zielerreichung auch zu unterstützen. 
• Bevor Du startest, präsentiere kurz Deine Projektidee, die geplante Umsetzung und die 
ausgewählten Daten einem Mitglied des Teaching Teams.  
Zeitplanung 
Wann  
Was? 
Wer 
Ab donnerstagvormittags, 
16.01.2025 bis einschließlich 
Mittwoch, 22.01. 
geführte Arbeit der 
Teilnehmer an ih
ren Projekten 
Teaching Assist
ents/Tina 
Anmerkung 
Keine Vorlesung 
Mittwoch, 22.01., bis 18:00 
Uhr 
Abgabe der Pro
jektunterlagen 
Teilnehmer  
Donnerstag, 23.01., (ganz
tags) 
Präsentation 
Teilnehmer + Tina  
Freitagvormittags, 24.01. 
Einarbeitung 
Feedback 
Teilnehmer + Tina  
4 
