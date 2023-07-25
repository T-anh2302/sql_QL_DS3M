-- QUẢN LÝ CỬA HÀNG BÁN ĐẶC SẢN 3 MIỀN

CREATE DATABASE QUAN_LY_DAC_SAN_BA_MIEN 
-----------------------------------------------------
-----------------------------------------------------
--------------------------------------------------
use QUAN_LY_DAC_SAN_BA_MIEN

-- KHACHHANG
CREATE TABLE KHACHHANG(
	makhachhang nvarchar (50) not null,
	tenkhachhang nvarchar (50) not null,
	diachi nvarchar (50) not null,
	email nvarchar (50) not null,
	dienthoai nvarchar (50) not null
	CONSTRAINT pk_kh PRIMARY KEY(MAKHACHHANG)
);
-----------------------------------------------------

-- NHANVIEN
CREATE TABLE NHANVIEN(
	manhanvien nvarchar (50) not null,
	ho nvarchar (50) not null,
	ten nvarchar (50) not null,
	ngaysinh date not null check (ngaysinh < getdate()),
	ngaylamviec date not null check ( ngaylamviec <= getdate()),
	diachi nvarchar (50) not null,
	gioitinh nvarchar (50) not null default ('Nam'),
	dienthoai nvarchar (50) not null,
	luongcoban float not null,
	phucap float not null
	CONSTRAINT pk_nv PRIMARY KEY(MANHANVIEN)
);
-----------------------------------------------------

-- MIEN
CREATE TABLE MIEN(
	mamien nvarchar (50) not null,
	tenmien nvarchar (50) not null
	CONSTRAINT pk_mi PRIMARY KEY(MAMIEN)	
);
-----------------------------------------------------

-- LOAIMON
CREATE TABLE LOAIMON(
	maloaimon nvarchar (50) not null,
	tenloaimon nvarchar (50) not null
	CONSTRAINT pk_lm PRIMARY KEY(MALOAIMON)
);
-----------------------------------------------------

-- DONHANG 
CREATE TABLE DONHANG (
	sohoadon nvarchar (50) not null,
	makhachhang nvarchar (50) not null,
	manhanvien nvarchar (50) not null,
	ngaydathang date not null check (ngaydathang <= getdate()),
	ngaygiaohang date not null,
	noigiaohang nvarchar (50) not null
	CONSTRAINT pk_dh PRIMARY KEY(SOHOADON)
);
-----------------------------------------------------

-- CHITIETDONHANG 
CREATE TABLE CHITIETDONHANG (
	sohoadon nvarchar (50) not null,
	mamon nvarchar (50) not null,
	giaban float not null,
	soluong int not null
	CONSTRAINT pk_ctdh PRIMARY KEY(SOHOADON,MAMON)
);
-----------------------------------------------------

-- MONAN 
CREATE TABLE MONAN (
	mamon nvarchar (50) not null,
	tenmon nvarchar (50) not null,
	mamien nvarchar (50) not null,
	maloaimon nvarchar (50) not null,
	soluong int not null,
	donvi nvarchar (50) not null,
	giamon float not null
	CONSTRAINT pk_ma PRIMARY KEY(MAMON)
);
-----------------------------------------------------

----- Tạo kết nối
-- Khóa ngoại cho bảng DONDATHANG

alter table DONHANG
	add	
			constraint dh_kh 
			foreign key (makhachhang)
			references KHACHHANG (makhachhang),

			constraint dh_nv
			foreign key (manhanvien)
			references NHANVIEN (manhanvien)
------------------------------------------------------------

-- Khóa ngoại cho bảng CHITIETDONHANG

alter table CHITIETDONHANG
	add
			constraint ctdh_dh
			foreign key (sohoadon)
			references DONHANG (sohoadon),

			constraint ctdh_ma
			foreign key (mamon)
			references MONAN (mamon)
------------------------------------------------------------
-- Khóa ngoại cho bảng MON

alter table MONAN
	add
			constraint ma_m
			foreign key (mamien)
			references MIEN (mamien),

			constraint ma_lm
			foreign key (maloaimon)
			references LOAIMON (maloaimon)
------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

set dateformat dmy
-------------------------------
----- Thêm dữ liệu
-- KHACHHANG

insert into KHACHHANG values('kh01', N'Nguyễn Thảo Ly',N'Nghệ An', 'lylu@gmail.com', '09876543234'),
							('kh02', N'Trần Văn Nam',N'Bắc Ninh', 'Namtran@gmail.com', '0987236544'),
							('kh03', N'Ngô Tiến Tuấn',N'Nam Định', 'Tuntun45@gmail.com', '02457654346'),
							('kh04', N'Nguyễn Thị Mai Anh',N'Lào Cai', 'anhmai@gmail.com', '07436895234'),
							('kh05', N'Lê Minh Huy',N'Phú Thọ', 'Minhhuy@gmail.com', '035875434'),
							('kh06', N'Trần Trung Kiên',N'Thái Bình', 'Kienng@gmail.com', '0983567433'),
							('kh07', N'Vũ Văn Nam',N'Hà Nam', 'Namchip@gmail.com', '0356743932'),
							('kh08', N'Nguyễn Anh Dũng',N'Phú Thọ', 'Dunganh@gmail.com', '0565778234'),
							('kh09', N'Nguyễn Huy Quân',N'Vĩnh Phúc', 'huyQuan@gmail.com', '0654325634'),
							('kh10', N'Hoàng Yến Nhi',N'Lào Cai', 'Nhinhi@gmail.com', '087654345234')

------------------------------------------------------------------------------------------------------------

-- NHANVIEN

insert into NHANVIEN values	('nv01',N'Phạm',N'Đoàn Quốc Anh','09/08/2002','01/02/2022',N'Ninh Bình', N'Nam ', '0931684763',3000000,0),
							('nv02',N'Phạm',N'Duy Thuận','10/04/2002','12/02/2022',N'Thái Bình', N'Nam ','09318765433',3000000,0),
							('nv03',N'Khuất',N'Thanh Ngoan','06/18/2002','10/11/2022',N'Hà Nội', N'Nữ','086387654',3000000,0),
							('nv04',N'Nguyễn ',N'Văn Khải','07/12/2001','12/02/2021',N'Hải Dương', N'Nam ','093765435',4000000,0),
							('nv05',N'Vũ',N'Tuấn Anh','11/12/2002','05/05/2022',N'Nam Định', N'Nam ','03467763',3000000,0),
							('nv06',N'Nguyễn ',N'Hải Anh','09/08/2003','01/02/2022',N'Yên Bái',  N'Nam ','0931686543',3000000,0)

------------------------------------------------------------------------------------------------------------

-- MIEN

insert into MIEN values	('m01', N'Miền Bắc'),
						('m02', N'Miền Trung'),
						('m03', N'Miền Nam')

------------------------------------------------------------------------------------------------------------

-- LOAIMON

insert into LOAIMON values	('lm01',N'Bún'),
							('lm02',N'Phở'),
							('lm03',N'Cơm'),
							('lm04',N'Bánh'),
							('lm05',N'Kẹo'),
							('lm06',N'Món ăn kèm'),
							('lm07',N'Trái cây')

------------------------------------------------------------------------------------------------------------

-- DONHANG

insert into DONHANG values	('01', 'kh01', 'nv01', '01/01/2022', '01/03/2022', N'Hà Nội'),
							('02', 'kh01', 'nv01', '11/02/2022', '11/03/2022', N'Hà Nội'),
							('03', 'kh02', 'nv03', '04/21/2022', '04/23/2022', N'Hà Nam'),
							('04', 'kh04', 'nv02', '09/11/2022', '09/15/2022', N'Hải Phòng'),
							('05', 'kh05', 'nv01', '10/10/2022', '10/13/2022', N'Hải Dương')

------------------------------------------------------------------------------------------------------------

-- CHITIETDONHANG

insert into CHITIETDONHANG values	('01', 'ma01', 35000, 2),
									('01', 'ma05', 25000, 1),
									('01', 'ma10', 120000, 2),
									('02', 'ma02', 60000, 3),
									('03', 'ma01', 35000, 4),
									('04', 'ma06', 80000, 5),
									('05', 'ma09', 35000, 2)

------------------------------------------------------------------------------------------------------------

-- MONAN

insert into MONAN values( 'ma01', N'Bún Chả Hà Nội', 'm01', 'lm01', 50, N'Bát',35000),
					( 'ma02', N'Bún Riêu', 'm03', 'lm01', 60, N'Bát', 40000),
					( 'ma03', N'Cốm Hà Nội', 'm01', 'lm04', 50, N'Hộp', 20000),
					( 'ma04', N'Bún Mọc', 'm01', 'lm01', 50, N'Bát',35000),
					( 'ma05', N'Cơm Cháy Ninh Bình', 'm01', 'lm04', 70, N'Gói', 25000),
					( 'ma06', N'Chả Mực Hạ Long', 'm01', 'lm06', 100, N'Gói', 80000),
					( 'ma07', N'Canh Cá Rô Hải Dương', 'm01', 'lm06', 50, N'Bát',60000),
					( 'ma08', N'Bánh Đậu Xanh', 'm01', 'lm04', 40, N'Hộp',35000),
					( 'ma09', N'Bánh Cáy', 'm01', 'lm04', 50, N'Hộp', 25000),
					( 'ma10', N'Thịt Trâu gác bếp', 'm01', 'lm06', 50, N'kg', 120000),
					( 'ma11', N'Bánh Bèo', 'm02', 'lm04', 100, N'Cái', 15000),
					( 'ma12', N'Bánh Bột Lọc', 'm02', 'lm04', 120, N'Cái', 10000),
					( 'ma13', N'Bánh Xèo', 'm02', 'lm04', 50, N'Cái',20000),
					( 'ma14', N'Kẹo Cu-đơ', 'm02', 'lm05', 50, N'Gói',40000),
					( 'ma15', N'Chè Huế', 'm02', 'lm06', 50, N'Bát', 15000),
					( 'ma16', N'Mực Rim Me', 'm02', 'lm06', 50, N'Hộp', 150000),
					( 'ma17', N'Cháo Lươn Nghệ An', 'm02', 'lm06', 50, N'Bát',60000),
					( 'ma18', N'Cơm Tấm Sài Gòn', 'm03', 'lm03', 50, N'Đĩa',50000),
					( 'ma19', N'Kẹo Dừa Bến Tre', 'm03', 'lm05', 70, N'Hộp',70000),
					( 'ma20', N'Bánh Pía Sóc Trăng', 'm03', 'lm04', 65, N'Hộp',60000),
					( 'ma21', N'Gỏi cá Tây Ninh', 'm03', 'lm06', 50, N'Đĩa',120000)
------------------------------------------------------------------------------------------------------------

select * from KHACHHANG
select * from DONHANG
select * from NHANVIEN
select * from MIEN
select * from MONAN
select * from CHITIETDONHANG
select * from LOAIMON
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
-- Câu hỏi truy vấn
--1. In ra danh sách các nhân viên (MANHANVIEN,HO,TEN) có địa chỉ ở "Hà Nội"

--2. In ra danh sách họ tên của nhân viên sinh vào tháng 9

--3. In ra nhân viên có lương cơ bản cao nhất

--4. In ra danh sách các sản phẩm (mamon, tenmon) có đơn vị tính là "bát", "hộp".

--5. In ra danh sách các món(mamon, tenmon) theo tên miền

--6. In ra tên món ăn của loại món 1 hoặc 2

--7. Tìm các số hóa đơn đã mua sản phẩm có mã số “ma01” hoặc “ma02”, mỗi sản phẩm mua với số lượng từ 1 đến 2

--8. In ra nhân viên có tuổi cao nhất hiện nay

--9. In ra danh sách các món (mamon, tenmon) có tên món bắt đầu là “B” và số lượng > 50

--10. In ra danh sách các món (mamon, tenmon) do “miền bắc” sản xuất có giá từ 25.000 đến 60.000

--11. In ra danh sách các món (mamon, tenmon) do "Miền Bắc" hoặc "Miền Nam" sản xuất có đơn giá từ 25.000 đến 40.000

--12. In ra danh sách các tên hàng không bán được mặt hàng nào

--13. Liệt kê danh sách các khách hàng đã mua trên 100k

--14. In ra danh sách các món ăn đã được mua trong năm 2022 và tổng tiền trên 200k

--15. In ra mã món, tên món, số hóa đơn trong bảng chi tiết đơn hàng có số hóa đơn là 1

--16. In ra tên khách hàng, tên địa chỉ và số hóa đơn trong bảng đơn hàng

--17. In ra những mã miền cung cấp loại món 6 và có số lượng mã loại món >= 1

--18. In ra danh sách tên món theo tên miền và mã miền cung cấp loại món 4 và có số lượng mã loại món >= 1

--19. (Đối với những nhân viên đã lập hóa đơn,) thống kê xem mỗi nhân viên đó được bao nhiêu hóa đơn

--20. In ra đơn đặt hàng nào có số lượng hàng được đặt ít nhất

--21. In ra món ăn nào chỉ mua được đúng 1 lần trong năm 2022

--22. In ra mức lương thấp nhất của nhân viên với đk: mức lương thấp nhất của nhân viên đó phải lớn hơn mức lương thấp nhất của nhân viên có mã nhân viên là nv1

--23. In ra mã món, tên món ăn có số lượng nhỏ hơn mọi số lượng của mặt hàng có mã loại món là lm03

--24. Tính doanh thu trung bình của tất cả các hóa đơn được bán ra trog năm 2022

--25. Tính doanh thu bán hàng mỗi ngày

--26. Tìm khách hàng (makhachhang, tenkhachhang) có số lần mua hàng nhiều nhất

--27. In ra danh sách các món được khách hàng có tên Nguyễn Thảo Ly mua trong tháng 1/2022

--28. Có bao nhiêu món ăn khác nhau được bán ra trong năm 2022

--29. In ra họ tên khách hàng đã mua hóa đơn có giá trị cao nhất trong năm 2022

--30. Tính tổng số tiền đã bán của từng hóa đơn

--31. Tính tổng số lượng và tổng số tiền đã bán được của từng món ăn trong năm 2022

--32. Tính tổng số tiền đã mua món ăn của từng khách hàng, thống kê dựa vào tên khách hàng

--33. In ra tên món ăn đã bán với số lượng nhiều nhất

--34. In ra tên món ăn đã bán với giá cao nhất
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

--1. In ra danh sách các nhân viên (MANHANVIEN,HO,TEN) có địa chỉ ở "Hà Nội"
select manhanvien, ho, ten
from NHANVIEN
where diachi = N'Hà Nội'

--2. In ra danh sách họ tên của nhân viên sinh vào tháng 9
select ho, ten, ngaysinh
from NHANVIEN
where MONTH(ngaysinh) in (9)

--3. In ra nhân viên có lương cơ bản cao nhất
select ten, luongcoban
from NHANVIEN
where luongcoban = (select MAX(luongcoban) 
from NHANVIEN)

--4. In ra danh sách các món ăn (mamon, tenmon) có đơn vị tính là "bát", "hộp".
select mamon, tenmon, donvi
from MONAN where donvi in (N'Bát', N'Hộp')

--5. In ra danh sách các món(mamon, tenmon) theo tên miền
select tenmien, mamon, tenmon
from MONAN join MIEN on MONAN.mamien = MIEN.mamien
group by tenmien, mamon, tenmon

--6. In ra tên món ăn của loại món 1 hoặc 2
select mamon, maloaimon,tenmon
from MONAN where maloaimon in ('lm01', 'lm02')

--7. Tìm các số hóa đơn đã mua sản phẩm có mã số “ma01” hoặc “ma02”, mỗi sản phẩm mua với số lượng từ 1 đến 2.
select sohoadon
from CHITIETDONHANG
where mamon in ('ma01', 'ma02') and soluong between 1 and 2

--8. In ra nhân viên có tuổi cao nhất hiện nay
select ho, ten, YEAR(GETDATE()) - YEAR(NgaySinh) as max_tuoi
from NHANVIEN
where YEAR(GETDATE()) - YEAR(ngaysinh) = (select 
MAX(YEAR(GETDATE()) - YEAR(ngaysinh))
from NHANVIEN) 

--9. In ra danh sách các món (mamon, tenmon) có tên món bắt đầu là “B” và số lượng > 50
select mamon, tenmon, soluong
from MONAN where tenmon like 'B%' and soluong > 50

--10. In ra danh sách các món (mamon, tenmon) do “miền bắc” sản xuất có giá từ 25.000 đến 60.000
select mamon, tenmon, tenmien, giamon
from MONAN join MIEN on MONAN.mamien = MIEN.mamien
where tenmien = N'Miền Bắc' and giamon between 25000 and 60000
group by mamon, tenmon, tenmien, giamon
order by giamon asc

--11. In ra danh sách các món (mamon, tenmon) do "Miền Bắc" hoặc "Miền Nam" sản xuất có đơn giá từ 25.000 đến 40.000
select mamon, tenmon, tenmien, giamon
from MONAN join MIEN on MONAN.mamien = MIEN.mamien
where (tenmien = N'Miền Bắc' or tenmien = N'Miền Nam') and giamon between 25000 and 40000
group by mamon, tenmon, tenmien, giamon
order by giamon asc

--12. In ra danh sách các tên hàng không bán được mặt hàng nào
select m.tenmon
from MONAN m
where m.mamon not in(select mamon from CHITIETDONHANG)

--13. Liệt kê danh sách các khách hàng đã mua trên 100k
select DONHANG.makhachhang, KHACHHANG.tenkhachhang, SUM(CHITIETDONHANG.soluong*CHITIETDONHANG.giaban) as total
from (DONHANG inner join CHITIETDONHANG on DONHANG.sohoadon = CHITIETDONHANG.sohoadon)
join KHACHHANG on KHACHHANG.makhachhang = DONHANG.makhachhang
group by DONHANG.makhachhang, KHACHHANG.tenkhachhang
having SUM(CHITIETDONHANG.soluong*CHITIETDONHANG.giaban) > 100000

--14. In ra danh sách các món ăn đã được mua trong năm 2022 và tổng tiền trên 200k
select CHITIETDONHANG.mamon, MONAN.tenmon, SUM(CHITIETDONHANG.soluong*MONAN.giamon) as total
from (CHITIETDONHANG inner join DONHANG on CHITIETDONHANG.sohoadon = DONHANG.sohoadon)
join MONAN on MONAN.mamon = CHITIETDONHANG.mamon
where YEAR(ngaydathang) = 2022
group by CHITIETDONHANG.mamon, MONAN.tenmon
having SUM(CHITIETDONHANG.soluong*MONAN.giamon) > 200000

--15. In ra mã món, tên món, số hóa đơn trong bảng chi tiết đơn hàng có số hóa đơn là 1
select CHITIETDONHANG.mamon, tenmon, sohoadon
from CHITIETDONHANG join MONAN
on CHITIETDONHANG.mamon = MONAN.mamon

where sohoadon = All (select sohoadon from CHITIETDONHANG where sohoadon = 1)
--16. In ra tên khách hàng, tên địa chỉ và số hóa đơn trong bảng đơn hàng
select tenkhachhang, diachi,sohoadon
from KHACHHANG join DONHANG 
on KHACHHANG.makhachhang = DONHANG.makhachhang

--17. In ra những mã miền cung cấp loại món 6 và có số lượng mã loại món >= 1
select mamien, tenmon
from MONAN where maloaimon = 'lm06'
group by mamien, tenmon
having COUNT(maloaimon) >= 1

--18. In ra danh sách tên món theo tên miền và mã miền cung cấp loại món 4 và có số lượng mã loại món >= 1
select MIEN.mamien, tenmien, tenmon
from MIEN join MONAN on MIEN.mamien = MONAN.mamien
where maloaimon = 'lm04'
group by MIEN.mamien, tenmien, tenmon
having COUNT(maloaimon) >= 1

--19. (Đối với những nhân viên đã lập hóa đơn,) thống kê xem mỗi nhân viên đó được bao nhiêu hóa đơn
select NHANVIEN.manhanvien, ho, ten, COUNT(sohoadon) as 'Thống kê hóa đơn'
from NHANVIEN, DONHANG
where NHANVIEN.manhanvien = DONHANG.manhanvien
group by NHANVIEN.manhanvien, ho, ten

--20. In ra đơn đặt hàng nào có số lượng hàng được đặt ít nhất
select DONHANG.sohoadon, SUM(soluong) as min_so_luong
from DONHANG join CHITIETDONHANG on DONHANG.sohoadon = CHITIETDONHANG.sohoadon
group by DONHANG.sohoadon
having SUM(soluong) = (select MIN(a.TSL)
					from (select sohoadon, SUM(soluong) as TSL from CHITIETDONHANG 
					group by sohoadon) as a);

--21. In ra món ăn nào chỉ mua được đúng 1 lần trong năm 2022
select CHITIETDONHANG.mamon, MONAN.tenmon
from (DONHANG join CHITIETDONHANG on DONHANG.sohoadon = CHITIETDONHANG.sohoadon)
join MONAN on MONAN.mamon = CHITIETDONHANG.mamon
where YEAR(ngaygiaohang) = 2022
group by CHITIETDONHANG.mamon, MONAN.tenmon
having COUNT(CHITIETDONHANG.mamon) < 2

--22. In ra mức lương thấp nhất của nhân viên với đk: mức lương thấp nhất của nhân viên đó phải lớn hơn mức lương thấp nhất của nhân viên có mã nhân viên là nv1
select manhanvien, ten, MAX(luongcoban) as luong_co_ban
from NHANVIEN
group by manhanvien, ten
having MAX(luongcoban) > (select MAX(luongcoban) from NHANVIEN where manhanvien = 'nv01')

--23. In ra mã món, tên món ăn có số lượng nhỏ hơn mọi số lượng của mặt hàng có mã loại món là lm03
select mamon, tenmon, soluong, maloaimon
from MONAN
where soluong < All (select soluong from MONAN where maloaimon = 'lm03')

--24. Tính doanh thu trung bình của tất cả các hóa đơn được bán ra trog năm 2022
select AVG(giaban) as Doanh_thu
from CHITIETDONHANG join DONHANG on CHITIETDONHANG.sohoadon = DONHANG.sohoadon
where YEAR(ngaydathang) = 2022

--25. Tính doanh thu bán hàng mỗi ngày
select ngaydathang, SUM(giaban) as Doanh_thu_moi_ngay
from CHITIETDONHANG join DONHANG on CHITIETDONHANG.sohoadon = DONHANG.sohoadon
group by ngaydathang

--26. Tìm khách hàng (makhachhang, tenkhachhang) có số lần mua hàng nhiều nhất
select makhachhang, tenkhachhang
from KHACHHANG where makhachhang = (select TOP 1 makhachhang
from DONHANG group by makhachhang
order by COUNT(distinct sohoadon) desc)

--27. In ra danh sách các món được khách hàng có tên Nguyễn Thảo Ly mua trong tháng 1/2022
select distinct MONAN.mamon, tenmon
from MONAN join CHITIETDONHANG on MONAN.mamon = CHITIETDONHANG.mamon
and exists (select * from CHITIETDONHANG join DONHANG on CHITIETDONHANG.sohoadon = DONHANG.sohoadon
and MONTH(ngaydathang) = 1 and YEAR(ngaydathang) = 2022 and makhachhang in (select DONHANG.makhachhang
from DONHANG join KHACHHANG on DONHANG.makhachhang = KHACHHANG.makhachhang
where tenkhachhang = N'Nguyễn Thảo Ly') and MONAN.mamon = CHITIETDONHANG.mamon)

--28. Có bao nhiêu món ăn khác nhau được bán ra trong năm 2022
select COUNT(distinct mamon) as N'số món được bán'
from CHITIETDONHANG join DONHANG on CHITIETDONHANG.sohoadon = DONHANG.sohoadon
where YEAR(ngaydathang) = 2022

--29. In ra họ tên khách hàng đã mua hóa đơn có giá trị cao nhất trong năm 2022
select KHACHHANG.tenkhachhang, DONHANG.sohoadon, CHITIETDONHANG.giaban
from (CHITIETDONHANG join DONHANG on CHITIETDONHANG.sohoadon = DONHANG.sohoadon)
join KHACHHANG on KHACHHANG.makhachhang = DONHANG.makhachhang
and DONHANG.sohoadon >= (select sohoadon from CHITIETDONHANG 
where giaban = (select MAX(giaban) from CHITIETDONHANG))

--30. Tính tổng số tiền đã bán của từng hóa đơn
select sohoadon, SUM(CHITIETDONHANG.soluong*MONAN.giamon) as total
from CHITIETDONHANG join MONAN on CHITIETDONHANG.mamon = MONAN.mamon
group by sohoadon
order by total desc

--31. Tính tổng số lượng và tổng số tiền đã bán được của từng món ăn trong năm 2022
select mamon, SUM(soluong) as tong_so_luong, SUM(giaban*soluong) as tong_so_tien
from CHITIETDONHANG join DONHANG on CHITIETDONHANG.sohoadon = DONHANG.sohoadon
where YEAR(ngaydathang) = 2022
group by mamon

--32. Tính tổng số tiền đã mua món ăn của từng khách hàng, thống kê dựa vào tên khách hàng
select SUM(giaban*soluong) as tong_so_tien, KHACHHANG.tenkhachhang
from (CHITIETDONHANG join DONHANG on CHITIETDONHANG.sohoadon = DONHANG.sohoadon)
join KHACHHANG on KHACHHANG.makhachhang = DONHANG.makhachhang
group by KHACHHANG.tenkhachhang

--33. In ra tên món ăn đã bán với số lượng nhiều nhất
select tenmon, SUM(CHITIETDONHANG.soluong) as max_so_luong
from MONAN join CHITIETDONHANG on MONAN.mamon = CHITIETDONHANG.mamon
group by tenmon
having SUM(CHITIETDONHANG.soluong) = (select MAX(a.TSL)
									from (select mamon, SUM(soluong) as TSL from CHITIETDONHANG
									group by mamon) as a);

--34. In ra tên món ăn đã bán với giá cao nhất
select MIEN.tenmien, tenmon, SUM(CHITIETDONHANG.giaban) as max_gia
from (MONAN join CHITIETDONHANG on MONAN.mamon = CHITIETDONHANG.mamon)
join MIEN on MIEN.mamien = MONAN.mamien
group by tenmon, MIEN.tenmien
having SUM(CHITIETDONHANG.giaban) = (select MAX(a.TSL)
									from (select mamon, SUM(giaban) as TSL from CHITIETDONHANG
									group by mamon) as a);

--35. Thống kê xem trong năm 20022, mỗi một mặt hàng trong quý 1 bán được với số lượng bao nhiêu 
select ma.MaMon, ma.TenMon,
		sum (case MONTH(NgayDatHang) when 1 then ct.SoLuong
			else 0 end) as [tháng 1],
		sum (case MONTH(NgayDatHang) when 2 then ct.SoLuong
			else 0 end) as [tháng 2],
		sum (case MONTH(NgayDatHang) when 3 then ct.SoLuong
			else 0 end) as [tháng 3]
from (DonHang dh inner join ChiTietDonHang ct on dh.SoHoaDon = ct.SoHoaDon) inner join MonAn ma on ma.MaMon = ct.MaMon
where YEAR (NgayDatHang) = 2022
group by ma.MaMon, ma.TenMon
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
-- Câu hỏi view
--1. Tạo khung nhìn có tên DSMA từ câu lệnh select truy vấn dữ liệu từ hai bảng MONAN và MIEN
create view dsma
	 as
		select mamon, tenmon, tenmien
		from MONAN, MIEN
		where MONAN.mamien = MIEN.mamien
		select * from dsma

--2. Tạo view Cho 3 món ăn có giá cao nhất
create view [dsmax3]
as
		select *
		from MonAn
		where giamon in (select top 3 giamon
					from MonAn
					order by giamon desc)

	select * from [dsmax3]

--3. Tạo view in ra số lượng, giá bán được đặt từ ngày 1/1/2022 đến ngày 10/10/2022
create view [Giá bán]
as
	select soluong, giaban, ngaydathang
	from CHITIETDONHANG join DONHANG on CHITIETDONHANG.sohoadon = DONHANG.sohoadon
	where ngaydathang >= '2022-01-01' and  ngaydathang <= '2022-10-10'
	group by soluong, giaban, ngaydathang
	
	select * from  [Giá bán]

--4. Thống kê tình hình đặt hàng
create view [Tình hình đặt hàng]
as
	select DONHANG.ngaydathang, CHITIETDONHANG.mamon, MONAN.tenmon, SUM(CHITIETDONHANG.soluong) as tong_so_luong
	from (DONHANG join CHITIETDONHANG on DONHANG.sohoadon = CHITIETDONHANG.sohoadon)
	join MONAN on MONAN.mamon = CHITIETDONHANG.mamon
	group by DONHANG.ngaydathang, CHITIETDONHANG.mamon, MONAN.tenmon

	select * from [Tình hình đặt hàng]

--5. Tạo view tính tổng số tiền đã mua hàng của từng khách hàng
create view [Tổng tiền từng khách1]
as
	select SUM(giaban*soluong) as tong_so_tien, KHACHHANG.tenkhachhang
	from (CHITIETDONHANG join DONHANG on CHITIETDONHANG.sohoadon = DONHANG.sohoadon)
	join KHACHHANG on KHACHHANG.makhachhang = DONHANG.makhachhang
	group by KHACHHANG.tenkhachhang
 
	select * from [Tổng tiền từng khách1]

--6. Tạo view in ra hóa đơn có mua ít nhất 4 sản phẩm khác nhau
 create view [hóa đơn1]
 as
	select * from DONHANG
	where sohoadon in (select sohoadon from CHITIETDONHANG where soluong >= 4)

	select * from [hóa đơn1]

--7. Tạo view in ra danh sách các món theo mã miền 1 hoặc 2
create view [danh sách món1]
as
	select mamien, mamon, tenmon 
	from MONAN where mamien in ('m01', 'm02')

	select * from [danh sách món1]

--8. Tạo view đếm số lượng của mỗi loại món
create view [đếm số lượng1]
as
	select maloaimon, COUNT(soluong) as so_luong
	from MONAN
	group by maloaimon

	select * from [đếm số lượng1]

--9. Tạo view in ra nhân viên có lương cao hơn lương của nhân viên A(manhanvien = nv1)
create view [nhân viên có lương]
as 
	select ten, luongcoban
	from NHANVIEN
	where luongcoban > (select luongcoban from NHANVIEN where manhanvien = 'nv01')

	select * from [nhân viên có lương]

--10. Tạo view Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
create view [giá trị hóa đơn 1]
as
	select MAX(giaban) as max_gia, MIN(giaban) as min_gia
	from CHITIETDONHANG

	select * from [giá trị hóa đơn 1]
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
-- Câu hỏi thủ tục
--1. Tạo thủ tục tính tổng số lượng của 2 món ăn bất kỳ 
create proc soluong2monan(@mamon1 nvarchar(20), @mamon2 nvarchar(20))
as
	declare @soluong1 int
	declare @soluong2 int
	declare @tong int
	select @soluong1 = soluong from MONAN where mamon = @mamon1
	select @soluong2 = soluong from MONAN where mamon = @mamon2
	select @tong = @soluong1 + @soluong2
	print N'tổng số lượng là: ' + str(@tong)

	soluong2monan  ma01,ma02

--2. Tạo thủ tục để so sánh số lượng của 2 mặt hàng bất kỳ
create proc soluong2monan1(@mamon1 nvarchar(20), @mamon2 nvarchar(20))
as
	declare @soluong1 int
	declare @soluong2 int
	
	select @soluong1 = soluong from MONAN where mamon = @mamon1
	select @soluong2 = soluong from MONAN where mamon = @mamon2
	print N'số lượng mặt hàng'+@mamon1+N' là:' + str(@soluong1)
	print N'số lượng mặt hàng'+@mamon2+N' là:' + str(@soluong2)
	if @soluong1 = @soluong2 print N'2 mặt hàng có cùng số lượng'
	else if @soluong1 < @soluong2 print N' mặt hàng '+@mamon1+N' nhỏ hơn'+ @mamon2
	else print N' mặt hàng '+@mamon1 +N' lớn hơn '+ @mamon2

	soluong2monan1 ma01,ma02

--3. Kiểm tra xem 2 nhân viên có cùng năm sinh hay không
create proc ktnamsinh(@manhanvien1 nvarchar(20), @manhanvien2 nvarchar(20))
as
	declare @nam1 int
	declare @nam2 int
	select @nam1 = YEAR(ngaysinh) from NHANVIEN where manhanvien = @manhanvien1
	select @nam2 = YEAR(ngaysinh) from NHANVIEN where manhanvien = @manhanvien2
	if @nam1 = @nam2 print N'cùng năm sinh'
	else print N'không cùng năm sinh'

	ktnamsinh nv01, nv02

--4. Kiểm tra số lượng món ăn 
create proc soluong(@mamon nvarchar(20), @soluong1 int output)
as
	select @soluong1 = soluong from MONAN where mamon = @mamon
	
	soluong ma01

--5. Cho biết tổng số tiền hàng đã mua của một hóa đơn nào đó
create proc tongtienHD(@sohoadon int)
as
	declare @sumHd int
	select @sumHd = bang2.sumhd
	from (select CHITIETDONHANG.sohoadon, SUM(soluong*giaban) as sumhd 
	from DONHANG join CHITIETDONHANG on DONHANG.sohoadon = CHITIETDONHANG.sohoadon
	where CHITIETDONHANG.sohoadon = @sohoadon
	group by CHITIETDONHANG.sohoadon) as bang2
	print N'Tổng số tiền đã mua' + str(@sumhd)

	select * from DONHANG
	tongtienHD 01

--6. Cho biết tổng số tiền hàng đã bán của một tháng nào đó
create proc tongtienthang(@thang int)
as
	declare @sumThang int
	select @sumThang = bang3.sumTien
	from (select MONTH(ngaygiaohang) as thang, SUM(soluong*giaban) as sumTien
	from DONHANG join CHITIETDONHANG on DONHANG.sohoadon = CHITIETDONHANG.sohoadon
	where MONTH(ngaygiaohang) = @thang
	group by MONTH(ngaygiaohang)) as bang3
	print N'Tổng số tiền đã bán' + str(@sumthang)

	select * from DONHANG
	tongtienthang  01

--7. viết thủ tục lưu trữ có chức năng thống kê tên Khách hàng  ở một đơn hàng bất kì
create proc [thống kê khách hàng] @sohoadon int 
as
	select tenkhachhang
	from KhachHang
	where makhachhang in (select makhachhang
					from DonHang
					where SoHoaDon = @sohoadon)

execute [thống kê khách hàng] 1

--8. Xây dựng thủ tục liệt kê các cột dữ liệu trong bảng MonAn với tên ssma. Thủ tục này không có tham số. Hành động duy nhất là câu lệnh truy vấn SELECT * FROM MonAn sắp xếp với TenMon tăng dần
create proc [sắp xếp tên món]
as
	select *
	from MonAn
	order by TenMon asc

execute [sắp xếp tên món]

--9.  Xây dưng thủ tục sửa đổi món ăn trong bảng MONAN
create proc Monan_Sua
		@mamon nvarchar (50),
		@tenmon nvarchar (50),
		@mamien nvarchar (50),
		@maloaimon nvarchar (50),
		@soluong int,
		@donvi nvarchar (50),
		@giamon money
		as
			update MonAn
			set  TenMon=@tenmon, MaMien = @mamien, MaLoaiMon= @maloaimon,Soluong = @soluong ,DonVi=@donvi, giamon = @giamon
			where MaMon = @mamon

execute Monan_Sua 'ma21',N'Bánh đậu', 'm03', 'lm07', 32, N'Hộp', 230000
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
--Câu hỏi bẫy lỗi
--1. Tạo trigger có chức năng tự động giảm số lượng hàng khi thực hiện bổ sung một bản ghi vào bảng CHITIETDATHANG
create trigger tg_ctdh_insert 
on ChiTietDonHang
for insert 
as 
	update MonAn
	set MonAn.Soluong = MonAn.Soluong-inserted.SoLuong
	from MonAn inner join inserted on MonAn.MaMon = inserted.MaMon

	select * from CHITIETDONHANG
	-- gọi thực hiện 
	insert ChiTietDonHang( SoHoaDon, MaMon, giaban, SoLuong)
	values ('01', 'ma02', 35000, 3)

	--Tắt Bật 
	disable trigger tg_ctdh_insert
	on CHITIETDONHANG

--2. Tạo trigger có chức năng tự động tăng số lượng hàng hiện có khi 1 bản ghi bị xóa trong bảng  CHITIETDONHANG
create trigger tg_del_ctdh
on ChiTietDonHang
for delete
as
	update MonAn
	set MonAn.Soluong = MonAn.Soluong+deleted.SoLuong
	from MonAn inner join deleted on MonAn.MaMon = deleted.MaMon

	delete ChiTietDonHang
	where SoHoaDon = '02' and MaMon = 'ma03'

	enable trigger tg_del_ctdh
	on CHITIETDONHANG

	Disable trigger tg_del_ctdh
	on CHITIETDONHANG

--3. Tạo trigger có chức năng tự động tăng giảm số lượng hàng hiện có khi 1 bản ghi trong bảng chitietdathang bị sửa.
create trigger tg_update_soluong
on ChiTietDonHang
for update
as
	if update(Soluong)
	update MonAn
	set MonAn.Soluong = MonAn.Soluong-(inserted.SoLuong-deleted.SoLuong)
	from (deleted inner join inserted on deleted.MaMon = inserted.MaMon) inner join MonAn on MonAn.MaMon = deleted.MaMon

	update ChiTietDonHang
	set SoLuong=SoLuong
	where SoHoaDon = '02' and MaMon = 'ma02'

	enable trigger tg_update_soluong
	on CHITIETDONHANG

	Disable trigger tg_update_soluong
	on CHITIETDONHANG

--4. Kiểm tra điều kiệ hợp lệ của dũ liệu
--Tạo trigger có chức năng tự động giảm số lượng hàng hiện có khi bổ sung 1 bản ghi vào bảng chitietdathang.
--Trong trigger này kiểm tra điều kiện hợp lệ của dữ liệu là số lượng hàng bán ra phải nhỏ hơn hoặc bằng số lượng hàng hiện có. Nếu kiều kiện này không thỏa mãn thì hủy bỏ thao tác bổ sung số liệu
create trigger chitietdathang2
on ChiTietDonHang 
for insert
as
	declare @slc int
	declare @slb int
	declare @mm nvarchar(50)
	select @mm = MaMon, @slb = SoLuong from inserted
	select @slc = Soluong from MonAn where MaMon = @mm
	if @slc < @slb 
	begin print N'Số lượng không đủ'
	rollback tran
	return
	end
	else
	update MonAn
	set Soluong = Soluong - @slb 
	where MaMon = @mm

--5. hiển thị bảng khi thay đổi số lượng 
create trigger tg_hienthi
on MonAn
for insert , update
as
		print N'Kết quả sau khi cập nhật'
		select * from MonAn