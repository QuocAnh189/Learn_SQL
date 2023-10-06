
--*Tạo cơ sở dữ liệu
CREATE DATABASE BANHANG;

--1.Tạo các quan hệ  và khai báo các khóa chính , khóa ngoại của quan hệ
--1.1 Tạo quan hệ KHACH HANG
CREATE TABLE KHACHHANG
(
	MAKH char(4) PRIMARY KEY NOT NULL,
	HOTEN varchar(40),
	DCHI  varchar(50),
	SODT varchar(20),
	NGSINH smalldatetime,
	DOANHSO money,
	NGDK smalldatetime
);

--1.2 Tạo quan hệ NHANVIEN
CREATE TABLE NHANVIEN
(
	MANV char(4) PRIMARY KEY NOT NULL,
	HOTEN varchar(40),
	SODT varchar(20),
	NGVL smalldatetime
);

--1.3 Tạo quan hệ SANPHAM
CREATE TABLE SANPHAM
(
	MASP char(4) PRIMARY KEY NOT NULL,
	TENSP varchar(40),
	DVT varchar(20),
	NUOCSX varchar(40),
	GIA money,
);

--1.4 Tạo quan hệ HOADON
CREATE TABLE HOADON
(
	SOHD int PRIMARY KEY NOT NULL,
	NGHD smalldatetime,
	MAKH char(4) NOT NULL,
	FOREIGN KEY(MAKH)REFERENCES KHACHHANG(MAKH),
	MANV char(4) NOT NULL,
	FOREIGN KEY(MANV)REFERENCES NHANVIEN(MANV),
	TRIGIA money
);

--1.5 Tạo quan hệ CTHD
CREATE TABLE CTHD
(
	SOHD int NOT NULL,
	FOREIGN KEY(SOHD)REFERENCES HOADON(SOHD),
	MASP char(4) NOT NULL,
	FOREIGN KEY(MASP)REFERENCES SANPHAM(MASP),
	SL int
);

--2.Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20) cho quan hệ SANPHAM
ALTER TABLE SANPHAM ADD GHICHU varchar(20);

--3.Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint cho quan hệ KHACHHANG
ALTER TABLE KHACHHANG ADD LOAIKH tinyint;

--4.Sữa dữ liệu của thuộc tính GHICHU trong quan hệ SANPHAM thành varchar(100)
ALTER TABLE SANPHAM 
ALTER COLUMN GHICHU varchar(100);

--5.Xóa thuộc tính GHICHU trong quan hệ SANPHAM
ALTER TABLE SANPHAM 
DROP COLUMN GHICHU;

--6.Làm thế nào để thuộc tính LOAIKH trong quan hệ KHACHHANG có thể lưu các giá trị là: "Vang lai","Thuong xuyen"
ALTER TABLE KHACHHANG
ALTER COLUMN LOAIKH varchar(20);

--7.Đon vị tính của sản phẩm chỉ có thể là ("cay","hop","cai","quyen","chuc")
ALTER TABLE SANPHAM
ADD CONSTRAINT SP_DVT CHECK(DVT = 'cay' OR DVT = 'hop' OR DVT = 'cai' OR DVT = 'quyen' OR DVT = 'chuc');

--8.Gía bán của sản phẩn từ 500 đồng trở lên
ALTER TABLE SANPHAM
ADD CONSTRAINT SP_GIA CHECK(GIA>500);

--9.Môi lần mua hàng , khách hàng phải mua ít nhất 1 sản phẩm(không yêu cầu làm)

--10. Ngày khách hàng đăng kí là khách hàng thành viên phải lớn hơn ngày sinh của người đó
ALTER TABLE KHACHHANG
ADD CONSTRAINT NGDK_KHACHHANG CHECK(NGDK>NGSINH);



