--Tạo cơ sở dữ liệu
CREATE DATABASE GIAOVU;
USE GIAOVU;

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
	MAHV CHAR(5),
	HO VARCHAR(40),
	TEN VARCHAR(10),
	NGSINH SMALLDATETIME,
	GIOITINH VARCHAR(3),
	NOISINH VARCHAR(40),
	MALOP CHAR(3),
	CONSTRAINT PK_HOCVIEN PRIMARY KEY (MAHV)
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
	MAHV CHAR(5),
	MAMH VARCHAR(10),
	LANTHI TINYINT,
	NGTHI SMALLDATETIME,
	DIEM NUMERIC(4,2),
	KQUA VARCHAR(10)
	CONSTRAINT PK_KETQUATHI PRIMARY KEY (MAHV, MAMH, LANTHI)
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

--Tuần 2
--1.Nhập dữ liệu cho mỗi quan hệ
--1.1 Nhập dữ liệu cho quan hệ KHOA
insert into KHOA values('KHMT','Khoa hoc may tinh','6/7/2005','GV01')
insert into KHOA values('HTTT','He thong thong tin','6/7/2005','GV02')
insert into KHOA values('CNPM','Cong nghe phan mem','6/7/2005','GV04')
insert into KHOA values('MTT','Mang va truyen thong','10/20/2005','GV03')
insert into KHOA values('KTMT','Ky thuat may tinh','12/20/2005','')

SELECT * FROM KHOA;

--1.2.Nhập dữ liệu cho quan hệ GIAOVIEN
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

SELECT * FROM GIAOVIEN;

--1.3.Nhập dữ liệu cho quan hệ MONHOC
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

SELECT * FROM MONHOC;


--1.4.Nhập dữ liệu cho quan hệ LOP
insert into LOP values('K11','Lop 1 khoa 1','K1108',11,'GV07')
insert into LOP values('K12','Lop 2 khoa 1','K1205',12,'GV09')
insert into LOP values('K13','Lop 3 khoa 1','K1305',12,'GV14')

SELECT * FROM LOP;

--1.5.Nhập dữ liệu cho quan hệ HOCVIEN
insert into HOCVIEN values('K1101','Nguyen Van','A','1/27/1986','Nam','TpHCM','K11')
insert into HOCVIEN values('K1102','Tran Ngoc','Han','3/1/1986','Nu','Kien Giang','K11')
insert into HOCVIEN values('K1103','Ha Duy','Lap','4/18/1986','Nam','Nghe An','K11')
insert into HOCVIEN values('K1104','Tran Ngoc','Linh','3/30/1986','Nu','Tay Ninh','K11')
insert into HOCVIEN values('K1105','Tran Minh','Long','2/27/1986','Nam','TpHCM','K11')
insert into HOCVIEN values('K1106','Le Nhat','Minh','1/24/1986','Nam','TpHCM','K11')
insert into HOCVIEN values('K1107','Nguyen Nhu','Nhut','1/27/1986','Nam','Ha Noi','K11')
insert into HOCVIEN values('K1108','Nguyen Manh','Tam','2/27/1986','Nam','Kien Giang','K11')
insert into HOCVIEN values('K1109','Phan Thi Thanh','Tam','1/27/1986','Nu','Vinh Long','K11')
insert into HOCVIEN values('K1110','Le Hoai','Thuong','2/5/1986','Nu','Can Tho','K11')
insert into HOCVIEN values('K1111','Le Ha','Vinh','12/25/1986','Nam','Vinh Long','K11')
insert into HOCVIEN values('K1201','Nguyen Van','B','2/11/1986','Nam','TpHCM','K12')
insert into HOCVIEN values('K1202','Nguyen Thi Kim','Duyen','1/18/1986','Nu','TpHCM','K12')
insert into HOCVIEN values('K1203','Tran Thi Kim','Duyen','9/17/1986','Nu','TpHCM','K12')
insert into HOCVIEN values('K1204','Truong My','Hanh','5/19/1986','Nu','Dong Nai','K12')
insert into HOCVIEN values('K1205','Nguyen Thanh','Nam','4/17/1986','Nam','TpHCM','K12')
insert into HOCVIEN values('K1206','Nguyen Thi Truc','Thanh','3/4/1986','Nu','Kien Giang','K12')
insert into HOCVIEN values('K1207','Tran Thi Bich','Thuy','2/8/1986','Nu','Nghe An','K12')
insert into HOCVIEN values('K1208','Huynh Thi Kim','Trieu','4/8/1986','Nu','Tay Ninh','K12')
insert into HOCVIEN values('K1209','Pham Thanh','Trieu','2/23/1986','Nam','TpHCM','K12')
insert into HOCVIEN values('K1210','Ngo Thanh','Tuan','2/14/1986','Nam','TpHCM','K12')
insert into HOCVIEN values('K1211','Do Thi','Xuan','3/9/1986','Nu','Ha Noi','K12')
insert into HOCVIEN values('K1212','Le Thi Phi','Yen','3/12/1986','Nu','TpHCM','K12')
insert into HOCVIEN values('K1301','Nguyen Thi Kim','Cuc','6/9/1986','Nu','Kien Giang','K13')
insert into HOCVIEN values('K1302','Truong Thi My','Hien','3/18/1986','Nu','Nghe An','K13')
insert into HOCVIEN values('K1303','Le Duc','Hien','3/12/1986','Nam','Tay Ninh','K13')
insert into HOCVIEN values('K1304','Le Quang','Hien','4/18/1986','Nam','TpHCM','K13')
insert into HOCVIEN values('K1305','Le Thi','Huong','3/27/1986','Nu','TpHCM','K13')
insert into HOCVIEN values('K1306','Nguyen Thai','Huu','3/30/1986','Nam','Ha Noi','K13')
insert into HOCVIEN values('K1307','Tran Minh','Man','5/28/1986','Nam','TpHCM','K13')
insert into HOCVIEN values('K1308','Nguyen Hieu','Nghia','4/8/1986','Nam','Kien Giang','K13')
insert into HOCVIEN values('K1309','Nguyen Trung','Nghia','1/18/1987','Nam','Nghe An','K13')
insert into HOCVIEN values('K1310','Tran Thi Hong','Tham','4/22/1986','Nu','Tay Ninh','K13')
insert into HOCVIEN values('K1311','Tran Minh','Thuc','4/4/1986','Nam','TpHCM','K13')
insert into HOCVIEN values('K1312','Nguyen Thi Kim','Yen','9/7/1986','Nu','TpHCM','K13')

SELECT * FROM HOCVIEN;

--1.6.Nhập dữ liệu cho quan hê GIANGDAY
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

SELECT * FROM GIANGDAY;

--1.7.Nhập dữ liệu cho quan hệ DIEUKIEN
insert into DIEUKIEN values('CSDL','CTRR')
insert into DIEUKIEN values('CSDL','CTDLGT')
insert into DIEUKIEN values('CTDLGT','THDC')
insert into DIEUKIEN values('PTTKTT','THDC')
insert into DIEUKIEN values('PTTKTT','CTDLGT')
insert into DIEUKIEN values('DHMT','THDC')
insert into DIEUKIEN values('LTHDT','THDC')
insert into DIEUKIEN values('PTTKHTTT','CSDL')

SELECT * FROM DIEUKIEN;

--1.8.Nhập dữ liệu cho quan hệ KETQUATHI
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

SELECT * FROM KETQUATHI;

--I.11.Học viên ít nhất là 18 tuổi
ALTER TABLE HOCVIEN ADD CONSTRAINT CHECK_TUOI CHECK (YEAR(GETDATE()) - YEAR(NGSINH) >= 18)

--I.12.Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc (DENNGAY).
ALTER TABLE GIANGDAY ADD CONSTRAINT CHECK_GIANGDAY CHECK (TUNGAY < DENNGAY)

--I.13.Giáo viên khi vào làm ít nhất là 22 tuổi
ALTER TABLE GIAOVIEN ADD CONSTRAINT CHECK_TUOILAM CHECK (YEAR(NGVL) - YEAR(NGSINH) >= 22)

--I.14Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không quá 3.
ALTER TABLE MONHOC ADD CONSTRAINT CHECK_TINCHI CHECK (ABS(TCLT - TCTH) <= 3)


--III.1.In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp.
SELECT
	MaHV, (Ho+Ten) HoTen, NgSinh, HocVien.MaLop
FROM
	HocVien, Lop
WHERE
	HocVien.MaHV = Lop.TrgLop

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
	HocVien.MaHV, (Ho+' '+Ten) HoTen, TenMH
FROM
	KetQuaThi, MonHoc, HocVien
WHERE
	KetQuaThi.MaMH = MonHoc.MaMH
	AND KetQuaThi.MaHV = HocVien.MaHV
	AND LanThi = 1 AND KQua = 'Dat'


--III.4.In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ở lần thi 1).
SELECT
	HocVien.MaHV, (Ho+' '+Ten) HoTen
FROM
	HocVien, KetQuaThi
WHERE
	HocVien.MaHV = KetQuaThi.MaHV
	AND MaLop = 'K11'
	AND MaMH = 'CTRR'
	AND KQua = 'Khong Dat'
	AND LanThi = 1

--III.5.Danh sách học viên (mã học viên, họ tên) của lớp “K” thi môn CTRR không đạt (ở tất cả các lần thi).
SELECT DISTINCT
	HocVien.MaHV, (Ho+' '+Ten) HoTen
FROM
	HocVien, KetQuaThi
WHERE
	HocVien.MaHV = KetQuaThi.MaHV
	AND MaLop like 'K%'
	AND MaMH = 'CTRR'
	AND NOT EXISTS
		(SELECT * FROM KetQuaThi 
		WHERE 
			KQua = 'Dat' 
			AND MaMH = 'CTRR' 
			AND MaHV = HocVien.MaHV)




