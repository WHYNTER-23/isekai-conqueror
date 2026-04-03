# Isekai Conqueror
## Game Design Document (GDD)
**Versi:** 0.6  
**Tanggal:** 2026  
**Status:** Draft Awal

---

## Daftar Isi

1. [Overview](#1-overview)
2. [Premis & Lore](#2-premis--lore)
3. [Core Gameplay Loop](#3-core-gameplay-loop)
4. [Sistem Era & Wilayah](#4-sistem-era--wilayah)
5. [Sistem Jenderal](#5-sistem-jenderal)
6. [Karakter: Julia Caesar](#6-karakter-julia-caesar)
7. [Campaign Mode](#7-campaign-mode)
8. [Tutorial Design](#8-tutorial-design)
9. [Mode Permainan](#9-mode-permainan)
10. [Monetisasi](#10-monetisasi)
11. [UI & UX Design](#11-ui--ux-design)
12. [Sistem In-Battle](#12-sistem-in-battle)
13. [Referensi & Inspirasi](#13-referensi--inspirasi)
14. [Roadmap Pengembangan](#14-roadmap-pengembangan)

---

## 1. Overview

| Kategori | Detail |
|---|---|
| **Judul** | Isekai Conqueror |
| **Genre** | Turn-based Strategy |
| **Platform** | Mobile (Android / iOS) |
| **Engine** | Godot (target) |
| **Setting** | Dunia fantasi paralel bernama Orion |
| **Tone** | Epik, ringan, dengan elemen anime |
| **Target Pemain** | Penggemar strategy game & anime, usia 15+ |

### Ringkasan Konsep

Isekai Conqueror adalah game strategi berbasis giliran di mana pemain berperan sebagai seorang Raja dari dunia lain yang dipanggil oleh Sang Dewi ke dunia Orion. Untuk membawa kedamaian, Raja harus menaklukkan dan menyatukan seluruh wilayah Orion -- dibantu oleh para Jenderal, jiwa-jiwa pahlawan sejarah yang telah bereinkarnasi sebagai karakter-karakter wanita perkasa bergaya anime.

---

## 2. Premis & Lore

### Latar Dunia

Dunia **Orion** adalah dunia paralel yang kaya akan sejarah dan kekuatan magis. Lima wilayah besar Orion -- Aurestia, Valdenmoor, Sakurima, Grandilion, dan The Shattered North -- masing-masing berdiri sebagai **benua yang terpisah**, dikelilingi oleh **Samudra Abyssal** yang luas dan ganas.

Selama berabad-abad, kelima benua ini hidup dalam isolasi total. Bukan karena tidak ada keinginan untuk menjelajah -- melainkan karena **Samudra Abyssal menyimpan teror yang tak tertandingi**: monster-monster laut purba yang disebut **Levianthos**, makhluk raksasa yang menghancurkan setiap kapal yang berani melewati batas perairan dangkal. Tidak ada satu pun ekspedisi yang pernah kembali. Karena itulah, kelima wilayah Orion tidak pernah saling mengenal -- mereka tumbuh dengan budaya, bahasa, pasukan, dan sejarah yang sepenuhnya berbeda.

Namun kini, keseimbangan dalam masing-masing benua telah hancur dari dalam -- perang saudara, pengkhianatan, dan **kekuatan gelap yang belum diketahui asalnya** mulai menggerogoti Orion satu per satu. Sang Dewi menyadari bahwa ancaman ini bukan berasal dari salah satu benua -- melainkan dari sesuatu yang jauh lebih tua, yang tidur di bawah dasar Samudra Abyssal.

**Sang Dewi Orion** -- sosok misterius yang menjaga keseimbangan dunia -- menyadari bahwa tidak ada satu pun pemimpin di Orion yang mampu menyatukan kelima wilayah. Karena itu, ia membuka portal ke dunia lain dan memanggil seseorang dari luar: seorang Raja yang belum terkontaminasi oleh perpecahan Orion.

### Premis Utama

> *Seorang Raja dari dunia modern dipanggil oleh Sang Dewi ke dunia Orion yang dilanda kekacauan. Untuk membawa kedamaian, ia harus menaklukkan dan menyatukan dunia -- dibantu oleh para Jenderal, jiwa-jiwa pahlawan sejarah yang telah bereinkarnasi sebagai wanita-wanita perkasa di Orion.*

### Elemen Kunci Lore

- **Para Jenderal** bukan sekadar prajurit -- mereka adalah jiwa-jiwa pahlawan legendaris dari berbagai era sejarah yang telah terlahir kembali di Orion dengan kekuatan penuh namun tanpa memori masa lalu mereka.
- **Sang Dewi** memiliki motif yang belum sepenuhnya jelas -- apakah ia benar-benar menginginkan kedamaian, atau ada sesuatu yang lebih besar di balik pemanggilan sang Raja?
- **Samudra Abyssal & Levianthos** -- monster laut purba yang memisahkan kelima benua. Kelak, menaklukkan Levianthos akan menjadi kunci membuka jalur antar benua dan membuka chapter akhir game.
- **Kekuatan Gelap** yang menjadi dalang kekacauan Orion tidur di bawah Samudra Abyssal -- hubungannya dengan Levianthos belum diketahui dan akan terungkap bertahap sepanjang kampanye.

---

## 3. Core Gameplay Loop

```
Pilih misi / kampanye
        ↓
Susun formasi & pilih jenderal
        ↓
Deploy pasukan di peta
        ↓
Gerakkan unit giliran per giliran
        ↓
Gunakan skill jenderal secara strategis
        ↓
Taklukkan wilayah / selesaikan objektif
        ↓
Dapatkan reward (Gold, XP, item)
        ↓
Upgrade jenderal & pasukan
        ↓
Lanjut ke misi berikutnya
```

### Mekanik Dasar

- **Giliran (Turn):** Pemain dan musuh bergerak bergantian. Setiap unit memiliki jatah gerak dan aksi per giliran.
- **Peta Berbasis Hex Tile:** Peta dibagi dalam grid heksagonal (segi enam). Setiap hex memiliki **6 arah gerak** -- lebih natural dan fleksibel dibanding grid persegi.
- **Sistem Aksi Independen:** Gerak dan serang adalah dua aksi yang **terpisah dan bebas**. Unit bisa:
  - Bergerak saja (tanpa menyerang)
  - Menyerang saja (tanpa bergerak, jika musuh sudah dalam jangkauan)
  - Bergerak lalu menyerang
  - Tidak melakukan apa-apa (skip)
- **Jenis Pasukan:** Infantry, Cavalry, Range -- masing-masing punya kelebihan dan kelemahan berdasarkan sistem segitiga.
- **Objektif Variatif:** Tidak hanya "habisi semua musuh" -- ada objektif seperti pertahankan titik, escort unit, selesaikan dalam X giliran, dll.

---

## 3b. Sistem Unit

Terdapat **3 jenis unit** yang bisa dikerahkan di medan perang. Setiap jenis memiliki peran, kelebihan, dan kelemahan yang berbeda.

### Tiga Jenis Unit

| Unit | Peran | Jangkauan Serang | Aksi per Giliran |
|---|---|---|---|
| **Infantry** | Garda depan, tank | 1 hex (jarak dekat) | Gerak + Serang (bebas urutan) |
| **Cavalry** | Penyerang cepat | 1 hex (jarak dekat) | Gerak + Serang (bebas urutan) |
| **Range** | Penyerang jarak jauh | 2-3 hex | Serang tanpa perlu bergerak |

### Stat Dasar Per Unit

| Stat | Infantry | Cavalry | Range |
|---|---|---|---|
| HP | Tinggi | Sedang | Rendah |
| Attack | Sedang | Tinggi | Sedang |
| Defense | Tinggi | Rendah | Rendah |
| Mobility | 2 hex | 4 hex | 3 hex |
| Jangkauan Serang | 1 hex | 1 hex | 3 hex |

### Sistem Aksi Per Giliran

Setiap unit mendapat **2 token aksi** per giliran:
- **Move token** -- digunakan untuk bergerak ke hex tujuan
- **Attack token** -- digunakan untuk menyerang musuh dalam jangkauan

Kedua token bisa digunakan dalam urutan bebas, atau salah satu saja. Setelah kedua token habis atau pemain menekan **End Turn**, giliran berpindah ke musuh.

### Sistem Segitiga (Triangle System)

```
Infantry --> menang lawan Cavalry   (+25% damage)
Cavalry  --> menang lawan Range     (+25% damage)
Range    --> menang lawan Infantry  (+25% damage)
```

### Hex Grid -- 6 Arah Gerak

Berbeda dari grid persegi (4 arah), hex grid memberi **6 arah gerak**:

```
    [TL][TR]
  [L]  [ ]  [R]
    [BL][BR]
```

Ini membuat flanking, pengepungan, dan manuver terasa lebih natural dan taktis.

### Bonus Terrain (Hex)

Setiap jenis unit mendapat bonus berdasarkan terrain hex:

| Terrain | Efek |
|---|---|
| Dataran (Plain) | Tidak ada bonus |
| Hutan (Forest) | Infantry +15% Defense, Cavalry -1 Mobility |
| Bukit (Hill) | Range +20% Attack, Infantry +10% Defense |
| Sungai (River) | Cavalry tidak bisa lewat, Infantry -1 Mobility |
| Jalan (Road) | Semua unit +1 Mobility |
| Reruntuhan (Ruin) | Infantry +10% Defense, cover dari Range |

---

## 4. Sistem Era & Wilayah

Dunia Orion dibagi menjadi **5 Wilayah Besar**, masing-masing terinspirasi dari satu era dan budaya sejarah nyata.

| Wilayah | Inspirasi Era | Ciri Khas Medan | Contoh Jenderal |
|---|---|---|---|
| **Aurestia** | Romawi & Yunani Kuno | Kota-kota klasik, koloseum, padang rumput Mediterania | Julia Caesar, Cleopatra, Leonidas |
| **Valdenmoor** | Abad Pertengahan Eropa | Kastil, hutan gelap, jembatan batu | Jeanne d'Arc, Saladin, Richard I |
| **Sakurima** | Asia (Jepang, China, Mongolia) | Kuil, pegunungan bersalju, hutan bambu | Oda Nobunaga, Wu Zetian, Genghis Khan |
| **Grandilion** | Era Napoleon & Revolusi | Kota industri awal, ladang pertempuran, benteng | Napoleon, Wellington, Kutuzov |
| **The Shattered North** | Viking & Barbar | Fjord, tundra, reruntuhan kuno | Ragnar, Boudicca, Attila |

### Mekanik Unik Per Wilayah

Setiap wilayah memiliki mekanik khusus yang membedakan gaya bermain:

- **Aurestia:** Sistem formasi Legio -- unit yang berdekatan mendapat bonus defensif.
- **Valdenmoor:** Medan kastil -- pertempuran siege dengan mekanik tembok dan gerbang.
- **Sakurima:** Sistem honor -- aksi tertentu memberikan atau mengurangi poin honor yang mempengaruhi morale pasukan.
- **Grandilion:** Artileri -- unit meriam dengan jangkauan jauh tapi butuh setup giliran.
- **The Shattered North:** Cuaca ekstrem -- blizzard atau badai bisa mempengaruhi visibility dan movement.

---

## 5. Sistem Jenderal

### Cara Mendapatkan Jenderal

- Semua jenderal dapat direkrut menggunakan **Gold** (mata uang in-game yang diperoleh dari gameplay).
- Jenderal tertentu di-unlock melalui penyelesaian kampanye cerita.
- **Gacha hanya untuk Skin** -- tidak ada jenderal eksklusif gacha. Gacha murni kosmetik.

### Tingkatan Jenderal (Rarity)

| Kelangkaan | Kategori | Cara Mendapatkan |
|---|---|---|
| <span style="color:#B87333">Copper</span> | Jenderal Umum | Gold murah, Market |
| <span style="color:#A9A9A9">Silver</span> | Jenderal Terkenal | Gold sedang, Market |
| <span style="color:#FFD700">Gold</span> | Jenderal Legendaris | Gold mahal, milestone kampanye / arc cerita |


### Sistem Upgrade

- **Level Up:** Menggunakan XP dari pertempuran.
- **Skill Upgrade:** Menggunakan Gold + material khusus dari misi.

### Sistem Skill

Setiap jenderal memiliki 3 skill:
- **Skill Aktif:** Diaktifkan manual saat giliran, memiliki cooldown.
- **Skill Pasif:** Selalu aktif, memberikan bonus kondisional.

---

## 6. Karakter: Julia Caesar

> **Jenderal pertama & karakter tutorial Isekai Conqueror.**

### Profil

| Atribut | Detail |
|---|---|
| **Nama** | Julia Caesar |
| **Inspirasi Sejarah** | Julius Caesar |
| **Wilayah** | Aurestia |
| **Rarity** | Gold |
| **Role** | Infantry Specialist |
| **Spesialisasi** | Memimpin unit Infantry -- mendapat bonus eksklusif saat memimpin pasukan berjenis Infantry |
| **Archetype Anime** | Rival yang akhirnya jadi sekutu -- ambisius, sarkastik, perfeksionis |

### Kepribadian

Julia Caesar adalah wanita yang tidak pernah meragukan dirinya sendiri. Ia percaya bahwa kepemimpinan bukan soal gelar -- melainkan kemampuan. Ia sarkastik kepada orang yang dianggapnya lemah, tapi jika seseorang berhasil membuktikan diri di hadapannya, Julia akan memberikan loyalitas penuh tanpa syarat.

Kutipan khas:
> *"Aku tidak membutuhkan keberuntungan. Aku sudah merencanakan segalanya -- termasuk kemenanganmu."*

### Lore di Dunia Orion

Julia Caesar adalah pemimpin Legio Aurestia, pasukan paling disiplin di benua Aurestia. Ia memerintah wilayah utara dengan tangan besi, namun rakyatnya mencintainya karena keadilannya. Saat Sang Dewi membawa sang Raja ke Orion, Julia adalah orang pertama yang datang -- bukan untuk menyambut, melainkan untuk menguji. Jika sang Raja berhasil membuktikan dirinya layak, Julia akan mengikutinya. Jika tidak, ia akan mengambil alih segalanya sendiri.

### Base Stats

| Stat | Nilai | Keterangan |
|---|---|---|
| Attack | 88 | Memberikan damage yang besar |
| Defense | 75 | Cukup tangguh |
| Mobility | 70 | Pergerakan cukup jauh |
| Leadership | 92 | Meningkatkan ekonomi kota |
| Morale | 85 | Tidak mudah masuk mode panik |

### Skills

#### I. Veni, Vidi, Vici *(Aktif)*
> Pasukan Julia bergerak dan menyerang dalam satu giliran tanpa penalti. Damage meningkat **+30%** jika musuh belum bergerak pada giliran itu.  
> *Cooldown: 3 giliran.*

#### II. Legio Formation *(Pasif)*
> Jika 2 atau lebih unit berdekatan di tile yang bersebelahan, seluruh unit tersebut mendapat **+20% Defense**.

#### III. Infantry General *(Pasif)*
> Jika memimpin pasukan infantry, unit tersebut mendapatkan **+10% Attack**.  


---

## 7. Campaign Mode

### Struktur Campaign

Campaign dibagi per **Wilayah** (Arc). Setiap wilayah memiliki:
- Beberapa chapter dengan misi-misi bertahap.
- Satu Boss Battle di akhir wilayah.
- Satu jenderal utama yang di-unlock setelah menyelesaikan wilayah.

### Arc 1: Aurestia (Wilayah Pertama + Tutorial)

**Premis Arc:**  
Sang Raja tiba di Orion dan mendarat di Aurestia, wilayah yang sedang dilanda konflik internal. Julia Caesar, pemimpin Legio Aurestia, tidak percaya begitu saja kepada orang asing yang mengaku dipanggil oleh Sang Dewi. Ia menantang sang Raja untuk membuktikan diri dalam serangkaian pertempuran.

**Chapter yang Direncanakan:**

| Chapter | Judul | Objektif | Jenis Misi |
|---|---|---|---|
| 1 | Kedatangan yang Tidak Disambut | Tutorial dasar movement & attack | Tutorial |
| 2 | Ujian Legio | Kalahkan skuad Legio Caesar | Battle |
| 3 | Ancaman dari Timur | Pertahankan desa dari serangan bandit | Defense |
| 4 | Perjanjian di Rubicon | Boss fight: Julia Caesar | Boss Battle |
| 5 | Di Bawah Panji yang Sama | Escort Julia ke ibu kota Aurestia | Escort |

---

## 8. Tutorial Design

### Filosofi Tutorial

Tutorial di Isekai Conqueror **tidak boleh membosankan**. Seluruh tutorial disampaikan melalui narasi dan dialog Julia Caesar yang menggabungkan instruksi dengan kepribadiannya yang sarkastik. Pemain belajar sambil merasa sedang berinteraksi dengan karakter, bukan membaca manual.

---

### 8a. Desain Peta Tutorial (Chapter 1)

**Ukuran peta:** 10 x 8 tile

**Kondisi menang:** Capai tile Gerbang Kota (kolom 9, baris 7)

**Kondisi kalah:** Seluruh unit pemain dikalahkan

#### Layout Peta

```
[ ][ ][H][H][ ][ ][R][R][H][ ]   Baris 1
[ ][P][J][ ][ ][ ][R][ ][H][ ]   Baris 2  P=Pemain
[ ][ ][J][F][ ][ ][ ][ ][ ][ ]   Baris 3
[F][F][J][F][ ][S][S][S][ ][ ]   Baris 4
[ ][ ][J][ ][ ][S][E1][ ][ ][ ]  Baris 5  E1=Musuh Infantry
[ ][H][J][ ][ ][S][ ][E2][ ][ ]  Baris 6  E2=Musuh Range
[ ][H][J][J][J][ ][ ][ ][OBJ][ ] Baris 7  OBJ=Gerbang Kota
[ ][ ][ ][ ][ ][ ][ ][ ][ ][ ]   Baris 8

Keterangan: H=Bukit, F=Hutan, J=Jalan, S=Sungai, R=Reruntuhan
```

#### Tile & Efek Terrain

| Terrain | Efek |
|---|---|
| Dataran | Tidak ada bonus |
| Bukit | Range +20% Attack, Infantry +10% Defense |
| Hutan | Infantry +15% Defense, Cavalry -1 Mobility |
| Jalan | Semua unit +1 Mobility |
| Sungai | Cavalry tidak bisa menyeberang, Infantry -1 Mobility |
| Reruntuhan | Infantry +10% Defense, cover dari serangan Range |

#### Musuh di Peta Tutorial

| ID | Jenis | Posisi | Perilaku AI |
|---|---|---|---|
| E1 | Infantry | Kol 7, Baris 5 | Bergerak mendekati pemain saat jarak <= 4 |
| E2 | Range | Kol 8, Baris 6 | Diam di tempat, menyerang dari jarak jauh |

#### Desain Tujuan Tutorial

Peta sengaja dirancang untuk mengajarkan tiga hal secara alami lewat layout-nya:

1. **Jalan** mengajarkan bonus Mobility -- pemain secara naluri akan mengikuti jalan karena lebih cepat
2. **Sungai** mengajarkan terrain blocking -- pemain perlu memutar atau mencari celah penyeberangan
3. **Reruntuhan** mengajarkan cover -- pemain bisa berlindung dari serangan E2 di balik reruntuhan

---

### 8b. Alur Tutorial (Chapter 1)

```
[Cutscene] Sang Raja tiba di Orion -- disorientasi
        ↓
Julia muncul -- meremehkan sang Raja
        ↓
Julia: "Kalau kamu benar-benar Raja, tunjukkan padaku."
        ↓
[Battle Tutorial dimulai -- peta muncul]
        ↓
Giliran 1: Julia menjelaskan movement (prompt muncul di layar)
        ↓
Giliran 2: Julia menjelaskan serangan saat E1 dalam jangkauan
        ↓
Giliran 3: Pemain bebas -- Julia berkomentar soal terrain
        ↓
E1 dikalahkan -- Julia memberi komentar singkat
        ↓
Giliran selanjutnya: Julia menjelaskan serangan jarak jauh E2
        ↓
E2 dikalahkan -- objektif Gerbang Kota terbuka
        ↓
Pemain mencapai Gerbang Kota
        ↓
Julia: "...Tidak buruk. Untuk pemula."
        ↓
[Cutscene penutup] Julia setuju memandu sang Raja
```

### Hal yang Diajarkan di Tutorial

1. **Sistem giliran** -- cara menggerakkan unit dan menyerang
2. **Tile & jangkauan** -- berapa jauh unit bisa bergerak
3. **Terrain bonus** -- efek hutan, bukit, jalan, sungai
4. **Jenis unit** -- perbedaan Infantry vs Range
5. **Kondisi menang** -- capai objektif, bukan hanya habisi musuh
6. **UI dasar** -- HP bar, giliran, tombol end turn

---

### 8c. Script Dialog Chapter 1

#### Scene 1 -- Kedatangan (Cutscene)

> **[Layar gelap. Suara angin. Perlahan muncul cahaya.]**

> **Julia:** "..."
> *(Hening. Langkah kaki mendekat.)*

> **Julia:** "Jadi ini dia yang disebut Sang Dewi sebagai 'harapan Orion'."
> *(Nada datar, tidak terkesan sama sekali.)*

> **Julia:** "Tidak ada apa-apanya."

> **Raja:** "Kamu siapa?"

> **Julia:** "Julia Caesar. Pemimpin Legio Aurestia."
> *(Membalik badan, tidak memandang sang Raja.)*

> **Julia:** "Dan kamu adalah orang asing yang entah dari mana, yang tiba-tiba mengklaim akan membawa kedamaian ke Orion."

> **Julia:** "Lucu."

---

#### Scene 2 -- Tantangan (Menjelang Battle)

> **Raja:** "Aku tidak mengklaim apapun. Sang Dewi yang--"

> **Julia:** "Aku tidak peduli apa kata Sang Dewi."
> *(Berbalik, menatap tajam.)*

> **Julia:** "Yang aku pedulikan adalah satu hal -- apakah kamu layak?"

> **Julia:** "Buktikan. Sekarang."

> **[Transisi ke peta pertempuran]**

---

#### Scene 3 -- Tutorial Giliran 1 (Movement)

> **Julia:** *(muncul di sisi layar)*
> "Kita mulai dari dasar. Gerakkan unitmu."

> **[Prompt UI: tile hijau muncul menunjukkan jangkauan]**

> **Julia:** "Tile yang bercahaya adalah area yang bisa kamu capai giliran ini."
> "Jalan itu -- ikuti jalan. Lebih cepat."

> **[Setelah pemain bergerak]**

> **Julia:** "Baik. Tidak terlalu buruk."

---

#### Scene 4 -- Tutorial Giliran 2 (Combat)

> **[E1 masuk jangkauan serangan]**

> **Julia:** "Musuh dalam jangkauan. Serang."

> **[Prompt UI: tile oranye muncul pada E1]**

> **Julia:** "Infantry lawan Infantry. Tidak ada keunggulan. Murni kekuatan."
> "Jangan ragukan dirimu."

> **[Setelah serangan berhasil]**

> **Julia:** "Damage dihitung berdasarkan Attack dikurangi Defense musuh."
> "Ingat itu."

---

#### Scene 5 -- Tutorial Terrain (Sungai & Cover)

> **[Pemain mendekati sungai]**

> **Julia:** "Berhenti."
> "Sungai. Infantry bisa menyeberang -- tapi gerakanmu akan melambat."
> "Cavalry tidak bisa sama sekali. Pilih jalurmu dengan bijak."

> **[Pemain menggunakan reruntuhan sebagai cover dari E2]**

> **Julia:** "Bagus. Reruntuhan itu memberi perlindungan dari serangan jarak jauh."
> "Musuh di belakang itu -- dia Range. Jangan berdiri di tempat terbuka."

---

#### Scene 6 -- E1 Dikalahkan

> **Julia:** "Satu musuh jatuh."
> *(Singkat. Tidak berlebihan.)*

> **Julia:** "Masih ada satu lagi. Yang itu berbahaya dari jauh."
> "Dekati dia, potong jarak serangannya."

---

#### Scene 7 -- E2 Dikalahkan & Objektif

> **[E2 dikalahkan]**

> **Julia:** "Gerbang Kota. Di sana."
> "Capai itu, dan kamu selesai."

> **[Pemain mencapai Gerbang Kota]**

> **Julia:** "..."
> *(Diam sejenak.)*

> **Julia:** "...Tidak buruk. Untuk pemula."

---

#### Scene 8 -- Penutup (Cutscene)

> **Raja:** "Apakah itu cukup untuk membuktikan diriku?"

> **Julia:** "Belum."
> *(Berbalik berjalan pergi.)*

> **Julia:** "Tapi kamu tidak mempermalukanku. Itu cukup untuk sekarang."

> **Julia:** "Ikuti aku. Aurestia butuh lebih dari sekadar satu pertempuran kecil."

> **[Cutscene berakhir. Chapter 1 selesai. Julia Caesar bergabung sebagai jenderal.]**

---

## 9. Mode Permainan

| Mode | Deskripsi | Status |
|---|---|---|
| **Campaign Mode** | Ikuti kisah utama menaklukkan 5 wilayah Orion | Prioritas utama |
| **Conquest Mode** | Sandbox bebas, taklukkan peta dunia Orion tanpa batasan cerita | Fase berikutnya |
| **Historical Battles** | Recreate pertempuran sejarah terkenal dengan twist anime | Fase berikutnya |
| **PvP Mode** | Lawan raja dari pemain lain secara asinkron | Fase lanjut |

---

## 10. Monetisasi

### Filosofi Monetisasi

> Pemain yang tidak mengeluarkan uang tetap bisa menikmati **100% konten gameplay**. Tidak ada jenderal, stage, atau fitur gameplay yang dikunci di balik pembayaran. Monetisasi murni bersifat kosmetik.

### Tabel Monetisasi

| Item | Cara Mendapatkan | Bisa Dibeli? |
|---|---|---|
| Jenderal (semua) | Gold dari gameplay | Tidak perlu beli |
| Gold | Gameplay, daily login, event | Opsional (top-up) |
| Skin Jenderal | Gacha / Event khusus / Battle Pass | Ya |
| Battle Pass | Pembelian bulanan | Ya (opsional) |
| Material Upgrade | Gameplay, stage reward | Tidak perlu beli |

### Gacha

- Gacha **hanya berlaku untuk skin** (penampilan jenderal), bukan jenderal itu sendiri.
- Setiap gacha pull menggunakan mata uang khusus yang bisa didapatkan dari event, atau dibeli.
- Sistem pity terjamin setelah sejumlah pull tertentu.

---

## 11. UI & UX Design

### Filosofi UI

UI Isekai Conqueror menggabungkan estetika **medieval fantasy** dari European War 7 dengan sentuhan **anime** yang hangat. Setiap layar harus terasa konsisten -- seperti membuka halaman buku tua yang hidup.

### Referensi UI dari European War 7

Berdasarkan analisis screenshot EW7, berikut elemen yang diadaptasi untuk Isekai Conqueror:

#### Navigasi Utama (Main Menu)
Tiga tombol besar di kanan layar:
- **Campaign** -- mode cerita utama
- **Conquest** -- mode sandbox *(fase lanjut)*
- **Territory** -- mode pertahanan wilayah *(fase lanjut)*

Ikon pendukung di kiri layar: Event, Setting, Notice, Sign-in (Daily Login), Cloud Archive.

#### Bottom Navigation (dalam Campaign)
Empat tab tetap di bawah layar:

| Tab | Fungsi di EW7 | Adaptasi untuk Isekai Conqueror |
|---|---|---|
| **Castle** | Pilih raja & upgrade | **Palace** -- pilih Raja & upgrade istana |
| **Item** | Inventori & crafting | **Item** -- equipment untuk jenderal |
| **General** | Koleksi jenderal | **General** -- koleksi & upgrade jenderal |
| **Shop** | Beli item dengan Gold | **Market** -- beli unit, item, & material |

#### Sistem Mata Uang
EW7 menggunakan dua mata uang utama yang terlihat di HUD atas: Gold (koin) dan Medal (laurel). Isekai Conqueror mengadopsi sistem serupa:

| Mata Uang | Cara Dapat | Kegunaan |
|---|---|---|
| **Gold** | Gameplay, daily login, stage reward | Rekrut jenderal, beli item, upgrade |
| **Crystal** | Event, achievement, pembelian | Gacha skin, item eksklusif event |

#### Layar General (Jenderal)
Berdasarkan screenshot EW7 General screen -- jenderal ditampilkan dalam **grid portrait** dengan tab rarity di atas. Adaptasi untuk Isekai Conqueror:
- Tab rarity: **Gold / Silver / Copper** (sesuai sistem kita)
- Portrait gaya anime dengan frame dekoratif
- Tap portrait = buka detail stats, skill, dan lore jenderal

#### Sistem Item
EW7 membagi item ke dalam tiga kategori (tab atas): Equipment, War Gear, dan Armor. Adaptasi:
- **Equipment** -- senjata untuk boost Attack jenderal
- **War Gear** -- item situasional (catapult, dll)
- **Relic** -- armor & artefak untuk boost Defense & skill

#### Sistem Triumphs (Achievement)
EW7 punya sistem achievement berjenjang dengan reward berlapis. Isekai Conqueror mengadopsi:
- **Triumphs** -- achievement dengan progress bar dan reward bertahap
- Contoh: "Selesaikan 2 misi tutorial", "Kumpulkan 4 Jenderal", "Menangkan 10 pertempuran"

#### Sistem Bond
EW7 menampilkan Bond sebagai pasangan jenderal yang memberi bonus pasif saat keduanya dimiliki. Adaptasi:
- **Pact** -- dua jenderal yang memiliki hubungan sejarah (Julia Caesar & Cleopatra, Joan of Arc & Saladin, dll)
- Saat keduanya aktif di roster, bonus pasif aktif (misal: +15% Attack untuk semua Infantry)

#### Sistem Daily Login
EW7 menampilkan kalender reward harian dengan item berbeda setiap hari. Adaptasi:
- Login harian memberi Gold, Crystal, dan material upgrade
- Hari ke-7 memberikan jenderal Silver tier gratis

#### Privilege / Battle Pass
EW7 menjual "Privilege" berupa buff permanen. Ini adalah area yang perlu **hati-hati** -- Isekai Conqueror memilih pendekatan yang lebih player-friendly:
- **Tidak ada buff permanen berbayar** yang mempengaruhi gameplay
- Satu-satunya pembelian opsional: **Cosmetic Pass** (skin jenderal, efek visual giliran, frame portrait)

#### Growth Path

EW7 memiliki sistem **Growth Path** -- semacam battle pass gratis yang progresif. Pemain menyelesaikan quest bertahap dan mendapat reward. Isekai Conqueror mengadopsinya sebagai:

- **Conqueror's Path** -- sistem progression utama
- Setiap stage memiliki 4-6 quest (misal: selesaikan tutorial, rekrut jenderal pertama, menangkan 5 battle)
- Menyelesaikan semua quest di satu stage membuka stage berikutnya + reward besar

#### Quick Collection

Tombol **"One Click Collection"** di EW7 memungkinkan pemain mengambil semua reward harian sekaligus. Isekai Conqueror mengadopsi fitur ini -- pemain tidak perlu mengklik satu per satu.

#### Sistem Dialog Dalam Battle

EW7 menampilkan portrait jenderal di pojok kiri bawah dengan speech bubble saat battle berlangsung. Ini adalah elemen yang **wajib** diadopsi untuk Isekai Conqueror karena sangat cocok dengan konsep karakter anime kita -- portrait Julia Caesar dengan ekspresi berbeda-beda memberikan personalitas yang kuat.

---

## 12. Sistem In-Battle

Bagian ini mendokumentasikan semua sistem yang aktif **selama pertempuran berlangsung**, berdasarkan analisis gameplay European War 7 sebagai referensi.

---

### 12a. Tiga Sumber Daya (Resources)

Setiap misi memiliki tiga sumber daya yang mengalir setiap giliran:

| Sumber Daya | Ikon | Sumber | Kegunaan |
|---|---|---|---|
| **Gold** | Koin emas | Kota, quest reward | Rekrut unit, beli item |
| **Iron** | Batang besi | Kota (Workshop) | Upgrade unit, crafting |
| **Wisdom** | Roda gigi | Kota (Library) | Unlock kebijakan kerajaan |

Income per giliran ditampilkan di layar awal misi sebelum battle dimulai, dan diupdate di HUD kiri layar setiap giliran. Kota yang lebih berkembang menghasilkan lebih banyak ketiga resource ini.

---

### 12b. Sistem Kota

Kota adalah **sumber daya utama** di peta. Setiap kota bisa dikuasai, dipertahankan, dan ditingkatkan.

#### Properti Kota

| Properti | Keterangan |
|---|---|
| **Durability (HP)** | HP kota -- jika habis, kota jatuh ke tangan musuh |
| **Level** | Level 1-5, mempengaruhi semua output |
| **Gold per giliran** | Income Gold dari kota ini |
| **Iron per giliran** | Income Iron dari kota ini |
| **Wisdom per giliran** | Income Wisdom dari kota ini |
| **Unit capacity** | Level kota menentukan tier unit yang bisa direkrut |

#### Bangunan Kota (tiga slot)

| Bangunan | Fungsi |
|---|---|
| **Fortification** | Meningkatkan HP dan Defense kota |
| **House** | Meningkatkan populasi & Gold per giliran |
| **Workshop** | Meningkatkan Iron & Wisdom per giliran |

#### Kondisi Kota

Kota bisa berada dalam dua kondisi yang mempengaruhi income:
- **Peaceful** -- income normal, unit bisa direkrut
- **Under Siege** -- income berkurang, unit tidak bisa direkrut

---

### 12c. Rekrutmen Unit di Kota

Setiap kota yang dikuasai bisa digunakan untuk merekrut unit baru selama battle. Bottom navigation saat klik kota menampilkan opsi rekrut.

Unit yang tersedia ditentukan oleh **level kota**:
- Level 1-2: Unit dasar (tier 1)
- Level 3-4: Unit menengah (tier 2-3)
- Level 5: Unit elite (tier 4-5)

Unit baru direkrut menggunakan Gold dan langsung muncul di hex kota tersebut.

---

### 12d. HUD In-Battle

**HUD Kiri (resource & status):**
```
[Populasi / Kapasitas]
[Gold income per giliran]
[Iron income per giliran]
[Wisdom income per giliran]
[Morale kerajaan]
[Unit 1 -- HP bar]
[Unit 2 -- HP bar]
[Unit 3 -- HP bar]
...
```

**HUD Kanan Atas:**
- Tombol Pause / Menu
- Tombol Skip animasi (fast forward)

**HUD Kanan Bawah:**
- Tombol End Turn (hourglass)
- Tombol Skip animasi musuh

**Bottom Navigation (dalam battle):**

| Tombol | Fungsi |
|---|---|
| **City** | Buka detail & bangun di kota yang dipilih |
| **General** | Lihat semua jenderal & unit yang dimiliki |
| **Waypoint** | Set jalur gerak unit secara otomatis |
| **War Gear** | Equip alat perang (Catapult, dll) ke unit |
| **Info** | Tampilkan Victory & Defeat conditions |
| **War Drum** | Gunakan item pemulihan HP unit |

---

### 12e. Sistem Unit Stacking & Legion Effect

Beberapa unit bisa berada di **hex yang sama** -- ini disebut **stacking**. Unit yang di-stack bersama membentuk sebuah **Legion**.

**Legion Effect** memberikan bonus pasif selama unit berada dalam hex yang sama:
- Bonus Defense untuk seluruh unit di hex tersebut
- Beberapa jenderal memiliki skill yang memperkuat Legion Effect mereka sendiri
- Julia Caesar -- skill *Legio Formation* adalah contoh bonus Legion Effect

Jumlah maksimal unit per hex: **3 unit**.

---

### 12f. Pohon Kebijakan Kerajaan (National Policy)

Di dalam battle, pemain bisa mengakses **National Policy** -- pohon kebijakan yang memberikan buff permanen selama misi berlangsung. Dibagi tiga kategori:

| Kategori | Contoh Kebijakan | Efek |
|---|---|---|
| **Combat** | Infantry Tactics | Infantry Mobility +1 |
| **Combat** | Cavalry Charge | Cavalry Attack +15% |
| **Combat** | Archer Training | Range Attack range +1 |
| **Logistics** | Iron Smelting | Iron income +20% |
| **Logistics** | Tax Reform | Gold income +25% |
| **Logistics** | Road Network | Semua unit Mobility +1 di Jalan |
| **Management** | City Defense | Fortification HP +30% |
| **Management** | Recruitment | Rekrut unit lebih murah -20% |
| **Management** | Research | Wisdom income +30% |

Setiap kebijakan dibuka menggunakan **Wisdom**. Kebijakan yang dipilih menyesuaikan gaya bermain pemain.

---

### 12g. War Gear (Alat Perang)

War Gear adalah item yang bisa di-equip ke unit sebelum atau selama battle:

| War Gear | Efek |
|---|---|
| **Catapult Lv.1** | Ignore 25% damage reduction dari kota/benteng |
| **Support Wagon** | Unit yang di-equip bisa memulihkan HP sekitar |

War Gear dikonsumsi hanya dalam satu battle -- setelah battle selesai, War Gear kembali ke inventori.

---

### 12h. Item Konsumable Dalam Battle

**War Drum** -- item yang bisa digunakan kapan saja saat giliran pemain untuk **memulihkan sejumlah kecil HP** unit yang dipilih. Sangat berguna saat unit hampir kalah sebelum sempat mundur.

Item ini didapat dari: stage reward, quest, daily login, dan Market.

---

### 12i. Waypoint System

Pemain bisa set **waypoint** (titik tujuan) ke unit agar bergerak otomatis melewati jalur yang sudah ditentukan. Ini berguna untuk:
- Menggerakkan banyak unit sekaligus tanpa harus klik satu per satu
- Menentukan rute aman menghindari musuh kuat

Waypoint ditampilkan sebagai pin kuning di peta.

---

### 12j. Dialog Karakter Dalam Battle

Seperti yang terlihat di referensi EW7 -- jenderal memberikan komentar situasional dalam battle lewat **dialog box** di pojok kiri bawah. Portrait karakter muncul di kiri, teks dialog di kanan.

Di Isekai Conqueror, dialog dalam battle menggunakan **gaya anime** -- portrait Julia Caesar (atau jenderal aktif) muncul dengan ekspresi berbeda sesuai situasi:

| Situasi | Contoh Dialog Julia |
|---|---|
| Awal battle | "Ikuti strategiku. Jangan bertindak sendiri." |
| Unit hampir mati | "Mundur dulu. Aku tidak membiarkan pasukanku mati sia-sia." |
| Musuh dikalahkan | "Tepat seperti yang kurencanakan." |
| Triangle advantage | "Keunggulan taktis. Gunakan sekarang." |
| Kota dikuasai | "Kota ini sekarang milik kita. Perkuat pertahanannya." |

---

### 12k. Pause Menu Dalam Battle

Saat tombol Pause ditekan, menu berikut muncul:

| Opsi | Fungsi |
|---|---|
| **Restart** | Ulangi misi dari awal |
| **Setting** | BGM, Sound, Game Speed |
| **Exit** | Keluar ke Campaign Menu |
| **Combat Scene** | Toggle ON/OFF animasi pertempuran |

**Combat Scene OFF** berguna untuk pemain yang ingin bermain lebih cepat tanpa animasi.

---

## 13. Referensi & Inspirasi

| Referensi | Aspek yang Diambil |
|---|---|
| **European War Series (EasyTech)** | Sistem turn-based di peta, jenderal dengan skill unik |
| **Fate/Grand Order** | Genderbent historical figures, lore jenderal, sistem gacha kosmetik |
| **Eiyuu Senki** | Strategy + karakter anime wanita dari tokoh sejarah |
| **Fire Emblem** | Sistem bond/relationship antar karakter, permanen death (referensi) |
| **Romance of the Three Kingdoms** | Kedalaman sistem jenderal dan strategi |

---

## 14. Roadmap Pengembangan

### Fase 1 -- Fondasi (SELESAI)
- [x] Konsep & visi game
- [x] Game Design Document v0.1
- [x] Desain wilayah (5 wilayah)
- [x] Desain jenderal pertama (Julia Caesar)
- [x] Sistem unit (Infantry, Cavalry, Range) & triangle system
- [x] Desain peta tutorial Aurestia (10x8 tile, 2 musuh, 1 objektif)
- [x] Script dialog Chapter 1 (8 scene lengkap)

### Fase 2 -- Prototipe
- [x] Setup Godot Engine
- [x] Implementasi sistem tile & movement (square grid)
- [x] Implementasi sistem giliran dasar
- [x] Sistem HP & combat dasar
- [x] Implementasi 3 jenis unit (Infantry, Cavalry, Range)
- [x] Implementasi triangle system
- [x] Implementasi terrain system (BFS pathfinding)
- [ ] Migrasi ke hex grid
- [ ] Sistem aksi independen (Move token + Attack token)
- [ ] Peta tutorial hex sederhana (1 stage)
- [ ] Placeholder art untuk unit

### Fase 3 -- Alpha
- [ ] Campaign Arc 1 (Aurestia) lengkap 5 chapter
- [ ] UI/UX dasar
- [ ] Sistem Gold & upgrade dasar
- [ ] Desain 3 jenderal Aurestia
- [ ] Basic enemy AI

### Fase 4 -- Beta
- [ ] Campaign Arc 2 (Valdenmoor)
- [ ] Sistem Gacha Skin
- [ ] Sound & music placeholder
- [ ] Balancing dan playtesting

### Fase 5 -- Release
- [ ] Semua 5 wilayah selesai
- [ ] 15+ jenderal
- [ ] Polish art & UI
- [ ] Conquest Mode
- [ ] Rilis di Google Play (Android)

---

*Dokumen ini akan terus diperbarui seiring perkembangan proyek.*  
*Versi berikutnya: GDD v0.7 -- Desain sistem kota & kebijakan kerajaan untuk Arc 1.*
