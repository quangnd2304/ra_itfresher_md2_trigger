create database it_fresher_demo;
use  it_fresher_demo;
create table Demo(
    id int primary key auto_increment,
    name varchar(100) unique not null ,
    age int check ( age>=18 ),
    status bit
);
DELIMITER &&
create procedure get_all_Demo()
BEGIN
    select * from Demo;
end &&
call get_all_Demo();
/*
    1. Tạo CSDL Shop
    2. Tạo các bảng:
        2.1. Bảng danh mục gồm các thông tin: mã danh mục, tên danh mục,
        độ ưu tiên (priority - int), trạng thái
        2.2. Bảng sản phẩm gồm các thông tin: Mã sản phẩm, tên sản phẩm,
        giá, số lượng sản phẩm, tiêu đề sản phẩm, mô tả sản phẩm, ngày tạo sản phẩm,
        trạng thái sản phẩm
    3. Viết các procedure sau:
        3.1. Các procedure cho phép lấy tất cả thông tin danh mục, thêm mới, cập nhật, xóa danh mục
        3.2. Các procedure cho phép lấy tất cả thông tin sản phẩm, thêm mới, cập nhật, xóa sản phẩm
        3.3. Procedure cho phép lấy thông tin danh mục theo mã danh mục
        3.4. Procedure cho phép lấy thông tin sản phẩm the mã sản phẩm
        3.5. Procedure cho phép lấy thông tin sản phẩm theo tên sản phẩm (tìm gần đúng)
        3.6. Procedure thống kê số lượng sản phẩm theo các danh mục
    4. Viết caác trigger sau:
        4.1. Chặn thêm mới các sản phẩm có giá < 0
        4.2. THêm mới các sản phẩm tạo ngày tạo sản phẩm là ngày hiện tại
        4.3. Không cho phép cập nhật các sản phẩm có số lượng bằng 0
*/
use student_management;
-- trigger chặn thêm mới sinh viên có tuổi < 18
DELIMITER &&
drop trigger if exists before_insert_student;
create trigger before_insert_student before insert on student for each row
BEGIN
    if((select NEW.age) < 18) then
        SIGNAL sqlstate '45001' set message_text = 'Tuổi sinh viên nhỏ hơn 18';
    end if;
end &&
select * from student;
insert into student
values ('SV008','abc',19,'Hà Nội',1,1);

DELIMITER &&
drop trigger if exists before_delete_student;
create trigger before_delete_student before delete on student for each row
BEGIN
    if((select OLD.student_id) = 'SV007') then
        SIGNAL sqlstate '45001' set message_text = 'Sinh viên không thể ra trường, không thể xóa được';
    end if;
end &&
delete from student where student_id='SV007';

DELIMITER &&
drop trigger if exists before_update_student;
create trigger before_update_student before update on student for each row
BEGIN
    if((select OLD.age) > 19) then
        set NEW.age = OLD.age;
    end if;
end &&
update student
    set student_name = 'Hoàng Thị Thùy xinh',
        age = 20
    where student_id = 'SV007';
