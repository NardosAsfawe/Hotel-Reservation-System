create table hotel(
h_id int not null,
h_city varchar2(20),
h_state varchar2(2),
h_zipcode int,
h_phone varchar2(20),
num_rooms int,
primary key (h_id)
);

//create sequence
Create sequence hotel_seq
Start with 6
INCREMENT by 1;


//Add a new hotel
Create or replace procedure add_hotel_PN50138(hotel_city hotel.h_city%type,
hotel_state hotel.h_state%type, hotel_zipcode hotel.h_zipcode%type,
hotel_phone hotel.h_phone%type, hotel_num_rooms hotel.num_rooms%type)
is
data_entry_wrong Exception;
begin
insert into hotel values (hotel_seq.nextval,hotel_city, hotel_state, hotel_zipcode, hotel_phone, hotel_num_rooms);
dbms_output.put_line('New hotel added successfully!');
raise data_entry_wrong;
Exception
when data_entry_wrong then
dbms_output.put_line('Error. Please try again.');
end;

//Exec add_hotel
exec add_hotel('Richmond', 'va', 00006, '493-000-8124', 2);

//Display hotel info by id
create or replace procedure display_hotel_info_PN50138(hotel_id hotel.h_id%type)
  is
  cursor c1 is select h_city, h_state, h_zipcode, h_phone, num_rooms, room_type, cost
  from hotel, room
  where hotel.h_id = room.h_id and
  hotel.h_id = hotel_id;
  hotel_city hotel.h_city%type;
  hotel_state hotel.h_state%type;
  hotel_zipcode hotel.h_zipcode%type;
  hotel_phone hotel.h_phone%type;
  hotel_num_rooms hotel.num_rooms%type;
  hotel_room_type room.room_type%type;
  hotel_cost room.cost%type;
  begin
  open c1;
  LOOP
  fetch c1 into
  hotel_city, hotel_state, hotel_zipcode, hotel_phone, hotel_num_rooms, hotel_room_type, hotel_cost;
  exit when c1%NOTFOUND;
  DBMS_OUTPUT.put_line('The hotel information of '|| hotel_id || ' is city:'|| hotel_city || '  state: '||
    hotel_state || ' zipcode: '|| hotel_zipcode || ' phone: '|| hotel_phone || ' number of rooms: '||
    hotel_num_rooms || ' room type: '|| hotel_room_type || ' cost: '|| hotel_cost);
    end loop;
    close c1;
    Exception
    when no_data_found THEN
    dbms_output.put_line('Sorry, no hotel found.Please try again.');
    end;

//exec display_hotel_info
exec display_hotel_info(1);


//Find a hotel id with address
create or replace function find_hotel_PN50138(hotel_address hotel.h_city%type)
  return int
  is
  hotel_id int;
  BEGIN
  select h_id into hotel_id from hotel where h_city = hotel_address;
  return hotel_id;
  Exception
  when no_data_found THEN
  dbms_output.put_line('Sorry, no hotel found in' || hotel_address || 'Please try another address.');
  return -1;
  end;

//Exec find_hotel
DECLARE
hotel_id int;
BEGIN
hotel_id := find_hotel('la');
dbms_output.put_line('The hotel id is: '|| hotel_id);
end;

//delete hotel by id
create or replace procedure delete_hotel_PN50138(hotel_id hotel.h_id%type)
  is
  begin
  delete from hotel where h_id = hotel_id;
  dbms_output.put_line('Successfully deleted a hotel with '|| hotel_id);
  Exception
  when no_data_found THEN
  dbms_output.put_line('Sorry, no hotel found with ' || hotel_id || 'Please try again.');
  end;

//exec delete_hotel
exec delete_hotel(6);

insert into hotel (h_id, h_city, h_state, h_zipcode, h_phone, num_rooms) values (1, 'rockville', 'md', 00001, '202-101-0001', 2);
insert into hotel (h_id, h_city, h_state, h_zipcode, h_phone, num_rooms) values (2, 'washington', 'dc', 00002, '302-504-0002', 1);
insert into hotel (h_id, h_city, h_state, h_zipcode, h_phone, num_rooms) values (3, 'la', 'ca', 00003, '401-960-0003', 3);
insert into hotel (h_id, h_city, h_state, h_zipcode, h_phone, num_rooms) values (4, 'sitka', 'al', 00004, '501-742-0004', 2);
insert into hotel (h_id, h_city, h_state, h_zipcode, h_phone, num_rooms) values (5, 'orlando', 'fl', 00005, '601-212-0005', 1);


create table room(
room_id int not null,
room_type varchar2(20),
cost int,
availablity varchar2(20),
h_id int,
primary key (room_id),
Foreign key (h_id) references hotel (h_id)
);

insert into room (room_id, room_type, cost, availablity, h_id) values (1, 'single', 50, 'occupied', 1);
insert into room (room_id, room_type, cost, availablity, h_id) values (2, 'double', 60, 'ch-available', 1);
insert into room (room_id, room_type, cost, availablity, h_id) values (3, 'conference', 80, 'occupied', 2);
insert into room (room_id, room_type, cost, availablity, h_id) values (4, 'single', 50, 'ch-occupied', 3);
insert into room (room_id, room_type, cost, availablity, h_id) values (5, 'double', 60, 'available', 3);
insert into room (room_id, room_type, cost, availablity, h_id) values (6, 'suite', 70, 'available', 3);
insert into room (room_id, room_type, cost, availablity, h_id) values (7, 'single', 50, 'available', 2);
insert into room (room_id, room_type, cost, availablity, h_id) values (8, 'conference', 80, 'available', 2);
insert into room (room_id, room_type, cost, availablity, h_id) values (9, 'suite', 70, 'available', 5);



create table customer(
c_id int not null,
c_first varchar2(20),
c_last varchar2(20),
c_city varchar2(20),
c_state varchar2(2),
c_zipcode int,
c_phone varchar2(20),
c_credit_card varchar2(20),
primary key (c_id),
);

insert into customer(c_id, c_first, c_last, c_city, c_state, c_zipcode, c_phone, c_credit_card) values
(1, 'max', 'alex', 'baltimore', 'md', 00001, '301-000-987', '1234-444-0001');
insert into customer(c_id, c_first, c_last, c_city, c_state, c_zipcode, c_phone, c_credit_card) values
(2, 'sky', 'bob', 'richmond', 'va', 00002, '201-076-937', '1234-444-0002');
insert into customer(c_id, c_first, c_last, c_city, c_state, c_zipcode, c_phone, c_credit_card) values
(3, 'ray', 'sam', 'miami', 'fl', 00003, '306-030-687', '1234-444-0003');
insert into customer(c_id, c_first, c_last, c_city, c_state, c_zipcode, c_phone, c_credit_card) values
(4, 'smith', 'sun', 'washington', 'dc', 00004, '308-036-637', '1994-044-0004');

//create sequence
Create sequence customer_seq
Start with 4
INCREMENT by 1;


//Add a new customer
Create or replace procedure add_customer(first_name customer.c_first%type,
last_name customer.c_last%type, customer_city customer.c_city%type,
customer_state customer.c_state%type, customer_zipcode customer.c_zipcode%type,
customer_phone customer.c_phone%type, customer_credit customer.c_credit_card%type)
is
data_entry_wrong Exception;
begin
insert into customer values (customer_seq.nextval, first_name, last_name, customer_city, customer_state,
  customer_zipcode, customer_phone, customer_credit);
dbms_output.put_line('New customer added successfully!');
Exception
when data_entry_wrong then
dbms_output.put_line('Error. Please try again.');
end;

create table reservation(
r_id int not null,
c_first varchar2(20),
c_last varchar2(20),
start_date date,
end_date date,
res_date date,
room_type varchar2(20),
c_id int,
h_id int,
primary key (r_id),
Foreign key (h_id) references hotel (h_id),
Foreign key (c_id) references customer (c_id)
);



insert into reservation (r_id, c_first, c_last, start_date, end_date, res_date, room_type, h_id, c_id) values
(1, 'max', 'alex', date'2020-01-01', date'2020-01-05', date'2019-12-01', 'double', 1, 1);
insert into reservation (r_id, c_first, c_last, start_date, end_date, res_date, room_type, h_id, c_id) values
(2, 'sky', 'bob', date'2020-02-01', date'2020-02-05', date'2020-01-01', 'double', 2, 2);
exec make_reservation('ray', 'sam', date'2020-06-01', date'2020-06-10', date'2020-05-04', 'single', 3, 3);
exec make_reservation('smith', 'sun', date'2020-07-01', date'2020-07-10', date'2020-05-05', 'single', 3, 3);


//create sequence
create sequence reservation_seq
  start with 3
  increment by 1;

//Make a reservation by Hotel ID, guest’s name, start date, end date, room type, date of reservation

create or replace procedure make_reservation_PN50138(first_name reservation.c_first%type,
last_name reservation.c_last%type, start_d reservation.start_date%type, end_d reservation.end_date%type,
reservation_date reservation.res_date%type, r_type reservation.room_type%type,
hotel_id reservation.h_id%type, customer_id reservation.c_id%type)
is
roo_id room.room_id%type;
begin
select count(*) into roo_id
from hotel, room
where hotel.h_id = hotel_id And
      hotel.h_id = room.h_id AND
      room.availablity = 'available' AND
      room.room_type = r_type;
      if (roo_id >0) then
insert into reservation values (reservation_seq.nextval, first_name, last_name, start_d, end_d, reservation_date, r_type, hotel_id, customer_id);
update room set availablity = 'occupied' where room_id = roo_id;
dbms_output.put_line('You have made a successfull reservation! This is your reservation id: ' || reservation_seq.nextval);
else
dbms_output.put_line('Room is not available');
end if;
Exception
when no_data_found THEN
dbms_output.put_line('Sorry, no hotel found. Please try again.');
end;

//exec make_reservation
exec make_reservation('smith', 'sun', date'2020-07-01', date'2020-07-10', date'2020-05-05', 'single', 3, 3);


//Change a reservationRoomType: Input the reservation ID and
change reservation room type if there is availability for that room type during the reservation’s date interval

create or replace procedure change_RoomType_PN50138(reservation_id reservation.r_id%type, room_t reservation.room_type%type)
  is
  roo_id room.room_id%type;
BEGIN
select count(*) into roo_id
from reservation, hotel, room
where reservation.r_id = reservation_id AND
      reservation.h_id = hotel.h_id and
      hotel.h_id = room.h_id and
      room.room_type = room_t and
      room.availablity = 'available';
      if (roo_id >0) then
update reservation set room_type = room_t where r_id = reservation_id;
dbms_output.put_line('You have successfully changed your room type to ' || room_t);
else
dbms_output.put_line('Room is not available');
end if;
Exception
when no_data_found THEN
dbms_output.put_line('Sorry, no reservation found. Please try again.');
end;

//exec change_RoomType_PN50138
exec change_RoomType_PN50138(1, 'double');


//Cancel a reservation: Input the reservationID and mark the reservation as cancelled (do NOT delete it)

create or replace procedure cancel_reservation_PN50138(reservation_id reservation.r_id%type)
is
cancel_status int;
data_entry_wrong Exception;
begin
select count(*) into cancel_status
from reservation , bill
where  reservation.r_id = reservation_id AND
      reservation.r_id = bill.r_id and
      bill.status = 'reserved';
      if (cancel_status > 0)then
update bill set bill.status = 'cancelled' where bill.r_id = reservation_id;
  dbms_output.put_line('You have successfully cancelled your room reservation');
Else
raise data_entry_wrong;
  end if;
  Exception
  when data_entry_wrong THEN
  dbms_output.put_line('Wrong entry. Please try again.');
  end;


//exec cancel_reservation_PN50138
exec cancel_reservation_PN50138(1);

//Find a reservation: Input is guest’s name and date, hotel ID. Output is reservation ID
create or replace procedure find_reservation_PN50138(last_name reservation.c_last%type, reservation_date reservation.res_date%type,
hotel_id reservation.h_id%type)
is
cursor c2 is select r_id
from reservation
where c_last = last_name AND
      res_date = reservation_date AND
      h_id = hotel_id;
reservation_id reservation.r_id%type;
begin
open c2;
LOOP
fetch c2 into reservation_id;
exit when c2%Notfound;
dbms_output.put_line('The reservation id of '|| last_name || ' is ' || reservation_id);
end loop;
close c2;
Exception
when no_data_found THEN
dbms_output.put_line('Sorry, no hotel found. Please try again.');
end;

//exec find_reservation
exec find_reservation('sam', date'2020-05-04', 3);

// create bill table
create table bill(
  bill_id int not null,
  status varchar2(2),
  total_cost int;
  r_id int,
  foreign key r_id references reservation (r_id),
  primary key (bill_id)
);

// insert bill
insert into bill (bill_id, status, total_cost, r_id) values (1, 'reserved', 500 ,1);
insert into bill (bill_id, status, total_cost, r_id) values (2, 'reserved', 500 ,2);


//total_cost function
create or replace function total_cost_PN50138(reservation_id reservation.r_id%type)
  return int
  is
  total_amount int;
  discount_amount int;
  begin_date int;
  last_date int;
  book_date int;
  day_diff int;
  rate room.cost%type;
  BEGIN
  select extract(Month from start_date), extract(Month from end_date), extract(Month from res_date), room.cost into
  begin_date, last_date, book_date, rate
  from reservation, hotel, room
  where reservation.r_id = reservation_id AND
        reservation.h_id = hotel.h_id and
        hotel.h_id = room.h_id AND
        room.room_type = 'occupied';
if (begin_date >= 9 or begin_date <= 4) THEN
total_amount := ((last_date - begin_date) * rate) + 200;
return total_amount;
Else
total_amount := (last_date - begin_date) * rate + 300;
return total_amount;
end if;

day_diff := booK_date - begin_date;
if (day_diff > 2) then
discount_amount := total_amount * 0.1;
total_amount := total_amount - discount_amount;
return total_amount;
end if;
end;

//Exec total_cost_PN50138
DECLARE
total int;
BEGIN
total := total_cost_PN50138(1);
dbms_output.put_line('The total is: '|| total);
end;

Display a bill: Input parameters: reservation ID.
Print on the console a bill for the guest.
Include guest name, hotel Name and ID,
start date, end date, room type,
date of reservation, room number,
charge per day, rate per day and total amount.

create or replace procedure display_bill_PN50138(reservation_id reservation.r_id%type)
  is
  total_amount int;
  last_name reservation.c_last%type;
  state hotel.h_state%type;
  hotel_id reservation.h_id%type;
  begin_date reservation.start_date%type;
  last_date reservation.end_date%type;
  r_type reservation.room_type%type;
  book_date reservation.res_date%type;
  room_num room.room_id%type;
  rate room.cost%type;
  data_entry_wrong exception;
  begin
  select c_last, h_state, h_id, start_date, end_date, room.room_type, res_date, room_id, cost into
  last_name, state, hotel_id, begin_date, last_date, r_type, book_date, room_num, rate
  from hotel, reservation, room
  where reservation.r_id = reservation_id AND
        reservation.h_id = hotel.h_id and
        hotel.h_id = room.h_id;
  total_amount := total_cost_PN50138(reservation_id);
  if (total_amount > 0) THEN
  dbms_output.put_line('Customer Name: '||last_name ||', Hotel State: ' ||state ||
    ', Hotel Id: '||hotel_id ||', Start date: ' ||begin_date ||', end date: ' ||last_date ||
    ', room type: '||r_type || ', reservation date: '||book_date ||', room number: ' ||
    room_num ||', Charge per day: ' ||rate||', total amount: ' ||total_amount);
    Else
    raise data_entry_wrong;
      end if;
      Exception
      when data_entry_wrong THEN
      dbms_output.put_line('Wrong entry. Please try again.');
      end;

// exec display_bill
exec display_bill(1);

create or replace procedure display_hotel_info_PN50138(hotel_id hotel.h_id%type)
  is
  cursor c1 is select h_city, h_state, h_zipcode, h_phone, num_rooms, room_type, cost
  from hotel, room
  where hotel.h_id = room.h_id and
  hotel.h_id = hotel_id;
  hotel_city hotel.h_city%type;
  hotel_state hotel.h_state%type;
  hotel_zipcode hotel.h_zipcode%type;
  hotel_phone hotel.h_phone%type;
  hotel_num_rooms hotel.num_rooms%type;
  hotel_room_type room.room_type%type;
  hotel_cost room.cost%type;
  begin
  open c1;
  LOOP
  fetch c1 into
  hotel_city, hotel_state, hotel_zipcode, hotel_phone, hotel_num_rooms, hotel_room_type, hotel_cost;
  exit when c1%NOTFOUND;
  DBMS_OUTPUT.put_line('The hotel information of '|| hotel_id || ' is city:'|| hotel_city || '  state: '||
    hotel_state || ' zipcode: '|| hotel_zipcode || ' phone: '|| hotel_phone || ' number of rooms: '||
    hotel_num_rooms || ' room type: '|| hotel_room_type || ' cost: '|| hotel_cost);
    end loop;
    close c1;
    Exception
    when no_data_found THEN
    dbms_output.put_line('Sorry, no hotel found.Please try again.');
    end;


Income By State Report:
a.	Input is state. Print total income from all sources of all hotels by room type.

create or replace procedure income_by_state_PN50138(state hotel.h_state%type)
  is
  cursor c1 is select hotel.h_id, room.room_type, room.cost
  FROM hotel, room
  where h_state = state and
        hotel.h_id = room.room_id
  group by room_type;
  hotel_id hotel.h_id%type;
  r_type room.room_type%type;
  amount room.cost%type;
  begin
  open c1;
  LOOP
  fetch c1 into hotel_id, r_type, amount;
  exit when c1%NOTFOUND;
  dbms_output.put_line('The total income of ' || state || ' by room type is ' || r_type
    ||' and cost is ' ||amount);
    end loop;
    close c1;
    Exception
    when no_data_found THEN
    dbms_output.put_line('Sorry, no hotel found.Please try again.');
    end;

    //exec income_by_state_PN50138
    exec income_by_state_PN50138('dc');

    b.	Input is hotel ID. Print total income of hotel by room type.

    create or replace procedure income_by_id_PN50138(hotel_id hotel.h_id%type)
      is
      cursor c1 select room.room_type, room.cost
      FROM hotel, room
      where hotel.h_id = hotel_id and
            hotel.h_id = room.room_id
      group by room_type;
      r_type room.room_type%type;
      amount room.cost%type;
      begin
      open c1;
      LOOP
      fetch c1 into r_type, amount;
      exit when c1%NOTFOUND;
      dbms_output.put_line('The total income of ' || hotel_id || ' by room type is ' || r_type
        ||' and cost is ' ||amount);
        end loop;
        close c1;
        Exception
        when no_data_found THEN
        dbms_output.put_line('Sorry, no hotel found.Please try again.');
        end;

        //exec income_by_id_PN50138
        exec income_by_id_PN50138(1);

  ///////
  create or replace procedure income_by_state_PN50138(state hotel.h_state%type)
    is
    hotel_id hotel.h_id%type;
    r_type room.room_type%type;
    amount room.cost%type;
    begin
    select count(hotel.h_id), room.room_type, room.cost into hotel_id, r_type, amount
    FROM hotel, room
    where h_state = state and
          hotel.h_id = room.room_id
    group by room_type;
    if (hotel_id > 1) then
    dbms_output.put_line('The total income of ' || state || ' by room type is ' || r_type
      ||' and cost is ' ||amount);
      end if;
    Exception
    when no_data_found THEN
    dbms_output.put_line('Sorry, no hotel found. Please try again.');
    end;
/////////
