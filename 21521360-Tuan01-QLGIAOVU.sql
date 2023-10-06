--Tạo cơ sở dữ liệu
CREATE DATABASE GIAOVU;

--1.Tạo quan hệ và khai báo tất cả các ràng buộc khóa chính, khóa ngoại.Thêm vào 3 thuộc tính GHICHU,DIEMTB,XEPLOAI cho quan hệ HOCVIEN
--1.1 Tạo quan hệ KHOA
CREATE TABLE KHOA
(
	MAKHOA varchar(4) PRIMARY KEY NOT NULL,
	TENKHOA varchar(40),
	NGTLAP smalldatetime,
	TRGKHOA char(4)
);

--1.2 Tạo quan hệ MONHOC
CREATE TABLE MONHOC
(
	MAMH varchar(10) PRIMARY KEY NOT NULL,
	TENMH varchar(40),
	TCLT tinyint,
	TCTH tinyint,
	MAKHOA varchar(4)
);

--1.3 Tạo quan hệ DIEUKIEN
CREATE TABLE DIEUKIEN
(
	MAMH VARCHAR(10),
	MAMH_TRUOC VARCHAR(10),
	CONSTRAINT PK_DIEUKIEN PRIMARY KEY (MAMH, MAMH_TRUOC)
);

--1.4 Tạo quan hệ GIAOVIEN
CREATE TABLE GIAOVIEN
(
	MAGV char(4) PRIMARY KEY NOT NULL,
	HOTEN varchar(40),
	HOCVI varchar(10),
	HOCHAM varchar(10),
	GIOITINH varchar(3),
	NGSINH smalldatetime,
	NGVL smalldatetime,
	HESO numeric(4,2),
	MUCLUONG money,
	MAKHOA varchar(4)
);

--1.5 Tạo quan hệ LOP
CREATE TABLE LOP
(
	MALOP char(3) PRIMARY KEY NOT NULL,
	TENLOP varchar(40),
	TRGLOP char(5),
	SISO tinyint,
	MAGVCN char(4)
);

--1.6 Tạo quan hệ HOCVIEN
CREATE TABLE HOCVIEN
(
	MAHV char(5) PRIMARY KEY NOT NULL,
	HO varchar(40),
	TEN varchar(10),
	NGSINH smalldatetime,
	GIOITINH varchar(3),
	NOISINH varchar(40),
	MALOP char(3)
);

--1.7 Tạo quan hệ GIANGDAY
CREATE TABLE GIANGDAY
(
	MALOP char(3),
	FOREIGN KEY(MALOP)REFERENCES LOP(MALOP),
	MAMH varchar(10),
	FOREIGN KEY(MAMH)REFERENCES MONHOC(MAMH),
	MAGV char(4),
	HOCKY tinyint,
	NAM smallint,
	TUNGAY smalldatetime,
	DENNGAY smalldatetime
);

--1.8 Tạo quan hệ KETQUATHI
CREATE TABLE KETQUATHI
(
	MAHV char(5),
	FOREIGN KEY(MAHV)REFERENCES HOCVIEN(MAHV),
	MAMH varchar(10),
	FOREIGN KEY(MAMH)REFERENCES MONHOC(MAMH),
	LANTHI tinyint PRIMARY KEY NOT NULL,
	NGTHI smalldatetime,
	DIEM numeric(4,2),
	KQUA varchar(10)
);

--*Thêm vào 3 thuộc tính GHICHU,DIEMTB,XEPLOAI cho quan hệ HOCVIEN
ALTER TABLE HOCVIEN ADD GHICHU varchar(40) ,DIEMTB numeric(4,2) ,XEPLOAI varchar(10);



--3.Thuộc tính GIOITINH chỉ có giá trị là "Nam" hoặc Nữ
ALTER TABLE HOCVIEN ADD CONSTRAINT CHECK_GTHV CHECK (GIOITINH IN('Nam','Nu'));
ALTER TABLE GIAOVIEN ADD CONSTRAINT CHECK_GTGV CHECK (GIOITINH IN('Nam','Nu'));

--4.Điểm số của một lần thi có giá trị từ 0 đến 10 và cần lưu đến 2 số lẽ(VD: 6,22)
ALTER TABLE KETQUATHI ADD CONSTRAINT CHECK_DIEM CHECK 
(
	DIEM BETWEEN 0 AND 10
	AND RIGHT(CAST(DIEM AS VARCHAR), 3) LIKE '.__'
)

--5.Kết quả thi là "Dat" nếu từ điểm 5 đến 10 và "Khong dat" nếu điểm nhỏ hơn 5
ALTER TABLE KETQUATHI ADD CONSTRAINT CHECT_KQ CHECK
(
	(KQUA = 'Dat' AND DIEM BETWEEN 5 AND 10)
	OR(KQUA='Khong dat' AND DIEM<5)
)

--6.Học viên thi một một tối đa 3 lần
ALTER TABLE KETQUATHI ADD CONSTRAINT CHECk_LT CHECK(LANTHI<=3)

--7.Học kỳ chỉ có gái trị từ 1 đến 3
ALTER TABLE GIANGDAY ADD CONSTRAINT CHECK_HK CHECK(HOCKY BETWEEN 1 AND 3)

--8.Học vị của giáo viên chỉ có thể là “CN”, “KS”, “Ths”, ”TS”, ”PTS”
ALTER TABLE GIAOVIEN ADD CONSTRAINT CHECK_HV CHECK(HOCVI IN ('CN', 'KS', 'Ths', 'TS', 'PTS'));



