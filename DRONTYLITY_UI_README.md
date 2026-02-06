# Drontylity - Uživatelské Rozhraní s Interaktivní Mapou

## 🎯 Popis

Toto je jednoduché, uživatelsky přívětivé vizuální rozhraní pro Drontylity Engine - platformu pro sdílení autonomních dronů. Aplikace obsahuje interaktivní mapu s možností objednávky letů.

## 🚀 Jak použít

### Spuštění aplikace

1. **Jednoduchý způsob**: Otevřete soubor `drontylity-ui.html` přímo ve webovém prohlížeči (dvojklik na soubor)

2. **Lokální server** (doporučeno pro plnou funkcionalnost):
   ```bash
   # Python 3
   python3 -m http.server 8000
   
   # Python 2
   python -m SimpleHTTPServer 8000
   
   # Node.js (pokud máte nainstalovaný npx)
   npx http-server
   ```
   
   Poté otevřete prohlížeč a přejděte na `http://localhost:8000/drontylity-ui.html`

## 📱 Funkce aplikace

### 1. **Výběr úrovně služby**
   - **Level 1** - Základní přeprava ze stanice
   - **Level 2** - Osobní přílet k vaší pozici
   - **Level 3** - Autonomní sdílení dronu

### 2. **Interaktivní mapa**
   - Zobrazení dobíjecích/odletových stanic (zelené ikony 🔋)
   - Zobrazení aktivních dronů ve vzduchu (🚁)
   - Kliknutím na mapu vyberte start a cíl cesty
   - Automatické vykreslení plánované trasy

### 3. **Sledování letu**
   - Simulace letu dronu v reálném čase
   - Vizualizace pohybu po zvolené trase
   - Notifikace o stavu objednávky

### 4. **Status bar**
   - Počet dostupných dronů
   - Status energetické sítě (100% obnovitelná)
   - Aktuální stav služby

## 🎮 Návod k použití

1. **Vyberte úroveň služby** kliknutím na jednu ze tří možností v levém panelu

2. **Zadejte trasu** dvěma způsoby:
   - Klikněte na mapu pro výběr startu (první klik) a cíle (druhý klik)
   - NEBO zadejte souřadnice ručně do textových polí

3. **Objednejte let** kliknutím na tlačítko "🚁 Objednat Let"

4. **Sledujte dron** na mapě během simulovaného letu k vašemu cíli

## 🗺️ Mapa

Aplikace využívá:
- **Leaflet.js** - open-source JavaScript knihovna pro interaktivní mapy
- **OpenStreetMap** - volně dostupná mapová data
- Výchozí zobrazení: Praha, Česká republika
- 5 přednastavených stanic s dostupnými drony

## ✨ Vlastnosti

- ✅ Plně responzivní design
- ✅ Intuitivní uživatelské rozhraní
- ✅ Real-time simulace letu
- ✅ Animace a vizuální feedback
- ✅ Čeština jako primární jazyk
- ✅ Žádné závislosti - vše běží v prohlížeči
- ✅ Offline použitelné (po prvním načtení)

## 🔧 Technologie

- **HTML5** - struktura
- **CSS3** - styling s gradient efekty
- **JavaScript (Vanilla)** - funkcionalita
- **Leaflet.js 1.9.4** - interaktivní mapa
- **OpenStreetMap** - mapová data

## 🎨 Design

- Moderní gradient design (fialovo-modrá paleta)
- Přívětivé emoji ikony
- Plynulé animace a přechody
- Vysoký kontrast pro čitelnost
- Vizuálně odlišené stavy (aktivní služba, hover efekty)

## 📝 Poznámky

- Aplikace je samostatná (standalone) - nepotřebuje Rails backend
- Všechny drony a stanice jsou simulované pro demonstrační účely
- Souřadnice jsou zaměřené na Prahu, lze snadno změnit v kódu
- Pro produkční použití by bylo potřeba připojit k reálnému API

## 🚁 Co dál?

Pro integraci s backend systémem by bylo třeba:
1. Připojit API endpoint pro objednávky
2. WebSocket pro real-time tracking
3. Autentizaci uživatelů
4. Platební bránu
5. Databázi pro správu flotily

---

**Vytvořeno pro Drontylity Engine - Průlomová platforma pro sdílení autonomních dronů** 🚁✨
