USE diemDanhHocSinhLite

CREATE TABLE monHoc (
    monHocID    VARCHAR (20) PRIMARY KEY,
    tenMonHoc   NVARCHAR(50) ,
	soTiet      INT          ,
    ghiChu      NVARCHAR(MAX),
);

CREATE TABLE toChucDay (
	soKi     INT        ,
	nganhID  VARCHAR(50),
	monHocID VARCHAR(20),
	STT_ki   INT        ,
);

CREATE TABLE lop (
    lopID       VARCHAR (20) PRIMARY KEY,
	tenLop      NVARCHAR(30) ,
    siSo        INT          ,
    nganhID     VARCHAR (20) ,
	nam         INT          ,
	khoa        INT          ,
    ghiChu      NVARCHAR(MAX),
);

CREATE TABLE sinhVien (
    sinhVienID  VARCHAR (20) PRIMARY KEY,
    hoDem       NVARCHAR(50) ,
    ten         NVARCHAR(20) ,
    ngaySinh    DATE         ,
	nam         INT          , -- tiến độ học tính theo năm
    khoa        INT          , -- sinh viên tuyển đợt mấy
    lopID       VARCHAR (20) ,
    nganhID     VARCHAR (20) ,
	email       NVARCHAR(50) UNIQUE,  
    matKhau     NVARCHAR(50) , 
	soDienThoai VARCHAR (20) , 
	vaiTro      NVARCHAR(30) , 
    ghiChu      NVARCHAR(MAX),
);

CREATE TABLE giaoVien (
    giaoVienID  VARCHAR (20) PRIMARY KEY,
    hoDem       NVARCHAR(50) ,
    ten         NVARCHAR(20) ,
    ngaySinh    DATE         ,
	email       NVARCHAR(50) UNIQUE, 
    matKhau     NVARCHAR(50) ,  
	soDienThoai VARCHAR (20) ,
    vaiTro      NVARCHAR(30) ,
	monHocID    VARCHAR(20)  ,
    ghiChu      NVARCHAR(MAX),
);

CREATE TABLE phongHoc (
    phongHocID  VARCHAR (20) PRIMARY KEY,
    tenPhongHoc NVARCHAR(50) ,
    soGhe       INT          , -- >= 1 + so hoc sinh ( 1 ghe cho giao vien) de du cho ngoi
    tang        INT          ,

	maToaNha    VARCHAR (20) , -- nếu 1 cơ sở chỉ có 1 tòa nhà thì bỏ qua
	tenToaNha   NVARCHAR(50) ,

	maCoSo      VARCHAR (20) ,
	tenCoSo     NVARCHAR(50) ,
    diaChiCoSo  NVARCHAR(MAX), -- ví dụ : quận, huyện, …

    ghiChu      NVARCHAR(MAX),
);



CREATE TABLE buoiHoc (
    buoiHocID   VARCHAR(20)   PRIMARY KEY,

	ngay        DATE                     ,
	tietBatDau  INT                      ,
    tietKetThuc INT                      ,

	monHocID    VARCHAR(20)              ,
    phongHocID  VARCHAR(20)              ,
    lopID       VARCHAR(20)              ,
    giaoVienID  VARCHAR(20)              ,

	maDiemDanh  NVARCHAR(50)             ,

	ghiChu      NVARCHAR(MAX)            ,
);



CREATE TABLE luuDiemDanh (
    luuDiemDanhID VARCHAR(20)   PRIMARY KEY                 ,
	buoiHocID     VARCHAR(20)                               ,
    sinhVienID    VARCHAR(20)                               ,
    trangThai     NVARCHAR(20)                              ,
    soTiet        INT                                       ,
	ghiChu        NVARCHAR(MAX)                             ,
);

ALTER TABLE toChucDay
ADD CONSTRAINT FK_toChucDay_monHoc
FOREIGN KEY (monHocID) REFERENCES monHoc(monHocID);

ALTER TABLE sinhVien
ADD CONSTRAINT FK_sinhVien_lopID
FOREIGN KEY (lopID) REFERENCES lop(lopID);

ALTER TABLE giaoVien
ADD CONSTRAINT FK_giaoVien_monHocID
FOREIGN KEY (monHocID) REFERENCES monHoc(monHocID);

ALTER TABLE buoiHoc ADD 
CONSTRAINT FK_buoiHoc_monHocID   FOREIGN KEY (monHocID)   REFERENCES   monHoc(monHocID),
CONSTRAINT FK_buoiHoc_phongHocID FOREIGN KEY (phongHocID) REFERENCES   phongHoc(phongHocID),
CONSTRAINT FK_buoiHoc_lopID      FOREIGN KEY (lopID)      REFERENCES   lop(lopID),
CONSTRAINT FK_buoiHoc_giaoVienID FOREIGN KEY (giaoVienID) REFERENCES   giaoVien(giaoVienID);

ALTER TABLE luuDiemDanh ADD 
CONSTRAINT  FK_luuDiemDanh_buoiHocID   FOREIGN KEY (buoiHocID)  REFERENCES  buoiHoc(buoiHocID),
CONSTRAINT  FK_luuDiemDanh_sinhVienID  FOREIGN KEY (sinhVienID) REFERENCES  sinhVien(sinhVienID);

CREATE TABLE hoVaTen (
	ID	  INT         ,
	hoDem NVARCHAR(50),
	ten   NVARCHAR(20),
);


GO

CREATE PROCEDURE sp_RandomPassword
    @LengthString INT,
    @LengthNumber INT,
    @RandomString NVARCHAR(MAX) OUTPUT
AS
BEGIN
    SET @RandomString = '';
    DECLARE @Counter INT = 0;

    WHILE @Counter < @LengthString
    BEGIN
        -- Tạo ký tự ngẫu nhiên từ a-z
        SET @RandomString = @RandomString + CHAR(97 + ABS(CHECKSUM(NEWID())) % 26);
        SET @Counter = @Counter + 1;
    END

    SET @Counter = 0;
    WHILE @Counter < @LengthNumber
    BEGIN
        -- Tạo số ngẫu nhiên từ 0-9
        SET @RandomString = @RandomString + CONVERT(VARCHAR(1), ABS(CHECKSUM(NEWID())) % 10);
        SET @Counter = @Counter + 1;
    END
END;

GO

CREATE PROCEDURE sp_RandomPhoneNumber
    @Length INT,
    @RandomPhoneNumber NVARCHAR(20) OUTPUT
AS
BEGIN
    SET @RandomPhoneNumber = '0';
    DECLARE @Counter INT = 0;

    WHILE @Counter < @Length - 1
    BEGIN
        -- Tạo số ngẫu nhiên từ 1-9
        SET @RandomPhoneNumber = @RandomPhoneNumber + CONVERT(VARCHAR(1), ABS(CHECKSUM(NEWID())) % 9 + 1);
        SET @Counter = @Counter + 1;
    END
END;

GO

INSERT INTO hoVaTen (ID, hoDem, ten) VALUES 
(1, N'Nguyễn Văn', N'An'),
(2, N'Nguyễn Thị', N'Bình'),
(3, N'Trần Minh', N'Cường'),
(4, N'Phạm Hoàng', N'Dũng'),
(5, N'Lê Thị', N'Ela'),
(6, N'Nguyễn Quốc', N'Phong'),
(7, N'Đỗ Minh', N'Quân'),
(8, N'Vũ Huy', N'Quý'),
(9, N'Nguyễn Thế', N'Tuấn'),
(10, N'Trần Kim', N'Vân'),
(11, N'Nguyễn Thanh', N'Lan'),
(12, N'Phạm Hữu', N'Long'),
(13, N'Lê Hồng', N'Nhung'),
(14, N'Trần Đức', N'Nhàn'),
(15, N'Nguyễn Huy', N'Sơn'),
(16, N'Đỗ Quang', N'Thắng'),
(17, N'Vũ Đình', N'Thảo'),
(18, N'Nguyễn Văn', N'Thi'),
(19, N'Phạm Minh', N'Tuấn'),
(20, N'Lê Văn', N'Vinh'),
(21, N'Nguyễn Xuân', N'Yến'),
(22, N'Đinh Khải', N'Hoa'),
(23, N'Nguyễn Hữu', N'Khoa'),
(24, N'Trần Tùng', N'Nhật'),
(25, N'Phạm Quốc', N'Phúc'),
(26, N'Lê Nhật', N'Quyên'),
(27, N'Vũ Ngọc', N'Sang'),
(28, N'Nguyễn Văn', N'Thịnh'),
(29, N'Nguyễn Hồng', N'Tâm'),
(30, N'Nguyễn Thế', N'Tuệ'),
(31, N'Phạm Ngọc', N'Việt'),
(32, N'Lê Tấn', N'Xuân'),
(33, N'Trần Quang', N'Yêu'),
(34, N'Nguyễn Đình', N'An'),
(35, N'Vũ Văn', N'Bình'),
(36, N'Nguyễn Quốc', N'Cường'),
(37, N'Trần Minh', N'Duy'),
(38, N'Phạm Hữu', N'Hà'),
(39, N'Lê Kim', N'Minh'),
(40, N'Nguyễn Tâm', N'Nhân'),
(41, N'Vũ Văn', N'Phát'),
(42, N'Nguyễn Thái', N'Sinh'),
(43, N'Trần Đình', N'Thu'),
(44, N'Phạm Văn', N'Toàn'),
(45, N'Lê Hải', N'Vũ'),
(46, N'Nguyễn Tài', N'Xuân'),
(47, N'Đinh Văn', N'Yên'),
(48, N'Trần Văn', N'Quang'),
(49, N'Nguyễn Đình', N'Thiên'),
(50, N'Phạm Văn', N'Long'),
(51, N'Lê Văn', N'Mai'),
(52, N'Vũ Thị', N'Ngọc'),
(53, N'Nguyễn Văn', N'Quý'),
(54, N'Phạm Thái', N'Quân'),
(55, N'Lê Tường', N'Như'),
(56, N'Nguyễn Thiện', N'Phượng'),
(57, N'Vũ Quang', N'Thuận'),
(58, N'Trần Hùng', N'Thắng'),
(59, N'Nguyễn Khải', N'Tuyết'),
(60, N'Phạm Văn', N'Hà'),
(61, N'Lê Văn', N'Giang'),
(62, N'Nguyễn Đình', N'Tinh'),
(63, N'Đỗ Văn', N'Việt'),
(64, N'Vũ Đình', N'Tâm'),
(65, N'Trần Văn', N'Tuấn'),
(66, N'Phạm Văn', N'Sơn'),
(67, N'Lê Hữu', N'Thành'),
(68, N'Nguyễn Tấn', N'Bảo'),
(69, N'Vũ Huy', N'Hòa'),
(70, N'Nguyễn Thế', N'Hiệp'),
(71, N'Trần Quốc', N'Nhân'),
(72, N'Phạm Minh', N'Quang');


INSERT INTO monHoc (monHocID, tenMonHoc, soTiet, ghiChu)
VALUES 
    ('MH001', N'Triết học Mác – Lênin', 45, NULL),
	('MH002', N'Kinh tế chính trị Mác – Lênin', 45, NULL),
	('MH003', N'Chủ nghĩa xã hội khoa học', 45, NULL),
	('MH004', N'Lịch sử Đảng Cộng sản Việt Nam', 45, NULL),
	('MH005', N'Tư tưởng Hồ Chí Minh', 45, NULL),
	('MH006', N'Pháp luật đại cương', 45, NULL),
	('MH007', N'Giải tích', 60, NULL),
	('MH008', N'Đại số tuyến tính', 60, NULL),
	('MH009', N'Xác suất thống kê', 60, NULL),
	('MH010', N'Phương pháp tính', 45, NULL),
	('MH011', N'Kỹ năng mềm và tư duy khởi nghiệp', 45, NULL),
	('MH012', N'Toán rời rạc', 45, NULL),
	('MH013', N'Nhập môn Công nghệ thông tin – Truyền thông', 60, NULL),
	('MH014', N'Cấu trúc dữ liệu và giải thuật', 60, NULL),
	('MH015', N'Cơ sở lập trình', 60, NULL),
	('MH016', N'Cơ sở lập trình Web', 60, NULL),
	('MH017', N'Lập trình hướng đối tượng', 60, NULL),
	('MH018', N'Kiến trúc máy tính', 60, NULL),
	('MH019', N'Hệ điều hành', 60, NULL),
	('MH020', N'Cơ sở dữ liệu', 60, NULL),
	('MH021', N'Công nghệ phần mềm', 60, NULL),
	('MH022', N'Vật lý điện – điện tử', 60, NULL),
	('MH023', N'Lập trình Python', 60, NULL),
	('MH024', N'Pháp lý và Đạo đức nghề nghiệp', 45, NULL),
	('MH025', N'Thuật toán ứng dụng', 45, NULL),
	('MH026', N'An toàn thông tin', 45, NULL),
	('MH027', N'Mạng máy tính và truyền thông', 45, NULL),
	('MH028', N'Quản lý dự án CNTT', 45, NULL),
	('MH029', N'Phân tích và thiết kế hệ thống', 60, NULL),
	('MH030', N'Các hệ quản trị cơ sở dữ liệu', 60, NULL),
	('MH031', N'Giao diện và trải nghiệm người dùng', 60, NULL),
	('MH032', N'Lập trình C#', 60, NULL),
	('MH033', N'Công nghệ và lập trình WEB', 60, NULL),
	('MH034', N'Phân tích và thiết kế giải thuật', 60, NULL),
	('MH035', N'Đồ họa máy tính', 60, NULL),
	('MH036', N'Lập trình Java', 60, NULL),
	('MH037', N'Đồ án chuyên ngành', 60, NULL),
	('MH038', N'Triển khai phần mềm', 60, NULL),
	('MH039', N'Trí tuệ nhân tạo', 60, NULL),
	('MH040', N'Học máy và khai phá dữ liệu', 60, NULL),
	('MH041', N'Điện toán đám mây', 60, NULL),
	('MH042', N'Hệ thống số', 60, NULL),
	('MH043', N'Lý thuyết độ phức tạp', 60, NULL),
	('MH044', N'Kỹ năng lập trình nâng cao', 60, NULL),
	('MH045', N'Chuẩn kỹ năng Công nghệ thông tin Nhật Bản', 60, NULL),
	('MH046', N'Chuẩn kỹ năng Công nghệ thông tin Hàn Quốc', 60, NULL),
	('MH047', N'Yêu cầu phần mềm', 60, NULL),
	('MH048', N'Thiết kế và xây dựng phần mềm', 60, NULL),
	('MH049', N'Lập trình game', 60, NULL),
	('MH050', N'Quản lý dịch vụ CNTT', 60, NULL),
	('MH051', N'Bảo mật điện toán đám mây', 60, NULL),
	('MH052', N'Hệ thống máy tính phân tán và đám mây', 60, NULL),
	('MH053', N'Quản trị học', 45, NULL),
	('MH054', N'Mật mã và Blockchain', 60, NULL),
	('MH055', N'Bảo mật ứng dụng', 60, NULL),
	('MH056', N'Bảo mật mạng máy tính', 60, NULL),
	('MH057', N'An toàn dữ liệu', 60, NULL),
	('MH058', N'Cơ sở thiết kế máy tính', 60, NULL),
	('MH059', N'Lập trình hệ thống', 60, NULL),
	('MH060', N'Thiết kế Hệ thống nhúng', 60, NULL),
	('MH061', N'Nhập môn Điện tử số', 60, NULL),
	('MH062', N'Thiết kế để kiểm thử', 60, NULL),
	('MH063', N'Công cụ EDA cho thiết kế, kiểm chứng và mô phỏng', 60, NULL),
	('MH064', N'Học sâu và ứng dụng', 60, NULL),
	('MH065', N'Phân tích dữ liệu lớn', 60, NULL),
	('MH066', N'Xử lý ngôn ngữ tự nhiên', 60, NULL),
	('MH067', N'Thị giác máy tính', 60, NULL),
	('MH068', N'Các hệ thống song song và phân tán', 60, NULL),
	('MH069', N'Kiểm thử phần mềm', 60, NULL),
	('MH070', N'Phát triển ứng dụng di động', 60, NULL),
	('MH071', N'Quản lý dịch vụ Công nghệ thông tin', 60, NULL),
	('MH072', N'Nhập môn Hệ thống thông tin', 60, NULL),
	('MH073', N'Cơ sở dữ liệu đa phương tiện', 60, NULL),
	('MH074', N'Quản lý Hệ thống thông tin', 60, NULL),
	('MH075', N'An toàn và bảo mật hệ thống thông tin', 60, NULL),
	('MH076', N'Luật kinh doanh', 45, NULL),
	('MH077', N'Toán kinh tế', 45, NULL),
	('MH078', N'Thống kê trong kinh tế và kinh doanh', 45, NULL),
	('MH079', N'Phương pháp nghiên cứu khoa học', 45, NULL),
	('MH080', N'Quản trị học đại cương', 45, NULL),
	('MH081', N'Ứng dụng máy tính dành cho doanh nghiệp', 45, NULL),
	('MH082', N'Tâm lý học trong kinh doanh', 45, NULL),
	('MH083', N'Đạo đức kinh doanh', 45, NULL),
	('MH084', N'Phân tích dữ liệu kinh doanh 1', 45, NULL),
	('MH085', N'Văn hóa doanh nghiệp', 45, NULL),
	('MH086', N'Hệ thống thông tin trong kinh doanh', 45, NULL),
	('MH087', N'Quản trị và lãnh đạo đa văn hóa', 45, NULL),
	('MH088', N'Lập trình trong phân tích kinh doanh', 45, NULL),
	('MH089', N'Phân tích dữ liệu kinh doanh 2', 45, NULL),
	('MH090', N'Giao tiếp trong kinh doanh', 45, NULL),
	('MH091', N'Marketing mạng xã hội', 45, NULL),
	('MH092', N'Thương mại điện tử', 45, NULL),
	('MH093', N'Hành vi tổ chức', 45, NULL),
	('MH094', N'Kinh tế học vi mô', 45, NULL),
	('MH095', N'Nguyên lý kế toán', 45, NULL),
	('MH096', N'Nhập môn tài chính', 45, NULL),
	('MH097', N'Nhập môn marketing', 45, NULL),
	('MH098', N'Kinh doanh quốc tế', 45, NULL),
	('MH099', N'Quản trị vận hành', 45, NULL),
	('MH100', N'Quản trị nguồn nhân lực', 45, NULL),
	('MH101', N'Quản trị tài chính', 45, NULL),
	('MH102', N'Quản trị chiến lược', 45, NULL),
	('MH103', N'Quản trị dự án', 45, NULL),
	('MH104', N'Phân tích báo cáo tài chính', 45, NULL),
	('MH105', N'Chuẩn mực kiểm toán quốc tế', 45, NULL),
	('MH106', N'Kỹ thuật tài chính thực hành', 45, NULL),
	('MH107', N'Thuế doanh nghiệp', 45, NULL),
	('MH108', N'Truyền thông marketing', 45, NULL),
	('MH109', N'Hành vi khách hàng', 45, NULL),
	('MH110', N'Trực quan hóa dữ liệu thị trường', 45, NULL),
	('MH111', N'Thanh toán trong thương mại quốc tế', 45, NULL),
	('MH112', N'Nghiệp vụ xuất nhập khẩu', 45, NULL),
	('MH113', N'Mô hình tài chính', 45, NULL),
	('MH114', N'Kinh tế lượng', 45, NULL),
	('MH115', N'Kế toán tài chính', 45, NULL),
	('MH116', N'Kế toán quản trị', 45, NULL),
	('MH117', N'Kiểm toán căn bản', 45, NULL),
	('MH118', N'Tài chính quốc tế', 45, NULL),
	('MH119', N'Quản trị rủi ro', 45, NULL),
	('MH120', N'Mô hình kinh doanh số', 45, NULL),
	('MH121', N'Kho dữ liệu kinh doanh', 45, NULL),
	('MH122', N'Hoạch định tài nguyên doanh nghiệp', 45, NULL),
	('MH123', N'Quản trị thay đổi và đổi mới', 45, NULL),
	('MH124', N'Chuyển đổi số trong kinh doanh', 45, NULL),
	('MH125', N'Nhập môn logistics và quản lý chuỗi cung ứng', 45, NULL),
	('MH126', N'Vận tải đa phương thức', 45, NULL),
	('MH127', N'Quản lý kho hàng và phân phối', 45, NULL),
	('MH128', N'Quản trị mua hàng', 45, NULL),
	('MH129', N'Phân tích chuỗi cung ứng', 45, NULL),
	('MH130', N'Thực tập nghề nghiệp', 45, NULL),
	('MH131', N'Khóa luận tốt nghiệp', 45, NULL);


INSERT INTO lop (lopID, tenLop, siSo, nganhID, nam, khoa, ghiChu) VALUES
-- Năm 1, Khóa 3
('L01', N'CNTT11', 40, 'CNTT', 1, 3, NULL),
('L02', N'CNTT12', 40, 'CNTT', 1, 3, NULL),
('L03', N'KHMT11', 40, 'KHMT', 1, 3, NULL),
('L04', N'KHMT12', 40, 'KHMT', 1, 3, NULL),
('L05', N'QTKD11', 40, 'QTKD', 1, 3, NULL),
('L06', N'QTKD12', 40, 'QTKD', 1, 3, NULL),

-- Năm 2, Khóa 2
('L07', N'CNTT21', 40, 'CNTT', 2, 2, NULL),
('L08', N'CNTT22', 40, 'CNTT', 2, 2, NULL),
('L09', N'KHMT21', 40, 'KHMT', 2, 2, NULL),
('L10', N'KHMT22', 40, 'KHMT', 2, 2, NULL),
('L11', N'QTKD21', 40, 'QTKD', 2, 2, NULL),
('L12', N'QTKD22', 40, 'QTKD', 2, 2, NULL),

-- Năm 3, Khóa 1
('L13', N'CNTT_KTPM', 40, 'CNTT', 3, 1, NULL),
('L14', N'CNTT_KTM', 40,'CNTT', 3, 1, NULL),
('L15', N'CNTT_ATTT', 40, 'CNTT', 3, 1, NULL),
('L16', N'KHMT_PTPSW', 40, 'KHMT', 3, 1, NULL),
('L17', N'KHMT_TTNT', 40, 'KHMT', 3, 1, NULL),
('L18', N'KHMT_HTTT', 40, 'KHMT', 3, 1, NULL),
('L19', N'QTKD_QTKDS', 40, 'QTKD', 3, 1, NULL),
('L20', N'QTKD_TCKT', 40, 'QTKD', 3, 1, NULL),
('L21', N'QTKD_LOG', 40, 'QTKD', 3, 1, NULL);


INSERT INTO phongHoc (phongHocID, tenPhongHoc, soGhe, tang, maToaNha, tenToaNha, maCoSo, tenCoSo, diaChiCoSo, ghiChu)
VALUES
    ('PH01', N'101', 45, 1, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH02', N'102', 45, 1, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH03', N'103', 45, 1, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH04', N'104', 45, 1, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH05', N'105', 45, 1, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH06', N'106', 45, 1, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH07', N'107', 45, 1, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH08', N'201', 45, 2, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH09', N'202', 45, 2, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH10', N'203', 45, 2, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH11', N'204', 45, 2, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH12', N'205', 45, 2, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH13', N'206', 45, 2, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH14', N'207', 45, 2, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH15', N'301', 45, 3, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH16', N'302', 45, 3, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH17', N'303', 45, 3, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH18', N'304', 45, 3, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH19', N'305', 45, 3, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH20', N'306', 45, 3, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL),
    ('PH21', N'307', 45, 3, 'TN01', N'Tòa nhà A', 'CS01', N'Cơ sở A', N'Quận 1, TP.HCM', NULL);


INSERT INTO toChucDay (soKi, nganhID, monHocID, STT_ki) VALUES
(1, 'CNTT', 'MH001', 1),
(1, 'CNTT', 'MH002', 2),
(1, 'CNTT', 'MH003', 3),
(1, 'CNTT', 'MH004', 4),
(1, 'CNTT', 'MH005', 5),
(1, 'CNTT', 'MH006', 6),
(1, 'CNTT', 'MH007', 7),
(2, 'CNTT', 'MH008', 1),
(2, 'CNTT', 'MH009', 2),
(2, 'CNTT', 'MH011', 3),
(2, 'CNTT', 'MH012', 4),
(2, 'CNTT', 'MH013', 5),
(2, 'CNTT', 'MH014', 6),
(2, 'CNTT', 'MH015', 7),
(3, 'CNTT', 'MH016', 1),
(3, 'CNTT', 'MH017', 2),
(3, 'CNTT', 'MH018', 3),
(3, 'CNTT', 'MH019', 4),
(3, 'CNTT', 'MH020', 5),
(3, 'CNTT', 'MH021', 6),
(3, 'CNTT', 'MH022', 7),
(4, 'CNTT', 'MH023', 1),
(4, 'CNTT', 'MH024', 2),
(4, 'CNTT', 'MH026', 3),
(4, 'CNTT', 'MH027', 4),
(4, 'CNTT', 'MH028', 5),
(4, 'CNTT', 'MH029', 6),
(4, 'CNTT', 'MH030', 7),
(5, 'CNTT', 'MH031', 1),
(5, 'CNTT', 'MH032', 2),
(5, 'CNTT', 'MH033', 3),
(5, 'CNTT', 'MH070', 4),
(5, 'CNTT', 'MH036', 5),
(5, 'CNTT', 'MH037', 6),
(5, 'CNTT', 'MH038', 7),
(6, 'CNTT', 'MH039', 1),
(6, 'CNTT', 'MH040', 2),
(6, 'CNTT', 'MH041', 3),
(6, 'CNTT', 'MH044', 4),
(6, 'CNTT', 'MH130', 5),
(6, 'CNTT', 'MH131', 6),
(1, 'KHMT', 'MH001', 1),
(1, 'KHMT', 'MH002', 2),
(1, 'KHMT', 'MH003', 3),
(1, 'KHMT', 'MH004', 4),
(1, 'KHMT', 'MH005', 5),
(1, 'KHMT', 'MH006', 6),
(1, 'KHMT', 'MH007', 7),
(2, 'KHMT', 'MH008', 1),
(2, 'KHMT', 'MH009', 2),
(2, 'KHMT', 'MH010', 7),
(2, 'KHMT', 'MH011', 3),
(2, 'KHMT', 'MH012', 4),
(2, 'KHMT', 'MH013', 5),
(2, 'KHMT', 'MH014', 6),
(3, 'KHMT', 'MH015', 7),
(3, 'KHMT', 'MH016', 1),
(3, 'KHMT', 'MH017', 2),
(3, 'KHMT', 'MH018', 3),
(3, 'KHMT', 'MH019', 4),
(3, 'KHMT', 'MH020', 5),
(3, 'KHMT', 'MH021', 6),
(4, 'KHMT', 'MH022', 6),
(4, 'KHMT', 'MH023', 1),
(4, 'KHMT', 'MH024', 2),
(4, 'KHMT', 'MH025', 7),
(4, 'KHMT', 'MH026', 3),
(4, 'KHMT', 'MH027', 4),
(4, 'KHMT', 'MH028', 5),
(5, 'KHMT', 'MH029', 4),
(5, 'KHMT', 'MH030', 5),
(5, 'KHMT', 'MH031', 1),
(5, 'KHMT', 'MH032', 2),
(5, 'KHMT', 'MH033', 3),
(5, 'KHMT', 'MH037', 6),
(5, 'KHMT', 'MH034', 7),
(6, 'KHMT', 'MH035', 4),
(6, 'KHMT', 'MH039', 1),
(6, 'KHMT', 'MH040', 2),
(6, 'KHMT', 'MH041', 3),
(6, 'KHMT', 'MH130', 5),
(6, 'KHMT', 'MH131', 6),
(1, 'QTKD', 'MH001', 1),
(1, 'QTKD', 'MH002', 2),
(1, 'QTKD', 'MH003', 3),
(1, 'QTKD', 'MH004', 4),
(1, 'QTKD', 'MH005', 5),
(1, 'QTKD', 'MH076', 6),
(2, 'QTKD', 'MH077', 1),
(2, 'QTKD', 'MH078', 2),
(2, 'QTKD', 'MH079', 3),
(2, 'QTKD', 'MH080', 4),
(2, 'QTKD', 'MH081', 5),
(2, 'QTKD', 'MH082', 6),
(3, 'QTKD', 'MH083', 1),
(3, 'QTKD', 'MH084', 2),
(3, 'QTKD', 'MH085', 3),
(3, 'QTKD', 'MH086', 4),
(3, 'QTKD', 'MH090', 5),
(3, 'QTKD', 'MH091', 6),
(4, 'QTKD', 'MH011', 1),
(4, 'QTKD', 'MH094', 2),
(4, 'QTKD', 'MH095', 3),
(4, 'QTKD', 'MH096', 4),
(4, 'QTKD', 'MH097', 5),
(4, 'QTKD', 'MH098', 6),
(5, 'QTKD', 'MH099', 1),
(5, 'QTKD', 'MH100', 2),
(5, 'QTKD', 'MH101', 3),
(5, 'QTKD', 'MH102', 4),
(5, 'QTKD', 'MH103', 5),
(5, 'QTKD', 'MH104', 6),
(6, 'QTKD', 'MH107', 1),
(6, 'QTKD', 'MH108', 2),
(6, 'QTKD', 'MH109', 3),
(6, 'QTKD', 'MH130', 4),
(6, 'QTKD', 'MH131', 5);


GO

-- Tiếp tục cho đến khi đủ 720 hàng.
DECLARE @sinhVienID    VARCHAR (20)                ;
DECLARE @hoDem         NVARCHAR(50)                ;
DECLARE @ten           NVARCHAR(20)                ;
DECLARE @ngaySinh      DATE                        ;
DECLARE @nam           INT                         ; -- tiến độ học tính theo năm
DECLARE @khoa          INT                         ; -- sinh viên tuyển đợt mấy
DECLARE @lopID         VARCHAR (20)                ;
DECLARE @nganhID       VARCHAR (50)                ;
DECLARE @email         NVARCHAR(50)                ; 
DECLARE @matKhau       NVARCHAR(50)                ;
DECLARE @soDienThoai   VARCHAR (20)                ;
DECLARE @vaiTro        NVARCHAR(30)  = N'sinh vien';
DECLARE @ghiChu        NVARCHAR(MAX) = NULL        ;

DECLARE @formatted_k   VARCHAR(2)                  ;
DECLARE @k             INT                         ; -- vòng lặp theo lớp
DECLARE @i             INT                         ; -- vòng lặp theo học sinh
DECLARE @randomName    INT           = 1           ;
DECLARE @ngay          INT                         ;
DECLARE @thang         INT                         ;
DECLARE @namSinh       INT                         ;
DECLARE @maNganh       VARCHAR(20)                 ;
DECLARE @tenlop        VARCHAR(20)                 ;

SET @k = 1;
WHILE @k <= 21
BEGIN
	-- Chuyển đổi @k thành số có 2 chữ số
    SET @formatted_k = RIGHT('00' + CAST(@k AS VARCHAR(2)), 2);
	SET @lopID       = (
		SELECT lopID
		FROM   lop
		WHERE  lopID = 'L' + @formatted_k
	);

	SET @tenlop      = (
		SELECT tenLop
		FROM   lop
		WHERE  lopID = 'L' + @formatted_k
	);

	SET @nganhID       = (
		SELECT nganhID
		FROM   lop
		WHERE  lopID = 'L' + @formatted_k
	);

	SET @nam         = (
		SELECT nam
		FROM   lop
		WHERE  lopID = 'L' + @formatted_k
	);

	SET @khoa        = (
		SELECT khoa
		FROM   lop
		WHERE  lopID = 'L' + @formatted_k
	);

	IF @nam = 1 BEGIN SET @namSinh = 2005 END
	IF @nam = 2 BEGIN SET @namSinh = 2004 END
	IF @nam = 3 BEGIN SET @namSinh = 2003 END
	

	SET @i = 1;
	WHILE @i <= 40
	BEGIN
		-- Gán giá trị cho sinhVienID
		SET @sinhVienID = 'SV' + '_' + CAST(@tenlop AS NVARCHAR(50)) + '_' + RIGHT('00' + CAST(@i AS VARCHAR(2)), 2);

		-- Gán giá trị cho hoDem và ten
		SET @hoDem = (
			SELECT hoDem
			FROM hoVaTen
			WHERE ID = @randomName
		);

		SET @ten = (
			SELECT ten
			FROM hoVaTen
			WHERE ID = @randomName
		);

		SET @randomName = @randomName + 1; 
		IF @randomName = 73 BEGIN SET @randomName = 1 END

		-- Tạo số ngẫu nhiên cho ngày từ 1 đến 26
		SET @ngay = ABS(CHECKSUM(NEWID())) % 26 + 1; 

		-- Tạo số ngẫu nhiên cho tháng từ 1 đến 12
		SET @thang = ABS(CHECKSUM(NEWID())) % 12 + 1;

		-- Gán giá trị cho biến @ngaySinh
		SET @ngaySinh = CAST(CAST(@namsinh AS NVARCHAR(4)) + '-' + RIGHT('0' + CAST(@thang AS NVARCHAR(2)), 2) + '-' + RIGHT('0' + CAST(@ngay AS NVARCHAR(2)), 2) AS DATE);

		-- Gán giá trị cho email
		SET @email = @sinhVienID + '@gmail.com';

		-- Gọi stored procedures
		EXEC sp_RandomPassword @LengthString = 5, @LengthNumber = 3, @RandomString = @matKhau OUTPUT;
		EXEC sp_RandomPhoneNumber @Length = 10, @RandomPhoneNumber = @soDienThoai OUTPUT;

		-- Thực hiện câu lệnh INSERT
		INSERT INTO sinhVien (sinhVienID, hoDem, ten, ngaySinh, nam, khoa, lopID, nganhID, email, matKhau, soDienThoai, vaiTro, ghiChu)
		VALUES 
			(@sinhVienID, @hoDem, @ten, @ngaySinh, @nam, @khoa, @lopID, @nganhID, @email, @matKhau, @soDienThoai, @vaiTro, @ghiChu);

		-- Tăng giá trị counter
		SET @i = @i + 1;
	END
	

	SET @k = @k + 1;
END

GO

DECLARE @i             INT                      ; -- vòng lặp theo học sinh
DECLARE @randomName    INT           = 1        ;
DECLARE @ngay          INT                      ;
DECLARE @thang         INT                      ;
DECLARE @namSinh       INT                      ;


-- Tiếp tục cho đến khi đủ 720 hàng.
DECLARE @giaoVienID    VARCHAR (20)                ;
DECLARE @hoDem         NVARCHAR(50)                ;
DECLARE @ten           NVARCHAR(20)                ;
DECLARE @ngaySinh      DATE                        ;
DECLARE @email         NVARCHAR(50)                ; 
DECLARE @matKhau       NVARCHAR(50)                ;
DECLARE @soDienThoai   VARCHAR (20)                ;
DECLARE @vaiTro        NVARCHAR(30)  = N'giao vien';
DECLARE @monHocID      VARCHAR(20)                 ;
DECLARE @ghiChu        NVARCHAR(MAX) = NULL        ;


SET @i = 1;
WHILE @i <= 131
BEGIN
	-- Gán giá trị cho giaoVienID
	SET @giaoVienID = 'GV' + RIGHT('000' + CAST(@i AS NVARCHAR(5)), 3);

	-- Gán giá trị cho hoDem và ten
	SET @hoDem = (
		SELECT hoDem
		FROM hoVaTen
		WHERE ID = @randomName
	);

	SET @ten = (
		SELECT ten
		FROM hoVaTen
		WHERE ID = @randomName
	);

	SET @randomName = @randomName + 1; 
	IF @randomName = 73 BEGIN SET @randomName = 1 END

	-- Tạo số ngẫu nhiên cho ngày từ 1 đến 26
	SET @ngay = ABS(CHECKSUM(NEWID())) % 26 + 1

	-- Tạo số ngẫu nhiên cho tháng từ 1 đến 12
	SET @thang = ABS(CHECKSUM(NEWID())) % 12 + 1;

	-- Tạo số ngẫu nhiên cho tháng từ 25 đến 55
	SET @namsinh = 2024 - (ABS(CHECKSUM(NEWID())) % 31 + 25) ;

	-- Gán giá trị cho biến @ngaySinh
	SET @ngaySinh = CAST(CAST(@namsinh AS NVARCHAR(4)) + '-' + RIGHT('0' + CAST(@thang AS NVARCHAR(2)), 2) + '-' + RIGHT('0' + CAST(@ngay AS NVARCHAR(2)), 2) AS DATE);

	-- Gán giá trị cho email
	SET @email = @giaoVienID + '@gmail.com';

	-- Gọi stored procedures
	EXEC sp_RandomPassword @LengthString = 5, @LengthNumber = 3, @RandomString = @matKhau OUTPUT;
	EXEC sp_RandomPhoneNumber @Length = 10, @RandomPhoneNumber = @soDienThoai OUTPUT;

	
	SET @monHocID = 'MH' + RIGHT('000' + CAST(@i AS NVARCHAR(5)), 3);

	

	-- Thực hiện câu lệnh INSERT
	INSERT INTO giaoVien (giaoVienID, hoDem, ten, ngaySinh, email, matKhau, soDienThoai, vaiTro, monHocID, ghiChu)
	VALUES 
		(@giaoVienID, @hoDem, @ten, @ngaySinh, @email, @matKhau, @soDienThoai, @vaiTro, @monHocID, @ghiChu);

	-- Tăng giá trị counter
	SET @i = @i + 1;
END

GO

DECLARE @t INT;
DECLARE @i INT;
DECLARE @k INT;

DECLARE @buoiHocID    VARCHAR(20);
DECLARE @numBuoiHocID INT = 1;

DECLARE @ngayBuoiHoc  DATE; 
DECLARE @ngayKiHoc    DATE; 
DECLARE @ngayMonHoc   DATE;

DECLARE @tietBatDau   INT;
DECLARE @tietKetThuc  INT;
DECLARE @monHocID     VARCHAR(20);
DECLARE @phongHocID   VARCHAR(20);
DECLARE @lopID        VARCHAR(20);
DECLARE @giaoVienID   VARCHAR(20);
DECLARE @maDiemDanh   NVARCHAR(50);
DECLARE @ghiChu       NVARCHAR(MAX);

DECLARE @soMon1Ki     INT;
DECLARE @tongSoTiet   INT;
DECLARE @baseSoTiet   INT;
DECLARE @extraSoTiet  INT;
DECLARE @soTiet       INT;
DECLARE @nganhID      VARCHAR(50)  ;
DECLARE @STTLop       VARCHAR(50)  ;
DECLARE @STT_ki       INT          ;
DECLARE @numDate      INT          ;
DECLARE @formatted_k  VARCHAR(2)   ;

DECLARE @BangTam  TABLE (
	monHocID VARCHAR(20),
	soTiet INT,
	STT_ki INT
);

SET @ngayKiHoc = '2022-06-06';
SET @k = 1;
WHILE @k <= 6
BEGIN
	SET @formatted_k = RIGHT('00' + CAST(@k AS VARCHAR(2)), 2);
	SET @lopID       = (
		SELECT lopID
		FROM   lop
		WHERE  lopID = 'L' + @formatted_k
	);

	SET @phongHocID = 'PH' + @formatted_k;

	SET @nganhID = (
		SELECT nganhID
		FROM   lop
		WHERE  lopID = 'L' + @formatted_k
	);

	IF @nganhID = 'CNTT'
	BEGIN
		SET @numDate = 0;
	END

	IF @nganhID = 'KHMT'
	BEGIN
		SET @numDate = 1;
	END

	IF @nganhID = 'QTKD'
	BEGIN
		SET @numDate = 2;
	END

	INSERT INTO @BangTam (monHocID, soTiet, STT_ki)
	SELECT      toChucDay.monHocID, monHoc.soTiet, toChucDay.STT_ki
	FROM        toChucDay
	INNER JOIN  monHoc
		ON          toChucDay.monHocID = monHoc.monHocID
	WHERE       toChucDay.soKi = 1 AND toChucDay.nganhID = @nganhID;

	SET @soMon1Ki = (
		SELECT COUNT(*)
		FROM @BangTam
	);

	SET @i = 1;
	WHILE @i <= @soMon1Ki
	BEGIN
		SET @monHocID = (
			SELECT monHocID
			FROM   @BangTam
			WHERE  STT_ki = @i
		);

		SET @giaoVienID = (
			SELECT giaoVienID
			FROM   giaoVien
			WHERE  monHocID = @monHocID
		);

		SET @tongSoTiet = (
			SELECT soTiet
			FROM   @BangTam
			WHERE  STT_ki = @i
		);

		IF CAST(@STTLop AS INT) % 2 = 0
		BEGIN
			IF     @i >= 6 - @numDate
			BEGIN
				SET @tietKetThuc = 5;
				SET @ngayMonHoc = DATEADD(DAY, @i - 6 + @numDate, @ngayKiHoc);
			END

			ELSE  
			BEGIN
				SET @tietBatDau = 6;
				SET @ngayMonHoc = DATEADD(DAY, @i - 1 + @numDate, @ngayKiHoc);
			END
		END

		ELSE
		BEGIN
			IF     @i >= 6 - @numDate
			BEGIN
				SET @tietBatDau = 6;
				SET @ngayMonHoc = DATEADD(DAY, @i - 6 + @numDate, @ngayKiHoc);
			END

			ELSE  
			BEGIN
				SET @tietKetThuc = 5;
				SET @ngayMonHoc = DATEADD(DAY, @i - 1 + @numDate, @ngayKiHoc);
			END
		END



		

		SET @ngayBuoiHoc = @ngayMonHoc;
		SET @baseSoTiet  = FLOOR(@tongSoTiet / 4);
		SET @extraSoTiet = @tongSoTiet % 4;
	
	
		SET @t = 1;
		WHILE @t <= @baseSoTiet
		BEGIN
			SET @buoiHocID = 'BH' + RIGHT('00000' + CAST(@numBuoiHocID AS VARCHAR(5)), 5);
			SET @numBuoiHocID = @numBuoiHocID + 1;
			SET @soTiet = 4 + CASE WHEN @t <= @extraSoTiet THEN 1 ELSE 0 END;

			IF CAST(@STTLop AS INT) % 2 = 0
			BEGIN
				IF     @i >= 6 - @numDate
				BEGIN
					SET @tietBatDau = @tietKetThuc - @soTiet + 1;
				END

				ELSE  
				BEGIN
					SET @tietKetThuc = @tietBatDau + @soTiet - 1;
				END
			END

			ELSE
			BEGIN
				IF     @i >= 6 - @numDate
				BEGIN
					SET @tietKetThuc = @tietBatDau + @soTiet - 1;
				END

				ELSE  
				BEGIN
					SET @tietBatDau = @tietKetThuc - @soTiet + 1;
				END
			END




			INSERT INTO buoiHoc (buoiHocID, ngay, tietBatDau, tietKetThuc, monHocID, phongHocID, lopID, giaoVienID, maDiemDanh, ghiChu)
			VALUES (@buoiHocID, @ngayBuoiHoc, @tietBatDau, @tietKetThuc, @monHocID, @phongHocID, @lopID, @giaoVienID, NULL, NULL);

			SET @ngayBuoiHoc = DATEADD(WEEK, 1, @ngayBuoiHoc);
			SET @t = @t + 1;
		END

		SET @i = @i + 1;
	END
	DELETE FROM @BangTam;
	SET @k = @k + 1;
END

GO

CREATE PROCEDURE dangNhap
    @email   NVARCHAR(50)       ,  
    @matKhau NVARCHAR(50)       ,
    @ID      NVARCHAR(50) OUTPUT,
    @vaiTro  NVARCHAR(50) OUTPUT
AS
BEGIN
    -- Kiểm tra bảng sinhVien
    IF EXISTS (
        SELECT 1 
        FROM sinhVien
        WHERE email = @email AND matKhau = @matKhau
    )
    BEGIN
        -- Gán giá trị trực tiếp vào tham số đầu ra
        SELECT TOP 1 @ID = sinhVienID, @vaiTro = 'sinh vien'
        FROM sinhVien
        WHERE email = @email AND matKhau = @matKhau;
    END

    ELSE IF EXISTS (
        SELECT 1 
        FROM giaoVien
        WHERE email = @email AND matKhau = @matKhau
    )
    BEGIN
        -- Gán giá trị trực tiếp vào tham số đầu ra
        SELECT TOP 1 @ID = giaoVienID, @vaiTro = 'giao vien'
        FROM giaoVien
        WHERE email = @email AND matKhau = @matKhau;
    END

    ELSE
    BEGIN
        -- Nếu không tìm thấy tài khoản trong cả hai bảng
        SET @ID = NULL;
        SET @vaiTro = NULL;
    END
END
GO

CREATE FUNCTION layThoiKhoaBieu (
    @ID NVARCHAR(50),
	@vaiTro NVARCHAR(50),
	@date DATE
)
RETURNS @buoiHocTuan TABLE (
	buoiHocID   VARCHAR(20)   PRIMARY KEY,
	ngay        DATE                     ,
	tietBatDau  INT                      ,
	tietKetThuc INT                      ,

	monHocID    VARCHAR(20)              ,
	phongHocID  VARCHAR(20)              ,
	lopID       VARCHAR(20)              ,
	giaoVienID  VARCHAR(20)              ,

	maDiemDanh  NVARCHAR(50)             ,

	ghiChu      NVARCHAR(MAX)            
)
AS
BEGIN
    DECLARE @Monday DATE = DATEADD(DAY, -DATEPART(WEEKDAY, @date) + 2, @date);
	DECLARE @Friday DATE = DATEADD(DAY, 4, @Monday);

	 -- Kiểm tra bảng sinhVien
    IF @vaiTro = N'sinh vien'
    BEGIN
		DECLARE @lopID VARCHAR(20) = (
			SELECT lopID
			FROM sinhVien
			WHERE sinhVienID = @ID
		);

		INSERT INTO @buoiHocTuan
		SELECT *
		FROM buoiHoc
		WHERE ngay BETWEEN @Monday AND @Friday AND 
			  lopID = @lopID
    END

    ELSE IF @vaiTro = N'giao vien'
    BEGIN
		INSERT INTO @buoiHocTuan
		SELECT *
		FROM buoiHoc
		WHERE ngay BETWEEN @Monday AND @Friday AND 
			  giaoVienID = @ID;
    END

    RETURN;
END;
GO

CREATE PROCEDURE thongTinBuoiHoc
    @buoiHocID VARCHAR(20),
    @tenMonHoc NVARCHAR(50) OUTPUT,
    @tietBatDau INT OUTPUT,
    @tietKetThuc INT OUTPUT,
    @ngay DATE OUTPUT,
    @tenLop NVARCHAR(30) OUTPUT,
    @maCoSo VARCHAR(20) OUTPUT,
    @tenPhongHoc NVARCHAR(50) OUTPUT,
    @hoDem NVARCHAR(50) OUTPUT,
    @ten NVARCHAR(20) OUTPUT
AS
BEGIN
    -- Lấy tên môn học
    SET @tenMonHoc = (
        SELECT tenMonHoc
        FROM monHoc
        WHERE monHocID = (
            SELECT monHocID
            FROM buoiHoc
            WHERE buoiHocID = @buoiHocID
        )
    );

    -- Lấy tiết bắt đầu
    SET @tietBatDau = (
        SELECT tietBatDau
        FROM buoiHoc
        WHERE buoiHocID = @buoiHocID
    );

    -- Lấy tiết kết thúc
    SET @tietKetThuc = (
        SELECT tietKetThuc
        FROM buoiHoc
        WHERE buoiHocID = @buoiHocID
    );

    -- Lấy ngày
    SET @ngay = (
        SELECT ngay
        FROM buoiHoc
        WHERE buoiHocID = @buoiHocID
    );

    -- Lấy tên lớp
    SET @tenLop = (
        SELECT tenLop
        FROM lop
        WHERE lopID = (
            SELECT lopID
            FROM buoiHoc
            WHERE buoiHocID = @buoiHocID
        )
    );

    -- Lấy mã cơ sở
    SET @maCoSo = (
        SELECT maCoSo
        FROM phongHoc
        WHERE phongHocID = (
            SELECT phongHocID
            FROM buoiHoc
            WHERE buoiHocID = @buoiHocID
        )
    );

    -- Lấy tên phòng học
    SET @tenPhongHoc = (
        SELECT tenPhongHoc
        FROM phongHoc
        WHERE phongHocID = (
            SELECT phongHocID
            FROM buoiHoc
            WHERE buoiHocID = @buoiHocID
        )
    );

    -- Lấy họ đệm của giáo viên
    SET @hoDem = (
        SELECT hoDem
        FROM giaoVien
        WHERE giaoVienID = (
            SELECT giaoVienID
            FROM buoiHoc
            WHERE buoiHocID = @buoiHocID
        )
    );

    -- Lấy tên giáo viên
    SET @ten = (
        SELECT ten
        FROM giaoVien
        WHERE giaoVienID = (
            SELECT giaoVienID
            FROM buoiHoc
            WHERE buoiHocID = @buoiHocID
        )
    );
END

GO 


CREATE FUNCTION layDanhSachLop (
    @buoiHocID VARCHAR(20)
)
RETURNS @danhSachLop TABLE (
	sinhVienID VARCHAR(20),
	hoDem      NVARCHAR(50),
	ten        NVARCHAR(20)
)
AS
BEGIN
    DECLARE @lopID VARCHAR(20) = (
		SELECT lopID
		FROM   buoiHoc
		WHERE  buoiHocID = @buoiHocID
	);

	INSERT INTO @danhSachLop
		SELECT sinhVienID, hoDem, ten
		FROM sinhVien
		WHERE lopID = @lopID

    RETURN;
END;
GO

CREATE PROCEDURE taoMaDiemDanh
    @maDiemDanh NVARCHAR(50),
	@buoiHocID  VARCHAR(20)
AS
BEGIN
    UPDATE buoiHoc
	SET maDiemDanh = @maDiemDanh
	WHERE buoiHocID = @buoiHocID;
END;
GO

CREATE FUNCTION nhapMaDiemDanh
(
    @maDiemDanh NVARCHAR(50),
	@sinhVienID VARCHAR(20),
	@buoiHocID  VARCHAR(20)
)
RETURNS NVARCHAR(50) -- Kích thước lớn nhất là tổng kích thước của các tham số đầu vào cộng thêm dấu cách giữa chúng
AS
BEGIN
    DECLARE @xacThuc NVARCHAR(50) = '';
	DECLARE @maDiemDanhThuc NVARCHAR(50) = (
		SELECT maDiemDanh
		FROM   buoiHoc
		WHERE  buoiHocID = @buoiHocID
	);

	IF @maDiemDanhThuc = @maDiemDanh 
	BEGIN
		SET @xacThuc = 'yes'
	END

	ELSE
	BEGIN
		SET @xacThuc = 'no'
	END

    RETURN @xacThuc;
END;
GO


/*
-- Khai báo biến để nhận giá trị đầu ra
DECLARE @ID NVARCHAR(50);
DECLARE @VaiTro NVARCHAR(50);

-- Gọi thủ tục lưu trữ với tham số đầu ra
EXEC dangNhap 
    @email = N'SV_CNTT11_01@gmail.com', 
    @matKhau = N'wptjs433',
    @ID = @ID OUTPUT,
    @VaiTro = @VaiTro OUTPUT;

PRINT (@ID);
PRINT (@Vaitro);

SELECT * 
FROM layThoiKhoaBieu('GV001', 'giao vien', '2022-06-06');
	




buoi hoc: monHocID, tietBatDau, tietKetThuc, phongHocID (buoiHocID), sinhVienID, hoDem, ten (select from lopID)
- sinh vien: luu diem danh: trang thai, so tiet (buoiHocID , sinhVienID),  sinhVien
- giao vien: siSo(lopID)


DECLARE @tenMonHoc NVARCHAR(50),
        @tietBatDau INT,
        @tietKetThuc INT,
        @ngay DATE,
        @tenLop NVARCHAR(30),
        @maCoSo VARCHAR(20),
        @tenPhongHoc NVARCHAR(50),
        @hoDem NVARCHAR(50),
        @ten NVARCHAR(20);

-- Gọi thủ tục lưu trữ
EXEC thoiKhoaBieu
    @buoiHocID = 'BH00001', -- Thay thế bằng giá trị thực tế của buổi học
    @tenMonHoc = @tenMonHoc OUTPUT,
    @tietBatDau = @tietBatDau OUTPUT,
    @tietKetThuc = @tietKetThuc OUTPUT,
    @ngay = @ngay OUTPUT,
    @tenLop = @tenLop OUTPUT,
    @maCoSo = @maCoSo OUTPUT,
    @tenPhongHoc = @tenPhongHoc OUTPUT,
    @hoDem = @hoDem OUTPUT,
    @ten = @ten OUTPUT;

-- Xem kết quả
SELECT @tenMonHoc AS TenMonHoc,
       @tietBatDau AS TietBatDau,
       @tietKetThuc AS TietKetThuc,
       @ngay AS Ngay,
       @tenLop AS TenLop,
       @maCoSo AS MaCoSo,
       @tenPhongHoc AS TenPhongHoc,
       @hoDem AS HoDem,
       @ten AS Ten;


GO
*/
