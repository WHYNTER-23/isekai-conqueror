# Isekai Conqueror
## Game Design Document (GDD)
**Versi:** 0.1  
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
11. [Referensi & Inspirasi](#11-referensi--inspirasi)
12. [Roadmap Pengembangan](#12-roadmap-pengembangan)

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

Dunia **Orion** adalah dunia paralel yang kaya akan sejarah dan kekuatan magis. Selama berabad-abad, lima wilayah besar di Orion hidup dalam keseimbangan yang rapuh. Namun kini, keseimbangan itu telah hancur -- perang, penghianatan, dan kekuatan gelap yang belum diketahui asalnya mulai menggerogoti Orion dari dalam.

**Sang Dewi Orion** -- sosok misterius yang menjaga keseimbangan dunia -- menyadari bahwa tidak ada satu pun pemimpin di Orion yang mampu menyatukan kelima wilayah. Karena itu, ia membuka portal ke dunia lain dan memanggil seseorang dari luar: seorang Raja yang belum terkontaminasi oleh perpecahan Orion.

### Premis Utama

> *Seorang Raja dari dunia modern dipanggil oleh Sang Dewi ke dunia Orion yang dilanda kekacauan. Untuk membawa kedamaian, ia harus menaklukkan dan menyatukan dunia -- dibantu oleh para Jenderal, jiwa-jiwa pahlawan sejarah yang telah bereinkarnasi sebagai wanita-wanita perkasa di Orion.*

### Elemen Kunci Lore

- **Para Jenderal** bukan sekadar prajurit -- mereka adalah jiwa-jiwa pahlawan legendaris dari berbagai era sejarah yang telah terlahir kembali di Orion dengan kekuatan penuh namun tanpa memori masa lalu mereka.
- **Sang Dewi** memiliki motif yang belum sepenuhnya jelas -- apakah ia benar-benar menginginkan kedamaian, atau ada sesuatu yang lebih besar di balik pemanggilan sang Raja?
- **Kekuatan Gelap** yang menjadi dalang kekacauan Orion akan terungkap secara bertahap sepanjang kampanye.

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
- **Peta Berbasis Tile:** Peta dibagi dalam grid tile. Setiap unit memiliki jangkauan gerak yang berbeda tergantung jenis pasukan.
- **Jenis Pasukan:** Infantry, Cavalry, Archer, Siege -- masing-masing punya kelebihan dan kelemahan (sistem segitiga atau lebih kompleks).
- **Objektif Variatif:** Tidak hanya "habisi semua musuh" -- ada objektif seperti pertahankan titik, escort unit, selesaikan dalam X giliran, dll.

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
| **Role** | Infantry / Strategist |
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

### Alur Tutorial (Chapter 1)

```
[Cutscene] Sang Raja tiba di Orion -- disorientasi
        ↓
Julia muncul -- meremehkan sang Raja
        ↓
Julia: "Kalau kamu benar-benar Raja, tunjukkan padaku."
        ↓
[Battle Tutorial dimulai]
        ↓
Giliran 1: Julia menjelaskan cara menggerakkan unit
        ↓
Giliran 2: Julia menjelaskan cara menyerang
        ↓
Giliran 3: Pemain bebas bergerak -- Julia berkomentar
        ↓
Musuh terakhir dikalahkan
        ↓
Julia: "...Tidak buruk. Untuk pemula."
        ↓
[Cutscene singkat] Julia setuju memandu sang Raja
```

### Hal yang Diajarkan di Tutorial

1. **Sistem giliran** -- cara menggerakkan unit dan menyerang.
2. **Tile & jangkauan** -- berapa jauh unit bisa bergerak.
3. **Penggunaan skill** -- menggunakan *Veni, Vidi, Vici* untuk pertama kali.
4. **Kondisi menang** -- memahami objektif misi.
5. **UI dasar** -- HP bar, giliran, tombol end turn.

### Gaya Dialog Julia di Tutorial

Julia **tidak** berbicara seperti NPC tutorial biasa. Contoh:

> *"Tile itu. Gerakkan unitmu ke sana. Jangan membuatku menjelaskan dua kali."*

> *"Musuh di depanmu tidak akan menunggu kamu berpikir selamanya, Raja."*

> *"Skill-ku bernama Veni, Vidi, Vici. Datang, Lihat, Menang. Kamu cukup tekan tombol itu -- sisanya biar aku yang urus."*

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

## 11. Referensi & Inspirasi

| Referensi | Aspek yang Diambil |
|---|---|
| **European War Series (EasyTech)** | Sistem turn-based di peta, jenderal dengan skill unik |
| **Fate/Grand Order** | Genderbent historical figures, lore jenderal, sistem gacha kosmetik |
| **Eiyuu Senki** | Strategy + karakter anime wanita dari tokoh sejarah |
| **Fire Emblem** | Sistem bond/relationship antar karakter, permanen death (referensi) |
| **Romance of the Three Kingdoms** | Kedalaman sistem jenderal dan strategi |

---

## 12. Roadmap Pengembangan

### Fase 1 -- Fondasi (Sekarang)
- [x] Konsep & visi game
- [x] Game Design Document v0.1
- [x] Desain wilayah (5 wilayah)
- [x] Desain jenderal pertama (Julia Caesar)
- [ ] Desain peta tutorial Aurestia
- [ ] Script dialog Chapter 1

### Fase 2 -- Prototipe
- [ ] Setup Godot Engine
- [ ] Implementasi sistem tile & movement
- [ ] Implementasi sistem giliran dasar
- [ ] Peta tutorial sederhana (1 stage)
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
*Versi berikutnya: GDD v0.2 -- Desain peta tutorial & enemy pertama.*
