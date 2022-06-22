use master 
go

drop database Lad9
go

create database Lad9
go 

use Lad9
go

create table KhachHang 
(
	KhachHangID int primary key,
	TenKhachHang nvarchar(50),
	DiaChi nvarchar(100),
	SDT varchar(15)
)
go

insert into KhachHang values (1,N'Vũ Duy Khánh',N'Nam Định','0369852147'),
							(2,N'Mai Xuân Tiến',N'Hà Nội','0123456789'),
							(3,N'Nguyễn Xuân Hạnh',N'Bắc Ninh','0456123789'),
							(4,N'Tống Minh Dương',N'Thanh Hoá','0321654789'),
							(5,N'Nguyễn Bá Quốc',N'Hà Nội','0123963852147'),
							(6,N'Nguyễn Bá Tiến',N'Hà Nội','0123963852147')

create table Sach_ 
(	
	SachID int primary key,
	LoaiSach nvarchar(50),
	TacGia nvarchar(50),
	NhaXuatBan nvarchar(50),
	TenSach nvarchar(100),
	Gia int ,
	SoLuong int,
)
go

insert into Sach_ values (101,N'Truyện tranh',N'Khuất Duy Tiến',N'Kim Đồng',N'Đô rê mon',10000,50),
						(102,N'Trinh Thám',N'Khuất Duy Khánh',N'Trí Đức',N'Harryporter',30000,75),
						(103,N'Văn Học',N'Khuất Duy Lai',N'Đông Đô',N'Em và Trịnh',50000,55),
						(104,N'Toán Học',N'Khuất Duy Dũng',N'Quốc Gia',N'Định Lý Viet',15000,25),
						(105,N'CNTT',N'Khuất Duy Trinh',N'Hoài Đức',N'Lập Trình C',1000,14)


create table SachDaBan 
(	
	HoaDonSach int primary key,
	KhachHangID int constraint fk_KhachHangID 
	foreign key (KhachHangID) 
	references KhachHang(KhachHangID),
	SachID int constraint fk_SachID 
	foreign key (SachID) 
	references Sach_(SachID),
	NgayBan date,
	GiaSachTaiThoiDiemBan int,
	SoLuongDaBan int
)
go

insert into SachDaBan values (301,1,101,'2022-1-9',25000,3),
							(302,1,102,'2022-2-9',25000,3),
							(303,2,103,'2022-5-9',25000,3),
							(304,2,104,'2022-5-9',25000,3),
							(305,3,105,'2022-1-9',25000,3),
							(306,3,101,'2022-4-9',25000,3),
							(307,4,102,'2022-3-9',25000,3),
							(308,4,103,'2022-6-9',25000,3),
							(309,5,104,'2022-6-9',25000,3),
							(310,5,105,'2022-5-9',25000,3)

create view V_SachDaBan as 
select Sach_.TenSach,SachDaBan.GiaSachTaiThoiDiemBan,sum(SachDaBan.SoLuongDaBan) as
TongSoLuongBan
from Sach_
join SachDaBan on
Sach_.SachID = SachDaBan.SachID 
group by Sach_.TenSach,SachDaBan.GiaSachTaiThoiDiemBan

select * from V_SachDaBan 
go

create view V_SachDaMuaKhachHang as 
select TenKhachHang,DiaChi, sum(SoLuongDaBan) as SoLuongDaMua
from KhachHang
join SachDaBan on 
KhachHang.KhachHangID = SachDaBan.KhachHangID
group by TenKhachHang,DiaChi

select * from V_SachDaMuaKhachHang 
go

create view V_SachDaMuaKhachHangDaMuaThangTruoc as 
select TenKhachHang,DiaChi,TenSach from ((KhachHang
join SachDaBan on KhachHang.KhachHangID = SachDaBan.KhachHangID)
join Sach_ on Sach_.SachID = SachDaBan.SachID)
where month(GETDATE()) - month(NgayBan) = 1

select TenKhachHang,sum(SachDaBan.GiaSachTaiThoiDiemBan * SoLuongDaBan) as CCC
from KhachHang
join SachDaBan on
KhachHang.KhachHangID = SachDaBan.KhachHangID
group by TenKhachHang,SachDaBan.GiaSachTaiThoiDiemBan








