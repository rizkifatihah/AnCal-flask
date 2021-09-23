-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 22, 2021 at 01:43 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ancal`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id_admin`, `email`, `password`) VALUES
(1, 'admin@gmail.com', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `sapi`
--

CREATE TABLE `sapi` (
  `id_sapi` int(11) NOT NULL,
  `nama_sapi` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sapi`
--

INSERT INTO `sapi` (`id_sapi`, `nama_sapi`, `content`, `image`) VALUES
(0, 'Sapi Aceh', '                                                                <div class=\"field field-name-field-deskripsi-singkat field-type-text-with-summary field-label-above\" style=\"color: rgb(0, 0, 0); font-family: FrutigerLTW02-45Light, Arial, Helvetica, Verdana, sans-serif; font-size: 14.4px;\"><div class=\"field-label\" style=\"font-weight: bold;\">Deskripsi Singkat:&nbsp;</div><div class=\"field-label\" style=\"font-weight: bold;\"><br></div><div class=\"field-items\"><div class=\"field-item even\"><p>Sapi aceh merupakan salah satu rumpun sapi lokal Indonesia yang mempunyai sebaran asli geografis di Provinsi Aceh, dan telah dibudidayakan secara turuntemurun.</p><p><span style=\"font-size: 14.4px;\">Sapi aceh merupakan kekayaan sumber daya genetik ternak Indonesia yang perlu dilindungi dan dilestarikan</span></p></div></div></div><div class=\"field field-name-field-ciri-kualitatif field-type-text-long field-label-above\" style=\"color: rgb(0, 0, 0); font-family: FrutigerLTW02-45Light, Arial, Helvetica, Verdana, sans-serif; font-size: 14.4px;\"><div class=\"field-label\" style=\"font-weight: bold;\">Ciri Spesifik Sifat Kualitatif:&nbsp;</div><div class=\"field-items\"><div class=\"field-item even\"><p>1) warna :<br>a) tubuh dominan : merah kecokelatan pada<br>yang jantan dan merah<br>bata pada yang betina;<br>b) kepala : sekeliling mata, telinga<br>bagian dalam dan bibir<br>atas berwarna keputihputihan;<br>c) leher : lebih gelap pada yang<br>jantan;<br>d) garis punggung : cokelat kehitaman;<br>e) paha belakang : merah bata;<br>f) pantat : cokelat muda;<br>g) kaki : keputih-putihan;<br>h) ekor : bagian ujung berwarna<br>hitam;<br>i) rambut : merah bata sampai<br>cokelat;<br>j) bentuk muka : pada umumnya cekung;<br>k) bentuk punggung : pada umumnya cekung;</p><p>2) bentuk tanduk : mengarah ke samping<br>dan melengkung ke<br>atas;<br>3) bentuk telinga : kecil, mengarah ke<br>samping, tidak terkulai.</p></div></div></div>\r\n              \r\n              \r\n              \r\n              ', 'sapiaceh.jpeg'),
(1, 'Sapi Bali', '                                <div class=\"field field-name-field-deskripsi-singkat field-type-text-with-summary field-label-above\" style=\"color: rgb(0, 0, 0); font-family: FrutigerLTW02-45Light, Arial, Helvetica, Verdana, sans-serif; font-size: 14.4px;\"><div class=\"field-label\" style=\"font-weight: bold;\">Deskripsi Singkat:&nbsp;</div><div class=\"field-label\" style=\"font-weight: bold;\"><br></div><div class=\"field-items\"><div class=\"field-item even\"><p>Sapi Bali merupakan sapi hasil domestikasi dari banteng asli Indonesia yang mempunyai keunggulan dalam daya reproduksi, daya adaptasi dan persentase karkas yang tinggi.</p><p>Sapi Bali mempunyai cari khas yang tidak dimiliki oleh sapi dari bangsa lainnnya dan merupakan sumber daya genetik asli Indonesia yang perlu dijaga dan dipelihara kelestariannya sehingga dapat memberikan manfaat dalam peningkatan kesejahteraan dan kemakmuran rakyat Indonesia</p></div></div></div><div class=\"field field-name-field-ciri-kualitatif field-type-text-long field-label-above\" style=\"color: rgb(0, 0, 0); font-family: FrutigerLTW02-45Light, Arial, Helvetica, Verdana, sans-serif; font-size: 14.4px;\"><div class=\"field-label\" style=\"font-weight: bold;\">Ciri Spesifik Sifat Kualitatif:&nbsp;</div><div class=\"field-items\"><div class=\"field-item even\"><p>a. Warna</p><ol style=\"margin: 0.5em 0px 1em; padding: 0px 0px 0px 1.5em; list-style-image: none;\"><li style=\"margin: 0.15em 0px 0.15em 0.5em; padding-bottom: 0.1em;\">tubuh - betina : warna bulu merah bata. - jantan : warna bulu merah bata tersebut berubah menjadi kehitaman dengan makin bertambahnya umur, perubahan warna tersebut terjadi pada kisaran umur 12 – 18 bulan. Perubahan warna tersebut tidak akan terjadi pada sapi bali jantan yang dikastrasi.</li><li style=\"margin: 0.15em 0px 0.15em 0.5em; padding-bottom: 0.1em;\">kaki : warna putih pada empat kaki bagian bawah, mulai dari tarsus/carpus ke bawah.</li><li style=\"margin: 0.15em 0px 0.15em 0.5em; padding-bottom: 0.1em;\">pantat : warna putih dengan batas yang jelas (bentuk oval).</li><li style=\"margin: 0.15em 0px 0.15em 0.5em; padding-bottom: 0.1em;\">bibir atas : warna putih.</li><li style=\"margin: 0.15em 0px 0.15em 0.5em; padding-bottom: 0.1em;\">bibir bawah : warna putih.</li></ol><p>b. Punggung : terdapat garis belut berwarna hitam pada betina.</p><p>c. Ekor : bagian ujung berwarna hitam.</p><p>d. Tanduk : hitam, meruncing, melengkung ke arah tengah.</p><p>e. Kemampuan kerja : baik</p><p>f. Kemampuan hidup secara liar : baik</p><p>g. Daya adaptasi terhadap pakan terbatas : baik</p><p>h. Daya adaptasi terhadap cekaman panas : baik</p><p>i. Kemampuan adaptasi terhadap lingkungan jelek : baik</p><p>j. Kemampuan mencerna pakan berserat tinggi : baik&nbsp;</p></div></div></div><div class=\"field field-name-field-ciri-kuantitatif field-type-text-long field-label-above\" style=\"color: rgb(0, 0, 0); font-family: FrutigerLTW02-45Light, Arial, Helvetica, Verdana, sans-serif; font-size: 14.4px;\"><div class=\"field-label\" style=\"font-weight: bold;\">Ciri Spesifik Sifat Kuantitatif:&nbsp;</div><div class=\"field-items\"><div class=\"field-item even\"><p>a. Bobot badan umur 2 tahun<br>- jantan : 210 – 260 kg<br>- betina : 170 – 225 kg<br>b. Tinggi badan<br>- jantan : 122,3 – 130,1 cm<br>- betina : 105,4 – 114,4 cm<br>c. Panjang badan<br>- jantan : 125,6 – 146,2 cm<br>- betina : 117,2 – 120,0 cm<br>d. Lingkar dada<br>- jantan : 180,4 – 188,8 cm<br>- betina : 158,6 – 174,2 cm<br>e. Kesuburan induk : 82 – 85%<br>f. Angka kelahiran : 40 – 85%<br>g. persentase karkas : 51 – 57%<br>h. kadar lemak daging : 2 – 6,9%<br>i. kemampuan hidup hingga dewasa : 68 – 80%</p></div></div></div><div class=\"field field-name-field-ciri-reproduksi field-type-text-long field-label-above\" style=\"color: rgb(0, 0, 0); font-family: FrutigerLTW02-45Light, Arial, Helvetica, Verdana, sans-serif; font-size: 14.4px;\"><div class=\"field-label\" style=\"font-weight: bold;\">Ciri Spesifik Sifat Reproduksi:&nbsp;</div><div class=\"field-items\"><div class=\"field-item even\"><p>a. umur pubertas : 540 – 660 hari<br>b. bobot saat pubertas : 165 – 185 kg<br>c. siklus estrus : 18 – 20 hari<br>d. service/Conception : 1,2 – 1,8<br>e. bunting : 286,6 ± 9,8 hari<br>f. kebuntingan : 86,56 ± 5,4%<br>g. beranak pertama : 730 – 972 hari<br>h. beranak : 69 – 86%/tahun<br>i. estrus postpartus : 62,8 ± 21,8 hari</p></div></div></div><div class=\"field field-name-field-sebaran field-type-text-long field-label-above\" style=\"color: rgb(0, 0, 0); font-family: FrutigerLTW02-45Light, Arial, Helvetica, Verdana, sans-serif; font-size: 14.4px;\"><div class=\"field-label\" style=\"font-weight: bold;\">Sebaran Awal dan Perkembangannya:&nbsp;</div><div class=\"field-items\"><div class=\"field-item even\">Wilayah sebaran hampir ke seluruh wilayah Negara Kesatuan Republik Indonesia</div></div></div>\r\n              \r\n              ', 'sapibali.jpeg'),
(2, 'Sapi Brahman Cross', '                <span style=\"color: rgb(68, 68, 68); font-family: arial, sans-serif; font-size: 12.8px; background-color: rgba(255, 255, 255, 0.8);\">Sapi BX (baca : Brahman Cross), adalah ternak sapi hasil domestikasi/ penjinakan sapi Brahman (asal India) yang dikembangkan di Amerika dan Australia dan disilangkan dengan jenis ternak dari daratan Amerika, seperti Shorthorn, Santa Gertrudis, Droughmaster, Hereford.</span>\r\n              ', 'sapibrahmancross.jpeg'),
(3, 'Sapi Limousin', '                Sapi limousin merupakan keturunan Bos taurus yang berkembang di \r\nPrancis. Karakteristik dari sapi limousin adalah pertambahan badan yang cepat \r\nperharinya sekitar 1,1 kg, tinggi mencapai 1,5 m, bulu tebal yang menutupi \r\nseluruh tubuh warnanya mulai dari kuning sampai merah keemasan, tanduknya \r\nberwarna cerah, bobot lahir tergolong kecil sampai medium (sapi betina dewasa \r\nmencapai 575 kg dan pejantan dewasa mencapai berat 1100 kg), fertilitasnya \r\ncukup tinggi, mudah melahirkan, mampu menyusui, dan mengasuh anak dengan \r\nbaik serta pertumbuhannya capat (Blakely dan Bade, 1994). \r\nPenggolongan sapi ke dalam suatu bangsa (breed), didasarkan atas \r\nsekumpulan persamaan karakteristik yang sama. Karakteristik yang dimiliki \r\ntersebut akan diturunkan ke generasi berikutnya. Menurut Blakely dan Bade \r\n(1992) bangsa sapi limosin mempunyai klasifikasi taksonomi sebagai berikut :\r\nPhylum : Chordata \r\nSubphylum : Vertebrata \r\nClass : Mamalia \r\nSub class : Theria \r\nInfra Class : Eutheria \r\nOrdo : Artiodactyla \r\nSub Ordo : Ruminantia \r\nInfra Ordo : Pecora \r\n45\r\nFamily : Bovidae \r\nGenus : Bos (cattle) \r\nSpesies : Bos Taurus (Sapi Eropa)\r\nSapi limousin dapat berproduksi secara optimal pada daerah yang beriklim \r\nsubtropis dengan temperature suhu antara 4 - 15oC dan mendapat hijauan serta \r\nkonsentrat (Meyn, 1991). Menurut Thomas (1991) sapi limousin memiliki berat \r\nlahir rata-rata 39,95 kg dengan berat sapih pada umur 205 hari mencapai 198 kg.\r\n              ', 'sapilimousin.jpeg'),
(4, 'Sapi PO', '                                                                                                                                                <p class=\"p1\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal;\">Sapi Peranakan Ongole (sapi PO) sering disebut sebagai Sapi Lokal atau Sapi Jawa atau Sapi Putih. Sapi PO ini merupakan hasil persilangan antara pejantan sapi Sumba Ongole (SO) dengan sapi betina Jawa yang berwarna putih. Sapi Ongole (Bos Indicus) sebenarnya berasal dari India, termasuk tipe sapi pekerja dan pedaging yang disebarkan di Indonesia sebagai sapi Sumba Ongole (SO). Warna bulu sapi Ongole sendiri adalah putih abu-abu dengan warna hitam di sekeliling mata, mempunyai gumba dan gelambir yang besar menggelantung. Saat mencapai umur dewasa, sapi jantan mempunyai berat badan kurang dari 600 kg dan yang betina kurang dari 450 kg. Bobot hidup Sapi PO bervariasi, mulai 220 kg hingga mencapai sekitar 600 kg.&nbsp;</p><p class=\"p1\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal;\">Saat ini Sapi PO yang murni mulai sulit ditemukan, karena telah banyak disilangkan dengan sapi Brahman. Oleh karena itu sapi PO sering diartikan sebagai sapi lokal berwarna putih (keabu-abuan), berkelasa dan gelambir. Sesuai dengan induk persilangannya, Sapi PO terkenal sebagai sapi pedaging dan sapi pekerja. Mempunyai kemampuan adaptasi yang tinggi terhadap perbedaan kondisi lingkungan, sapi ini juga memiliki tenaga yang kuat.</p><p class=\"p1\" style=\"margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: normal;\">Aktivitas reproduksi induknya cepat kembali normal setelah beranak, sedangkan jantannya memiliki kualitas semen yang baik. Keunggulan sapi PO ini antara lain tahan terhadap panas, terhadap ekto dan endoparasit, pertumbuhan relatif cepat walaupun adaptasi terhadap pakan kurang, serta persentase karkas dan kualitas daging baik.&nbsp;</p>\r\n              \r\n              \r\n              \r\n              \r\n              \r\n              \r\n              \r\n              \r\n              ', 'sapipo.jpeg'),
(5, 'Sapi Simental', '                <p>Sapi Simmental merupakan salah satu sapi potong yang banyak dipelihara \r\ndi Sumatera Barat karena sapi ini mempunyai banyak keunggulan diantaranya \r\nsebagai penghasil daging, susu serta dapat digunakan sebagai tenaga kerja, ukuran\r\ntubuh besar, pertumbuhan otot bagus, penimbunan lemak di bawah kulit rendah, \r\nfertilitas tinggi, memiliki bobot lahir anak tinggi, pertambahan bobot badan harian \r\ntinggi serta pertumbuhannya cepat. \r\nPopulasi Sapi Simmental di Indonesia pada tahun 2009 berjumlah \r\n1.217.000 ekor (Direktorat Jenderal Peternakan, 2010). Ukuran dan \r\npertumbuhannya yang cepat serta performans yang baik menyebabkan sapi \r\nSimmental banyak dipelihara.</p><p> Sapi Simmental berasal dari Switzerland, \r\nmempunyai sifat jinak, tenang dan mudah dikendalikan. Sapi ini memiliki\r\npertambahan bobot badan berkisar antara 0,6 sampai 1,5 kg/hari. Bobot badan \r\nbetina dewasa bisa mencapai 1000-1150 kg (Sugeng, 1996). Sapi ini menjadi sapi \r\nyang paling terkenal di Eropa terkenal karena menyusui anak dengan baik serta\r\npertumbuhan juga cepat badannya panjang dan padat, termasuk berukuran berat, \r\nbaik pada kelahiran, penyapihan, maupun saat mencapai dewasa. Hal ini sesuai\r\ndengan pendapat Rahmat dan Bagus, (2012) bahwa sapi Simmental memiliki\r\nkeunggulan dengan bobot badan dewasa dapat mencapai 1.400 kg dan\r\npertambahan bobot harian dapat mencapai 2,1 kg per hari</p>\r\n              ', 'sapisimental.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `nama`, `email`, `password`) VALUES
(1, 'Padang Perwira Yudha', 'padang@gmail.com', 'admin'),
(3, 'ini adalah nama', 'teslagi@gmail.com', 'tes123'),
(4, 'value', 'tes@gmail.com', 'inipasswd'),
(5, 'value', 'teszzz@gmail.com', 'inipasswd'),
(6, 'value', 'teszzwwwwz@gmail.com', 'inipasswd'),
(7, 'Tesnama', 'nama@gmail.com', 'tes123'),
(8, 'Padangtesting', 'padangz@gmail.com', 'padang');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indexes for table `sapi`
--
ALTER TABLE `sapi`
  ADD PRIMARY KEY (`id_sapi`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
