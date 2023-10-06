﻿
--*Tạo cơ sở dữ liệu
CREATE DATABASE BANHANG;
USE BANHANG;

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
	NGDK smalldatetime,
	LOAIKH varchar (4)
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

--TUẦN 2
--1.Nhập dữ liệu cho các quan hệ trên
--1.1.Nhập dữ liệu cho quan hệ NHANVIEN
set dateformat dmy
INSERT INTO NHANVIEN VALUES('NV01','Nguyen Nhu Nhut','0927345678','13/4/2006')
INSERT INTO NHANVIEN VALUES('NV02','Le Thi Phi Yen','0987567390','21/4/2006')
INSERT INTO NHANVIEN VALUES('NV03','Nguyen Van B','0997047382','27/4/2006')
INSERT INTO NHANVIEN VALUES('NV04','Ngo Thanh Tuan','0913758498','24/6/2006')
SELECT * FROM NHANVIEN

--1.2.Nhập dữ liệu cho quan hệ KHACHHANG
INSERT INTO KHACHHANG VALUES('KH01','Nguyen Van A','731 Tran Hung Dao, Q5, TpHCM','8823451','22/10/1960',13060000,'22/07/2006',Null)
INSERT INTO KHACHHANG VALUES('KH02','Tran Ngoc Han','23/5 Nguyen Trai, Q5, TpHCM','908256478','3/4/1974',280000,'30/07/2006',Null)
INSERT INTO KHACHHANG VALUES('KH03','Tran Ngoc Linh','45 Nguyen Canh Chan, Q1, TpHCM','938776266','12/6/1980',3860000,'05/08/2006',Null)
INSERT INTO KHACHHANG VALUES('KH04','Tran Minh Long','50/34 Le Dai Hanh, Q10, TpHCM','917325476','9/3/1965',250000,'02/10/2006',Null)
INSERT INTO KHACHHANG VALUES('KH05','Le Nhat Minh','34 Truong Dinh, Q3, TpHCM','8246108','10/3/1950',21000,'28/10/2006',Null)
INSERT INTO KHACHHANG VALUES('KH06','Le Hoai Thuong','227 Nguyen Van Cu, Q5, TpHCM','8631738','31/12/1981',915000,'24/11/2006',Null)
INSERT INTO KHACHHANG VALUES('KH07','Nguyen Van Tam','32/3 Tran Binh Trong, Q5, TpHCM','916783565','6/4/1971',12500,'01/12/2006',Null)
INSERT INTO KHACHHANG VALUES('KH08','Phan Thi Thanh','45/2 An Duong Vuong, Q5, TpHCM','938435756','10/1/1971',365000,'13/12/2006',Null)
INSERT INTO KHACHHANG VALUES('KH09','Le Ha Vinh','873 Le Hong Phong, Q5, TpHCM','8654763','3/9/1979',70000,'14/01/2007',Null)
INSERT INTO KHACHHANG VALUES('KH10','Ha Duy Lap','34/34B Nguyen Trai, Q1, TpHCM','8768904','2/5/1983',67500,'16/01/2007',Null)
SELECT * FROM KHACHHANG;

--1.3.Nhập dữ liệu cho quan hệ SANPHAM
INSERT INTO SANPHAM VALUES('BC01','But chi','cay','Singapore',3000)
INSERT INTO SANPHAM VALUES('BC02','But chi','cay','Singapore',5000)
INSERT INTO SANPHAM VALUES('BC03','But chi','cay','Viet Nam',3500)
INSERT INTO SANPHAM VALUES('BC04','But chi','hop','Viet Nam',30000)
INSERT INTO SANPHAM VALUES('BB01','But bi','cay','Viet Nam',5000)
INSERT INTO SANPHAM VALUES('BB02','But bi','cay','Trung Quoc',7000)
INSERT INTO SANPHAM VALUES('BB03','But bi','hop','Thai Lan',100000)
INSERT INTO SANPHAM VALUES('TV01','Tap 100 giay mong','quyen','Trung Quoc',2500)
INSERT INTO SANPHAM VALUES('TV02','Tap 200 giay mong','quyen','Trung Quoc',4500)
INSERT INTO SANPHAM VALUES('TV03','Tap 100 giay tot','quyen','Viet Nam',3000)
INSERT INTO SANPHAM VALUES('TV04','Tap 200 giay tot','quyen','Viet Nam',5500)
INSERT INTO SANPHAM VALUES('TV05','Tap 100 trang','chuc','Viet Nam',23000)
INSERT INTO SANPHAM VALUES('TV06','Tap 200 trang','chuc','Viet Nam',53000)
INSERT INTO SANPHAM VALUES('TV07','Tap 100 trang','chuc','Trung Quoc',34000)
INSERT INTO SANPHAM VALUES('ST01','So tay 500 trang','quyen','Trung Quoc',40000)
INSERT INTO SANPHAM VALUES('ST02','So tay loai 1','quyen','Viet Nam',55000)
INSERT INTO SANPHAM VALUES('ST03','So tay loai 2','quyen','Viet Nam',51000)
INSERT INTO SANPHAM VALUES('ST04','So tay','quyen','Thai Lan',55000)
INSERT INTO SANPHAM VALUES('ST05','So tay mong','quyen','Thai Lan',20000)
INSERT INTO SANPHAM VALUES('ST06','Phan viet bang','hop','Viet Nam',5000)
INSERT INTO SANPHAM VALUES('ST07','Phan khong bui','hop','Viet Nam',7000)
INSERT INTO SANPHAM VALUES('ST08','Bong bang','cai','Viet Nam',1000)
INSERT INTO SANPHAM VALUES('ST09','But long','cay','Viet Nam',5000)
INSERT INTO SANPHAM VALUES('ST10','But long','cay','Trung Quoc',7000)
SELECT *FROM SANPHAM;

--1.4.Nhập dữ liệu cho quan hệ HOADON
INSERT INTO HOADON VALUES (1001,'23/07/2006','KH01','NV01',320000)
INSERT INTO HOADON VALUES (1002,'12/08/2006','KH01','NV02',840000)
INSERT INTO HOADON VALUES (1003,'23/08/2006','KH02','NV01',100000)
INSERT INTO HOADON VALUES (1004,'01/09/2006','KH02','NV01',180000)
INSERT INTO HOADON VALUES (1005,'20/10/2006','KH01','NV02',3800000)
INSERT INTO HOADON VALUES (1006,'16/10/2006','KH01','NV03',2430000)
INSERT INTO HOADON VALUES (1007,'28/10/2006','KH03','NV03',510000)
INSERT INTO HOADON VALUES (1008,'28/10/2006','KH01','NV03',440000)
INSERT INTO HOADON VALUES (1009,'28/10/2006','KH03','NV04',200000)
INSERT INTO HOADON VALUES (1010,'01/11/2006','KH01','NV01',5200000)
INSERT INTO HOADON VALUES (1011,'04/11/2006','KH04','NV03',250000)
INSERT INTO HOADON VALUES (1012,'30/11/2006','KH05','NV03',21000)
INSERT INTO HOADON VALUES (1013,'12/12/2006','KH06','NV01',5000)
INSERT INTO HOADON VALUES (1014,'31/12/2006','KH03','NV02',3150000)
INSERT INTO HOADON VALUES (1015,'01/01/2007','KH06','NV01',910000)
INSERT INTO HOADON VALUES (1016,'01/01/2007','KH07','NV02',12500)
INSERT INTO HOADON VALUES (1017,'02/01/2007','KH08','NV03',35000)
INSERT INTO HOADON VALUES (1018,'13/01/2007','KH08','NV03',330000)
INSERT INTO HOADON VALUES (1019,'13/01/2007','KH01','NV03',30000)
INSERT INTO HOADON VALUES (1020,'14/01/2007','KH09','NV04',70000)
INSERT INTO HOADON VALUES (1021,'16/01/2007','KH10','NV03',67500)
INSERT INTO HOADON VALUES (1022,'16/01/2007','Null','NV03',7000)
INSERT INTO HOADON VALUES (1023,'17/01/2007','Null','NV01',330000)

SELECT * FROM HOADON;

--1.5.Nhập dữ liệu cho quan hệ  CTHD
INSERT INTO CTHD VALUES(1001,'TV02',10)
INSERT INTO CTHD VALUES(1001,'ST01',5)
INSERT INTO CTHD VALUES(1001,'BC01',5)
INSERT INTO CTHD VALUES(1001,'BC02',10)
INSERT INTO CTHD VALUES(1001,'ST08',10)
INSERT INTO CTHD VALUES(1002,'BC04',20)
INSERT INTO CTHD VALUES(1002,'BB01',20)
INSERT INTO CTHD VALUES(1002,'BB02',20)
INSERT INTO CTHD VALUES(1003,'BB03',10)
INSERT INTO CTHD VALUES(1004,'TV01',20)
INSERT INTO CTHD VALUES(1004,'TV02',10)
INSERT INTO CTHD VALUES(1004,'TV03',10)
INSERT INTO CTHD VALUES(1004,'TV04',10)
INSERT INTO CTHD VALUES(1005,'TV05',50)
INSERT INTO CTHD VALUES(1005,'TV06',50)
INSERT INTO CTHD VALUES(1006,'TV07',20)
INSERT INTO CTHD VALUES(1006,'ST01',30)
INSERT INTO CTHD VALUES(1006,'ST02',10)
INSERT INTO CTHD VALUES(1007,'ST03',10)
INSERT INTO CTHD VALUES(1008,'ST04',8)
INSERT INTO CTHD VALUES(1009,'ST05',10)
INSERT INTO CTHD VALUES(1010,'TV07',50)
INSERT INTO CTHD VALUES(1010,'ST07',50)
INSERT INTO CTHD VALUES(1010,'ST08',100)
INSERT INTO CTHD VALUES(1010,'ST04',50)
INSERT INTO CTHD VALUES(1010,'TV03',100)
INSERT INTO CTHD VALUES(1011,'ST06',50)
INSERT INTO CTHD VALUES(1012,'ST07',3)
INSERT INTO CTHD VALUES(1013,'ST08',5)
INSERT INTO CTHD VALUES(1014,'BC02',80)
INSERT INTO CTHD VALUES(1014,'BB02',100)
INSERT INTO CTHD VALUES(1014,'BC04',60)
INSERT INTO CTHD VALUES(1014,'BB01',50)
INSERT INTO CTHD VALUES(1015,'BB02',30)
INSERT INTO CTHD VALUES(1015,'BB03',7)
INSERT INTO CTHD VALUES(1016,'TV01',5)
INSERT INTO CTHD VALUES(1017,'TV02',1)
INSERT INTO CTHD VALUES(1017,'TV03',1)
INSERT INTO CTHD VALUES(1017,'TV04',5)
INSERT INTO CTHD VALUES(1018,'ST04',6)
INSERT INTO CTHD VALUES(1019,'ST05',1)
INSERT INTO CTHD VALUES(1019,'ST06',2)
INSERT INTO CTHD VALUES(1020,'ST07',10)
INSERT INTO CTHD VALUES(1021,'ST08',5)
INSERT INTO CTHD VALUES(1021,'TV01',7)
INSERT INTO CTHD VALUES(1021,'TV02',10)
INSERT INTO CTHD VALUES(1022,'ST07',1)
INSERT INTO CTHD VALUES(1023,'ST04',6)

SELECT * FROM CTHD;

--2.Tạo quan hệ SANPHAM1 chứa toàn bộ dữ liệu của quan hệ SANPHAM. Tạo quan hệ KHACHHANG1 chứa toàn bộ dữ liệu của quan hệ KHACHHANG.
SELECT * INTO SANPHAM1 FROM SANPHAM;
SELECT * FROM SANPHAM1;

 
--3.Cập nhật giá tăng 5% đối với những sản phẩm do “Thai Lan” sản xuất (cho quan hệ SANPHAM1)
UPDATE SANPHAM1 SET GIA+=GIA*0.05 WHERE NUOCSX='Thai Lan';
SELECT * FROM SANPHAM1;

--4.Cập nhật giá giảm 5% đối với những sản phẩm do “Trung Quoc” sản xuất có giá từ 10.000 trở xuống (cho quan hệ SANPHAM1)
UPDATE SANPHAM1 SET GIA-=GIA*0.05 WHERE (NUOCSX='Trung Quoc' AND GIA <=10000);
SELECT * FROM SANPHAM1;

--5.Cập nhật giá trị LOAIKH là “Vip” đối với những khách hàng đăng ký thành viên trước ngày 1/1/2007 có doanh số từ 10.000.000 trở lên hoặc 
--khách hàng đăng ký thành viên từ 1/1/2007 trở về sau có doanh số từ 2.000.000 trở lên (cho quan hệ KHACHHANG2).
SELECT * INTO KHACHHANG2 FROM KHACHHANG;
SELECT * FROM KHACHHANG2;
UPDATE KHACHHANG2 SET LOAIKH = 'Vip' WHERE((NGDK<='1/1/2007' AND  DOANHSO>=10000000) OR (NGDK>='1/1/2007' AND DOANHSO>=2000000));


--III
--1.In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
SELECT MASP,TENSP FROM SANPHAM WHERE NUOCSX='Trung Quoc';

--2.In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
SELECT MASP,TENSP FROM SANPHAM WHERE (DVT='cay' OR DVT ='quyen');


--3.In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
SELECT MASP,TENSP FROM SANPHAM WHERE MASP LIKE 'B%01';

--4.In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000
SELECT MASP,TENSP FROM SANPHAM WHERE (NUOCSX = 'TRUNG QUOC' AND GIA BETWEEN 30000 AND 40000);

--5.In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP,TENSP FROM SANPHAM WHERE ((NUOCSX = 'TRUNG QUOC' OR NUOCSX = 'THAI LAN')  AND GIA BETWEEN 30000 AND 40000);

--6.xIn ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
SELECT SOHD, TRIGIA FROM HOADON WHERE NGHD >= '1/1/2007' AND NGHD <= '1/2/2007';

--7.	In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
SELECT SOHD, TRIGIA FROM HOADON WHERE MONTH(NGHD) = 1 AND YEAR(NGHD) = 2007 ORDER BY NGHD ASC, TRIGIA DESC

--8.	In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
SELECT K.MAKH, HOTEN FROM KHACHHANG K INNER JOIN HOADON H ON K.MAKH = H.MAKH WHERE NGHD = '1/1/2007';

--9.	In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006.
SELECT SOHD, TRIGIA FROM HOADON H INNER JOIN NHANVIEN N ON H.MANV = N.MANV WHERE NGHD = '28/10/2006' AND HOTEN = 'NGUYEN VAN B'
--10.	In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
SELECT DISTINCT S.MASP, TENSP FROM SANPHAM S INNER JOIN CTHD C ON S.MASP = C.MASP AND EXISTS(SELECT * FROM CTHD C INNER JOIN HOADON H
ON C.SOHD = H.SOHD
AND MONTH(NGHD) = 10 AND YEAR(NGHD) = 2006 AND MAKH IN(SELECT H.MAKH
FROM HOADON H INNER JOIN KHACHHANG K
ON H.MAKH = K.MAKH
WHERE HOTEN = 'NGUYEN VAN A') AND S.MASP = C.MASP)
--11.	Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
SELECT SOHD FROM CTHD WHERE MASP IN ('BB01', 'BB02');

--TUẦN 3
--12. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20
SELECT DISTINCT SOHD FROM CTHD WHERE MASP IN('BB01', 'BB02') AND SL BETWEEN 10 AND 20;

--13. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT SOHD FROM CTHD A WHERE A.MASP = 'BB01' AND SL BETWEEN 10 AND 20
AND EXISTS(SELECT * FROM CTHD B WHERE B.MASP = 'BB02' AND SL BETWEEN 10 AND 20
AND A.SOHD = B.SOHD)

--14.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT DISTINCT S.MASP, TENSP FROM SANPHAM S INNER JOIN CTHD C ON S.MASP = C.MASP WHERE NUOCSX = 'TRUNG QUOC'
AND C.SOHD IN(SELECT DISTINCT C2.SOHD FROM CTHD C2 INNER JOIN HOADON H ON C2.SOHD = H.SOHD
WHERE NGHD ='1/1/2007')
--15.	In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
SELECT S.MASP, TENSP FROM SANPHAM S WHERE NOT EXISTS(SELECT *  FROM SANPHAM S2 INNER JOIN CTHD C ON S2.MASP = C.MASP
AND S2.MASP = S.MASP)
--16.	In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
SELECT S.MASP, TENSP FROM SANPHAM S WHERE S.MASP NOT IN(SELECT C.MASP  FROM CTHD C INNER JOIN HOADON H ON C.SOHD = H.SOHD
WHERE YEAR(NGHD) = 2006)

--17.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006.
SELECT S.MASP, TENSP FROM SANPHAM S WHERE NUOCSX = 'TRUNG QUOC' AND S.MASP NOT IN(SELECT C.MASP  FROM CTHD C INNER JOIN HOADON H ON C.SOHD = H.SOHD
WHERE YEAR(NGHD) = 2006)
--18.	Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
SELECT H.SOHD  FROM HOADON H WHERE NOT EXISTS(SELECT * FROM SANPHAM S WHERE NUOCSX = 'SINGAPORE'
AND NOT EXISTS(SELECT *  FROM CTHD C WHERE C.SOHD = H.SOHD AND C.MASP = S.MASP))

--19.	Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất.
SELECT H.SOHD 
FROM HOADON H WHERE YEAR(NGHD) = 2006 AND NOT EXISTS(SELECT * FROM SANPHAM S WHERE NUOCSX = 'SINGAPORE'
AND NOT EXISTS(SELECT *  FROM CTHD C WHERE C.SOHD = H.SOHD AND C.MASP = S.MASP))
