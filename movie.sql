DROP DATABASE IF EXISTS movie;
CREATE DATABASE movie;
USE movie;

DROP TABLE IF EXISTS loai_nguoi_dung;
CREATE TABLE loai_nguoi_dung(
	id INT PRIMARY KEY AUTO_INCREMENT,
	ma_loai_nguoi_dung VARCHAR(255) NOT NULL CHECK (ma_loai_nguoi_dung IN ('QuanTri', 'KhachHang')),
    ten_loai VARCHAR(255) NOT NULL
);
INSERT INTO loai_nguoi_dung (ma_loai_nguoi_dung, ten_loai) VALUES
    ('QuanTri', 'Quản trị'),
    ('KhachHang', 'Khách hàng');

DROP TABLE IF EXISTS nguoi_dung;
CREATE TABLE nguoi_dung(
	id INT PRIMARY KEY AUTO_INCREMENT,
	tai_khoan VARCHAR(255) NOT NULL,
    ho_ten VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    so_dt VARCHAR(255) NOT NULL,
    mat_khau VARCHAR(255) NOT NULL,
    key_loai_nguoi_dung INT,
    FOREIGN KEY (key_loai_nguoi_dung) REFERENCES loai_nguoi_dung(id)
);
INSERT INTO nguoi_dung (tai_khoan, ho_ten, email, so_dt, mat_khau, key_loai_nguoi_dung)
VALUES
('user1', 'John Doe', 'john.doe@example.com', '123456789', 'password123', 1),
('user2', 'Jane Smith', 'jane.smith@example.com', '987654321', 'securepwd456', 2),
('user3', 'Bob Johnson', 'bob.johnson@example.com', '555666777', 'strongpass789', 1);

DROP TABLE IF EXISTS phim;
CREATE TABLE phim(
	ma_phim INT PRIMARY KEY AUTO_INCREMENT,
	ten_phim VARCHAR(255) NOT NULL,
    trailer VARCHAR(255) NOT NULL,
    hinh_anh VARCHAR(255) NOT NULL,
    mo_ta VARCHAR(255) NOT NULL,
    ngay_khoi_chieu DATE NOT NULL,
    danh_gia INT CHECK (danh_gia >= 0 AND danh_gia <= 10) NOT NULL,
    hot BOOLEAN DEFAULT false,
    dang_chieu BOOLEAN DEFAULT false,
    sap_chieu BOOLEAN DEFAULT false
);
INSERT INTO phim (ten_phim, trailer, hinh_anh, mo_ta, ngay_khoi_chieu, danh_gia, hot, dang_chieu, sap_chieu)
VALUES
('Inception', 'https://www.youtube.com/watch?v=YoHD9XEInc0', 'inception.jpg', 'A mind-bending thriller', '2023-01-01', 9, true, true, false),
('The Dark Knight', 'https://www.youtube.com/watch?v=EXeTwQWrcwY', 'dark_knight.jpg', 'Gotham silent guardian', '2022-12-15', 8, false, false, true),
('Avatar', 'https://www.youtube.com/watch?v=5PSNL1qE6VY', 'avatar.jpg', 'Discover the world of Pandora', '2023-02-28', 9, true, false, true);

DROP TABLE IF EXISTS banner;
CREATE TABLE banner(
	ma_banner INT PRIMARY KEY AUTO_INCREMENT,
    ma_phim INT,
	hinh_anh VARCHAR(255)  NOT NULL,
    FOREIGN KEY (ma_phim) REFERENCES phim(ma_phim)
);
INSERT INTO banner (ma_phim, hinh_anh)
VALUES
(1, 'banner1.jpg'),
(2, 'banner2.jpg'),
(3, 'banner3.jpg');

DROP TABLE IF EXISTS he_thong_rap;
CREATE TABLE he_thong_rap(
	ma_he_thong_rap INT PRIMARY KEY AUTO_INCREMENT,
	ten_he_thong_rap VARCHAR(255)  NOT NULL,
    logo VARCHAR(255)  NOT NULL
);
INSERT INTO he_thong_rap (ten_he_thong_rap, logo)
VALUES
('Cineplex', 'cineplex_logo.jpg'),
('Megaplex', 'megaplex_logo.jpg'),
('Star Cinemas', 'star_cinemas_logo.jpg');

DROP TABLE IF EXISTS cum_rap;
CREATE TABLE cum_rap(
	ma_cum_rap INT PRIMARY KEY AUTO_INCREMENT,
	ten_cum_rap VARCHAR(255)  NOT NULL,
    dia_chi VARCHAR(255)  NOT NULL,
    ma_he_thong_rap INT,
    FOREIGN KEY (ma_he_thong_rap) REFERENCES he_thong_rap(ma_he_thong_rap)
);
INSERT INTO cum_rap (ten_cum_rap, dia_chi, ma_he_thong_rap)
VALUES
('Main Cinemas - Downtown', '123 Main Street, City Center', 1),
('Westside Theaters', '456 Oak Avenue, Westside', 2),
('Starplex Cinemas - East', '789 Maple Road, Eastside', 3);

DROP TABLE IF EXISTS rap_phim;
CREATE TABLE rap_phim(
	ma_rap INT PRIMARY KEY AUTO_INCREMENT,
	ten_rap VARCHAR(255)  NOT NULL,
    ma_cum_rap INT,
    FOREIGN KEY (ma_cum_rap) REFERENCES cum_rap(ma_cum_rap)
);
INSERT INTO rap_phim (ten_rap, ma_cum_rap)
VALUES
('Screen 1', 1),
('Auditorium A', 2),
('Cinema 3', 3);

DROP TABLE IF EXISTS ghe;
CREATE TABLE ghe(
	ma_ghe INT PRIMARY KEY AUTO_INCREMENT,
	ten_ghe VARCHAR(255)  NOT NULL,
	loai_ghe VARCHAR(255)  NOT NULL,
    ma_rap INT,
    FOREIGN KEY (ma_rap) REFERENCES rap_phim(ma_rap)
);
INSERT INTO ghe (ten_ghe, loai_ghe, ma_rap)
VALUES
('A1', 'Standard', 1),
('B3', 'VIP', 2),
('C7', 'Standard', 3);

DROP TABLE IF EXISTS lich_chieu;
CREATE TABLE lich_chieu(
	ma_lich_chieu INT PRIMARY KEY AUTO_INCREMENT,
	ma_rap INT,
	ma_phim INT,
    ngay_gio_chieu DATETIME NOT NULL,
    gia_ve DOUBLE NOT NULL,
    FOREIGN KEY (ma_rap) REFERENCES rap_phim(ma_rap),
    FOREIGN KEY (ma_phim) REFERENCES phim(ma_phim)
);
INSERT INTO lich_chieu (ma_rap, ma_phim, ngay_gio_chieu, gia_ve)
VALUES
(1, 1, '2024-01-18 15:00:00', 10.50),
(2, 2, '2024-01-19 18:30:00', 12.75),
(3, 3, '2024-01-20 20:15:00', 9.99);

DROP TABLE IF EXISTS dat_ve;
CREATE TABLE dat_ve(
	id INT PRIMARY KEY AUTO_INCREMENT,
	ma_nguoi_dung INT,
	ma_lich_chieu INT,
    ma_ghe INT,
    FOREIGN KEY (ma_nguoi_dung) REFERENCES nguoi_dung(id),
    FOREIGN KEY (ma_lich_chieu) REFERENCES lich_chieu(ma_lich_chieu),
    FOREIGN KEY (ma_ghe) REFERENCES ghe(ma_ghe)
);
INSERT INTO dat_ve (ma_nguoi_dung, ma_lich_chieu, ma_ghe)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);
