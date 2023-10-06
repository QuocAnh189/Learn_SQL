CREATE DATABASE GIAOVU

--Tạo quan hệ KHOA
CREATE TABLE KHOA 
(
	MAKHOA VARCHAR(4),
	TENKHOA VARCHAR(40),
	NGTLAP SMALLDATETIME,
	TRGKHOA CHAR(4)
	CONSTRAINT PK_KHOA PRIMARY KEY (MAKHOA)
)

--Tạo quan hệ MONHOC
CREATE TABLE MONHOC
(
	MAMH VARCHAR(10),
	TENMH VARCHAR(40),
	TCLT TINYINT,
	TCTH TINYINT,
	MAKHOA VARCHAR(4),
	CONSTRAINT PK_MONHOC PRIMARY KEY (MAMH),
)

--Tạo quan hệ DIEUKIEN
CREATE TABLE DIEUKIEN
(
	MAMH VARCHAR(10),
	MAMH_TRUOC VARCHAR(10),
	CONSTRAINT PK_DIEUKIEN PRIMARY KEY (MAMH, MAMH_TRUOC)
)

--Tạo quan hệ GIAOVIEN
CREATE TABLE GIAOVIEN
(
	MAGV CHAR(4),
	HOTEN VARCHAR(40),
	HOCVI VARCHAR(10),
	HOCHAM VARCHAR(10),
	GIOITINH VARCHAR(3),
	NGSINH SMALLDATETIME,
	NGVL SMALLDATETIME,
	HESO NUMERIC(4,2),
	MUCLUONG MONEY,
	MAKHOA VARCHAR(4)
	CONSTRAINT PK_GIAOVIEN PRIMARY KEY (MAGV)
)
--Tạo quan hệ HOCVIEN
CREATE TABLE HOCVIEN
(
	MAHV CHAR(5),
	HO VARCHAR(40),
	TEN VARCHAR(10),
	NGSINH SMALLDATETIME,
	GIOITINH VARCHAR(3),
	NOISINH VARCHAR(40),
	MALOP CHAR(3),
	CONSTRAINT PK_HOCVIEN PRIMARY KEY (MAHV)
)

--Tạo quan hệ LOP
CREATE TABLE LOP
(
	MALOP CHAR(3),
	TENLOP VARCHAR(40),
	TRGLOP CHAR(5),
	SISO TINYINT,
	MAGVCN CHAR(4)
	CONSTRAINT PK_LOP PRIMARY KEY (MALOP)
)

--Tạo quan hệ GIANGDAY
CREATE TABLE GIANGDAY
(
	MALOP CHAR(3),
	MAMH VARCHAR(10),
	MAGV CHAR(4),
	HOCKY TINYINT,
	NAM SMALLINT,
	TUNGAY SMALLDATETIME,
	DENNGAY SMALLDATETIME
	CONSTRAINT PK_GIANGDAY PRIMARY KEY (MALOP, MAMH),
)

--Tạo quan hệ KETQUATHI
CREATE TABLE KETQUATHI
(
	MAHV CHAR(5),
	MAMH VARCHAR(10),
	LANTHI TINYINT,
	NGTHI SMALLDATETIME,
	DIEM NUMERIC(4,2),
	KQUA VARCHAR(10)
	CONSTRAINT PK_KETQUATHI PRIMARY KEY (MAHV, MAMH, LANTHI)
)
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

--TUẦN 2
-- Nhập dữ liệu cho quan hệ KHOA --
insert into KHOA values('KHMT','Khoa hoc may tinh','6/7/2005','GV01')
insert into KHOA values('HTTT','He thong thong tin','6/7/2005','GV02')
insert into KHOA values('CNPM','Cong nghe phan mem','6/7/2005','GV04')
insert into KHOA values('MTT','Mang va truyen thong','10/20/2005','GV03')
insert into KHOA values('KTMT','Ky thuat may tinh','12/20/2005','')
SELECT * FROM KHOA

-- Nhập dữ liệu cho quan hệ GIAOVIEN --
insert into GIAOVIEN values('GV01','Ho Thanh Son','PTS','GS','Nam','5/2/1950','1/11/2004',5.00,2250000,'KHMT')
insert into GIAOVIEN values('GV02','Tran Tam Thanh','TS','PGS','Nam','12/17/1965','4/20/2004',4.50,2025000,'HTTT')
insert into GIAOVIEN values('GV03','Do Nghiem Phung','TS','GS','Nu','8/1/1950','9/23/2004',4.00,1800000,'CNPM')
insert into GIAOVIEN values('GV04','Tran Nam Son','TS','PGS','Nam','2/22/1961','1/12/2005',4.50,2025000,'KTMT')
insert into GIAOVIEN values('GV05','Mai Thanh Danh','ThS','GV','Nam','3/12/1958','1/12/2005',3.00,1350000,'HTTT')
insert into GIAOVIEN values('GV06','Tran Doan Hung','TS','GV','Nam','3/11/1953','1/12/2005',4.50,2025000,'KHMT')
insert into GIAOVIEN values('GV07','Nguyen Minh Tien','ThS','GV','Nam','11/23/1971','3/1/2005',4.00,1800000,'KHMT')
insert into GIAOVIEN values('GV08','Le Thi Tran','KS','','Nu','3/26/1974','3/1/2005',1.69,760500,'KHMT')
insert into GIAOVIEN values('GV09','Nguyen To Lan','ThS','GV','Nu','12/31/1966','3/1/2005',4.00,1800000,'HTTT')
insert into GIAOVIEN values('GV10','Le Tran Anh Loan','KS','','Nu','7/17/1972','3/1/2005',1.86,837000,'CNPM')
insert into GIAOVIEN values('GV11','Ho Thanh Tung','CN','GV','Nam','1/12/1980','5/15/2005',2.67,1201500,'MTT')
insert into GIAOVIEN values('GV12','Tran Van Anh','CN','','Nu','3/29/1981','5/15/2005',1.69,760500,'CNPM')
insert into GIAOVIEN values('GV13','Nguyen Linh Dan','CN','','Nu','5/23/1980','5/15/2005',1.69,760500,'KTMT')
insert into GIAOVIEN values('GV14','Truong Minh Chau','ThS','GV','Nu','11/30/1976','5/15/2005',3.00,1350000,'MTT')
insert into GIAOVIEN values('GV15','Le Ha Thanh','ThS','GV','Nam','5/4/1978','5/15/2005',3.00,1350000,'KHMT')
SELECT *FROM GIAOVIEN


-- Nhập dữ liệu cho quan hệ MONHOC --
insert into MONHOC values('THDC','Tin hoc dai cuong',4,1,'KHMT')
insert into MONHOC values('CTRR','Cau truc roi rac',5,0,'KHMT')
insert into MONHOC values('CSDL','Co so du lieu',3,1,'HTTT')
insert into MONHOC values('CTDLGT','Cau truc du lieu va giai thuat',3,1,'KHMT')
insert into MONHOC values('PTTKTT','Phan tich thiet ke thuat toan',3,0,'KHMT')
insert into MONHOC values('DHMT','Do hoa may tinh',3,1,'KHMT')
insert into MONHOC values('KTMT','Kien truc may tinh',3,0,'KTMT')
insert into MONHOC values('TKCSDL','Thiet ke co so du lieu',3,1,'HTTT')
insert into MONHOC values('PTTKHTTT','Phan tich thiet ke he thong thong tin',4,1,'HTTT')
insert into MONHOC values('HDH','He dieu hanh',4,0,'KTMT')
insert into MONHOC values('NMCNPM','Nhap mon cong nghe phan mem',3,0,'CNPM')
insert into MONHOC values('LTCFW','Lap trinh C for win',3,1,'CNPM')
insert into MONHOC values('LTHDT','Lap trinh huong doi tuong',3,1,'CNPM')
SELECT* FROM MONHOC


-- Nhập dữ liệu cho quan hệ LOP --
insert into LOP values('K11','Lop 1 khoa 1','K1108',11,'GV07')
insert into LOP values('K12','Lop 2 khoa 1','K1205',12,'GV09')
insert into LOP values('K13','Lop 3 khoa 1','K1305',12,'GV14')
SELECT *FROM LOP

-- Nhập dữ liệu cho quan hệ HOCVIEN --
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1101','Nguyen Van','A','1986/1/27','Nam',N'TpHCM','K11')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1102','Tran Ngoc','Han','1986/3/14','Nu','Kiên Giang','K11')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1103','Ha Duy','Lap','1986/4/18','Nam' ,'Nghệ An','K11')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1104','Tran Ngoc','Linh','1986/3/30','Nu','Tây Ninh','K11')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1105','Tran Minh','Long','1986/2/27','Nam' ,'TpHCM','K11')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1106','Le Nhat','Minh','1986/1/24', 'Nam' ,'TpHCM'  ,'K11')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1107','Nguyen Nhu'	,'Nhut'  ,'1986/1/27', 'Nam' ,'Hà Nội'    ,'K11')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1108','Nguyen Manh'	,'Tam'   ,'1986/2/27', 'Nam' ,'Kiên Giang','K11')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1109','Phan Thi Thanh' 	,'Tam'   ,'1986/1/27', 'Nu'  ,'Vĩnh Long' ,'K11')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1110','Le Hoai'		,'Thuong','1986/2/5' , 'Nu'  ,'Cần Thơ'   ,'K11')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1111','Le Ha'		,'Vinh'  ,'1986/2/25', 'Nam' ,'Vĩnh Long' ,'K11')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1201','Nguyen Van'      ,'B'	  ,'1986/2/11', 'Nam' ,'TpHCM'     ,'K12')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1202','Nguyen Thi Kim'  ,'Duyen' ,'1986/1/18', 'Nu'  ,'TpHCM'     ,'K12')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1203','Tran Th Kim'    ,'Duyen' ,'1986/9/17', 'Nu'  ,'TpHCM'     ,'K12')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1204','Truong My'	,'Hanh'  ,'1986/5/19', 'Nu'  ,'Đồng Nai'  ,'K12')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1205','Nguyen Thanh'    ,'Nam'   ,'1986/4/17', 'Nam', 'TpHCM'     ,'K12')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1206','Nguyen Thi Truc' ,'Thanh' ,'1986/3/4' , 'Nu'  ,'Kiên Giang','K12')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1207','Tran Thi Bich'   ,'Thuy'  ,'1986/2/8' , 'Nu'  ,'Nghệ An'   ,'K12')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1208','Huynh Thị Kim'   ,'Trieu' ,'1986/4/8' , 'Nu'  ,'Tây Ninh'  ,'K12')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1209','Pham Thanh'	,'Trieu' ,'1986/2/23', 'Nam' ,'TpHCM'     ,'K12')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1210','Ngo Thanh'	,'Tuan'  ,'1986/2/14', 'Nam' ,'TpHCM'     ,'K12')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1211','Đo Thi'		,'Xuan'  ,'1986/3/9' ,'Nu'  ,'Hà Nội'    ,'K12')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1212','Le Thi Phi'	,'Yen'   ,'1986/3/12','Nu'  ,'TpHCM'     ,'K12')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1301','Nguyen Thi Kim'  ,'Cuc'   ,'1986/6/9' , 'Nu'  ,'Kiên Giang','K13')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1302','Truong Thi My'   ,'Hien'  ,'1986/3/18', 'Nu'  ,'Nghệ An'   ,'K13')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1303','Le Đuc'          ,'Hien'  ,'1986/3/21', 'Nam' ,'Tây Ninh'  ,'K13')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1304','Le Quang'	,'Hien'  ,'1986/4/18', 'Nam' ,'TpHCM'     ,'K13')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1305','Le Thi'          ,'Huong' ,'1986/3/27', 'Nu'  ,'TpHCM'     ,'K13')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1306','Nguyen Thai'	,'Huu'   ,'1986/3/30', 'Nam' ,'Hà Nội'    ,'K13')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1307','Tran Minh'	,'Man'   ,'1986/5/28', 'Nam' ,'TpHCM'     ,'K13')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1308','Nguyen Hieu'	,'Nghia' ,'1986/4/8' , 'Nam' ,'Kiên Giang','K13')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1309','Nguyen Trung'    ,'Nghia' ,'1987/1/18', 'Nam' ,'Nghệ An'   ,'K13')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1310','Tran Thi Hong'   ,'Tham'  ,'1986/4/22', 'Nu'  ,'Tây Ninh'  ,'K13')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1311','Tran Minh'       ,'Thuc'  ,'1986/4/4' , 'Nam' ,'TpHCM'     ,'K13')
INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) VALUES ('K1312','Nguyen Thi Kim'  ,'Yen'   ,'1986/9/7' , 'Nu'  ,'TpHCM'     ,'K13')
SELECT * FROM HOCVIEN
DELETE FROM HOCVIEN

-- Nhập dữ liệu cho quan hệ GIANGDAY --
insert into GIANGDAY values('K11','THDC','GV07',1,2006,'1/2/2006','5/12/2006')
insert into GIANGDAY values('K12','THDC','GV06',1,2006,'1/2/2006','5/12/2006')
insert into GIANGDAY values('K13','THDC','GV15',1,2006,'1/2/2006','5/12/2006')
insert into GIANGDAY values('K11','CTRR','GV02',1,2006,'1/9/2006','5/17/2006')
insert into GIANGDAY values('K12','CTRR','GV02',1,2006,'1/9/2006','5/17/2006')
insert into GIANGDAY values('K13','CTRR','GV08',1,2006,'1/9/2006','5/17/2006')
insert into GIANGDAY values('K11','CSDL','GV05',2,2006,'6/1/2006','7/15/2006')
insert into GIANGDAY values('K12','CSDL','GV09',2,2006,'6/1/2006','7/15/2006')
insert into GIANGDAY values('K13','CTDLGT','GV15',2,2006,'6/1/2006','7/15/2006')
insert into GIANGDAY values('K13','CSDL','GV05',3,2006,'8/1/2006','12/15/2006')
insert into GIANGDAY values('K13','DHMT','GV07',3,2006,'8/1/2006','12/15/2006')
insert into GIANGDAY values('K11','CTDLGT','GV15',3,2006,'8/1/2006','12/15/2006')
insert into GIANGDAY values('K12','CTDLGT','GV15',3,2006,'8/1/2006','12/15/2006')
insert into GIANGDAY values('K11','HDH','GV04',1,2007,'1/2/2007','2/18/2007')
insert into GIANGDAY values('K12','HDH','GV04',1,2007,'1/2/2007','3/20/2007')
insert into GIANGDAY values('K11','DHMT','GV07',1,2007,'2/18/2007','3/20/2007')
SELECT * FROM GIANGDAY

-- NHẬP DỮ LIỆU CHO quan hệ DIEUKIEN --
insert into DIEUKIEN values('CSDL','CTRR')
insert into DIEUKIEN values('CSDL','CTDLGT')
insert into DIEUKIEN values('CTDLGT','THDC')
insert into DIEUKIEN values('PTTKTT','THDC')
insert into DIEUKIEN values('PTTKTT','CTDLGT')
insert into DIEUKIEN values('DHMT','THDC')
insert into DIEUKIEN values('LTHDT','THDC')
insert into DIEUKIEN values('PTTKHTTT','CSDL')
SELECT *FROM DIEUKIEN

-- Nhập dữ liệu cho quan hệ KETQUATHI --
insert into KETQUATHI values('K1101','CSDL',1,'7/20/2006',10.00,'Dat')
insert into KETQUATHI values('K1101','CTDLGT',1,'12/28/2006',9.00,'Dat')
insert into KETQUATHI values('K1101','THDC',1,'5/20/2006',9.00,'Dat')
insert into KETQUATHI values('K1101','CTRR',1,'5/13/2006',9.50,'Dat')
insert into KETQUATHI values('K1102','CSDL',1,'7/20/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1102','CSDL',2,'7/27/2006',4.25,'Khong Dat')
insert into KETQUATHI values('K1102','CSDL',3,'8/10/2006',4.50,'Khong Dat')
insert into KETQUATHI values('K1102','CTDLGT',1,'12/28/2006',4.50,'Khong Dat')
insert into KETQUATHI values('K1102','CTDLGT',2,'1/5/2007',4.00,'Khong Dat')
insert into KETQUATHI values('K1102','CTDLGT',3,'1/15/2007',6.00,'Dat')
insert into KETQUATHI values('K1102','THDC',1,'5/20/2006',5.00,'Dat')
insert into KETQUATHI values('K1102','CTRR',1,'5/13/2006',7.00,'Dat')
insert into KETQUATHI values('K1103','CSDL',1,'7/20/2006',3.50,'Khong Dat')
insert into KETQUATHI values('K1103','CSDL',2,'7/27/2006',8.25,'Dat')
insert into KETQUATHI values('K1103','CTDLGT',1,'12/28/2006',7.00,'Dat')
insert into KETQUATHI values('K1103','THDC',1,'5/20/2006',8.00,'Dat')
insert into KETQUATHI values('K1103','CTRR',1,'5/13/2006',6.50,'Dat')
insert into KETQUATHI values('K1104','CSDL',1,'7/20/2006',3.75,'Khong Dat')
insert into KETQUATHI values('K1104','CTDLGT',1,'12/28/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1104','THDC',1,'5/20/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1104','CTRR',1,'5/13/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1104','CTRR',2,'5/20/2006',3.50,'Khong Dat')
insert into KETQUATHI values('K1104','CTRR',3,'6/30/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1201','CSDL',1,'7/20/2006',6.00,'Dat')
insert into KETQUATHI values('K1201','CTDLGT',1,'12/28/2006',5.00,'Dat')
insert into KETQUATHI values('K1201','THDC',1,'5/20/2006',8.50,'Dat')
insert into KETQUATHI values('K1201','CTRR',1,'5/13/2006',9.00,'Dat')
insert into KETQUATHI values('K1202','CSDL',1,'7/20/2006',8.00,'Dat')
insert into KETQUATHI values('K1202','CTDLGT',1,'12/28/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1202','CTDLGT',2,'1/5/2007',5.00,'Dat')
insert into KETQUATHI values('K1202','THDC',1,'5/20/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1202','THDC',2,'5/27/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1202','CTRR',1,'5/13/2006',3.00,'Khong Dat')
insert into KETQUATHI values('K1202','CTRR',2,'5/20/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1202','CTRR',3,'6/30/2006',6.25,'Dat')
insert into KETQUATHI values('K1203','CSDL',1,'7/20/2006',9.25,'Dat')
insert into KETQUATHI values('K1203','CTDLGT',1,'12/28/2006',9.50,'Dat')
insert into KETQUATHI values('K1203','THDC',1,'5/20/2006',10.00,'Dat')
insert into KETQUATHI values('K1203','CTRR',1,'5/13/2006',10.00,'Dat')
insert into KETQUATHI values('K1204','CSDL',1,'7/20/2006',8.50,'Dat')
insert into KETQUATHI values('K1204','CTDLGT',1,'12/28/2006',6.75,'Dat')
insert into KETQUATHI values('K1204','THDC',1,'5/20/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1204','CTRR',1,'5/13/2006',6.00,'Dat')
insert into KETQUATHI values('K1301','CSDL',1,'12/20/2006',4.25,'Khong Dat')
insert into KETQUATHI values('K1301','CTDLGT',1,'7/25/2006',8.00,'Dat')
insert into KETQUATHI values('K1301','THDC',1,'5/20/2006',7.75,'Dat')
insert into KETQUATHI values('K1301','CTRR',1,'5/13/2006',8.00,'Dat')
insert into KETQUATHI values('K1302','CSDL',1,'12/20/2006',6.75,'Dat')
insert into KETQUATHI values('K1302','CTDLGT',1,'7/25/2006',5.00,'Dat')
insert into KETQUATHI values('K1302','THDC',1,'5/20/2006',8.00,'Dat')
insert into KETQUATHI values('K1302','CTRR',1,'5/13/2006',8.50,'Dat')
insert into KETQUATHI values('K1303','CSDL',1,'12/20/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1303','CTDLGT',1,'7/25/2006',4.50,'Khong Dat')
insert into KETQUATHI values('K1303','CTDLGT',2,'8/7/2006',4.00,'Khong Dat')
insert into KETQUATHI values('K1303','CTDLGT',3,'8/15/2006',4.25,'Khong Dat')
insert into KETQUATHI values('K1303','THDC',1,'5/20/2006',4.50,'Khong Dat')
insert into KETQUATHI values('K1303','CTRR',1,'5/13/2006',3.25,'Khong Dat')
insert into KETQUATHI values('K1303','CTRR',2,'5/20/2006',5.00,'Dat')
insert into KETQUATHI values('K1304','CSDL',1,'12/20/2006',7.75,'Dat')
insert into KETQUATHI values('K1304','CTDLGT',1,'7/25/2006',9.75,'Dat')
insert into KETQUATHI values('K1304','THDC',1,'5/20/2006',5.50,'Dat')
insert into KETQUATHI values('K1304','CTRR',1,'5/13/2006',5.00,'Dat')
insert into KETQUATHI values('K1305','CSDL',1,'12/20/2006',9.25,'Dat')
insert into KETQUATHI values('K1305','CTDLGT',1,'7/25/2006',10.00,'Dat')
insert into KETQUATHI values('K1305','THDC',1,'5/20/2006',8.00,'Dat')
insert into KETQUATHI values('K1305','CTRR',1,'5/13/2006',10.00,'Dat')
SELECT*FROM KETQUATHI

--I.11.Học viên ít nhất là 18 tuổi
ALTER TABLE HOCVIEN ADD CONSTRAINT CHECK_TUOI CHECK (YEAR(GETDATE()) - YEAR(NGSINH) >= 18)

--I.12.Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc (DENNGAY).
ALTER TABLE GIANGDAY ADD CONSTRAINT CHECK_GIANGDAY CHECK (TUNGAY < DENNGAY)

--I.13.Giáo viên khi vào làm ít nhất là 22 tuổi
ALTER TABLE GIAOVIEN ADD CONSTRAINT CHECK_TUOILAM CHECK (YEAR(NGVL) - YEAR(NGSINH) >= 22)

--I.14Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không quá 3.
ALTER TABLE MONHOC ADD CONSTRAINT CHECK_TINCHI CHECK (ABS(TCLT - TCTH) <= 3)


--III.1.In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp.
SELECT MAHV, (HO+TEN) HOTEN, NGSINH, HOCVIEN.MALOP
FROM
	HOCVIEN, LOP
WHERE
	HOCVIEN.MAHV = LOP.TRGLOP

--III.2.In ra bảng điểm khi thi (mã học viên, họ tên , lần thi, điểm số) môn CTRR của lớp “K12”, sắp xếp theo tên, họ học viên.
SELECT 
	HocVien.MaHV, (Ho+' '+Ten) HoTen, LanThi, Diem 
FROM 
	KetQuaThi, HocVien
WHERE
	KetQuaThi.MaHV = HocVien.MaHV
	AND MaMH = 'CTRR'
	AND MaLop = 'K12'
ORDER BY
	Ten, Ho

--III.3.In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt

SELECT
	HOCVIEN.MAHV, (HO+' '+TEN) HOTEN, TENMH
FROM
	KETQUATHI, MONHOC, HOCVIEN
WHERE
	KETQUATHI.MAMH = MONHOC.MAMH
	AND KETQUAThi.MAHV = HOCVIEN.MAHV
	AND LANTHI = 1 AND KQUA = 'Dat'


--III.4.In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ở lần thi 1).
SELECT
	HOCVIEN.MAHV, (HO+' '+TEN) HOTEN
FROM
	HOCVIEN, KETQUATHI
WHERE
	HOCVIEN.MAHV = KETQUATHI.MAHV
	AND MALOP = 'K11'
	AND MAMH = 'CTRR'
	AND KQUA = 'Khong Dat'
	AND LANTHI = 1

--III.5.Danh sách học viên (mã học viên, họ tên) của lớp “K” thi môn CTRR không đạt (ở tất cả các lần thi).
SELECT DISTINCT
	HOCVIEN.MAHV, (HO+' '+TEN) HOTEN
FROM
	HOCVIEN, KETQUATHI
WHERE
	HOCVIEN.MAHV = KETQUATHI.MAHV
	AND MALOP like 'K%'
	AND MAMH = 'CTRR'
	AND NOT EXISTS
		(SELECT * FROM KetQuaThi 
		WHERE 
			KQua = 'Dat' 
			AND MAMH = 'CTRR' 
			AND MAHV = HOCVIEN.MaHV)

--TUẦN 3
-- II.1 Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa
UPDATE GIAOVIEN SET HESO += 0.2 WHERE MAGV IN (SELECT TRGKHOA FROM KHOA)
SELECT *FROM GIAOVIEN

-- II.2 Cập nhật giá trị điểm trung bình tất cả các môn học (DIEMTB) của mỗi học viên (tất cả các môn học đều có hệ số 1 và nếu học viên thi một môn nhiều lần, chỉ lấy điểm của lần thi sau cùng)
UPDATE HOCVIEN
SET DiemTB =
(
	SELECT AVG(Diem)
	FROM KetQuaThi
	WHERE LanThi = (SELECT MAX(LanThi) FROM KetQuaThi KQ WHERE MaHV = KetQuaThi.MaHV GROUP BY MaHV)
	GROUP BY MaHV
	HAVING MAHV = HOCVIEN.MaHV
)

-- II.3 Cập nhật giá trị cho cột GHICHU là “Cam thi” đối với trường hợp: học viên có một môn bất kỳ thi lần thứ 3 dưới 5 điểm
UPDATE HOCVIEN
SET GHICHU = 'Cam thi'
WHERE MAHV IN 
(
	SELECT MAHV
	FROM KETQUATHI
	WHERE LANTHI = 3 AND DIEM < 5
)
SELECT * FROM HOCVIEN

-- II.4 Cập nhật giá trị cho cột XEPLOAI trong quan hệ HOCVIEN như sau: 
-- Nếu DIEMTB >= 9 thì XEPLOAI = ”XS”
-- Nếu 8 <= DIEMTB < 9 thì XEPLOAI = “G”
-- Nếu 6.5 <= DIEMTB < 8 thì XEPLOAI = “K”
-- Nếu 5 <= DIEMTB < 6.5 thì XEPLOAI = “TB” 
-- Nếu DIEMTB < 5 thì XEPLOAI = ”Y” 

UPDATE HOCVIEN
SET XEPLOAI =
(
	CASE 
		WHEN DIEMTB >= 9 THEN 'XS'
		WHEN DIEMTB >= 8 AND DIEMTB < 9 THEN 'G'
		WHEN DIEMTB >= 6.5 AND DIEMTB < 8 THEN 'K'
		WHEN DIEMTB >= 5 AND DIEMTB < 6.5 THEN 'TB'
		WHEN DIEMTB < 5 THEN 'Y'
	END
)
SELECT* FROM HOCVIEN

-- III.6 Tìm tên những môn học mà giáo viên có tên “Tran Tam Thanh” dạy trong học kỳ 1 năm 2006
SELECT DISTINCT TenMH
FROM
	MonHoc, GiaoVien, GiangDay
WHERE
	MonHoc.MaMH = GiangDay.MaMH
	AND GiaoVien.MaGV = GiangDay.MaGV
	AND HoTen = 'Tran Tam Thanh'
	AND HocKy = 1 AND Nam = 2006

-- III.7 Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy trong học kỳ 1 năm 2006
SELECT DISTINCT
	MonHoc.MaMH, TenMH
FROM
	MonHoc, Lop, GiangDay
WHERE
	GiangDay.MaMH = MonHoc.MaMH
	AND GiangDay.MaGV = Lop.MaGVCN
	AND Lop.MaLop = 'K11'
	AND HocKy = 1 AND Nam = 2006

-- III.8 Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan” dạy môn “Co So Du Lieu”
SELECT DISTINCT 
	(HO+' '+TEN) HOTEN
FROM
	HocVien, Lop, GiaoVien, GiangDay, MonHoc
WHERE
	Lop.TrgLop = HocVien.MaHV
	AND GiangDay.MaLop = Lop.MaLop
	AND GiangDay.MaGV = GiaoVien.MaGV
	AND GiangDay.MaMH = MonHoc.MaMH
	AND HoTen = 'Nguyen To Lan'
	AND TenMH = 'Co So Du Lieu'

-- III.9 In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So Du Lieu”
SELECT
	MonHocTruoc.MaMH, MonHocTruoc.TenMH
FROM
	MonHoc, MonHoc AS MonHocTruoc, DieuKien
WHERE
	MonHoc.MaMH = DieuKien.MaMH
	AND MonHocTruoc.MaMH = DieuKien.MaMH_Truoc
	AND MonHoc.TenMH = 'Co So Du Lieu'



-- III.10 Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học, tên môn học) nào
SELECT 
	MonHoc.MaMH, MonHoc.TenMH
FROM
	MonHoc, MonHoc AS MonHocTruoc, DieuKien
WHERE
	MonHoc.MaMH = DieuKien.MaMH
	AND MonHocTruoc.MaMH = DieuKien.MaMH_Truoc
	AND MonHocTruoc.TenMH = 'Cau Truc Roi Rac'

-- III.11 Tìm họ tên giáo viên dạy môn CTRR cho cả hai lớp “K11” và “K12” trong cùng học kỳ 1 năm 2006
SELECT HoTen
FROM
	GiaoVien, GiangDay
WHERE
	GiaoVien.MaGV = GiangDay.MaGV
	AND MaLop = 'K11'
	AND HocKy = 1 AND Nam = 2006
INTERSECT
	(SELECT HoTen
	FROM
		GiaoVien, GiangDay
	WHERE
		GiaoVien.MaGV = GiangDay.MaGV
		AND MaLop = 'K12' AND HocKy = 1 AND Nam = 2006)



-- III.12 Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 nhưng chưa thi lại môn này
SELECT
	HocVien.MaHV, (Ho+' '+Ten) HoTen
FROM
	HocVien, KetQuaThi
WHERE
	HocVien.MaHV = KetQuaThi.MaHV
	AND MaMH = 'CSDL' AND LanThi = 1 AND KQua = 'Khong Dat'
	AND NOT EXISTS (SELECT * FROM KetQuaThi WHERE LanThi > 1 AND KetQuaThi.MaHV = HocVien.MaHV)

-- III.13 Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào
SELECT MaGV, HoTen
FROM GiaoVien
WHERE MaGV NOT IN (SELECT MaGV FROM GiangDay)

SELECT MAGV,HOTEN FROM GIAOVIEN EXCEPT (SELECT V.MAGV,HOTEN FROM GIANGDAY D ,GIAOVIEN V WHERE D.MAGV=V.MAGV)

-- III.14 Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào thuộc khoa giáo viên đó phụ trách
SELECT MaGV, HoTen
FROM GiaoVien
WHERE NOT EXISTS
(
	SELECT *
	FROM MonHoc
	WHERE MonHoc.MaKhoa = GiaoVien.MaKhoa
	AND NOT EXISTS
	(
		SELECT *
		FROM GiangDay
		WHERE GiangDay.MaMH = MonHoc.MaMH
		AND GiangDay.MaGV = GiaoVien.MaGV
	)
)

-- III.15 Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn “Khong dat” hoặc thi lần thứ 2 môn CTRR được 5 điểm
SELECT DISTINCT
	(Ho+' '+Ten) HoTen
FROM
	HocVien, KetQuaThi
WHERE
	HocVien.MaHV = KetQuaThi.MaHV
	AND MaLop = 'K11'
	AND ((LanThi = 2 AND Diem = 5)
	OR HocVien.MaHV IN
	(
		SELECT DISTINCT MaHV
		FROM KetQuaThi
		WHERE KQua = 'Khong Dat'
		GROUP BY MaHV, MaMH
		HAVING COUNT(*) > 3	
	))

-- III.16 Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ của một năm học
SELECT HoTen
FROM
	GiaoVien, GiangDay
WHERE
	GiaoVien.MaGV = GiangDay.MaGV
	AND MaMH = 'CTRR'
GROUP BY 
	GiaoVien.MaGV, HoTen, HocKy
HAVING 
	COUNT(*) >= 2

-- III.17 Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng)
SELECT
	HocVien.*, Diem AS 'Điểm thi CSDL sau cùng'
FROM
	HocVien, KetQuaThi
WHERE
	HocVien.MaHV = KetQuaThi.MaHV
	AND MaMH = 'CSDL'
	AND LanThi = 
	(
		SELECT MAX(LanThi) 
		FROM KetQuaThi 
		WHERE MaMH = 'CSDL' AND KetQuaThi.MaHV = HocVien.MaHV 
		GROUP BY MaHV
	)

-- III.18 Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi)
SELECT
	HocVien.*, Diem AS 'Điểm thi CSDL cao nhất'
FROM
	HocVien, KetQuaThi, MonHoc
WHERE
	HocVien.MaHV = KetQuaThi.MaHV
	AND KetQuaThi.MaMH = MonHoc.MaMH
	AND TenMH = 'Co So Du Lieu'
	AND Diem = 
	(
		SELECT MAX(Diem) 
		FROM KetQuaThi, MonHoc
		WHERE
			KetQuaThi.MaMH = MonHoc.MaMH
			AND MaHV = HocVien.MaHV
			AND TenMH = 'Co So Du Lieu'
		GROUP BY MaHV
	)


--Tuần 04
--III.19.	Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất.
SELECT MAKHOA,TENKHOA FROM KHOA WHERE NGTLAP=(SELECT MIN(NGTLAP) FROM KHOA)

--20.	Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”.
SELECT HOCHAM, COUNT(MAGV) AS SOLUONG
FROM GIAOVIEN
WHERE HOCHAM = 'GS' OR HOCHAM = 'PGS'
GROUP BY HOCHAM

--21.	Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa.
SELECT MAKHOA,HOCVI, COUNT(*) AS SOLUONG 
FROM GIAOVIEN 
GROUP BY MAKHOA, HOCVI 
ORDER BY MAKHOA

--22.	Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt).
SELECT MAMH,KQUA,COUNT(MAHV) AS SoLuong FROM KETQUATHI WHERE KQUA='Dat' OR KQUA='Khong Dat'
GROUP BY MAMH,KQUA ORDER BY MAMH

--23.	Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho lớp đó ít nhất một môn học.

SELECT HOTEN,MAGV 
FROM GIAOVIEN 
WHERE MAGV IN( SELECT MAGVCN 
			   FROM LOP 
			   WHERE EXISTS( SELECT* 
							 FROM GIANGDAY 
						     WHERE MAGVCN = GIANGDAY.MAGV))

--24.	Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất.
SELECT HO + ' ' + TEN AS HOTEN FROM HOCVIEN V,LOP L WHERE V.MAHV=L.TRGLOP AND SISO IN(SELECT MAX(SISO) FROM LOP)

SELECT CONCAT(HO,' ',TEN) AS HOTEN
FROM HOCVIEN 
INNER JOIN LOP ON LOP.MALOP = HOCVIEN.MALOP
WHERE TRGLOP = HOCVIEN.MAHV 
	  AND LOP.SISO = (SELECT MAX(SISO) 
	                  FROM LOP) 

--25.	* Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả các lần thi).
SELECT CONCAT(HO,' ',TEN) AS HOTEN 
FROM HOCVIEN 
INNER JOIN LOP ON LOP.MALOP = HOCVIEN.MALOP
WHERE TRGLOP IN (SELECT MAHV
				 FROM (SELECT MAHV, MAMH
					   FROM KETQUATHI 
					   WHERE KQUA = 'Khong Dat' 
					   EXCEPT 
					   SELECT MAHV, MAMH 
					   FROM KETQUATHI 
					   WHERE KQUA = 'Dat' AND LANTHI >= 1) AS L
				 GROUP BY MAHV 
				 HAVING COUNT(MAMH) > 3)

--26.	Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
SELECT HOCVIEN.MAHV,CONCAT(HO,' ',TEN) AS HOTEN, COUNT(HOCVIEN.MAHV) AS SO_LUONG
FROM KETQUATHI 
INNER JOIN HOCVIEN ON HOCVIEN.MAHV = KETQUATHI.MAHV 
WHERE DIEM BETWEEN 9 AND 10 
GROUP BY HOCVIEN.MAHV,HO,TEN 
HAVING COUNT(DIEM) = ( SELECT MAX(SOLUONG) 
					   FROM( SELECT MAHV, COUNT(MAHV) AS SOLUONG 
							 FROM KETQUATHI 
							 WHERE DIEM BETWEEN 9 AND 10 
							 GROUP BY MAHV) AS A)

--27.	Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
SELECT DISTINCT HOCVIEN.MAHV, CONCAT(HO,' ',TEN) AS HOTEN, SOLUONG 
FROM ( SELECT MAHV, COUNT(MAHV) AS SOLUONG 
	   FROM KETQUATHI
	   WHERE DIEM BETWEEN 9 AND 10
	   GROUP BY MAHV) AS A, --Bảng A: Số lượng 9 10 của từng sinh viên 

	 ( SELECT MALOP, MAX(SOLUONG) AS SL
	   FROM (SELECT MAHV, COUNT(MAHV) AS SOLUONG 
			 FROM KETQUATHI 							 
			 WHERE DIEM BETWEEN 9 AND 10 
			 GROUP BY MAHV) AS A
			 INNER JOIN HOCVIEN ON HOCVIEN.MAHV = A.MAHV 
	   GROUP BY MALOP) AS B, --Bảng B: Số lượng 9 10 nhiều nhất trong từng lớp 
	 HOCVIEN
WHERE A.SOLUONG = B.SL AND A.MAHV = HOCVIEN.MAHV

--28.	Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp.
SELECT GIAOVIEN.MAGV, HOTEN, HOCKY, NAM, COUNT(DISTINCT MAMH) AS SL_MONHOC, COUNT(DISTINCT MALOP) AS SL_LOP 
FROM GIAOVIEN,GIANGDAY  
WHERE GIAOVIEN.MAGV = GIANGDAY.MAGV 
GROUP BY HOCKY, NAM,GIAOVIEN.MAGV,HOTEN 
ORDER BY HOCKY, NAM 

--29.	Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất.
SELECT GIAOVIEN.MAGV, HOTEN, A.HOCKY, A.NAM, A.SLGD  
FROM (SELECT HOCKY, NAM, MAX(SL_GIANGDAY) AS SLGD
	  FROM( SELECT MAGV,HOCKY,NAM, COUNT(MAGV) AS SL_GIANGDAY 
		    FROM GIANGDAY 
		    GROUP BY MAGV, HOCKY, NAM) AS BANGMOI 
	  GROUP BY HOCKY,NAM
	 ) AS A, -- Bảng A: Số lượng giảng dạy nhiều nhất trong từng học kì 
	 (SELECT MAGV,HOCKY,NAM, COUNT(MAGV) AS SL_GIANGDAY 
	  FROM GIANGDAY 
	  GROUP BY MAGV, HOCKY, NAM 
	 ) AS B, -- Bảng B: Trong từng học kì, năm, số lần giảng dạy của từng giáo viên 
	  GIAOVIEN
WHERE A.HOCKY = B.HOCKY AND A.NAM = B.NAM AND A.SLGD = B.SL_GIANGDAY AND GIAOVIEN.MAGV = B.MAGV
ORDER BY A.NAM, A.HOCKY	

--30.	Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1) nhất.
SELECT KQ.MAMH, TENMH, COUNT(KQ.MAHV) AS SL 
FROM KETQUATHI KQ, MONHOC MH 
WHERE KQ.MAMH = MH.MAMH AND KQUA = N'Không Đạt' AND LANTHI = 1 
GROUP BY KQ.MAMH,TENMH 
HAVING COUNT(KQ.MAHV) >=ALL (SELECT COUNT(MAHV) -- >= ALL: lớn nhất 
						     FROM KETQUATHI
						     WHERE KQUA = N'Không Đạt' AND LANTHI = 1 
						     GROUP BY MAMH)

--31.	Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1).
SELECT HOCVIEN.MAHV, CONCAT(HO,' ',TEN) AS HOTEN 
FROM(SELECT MAHV
	 FROM KETQUATHI 
	 WHERE LANTHI = 1 AND KQUA = N'Đạt'
	 GROUP BY MAHV
	 HAVING COUNT(MAHV) = 4) AS A
INNER JOIN HOCVIEN ON HOCVIEN.MAHV = A.MAHV 

--32.	* Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng).
SELECT HOCVIEN.MAHV, CONCAT(HO,' ',TEN) AS HOTEN 
FROM HOCVIEN, (SELECT MAHV, COUNT(MAHV) AS SL_QUAMON 
			   FROM KETQUATHI KQ1
			   WHERE LANTHI = (SELECT MAX(LANTHI) -- Lấy lần thi sau cùng 
                               FROM KETQUATHI KQ2
						       WHERE (KQ1.MAHV = KQ2.MAHV AND KQ1.MAMH = KQ2.MAMH)
						       GROUP BY MAHV,MAMH) 
			    	 AND KQUA = N'Đạt'
			   GROUP BY MAHV) AS A -- Bảng A lấy ra từng học viên và số môn đạt 
WHERE HOCVIEN.MAHV = A.MAHV AND SL_QUAMON = 4

--33.	* Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt (chỉ xét lần thi thứ 1).
SELECT HOCVIEN.MAHV, CONCAT(HO,' ',TEN) AS HOTEN 
FROM HOCVIEN 
WHERE NOT EXISTS(SELECT*
				 FROM MONHOC 
				 WHERE NOT EXISTS(SELECT* 
								  FROM KETQUATHI
								  WHERE KETQUATHI.MAMH = MONHOC.MAMH 
								        AND KETQUATHI.MAHV = HOCVIEN.MAHV 
										AND KQUA = N'Đạt'
										AND LANTHI = 1))
--34.	* Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt  (chỉ xét lần thi sau cùng).

SELECT HOCVIEN.MAHV, CONCAT(HO,' ',TEN) AS HOTEN 
FROM HOCVIEN 
WHERE NOT EXISTS(SELECT*
				 FROM MONHOC 
				 WHERE NOT EXISTS(SELECT* 
								  FROM KETQUATHI KQ1
								  WHERE KQ1.MAMH = MONHOC.MAMH 
								        AND KQ1.MAHV = HOCVIEN.MAHV 
										AND KQUA = N'Đạt'
										AND LANTHI =(SELECT MAX(LANTHI) -- Lấy ra lần thi sau cùng 
												     FROM KETQUATHI KQ2
													 WHERE (KQ1.MAHV = KQ2.MAHV 
												            AND KQ1.MAMH = KQ2.MAMH))))

--35.	** Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất trong từng môn (lấy điểm ở lần thi sau cùng).

SELECT HOCVIEN.MAHV,CONCAT(HO, ' ',TEN) AS HOTEN,KQ4.MAMH,DIEM  -- In ra điểm tất cả lần thi cuối 
FROM KETQUATHI KQ4,HOCVIEN, (SELECT MAMH, MAX(DIEM) AS DIEMCAONHAT -- Điểm cao nhất của từng môn lần thi cuối 
							 FROM ( SELECT MAHV,MAMH ,LANTHI,DIEM   
									FROM KETQUATHI KQ1
									WHERE LANTHI = (SELECT MAX(LANTHI)
													FROM KETQUATHI KQ2
				   									WHERE (KQ1.MAHV = KQ2.MAHV AND KQ1.MAMH = KQ2.MAMH)
													GROUP BY MAHV,MAMH
													)
								   ) AS A, HOCVIEN --Bảng A lọc ra điểm tất cả lần thi cuối
							 WHERE HOCVIEN.MAHV = A.MAHV
							 GROUP BY MAMH
							) AS C -- Bảng C lọc ra điểm cao nhất của từng môn lần thi cuối 
WHERE LANTHI = (SELECT MAX(LANTHI) -- Lần thi cuối 
			    FROM KETQUATHI KQ5
				WHERE (KQ4.MAHV = KQ5.MAHV AND KQ4.MAMH = KQ5.MAMH)
				GROUP BY MAHV,MAMH
			    )
	  AND KQ4.MAMH = C.MAMH AND KQ4.DIEM = C.DIEMCAONHAT -- Học viên có môn học và điểm trùng với bảng C
	  AND HOCVIEN.MAHV = KQ4.MAHV