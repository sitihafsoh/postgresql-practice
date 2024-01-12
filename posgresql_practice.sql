SELECT * FROM pg_tables WHERE schemaname='public';
-- Note: cek di konsol '\d barang' untuk melihat kolom dalam tabel barang

-- Membuat tabel
CREATE TABLE barang
(
	kode INT,
	name VARCHAR(100),
	harga INT,
	jumlah INT
);
-- Mengubah tabel: menambahkan kolom deskripsi
ALTER TABLE barang
add column deskripsi text;

-- Mengubah tabel: menghapus tabel deskripsi
ALTER TABLE barang
drop column deskripsi; 

-- Mengubah tabel: mengganti nama
ALTER TABLE barang
rename column name to nama;

-- Membuat ulang tabel
truncate barang;
''' Example: pada kasus kita sudah memasukkan data banyak, terus kita ingin
hapus semua datanya. Kemudian kita buat ulang tabel dengan struktur yang sama,
kita bisa buat dengan truncate tabel'''

-- Menghapus tabel
DROP TABLE barang;
'''Note: "\d" untuk melihat tabel'''

-- Membuat ulang tabel barang
CREATE TABLE barang
(
	kode INT not null,
	name VARCHAR(100) not null,
	harga INT not null DEFAULT 1000, --default 1000
	jumlah INT not null DEFAULT 0, --default 0
	waktu_dibuat TIMESTAMP not null DEFAULT current_timestamp --default current timestamp
);
'''Note: DEFAULT berfungsi secara otomatis mengisi null, karena kalau
tidak di setting default seperti itu. Secara otomatis nilainya kan null'''

-- Membuat tabel produk
CREATE TABLE products(
	id VARCHAR(10) NOT NULL,
	name VARCHAR(100) NOT NULL,
	description TEXT,
	price INT NOT NULL,
	quantity INT NOT NULL DEFAULT 0,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Memasukkan data ke dalam tabel products
INSERT INTO products(id, name, price, quantity)
VALUES ('P0001', 'Mie Ayam Original', 15000, 100);

INSERT INTO products(id, name, description, price, quantity)
VALUES('P0002', 'Mie Ayam Bakso Tahu', 'Mie Ayam Original + Bakso Tahu', 20000, 100);

-- Memasukkan beberapa data sekaligus
INSERT INTO products(id, name, price, quantity)
VALUES ('P0003', 'Mie Ayam Ceker', 20000, 100),
('POO04', 'Mie Ayam Spesial', 25000, 100),
('P0005', 'Mie Ayam Yamin', 15000, 100);

-- Mengambil data atau menampilkan data
SELECT * FROM products;

SELECT id, name, price, quantity FROM products;

-- Menambahkan primary key ketika membuat tabel
'''CREATE TABLE products
(
	id VARCHAR(10) NOT NULL,
	name VARCHAR(100) NOT NULL,
	description TEXT,
	price INT NOT NULL,
	quantity INT NOT NULL DEFAULT 0,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id)
);''' -- contoh aja, soalnya kolom products sudah dibuat sebelumnya
	
-- Menambahkan primary key di tabel yang sudah ada
ALTER TABLE products
	ADD PRIMARY KEY (id);
	
-- Mencari data menggunakan 'WHERE'
SELECT id, name, price, quantity
FROM products
WHERE quantity = 0;
	
SELECT id, name, price, quantity
FROM products
WHERE price = 20000;
	
SELECT id, name, price, quantity
FROM products
WHERE id = 'P0005';

-- Menambahkan  kolom kategori
CREATE TYPE PRODUCT_CATEGORY AS ENUM ('Makanan', 'Minuman', 'Lain-Lain');
	
ALTER TABLE products
	ADD COLUMN category PRODUCT_CATEGORY;
	
-- Mengubah satu kolom
UPDATE products
SET category = 'Makanan'
WHERE id = 'P0001';
	
UPDATE products
SET category = 'Makanan'
WHERE id = 'P0002';
	
UPDATE products
SET category = 'Makanan'
WHERE id = 'P0003';
	
UPDATE products
SET category = 'Makanan'
WHERE id = 'P0004';

UPDATE products
SET category = 'Makanan'
WHERE id = 'P0005';
	
UPDATE products
SET category = 'Makanan',
	description = 'Mie Ayam + Ceker'
WHERE id = 'P0003';

SELECT * FROM products;
	
-- Mengubah dengan value yang sudah ada di kolom
UPDATE products
SET price = price + 5000
WHERE id = 'P0004';
	
-- Menambahkan data
INSERT INTO products(id, name, price, quantity, category)
VALUES ('P0009', 'Contoh', 10000, 100, 'Minuman');

-- Menghapus data
'''DELETE FROM products;''' -- Jika ingin menghapus seluruh data di dalam products

DELETE FROM products
WHERE id = 'P0009'; -- Menghapus data pada baris yang id-nya 'P0009'

-- Alias untuk kolom
SELECT id AS Kode,
	price AS Harga,
	description AS Deskripsi
FROM products;
'''Note: hasil nama kolom baru akan lowercase semua sesuai default
postgresql'''
	
SELECT id AS "Kode Barang",
	price AS "Harga Barang",
	description AS "Deskripsi Barang"
FROM products;
'''Note: Dengan menambahkan tanda petik dua di antara nama kolom baru,
akan menampilkan nama kolom sesuai dengan syntax yang kita tulis'''
	
-- Alias untuk tabel
SELECT
	p.id AS Kode,
	p.price AS Harga,
	p.description AS Deskripsi
FROM products AS p;
	
-- Mencari data dengan operator perbandingan
SELECT *
FROM products
WHERE price > 15000;
	
SELECT *
FROM products
WHERE price <= 15000;
	
SELECT *
FROM products
WHERE category != 'Makanan';

SELECT *
FROM products
WHERE category != 'Minuman';
	
/* AND dan OR Operator */
-- Mencari data dengan operator AND
SELECT *
FROM products
WHERE price > 15000
	AND category = 'Makanan';

INSERT INTO products(id, name, price, quantity, category)
VALUES ('P0006', 'Es Teh Tawar', 10000, 100, 'Minuman'),
	('P0007', 'Es Campur', 20000, 100, 'Minuman'),
	('P0008', 'Jus Jeruk', 15000, 100, 'Minuman');
	
-- Mencari data dengan operator OR
SELECT *
FROM products
WHERE price > 15000
	OR category = 'Makanan';
	
-- Prioritas dengan tanda kurung ()
SELECT *
FROM products
WHERE (quantity > 100 OR category = 'Makanan')
	AND price > 10000;
	
/* LIKE Operator */
''' LIKE Operator adalah operator yang bisa kita gunakan untuk mencari 
	data dalam string. Operasi LIKE case sensitive, jika tidak ingin case
	sensitive bisa pakai ILIKE. Hasil operator LIKE:
	- lIKE 'b%': string dengan awalan b
	- LIKE '%a': string dengan akhiran a
	- LIKE '%eko%': string berisi eko
	- NOT LIKE: tidak LIKE'''
	
-- Mencari menggunakan LIKE operator
SELECT *
FROM products
WHERE name ILIKE '%mie%';
	
SELECT *
FROM products
WHERE name ILIKE '%es%';
	
SELECT *
FROM products
WHERE name LIKE '%es%';
	
/* NULL Operator */
''' Note: Untuk mencari nilai NULL, tidak bisa menggunakan operator 
	perbandingan. Jadi menggunakan IS NULL untuk mencari NULL, dan
	IS NOT NULL untuk mencari yang tidak NULL '''

-- Mencari menggunakan NULL Operator
SELECT *
FROM products
WHERE description IS NULL;
	
SELECT *
FROM products
WHERE description IS NOT NULL;
	
/* BETWEEN Operator */
'''Note: untuk mencari data yang >= dan <= sekaligus'''
	
-- Mencari menggunakan BETWEEN Operator
SELECT *
FROM products
WHERE price BETWEEN 10000 AND 20000;
	
SELECT *
FROM products
WHERE price NOT BETWEEN 10000 AND 20000;
	
/* IN Operator */
''' Note: Operator IN adalah operator untuk melakukan pencarian sebuah
kolom dengan beberapa nilai '''

-- Mencari menggunakan IN Operator
SELECT *
FROM products
WHERE category IN ('Makanan', 'Minuman');
	
SELECT *
FROM products
WHERE category IN ('Makanan');
	
SELECT *
FROM products
WHERE category NOT IN ('Makanan');

/* Order By Clause */
''' Untuk mengurutkan data ketika kita menggunakan perintah SQL SELECT,
kita bisa menambahkan ORDER BY clause '''

-- Mengurutkan data
SELECT *
FROM products
ORDER BY price ASC, id DESC;
	
/* limit Clause */
	
-- Membatasi hasil query
SELECT *
FROM products
WHERE price > 0
ORDER BY price ASC
LIMIT 2;
	
-- Skip hasil query
SELECT *
FROM products
WHERE price > 0
ORDER BY price ASC
LIMIT 2 OFFSET 2; -- OFFSET 2 artinya 2 data di awal tidak diambil
''' Note: biasanya dipakai untuk paging. Page ke-1 limit 2 offset 0, 
page ke-2 limit 2 offset 2, page ke-3 limit 2 offset 4, dst '''
	
/* Select Distinct Data */
''' Note: Untuk menghilangkan data-data duplikat'''
	
-- Menghilangkan data duplikat
SELECT DISTINCT category
FROM products;
	
/* Numeric Function */

-- Menggunakan arithmetic operator
SELECT 10 + 10 AS hasil;

SELECT id, price / 1000 AS price_in_k
FROM products;
	
/* Mathematical Function */
-- Menggunakan mathematical function
SELECT PI();
	
SELECT POWER(10, 2); -- 10 pangkat 2
	
SELECT COS(10), SIN(10), TAN(10);
	
SELECT id, name, power(quantity, 2) AS quantity_power_2
FROM products;
	
/* Auto Increment */
''' PostgreSQL memiliki tipe data Number bernama SERIAL, fitur ini bisa kita
gunakan untuk membuat function yang akan otomatis mengembalikan nilai yang
selalu naik ketika dipanggil '''
	
-- Membuat tabel dengan Auto Increment
CREATE TABLE admin
(
	id SERIAL NOT NULL, -- SERIAL itu sebenarnya INT, jadi ukurannya segitu.
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100),
	PRIMARY KEY (id)
);
	
-- Memasukkan data tanpa id
INSERT INTO admin(first_name, last_name) -- id tidak ditulis, karena nanti dia akan otomatis terisi nilainya
VALUES ('Eko', 'Khannedy'),
	('Budi', 'Nugraha'),
	('Joko', 'Morro');
	
SELECT * FROM admin;
	
-- Melihat id terakhir
SELECT currval(pg_get_serial_sequence('admin', 'id')); --cara ke - 1. curvall: current value
	
SELECT currval('admin_id_seq'); -- cara ke - 2. admin_id_seq bisa dilihat di describe tabel di console, cek dengan \d admin
	
/* Sequence */
''' Note: Sequence adalah fitur dimana kita bisa membuat function auto
increment (otomatis naik) '''

-- Kode membuat sequence

-- Membuat sequence
CREATE SEQUENCE contoh_sequence;
	
-- Memanggil sequence, otomatis increment
SELECT nextval('contoh_sequence'); -- selalu naik ketika query ini di eksekusi
	
-- Mengambil nilai terakhir sequence
SELECT currval('contoh_sequence');

-- Kode: sequence dari serial
CREATE SEQUENCE admin_id_seq; -- admin_id_seq: nama tabel + nama kolom + sequence
	
CREATE TABLE admin
(
	id INT NOT NULL DEFAULT nextval('admin_id_seq'),
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	PRIMARY KEY (id)
);

''' Note: melihat semua sequence di console gunakan '\ds' (detail sequence) '''

/* String Function */

-- Menggunakan string function
SELECT id, name, description
FROM products;

SELECT id, LOWER(name), LENGTH(name), LOWER(description)
FROM products;
	
/* Date and Time Function */

-- Menambah kolom timestamp
SELECT * FROM products;
	
SELECT id, EXTRACT(YEAR FROM created_at), EXTRACT(MONTH FROM created_at)
FROM products;
	
/* Flow Control Function */
''' Ini mirip dengan IF ELSE dalam bahasa pemrograman, tapi tidak 
sekompleks itu '''

-- Menggunakan Control Flow Case
SELECT id, category
FROM products;
	
SELECT id,
	category,
	CASE category
		WHEN 'Makanan' THEN 'Enak'
		WHEN 'Minuman' THEN 'Seger'
		ELSE 'Apa itu?'
		END AS category_case -- AS category  jika kamu mengganti nama kolomnya
FROM products;

-- Menggunakan operator
SELECT id,
	price,
	CASE -- untuk perbandingan tidak perlu disebutkan kolomnya
		WHEN price <= 15000 THEN 'Murah'
		WHEN price <= 20000 THEN 'Mahal'
		ELSE 'Mahal Banget'
		END AS "apakah murah?"
FROM products;
	
-- Menggunakan control flow check NULL
SELECT id, name, description
FROM products;
	
SELECT id,
	name,
	CASE
		WHEN description IS NULL THEN 'Kosong'
		ELSE description
		END AS description
FROM products;

/* Aggregate Function */
''' Note: Misal, kita ingin melihat harga paling mahal di tabel product, 
atau harga termurah, atau rata-rata harga produk, atau total jumlah data
di tabel, dan lain-lain '''

-- Menggunakan aggregate function
SELECT COUNT(id) AS "Total Product" FROM products;
	
SELECT AVG(price) AS "Rata-Rata Harga" FROM products;
	
SELECT MAX(price) AS "Harga Termahal" FROM products;
	
SELECT MIN(price) AS "Harga Termurah" FROM products;
	
/* Grouping */
''' Note: Ketika sedang melakukan aggregate terkadang kita ingin datanya di
grouping (dikelompokkan) berdasarkan kriteria tertentu '''
	
-- Menggunakan GROUP BY
SELECT category,
	COUNT(id) AS "Total Product"
FROM products
GROUP BY category;
	
SELECT category,
	AVG(price) AS "Rata-Rata Harga",
	MIN(price) AS "Harga Termurah",
	MAX(price) AS "Harga Termahal"
FROM products
GROUP BY category;
	
/* HAVING Clause */
''' Note: Jika kita ingin melakukan filter terhadap data yang sudah kita grouping.
Misal, kita ingin menampilkan rata-rata harga per kategori, tapi harganya diatas
10.000 '''

-- Menggunakan HAVING Clause
SELECT category,
	COUNT(id) AS total
FROM products
GROUP BY category
HAVING COUNT(id) > 1;
	
SELECT category,
	COUNT(id) AS "Total Product"
FROM products
GROUP BY category
HAVING COUNT(id) > 3;
	
SELECT category,
	AVG(price) AS "Rata-Rata Harga",
	MIN(price) AS "Harga Termurah",
	MAX(price) AS "Harga Termahal"
FROM products
GROUP BY category
HAVING AVG(price) >= 20000; 
''' Note: Kenapa tidak filter pakai WHERE? Karena HAVING Clause digunakan
untuk memfilter hasil dari pengelompokkan aggregate yang dilakukan oleh
GROUP BY '''
	
/* Constraint */
''' Note: Di PostgreSQL, kita bisa menambahkan constraint (aturan) untuk menjaga
data di tabel tetap baik. Constraint sangat bagus ditambahkan untuk menjaga 
terjadi validasi yang salah di program kita, sehingga data yang masuk ke
database tetap akan terjaga '''

-- 1. Unique Constraint
''' Note: Constraint yang memastikan bahwa data kita tetap unique. Jika kita
mencoba memasukkan data yang duplikat, maka PostgreSQL akan menolak data tersebut '''

-- Membuat table dengan unique constraint
CREATE TABLE customer
(
	id SERIAL NOT NULL,
	email VARCHAR(100) NOT NULL,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100),
	PRIMARY KEY (id),
	CONSTRAINT unique_email UNIQUE (email) --artinya kolom email tidak boleh duplikat
);
	
INSERT INTO customer(email, first_name, last_name)
VALUES ('eko@pzn.com', 'Eko', 'Khannedy');
	
SELECT *
FROM customer;
	
INSERT INTO customer(email, first_name, last_name)
VALUES ('eko@pzn.com', 'Budi', 'Nugraha'); -- hasil ERROR karena email sama dengan data yang dimasukkan sebelumnya

INSERT INTO customer(email, first_name, last_name)
VALUES ('budi@pzn.com', 'Budi', 'Nugraha'),
	('joko@pzn.com', 'Joko', 'Morro'),
	('rully@pzn.com', 'Rully', 'Irwansyah');
	
-- Menambah / Menghapus Unique Constraint
ALTER TABLE customer
	DROP CONSTRAINT unique_email;
	
ALTER TABLE customer
	ADD CONSTRAINT unique_email UNIQUE (email);
	
-- 2. Check Constraint
''' Note: Constraint yang bisa kita tambahkan kondisi pengecekannya. Misal kita 
ingin memastikan bahwa harga harus di atas 1000 misal '''
	
-- Membuat table dengan check constraint
CREATE TABLE products
(
	id VARCHAR(100) NOT NULL,
	name VARCHAR(100) NOT NULL,
	description TEXT,
	price INT NOT NULL,
	quantity INT NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	CONSTRAINT price_check CHECK (price >= 1000) -- constraint check untuk tidak menyertakan price >= 1000
);
	
-- Menambahkan / menghapus check constraint
ALTER TABLE products
	ADD CONSTRAINT price_check CHECK (price >= 1000);
	
ALTER TABLE products
	ADD CONSTRAINT quantity_check CHECK (quantity >= 0);
	
INSERT INTO products(id, name, price, quantity, category)
VALUES ('XXX1', 'Contoh Gagal', 10, 0, 'Minuman'); -- resultnya gagal, karena price < 1000
	
INSERT INTO products(id, name, price, quantity, category)
VALUES ('XXX1', 'Contoh Gagal', 10000, -10, 'Minuman'); --resultnya gagal, karena quantity < 0
	
SELECT *
FROM products;
	
ALTER TABLE products
	DROP CONSTRAINT price_check;
	
/* Index */
''' Note: dengan menggunakan INDEX, tidak hanya akan mempermudah kita dalam
pencarian, index juga akan mempermudah kita ketika melakukan pengurutan menggunakan
ORDER BY '''
	
-- Membuat table
CREATE TABLE sellers
(
	id SERIAL NOT NULL,
	name VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	PRIMARY KEY (id), -- PRIMARY KEY dan UNIQUE CONSTRAINT tidak perlu ditambahi Index, karena mereka sudah otomatis ada indeksnya
	CONSTRAINT email_unique UNIQUE (email)
);
	
INSERT INTO sellers(name, email)
VALUES ('Galeri Olahraga', 'galeri@pzn.com'),
	('Toko Tono', 'tono@pzn.com'),
	('Toko Budi', 'budi@pzn.com'),
	('Toko Rully', 'rully@pzn.com');
	
SELECT *
FROM sellers;
	
SELECT *
FROM sellers
WHERE id = 1; --otomatis akan menggunakan indeks, karena id adalah primary key yang otomatis menggunakan indeks
	
SELECT *
FROM sellers
WHERE email = 'rully@pzn.com'; -- cepat, karena email juga menggunakan indeks

SELECT *
FROM sellers
WHERE id = 1 OR name = 'Toko Tono'; --lambat, karena meskipun id indeks, namun name tidak menggunakan indeks. Jadi dicari secara manual dari atas ke bawah

-- Menambah/menghapus index
CREATE INDEX sellers_id_and_name_index ON sellers (id, name);
	
CREATE INDEX sellers_email_and_name_index ON sellers (email, name);
	
DROP INDEX sellers_name_index;
	
SELECT *
FROM sellers
WHERE name = 'Toko Tono'; --tidak menggunakan indeks, karena kita tidak pernah membuat 1 indeks khusus 1 kolom 'name' itu

CREATE INDEX sellers_name_index ON sellers (name);
	
SELECT *
FROM sellers
WHERE name = 'Toko Budi'; -- sudah pakai index
	
/* Full-Text Search */

-- Masalah dengan LIKE Operator
''' Note: Kadang kita ingin mencari sebuah kata dalam tabel, dan biasanya akan
menggunakan LIKE operator. Namun hal ini akan lambat, karena dia mencari manual
satu persatu dari atas ke bawah. Menambah index di tabel juga tidak akan membantu, 
karena LIKE operator tidak menggunakan index. Maka sebagai gantinya PostgreSQL
menyediakan fitur Full Text Search '''
	
-- Full-Text Search
''' Note: full-text search memungkinkan kita bisa mencari sebagian kata di kolom
dengan tipe data string. Di PostgreSQL, full-text search menggunakan function
to_tsvector(text) dan to_tsquery(query). Operator full-text search menggunakan
@@, bukan = '''
	
-- Mencari tanpa index
SELECT *
FROM products
WHERE name ILIKE '%mie%';
	
SELECT *
FROM products
WHERE to_tsvector(name) @@ to_tsquery('mie');
	
-- Full-text search index
''' Note: untuk membuat index full-text search kita bisa menggunakan perintah yang
sama dengan index biasa, tapi harus disebutkan detail dari jenis index
Full-Text Search nya '''

-- Membuat index full-text search
	
SELECT cfgname FROM pg_ts_config; -- melihat bahasa yang didukung di PostgreSQL
	
CREATE INDEX products_name_search ON products USING GIN (to_tsvector('indonesian', name));
	
CREATE INDEX products_description_search ON products USING GIN (to_tsvector('indonesian', description)); -- untuk memastikan indexnya ada, check di console \d produtcs
	
DROP INDEX products_name_search;
	
DROP INDEX products_description_search;
	
-- Mencari menggunakan full-text search
SELECT *
FROM products
WHERE name @@ to_tsquery('mie'); --tidak perlu menggunakan to_tsvector lagi, cukup to_tsquery

SELECT *
FROM products
WHERE description @@ to_tsquery('mie'); --tidak sefleksibel LIKE, yang tidak perlu 1 kata 'mie', bisa mi saja. Tapi ini bisa lebih cepat

-- Query operator di full-text search
'''
to_tsquery() mendukung banyak operator
& untuk AND
| untuk OR
! untuk NOT
'' ... '' untuk semua data
'''
	
-- Mencari dengan operator
SELECT *
FROM products
WHERE name @@ to_tsquery('original | bakso');
	
SELECT *
FROM products
WHERE name @@ to_tsquery('bakso & tahu');
	
SELECT *
FROM products
WHERE name @@ to_tsquery('bakso');
	
SELECT *
FROM products
WHERE name @@ to_tsquery('''bakso tahu'''); -- diapit 3 petik 1 untuk mencari case seperti itu

-- Tipe data tsvector
''' Note: kita juga bisa secara otomatis membuat kolom dengan tipe data TSVECTOR.
Secara otomatis kolom tersebut berisi text yang memiliki index full-text index '''
	
/* Table Relationship */
''' Note: kita butuh foreign key '''

-- Membuat table dengan foreign key
CREATE TABLE wishlist
(
	id SERIAL NOT NULL,
	id_product VARCHAR(10) NOT NULL,
	description TEXT,
	PRIMARY KEY (id),
	CONSTRAINT fk_wishlist_product FOREIGN KEY (id_product) REFERENCES products (id)
); -- pastikan tipe data pada foreign key sama dengan referencenya

-- Menambah / menghapus foreign key jika tabelnya sudah dibuat
ALTER TABLE wishlist
	DROP CONSTRAINT fk_wishlist_product;
	
ALTER TABLE wishlist
	DROP CONSTRAINT fk_wishlist_product FOREIGN KEY (id_product) REFERENCES products (id);
	
-- Keuntungan menggunakan foreign key
INSERT INTO wishlist(id_product, description)
VALUES ('SALAH', 'Contoh Salah'); -- resultnya akan ERROR, karena tidak ada id SALAH pada tabel reference
	
INSERT INTO wishlist(id_product, description)
VALUES ('P0001', 'Mie ayam kesukaan'),
	('P0002', 'Mie ayam kesukaan'),
	('P0005', 'Mie ayam kesukaan'); -- berhasil karena memang ada id demikian di table products (reference)
	
SELECT *
FROM wishlist;
	
UPDATE wishlist
SET id_product = 'SALAH'
WHERE id = 2; -- result error, karena tidak ada id 2 di tabel reference
	
DELETE
FROM products
WHERE id = 'P0005'; -- result error, karena kolom id 'P0005' pada tabel product juga digunakan sebagai referensi di tabel wishlist sebagai foreign key. Jadi tidak bisa dihapus

-- Ketika menghapus data berelasi
'''
Behavior dari foreign key:
(Behavior, ON DELETE, ON UPDATE)
>>>
(RESTRICT, Ditolak, Ditolak),
(CASCADE, Data akan dihapus, Data akan ikut diubah),
(NO ACTION, Data dibiarkan, Data dibiarkan),
(SET NULL, Diubah jadi NULL, Diubah jadi NULL),
(SET DEFAULT, Diubah jadi Default Value, Diubah jadi Default Value)
>>>
Disarankan tetap pakai RESTRICT supaya data tetap konsisten
'''
	
-- Mengubah behavior menghapus relasi
ALTER TABLE wishlist
DROP CONSTRAINT fk_wishlist_product;
	
ALTER TABLE wishlist
ADD CONSTRAINT fk_wishlist_product FOREIGN KEY (id_product) REFERENCES products (id)
ON DELETE CASCADE ON UPDATE CASCADE; --by default nya ON DELETE RESTRICT ON UPDATE RESTRICT

INSERT INTO products(id, name, price, quantity, category)
VALUES ('XXX', 'Xxx', 10000, 100, 'Minuman');
	
SELECT *
FROM products;
	
INSERT INTO wishlist(id_product, description)
VALUES ('XXX', 'Contoh');
	
SELECT *
FROM wishlist;
	
DELETE
FROM products
WHERE id = 'XXX'; -- delete success
	
SELECT *
FROM wishlist; -- cek tabel wishlist, ternyata juga ikutan dihapus

''' Note: Disarankan tetap menggunakan RESTRICT, karena lumayan berbahaya
jika kita hapus data ditabel utama, tapi data ditabel reference ikutan terhapus '''
	
/* Join */

-- Melakukan JOIN table
SELECT *
FROM wishlist
	JOIN products ON products.id = wishlist.id_product;
	
SELECT products.id, products.name, wishlist.description
FROM wishlist
	JOIN products ON products.id = wishlist.id_product;
	
-- Membuat relasi ke table customers
ALTER TABLE wishlist
	ADD COLUMN id_customer INT;
	
ALTER TABLE wishlist
	ADD CONSTRAINT fk_wishlist_customer FOREIGN KEY (id_customer) REFERENCES customer (id);
	
UPDATE wishlist
SET id_customer = 1
WHERE id in (2, 3);
	
UPDATE wishlist
SET id_customer = 4
WHERE id = 4;
	
SELECT *
FROM wishlist;
	
-- Melakukan JOIN multiple table
SELECT c.email, p.id, p.name, w.description
FROM wishlist AS w
	JOIN products AS p ON w.id_product = p.id
	JOIN customer AS c ON w.id_customer = c.id;
	
/* One to One Relationship */
''' Note: hanya boleh berelasi maksimal 1 data di tabel lainnya. Contoh misal,
kita membuat aplikasi toko online yang terdapat fitur wallet, dan 1 customer,
cuma boleh punya 1 wallet '''
	
-- Membuat one to one relationship
''' Note: kita bisa membuat kolom foreign key, lalu set kolom tersebut menggunakan
UNIQUE KEY, hal ini dapat mencegah terjadi data di kolom tersebut agar tidak duplikat.
	
atau cara lainnya, kita bisa menggunakan tabel dengan primary key yang sama, 
sehingga tidak buth lagi kolom untuk FOREIGN KEY '''
	
-- Membuat table wallet
CREATE TABLE wallet
(
	id SERIAL NOT NULL,
	id_customer INT NOT NULL,
	balance INT NOT NULL DEFAULT 0,
	PRIMARY KEY (id),
	CONSTRAINT wallet_customer_unique UNIQUE (id_customer),
	CONSTRAINT fk_wallet_customer FOREIGN KEY (id_customer) REFERENCES customer (id)
);
	
SELECT *
FROM customer; -- cek kolom id pada customer
	
INSERT INTO wallet(id_customer, balance)
VALUES (1, 1000000),
	(3, 2000000),
	(4, 3000000),
	(5, 4000000);
	
SELECT *
FROM wallet;
	
SELECT *
FROM customer
JOIN wallet ON wallet.id_customer = customer.id;
	
/* One to Many Relationship */
''' Note: contoh relasi antar table categories dan products, dimana satu category
bisa digunakan oleh lebih dari satu product, yang artinya relasinya one category
to many products. Bedanya dengan one to one, yang ini tidak perlu pakai UNIQUE '''
	
-- Membuat table category
CREATE TABLE categories
(
	id VARCHAR(10) NOT NULL,
	name VARCHAR(100) NOT NULL,
	PRIMARY KEY (id)
);
	
-- Mengubah tabel product
INSERT INTO categories(id, name)
VALUES ('C0001', 'Makanan'),
	('C0002', 'Minuman');
	
SELECT * FROM categories;
	
ALTER TABLE products
DROP COLUMN category;
	
ALTER TABLE products
ADD COLUMN id_category VARCHAR(10);
	
ALTER TABLE products
ADD CONSTRAINT fk_product_category FOREIGN KEY (id_category) REFERENCES categories (id);

SELECT * FROM products;
	
UPDATE products
SET id_category = 'C0001'
WHERE category = 'Makanan';
	
UPDATE products
SET id_category = 'C0002'
WHERE category = 'Minuman';
	
ALTER TABLE products
DROP COLUMN category;
	
SELECT *
FROM products
JOIN categories ON products.id_category = categories.id;
	
/* Many to Many Relationship */
''' Note: Contoh relasi many to many adalah relasi antara produk dan penjualan,
dimana setiap produk bisa dijual berkali-kali, dan setiap penjualan bisa untuk lebih
dari satu produk '''
	
''' Cara buatnya dengan menambahkan 1 tabel ditengahnya sebagai jembatan untuk
menggabungkan many to many '''
	
-- Membuat tabel order
CREATE TABLE orders
(
	id SERIAL NOT NULL,
	total INT NOT NULL,
	order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id)
);
	
-- Membuat tabel order detail (tabel yang untuk ditengah/ sebagai jembatan)
CREATE TABLE orders_detail
(
	id_product VARCHAR(10) NOT NULL,
	id_order INT NOT NULL,
	price INT NOT NULL,
	quantity INT NOT NULL,
	PRIMARY KEY (id_product, id_order)
);

-- Membuat FOREIGN KEY untuk orders_detail
ALTER TABLE orders_detail
	ADD CONSTRAINT fk_orders_detail_product FOREIGN KEY (id_product) REFERENCES products (id);
	
ALTER TABLE orders_detail
	ADD CONSTRAINT fk_orders_detail_order FOREIGN KEY (id_order) REFERENCES orders (id);
	
INSERT INTO orders(total)
VALUES (1),
	(1),
	(1);
	
SELECT * FROM orders;
	
SELECT * FROM products ORDER BY id;
	
INSERT INTO orders_detail (id_product, id_order, price, quantity)
VALUES ('P0001', 1, 1000, 2),
	('P0002', 1, 1000, 2),
	('P0003', 1, 1000, 2);
	
INSERT INTO orders_detail (id_product, id_order, price, quantity)
VALUES ('P0004', 2, 1000, 2),
	('P0006', 2, 1000, 2),
	('P0007', 2, 1000, 2);
	
INSERT INTO orders_detail (id_product, id_order, price, quantity)
VALUES ('P0001', 3, 1000, 2),
	('P0004', 3, 1000, 2),
	('P0005', 3, 1000, 2);
	
SELECT * FROM orders_detail;
	
-- Melihat data order, detail dan product-nya
SELECT *
FROM orders
	JOIN orders_detail ON orders_detail.id_order = orders.id
	JOIN products ON orders_detail.id_product = products.id;
	
SELECT *
FROM orders
	JOIN orders_detail ON orders_detail.id_order = orders.id
	JOIN products ON orders_detail.id_product = products.id
WHERE orders.id = 3; -- Implementasi many to many
	
/* Jenis-Jenis JOIN */
''' Jenis-jenis JOIN:
1. INNER JOIN
2. LEFT JOIN
3. RIGHT JOIN
4. FULL JOIN '''
	
-- INNER JOIN (defaultnya sql, seperti yang sudah dilakukan sebelumnya)

INSERT INTO categories (id, name)
VALUES ('C0003', 'Gadget'),
	('C0004', 'Laptop'),
	('C0005', 'Pulsa');
	
SELECT *
FROM categories;
	
SELECT *
FROM products;
	
INSERT INTO products(id, name, price, quantity)
VALUES ('X0001', 'Contoh 1', 10000, 100),
	('X0002', 'Contoh 2', 10000, 100);
	
SELECT *
FROM categories
	INNER JOIN products ON products.id_category = categories.id;
	
-- LEFT JOIN, yang diambil adalah semua data di tabel pertama dan tabel kedua yang berelasi
SELECT *
FROM categories
	LEFT JOIN products ON products.id_category = categories.id;
	
-- RIGTH JOIN, yang diambil adalah semua data di tabel kedua dan tabel pertama yang berelasi
SELECT *
FROM categories
	RIGHT JOIN products ON products.id_category = categories.id;
	
-- FULL JOIN, semua data di tabel pertama dan kedua ditampilkan
SELECT *
FROM categories
	FULL JOIN products ON products.id_category = categories.id;
	
/* Subqueries */

-- Melakukan subquery di WHERE Clause
SELECT *
FROM products
WHERE price > (SELECT AVG(price) FROM products); -- subquery pada WHERE
	
-- Melakukan subquery di FROM Clause
SELECT MAX(price)
FROM (SELECT products.price AS price
	FROM categories
		JOIN products ON products.id_category = categories.id) AS contoh; -- subquery pada FROM

/* Set Operator */
''' Note: PostgreSQL mendukung operator Set, dimana ini adalah operasi antara
hasil dari dua SELECT query. Ada banyak jenis operator Set, yaitu:
1. UNION
2. UNION ALL
3. INTERSECT, dan
4. EXCEPT '''
	
-- Membuat table Guest Book
CREATE TABLE guestbooks
(
	id SERIAL NOT NULL,
	email VARCHAR(100) NOT NULL,
	title VARCHAR(100) NOT NULL,
	content TEXT,
	PRIMARY KEY (id)
);
	
INSERT INTO guestbooks(email, title, content)
VALUES ('eko@pzn.com', 'feedback eko', 'ini feedback eko'),
	('eko@pzn.com', 'feedback eko', 'ini feedback eko'),
	('budi@pzn.com', 'feedback budi', 'ini feedback budi'),
	('rully@pzn.com', 'feedback rully', 'ini feedback rully'),
	('tono@pzn.com', 'feedback tono', 'ini feedback tono'),
	('tono@pzn.com', 'feedback tono', 'ini feedback tono');

SELECT *
FROM guestbooks;
	
-- UNION
''' Note: UNION adalah operasi menggabungkan dua buah SELECT query, dimana
jika terdapat data yang duplikat, data duplikatnya akan dihapus dari hasil query '''

-- Melakukan query UNION
SELECT DISTINCT email
FROM customer
UNION
SELECT DISTINCT email
FROM guestbooks;
	
-- UNION ALL
''' Note: UNION ALL adalah operasi yang sama dengan UNION, namun data duplikat
tetap akan ditampilkan di hasil query nya '''

-- Melakukan query UNION ALL
SELECT DISTINCT email
FROM customer
UNION ALL
SELECT DISTINCT email
FROM guestbooks;
	
SELECT email
FROM customer
UNION ALL
SELECT email
FROM guestbooks;
	
	
SELECT email, COUNT(email)
FROM (SELECT DISTINCT email
	 FROM customer
	 UNION ALL
	 SELECT DISTINCT email
	 FROM guestbooks) AS contoh
GROUP BY email;
	
-- INTERSECT
''' Note: Operasi menggabungkan 2 query, namun yang diambil hanya data yang
terdapat pada hasil query pertama dan query kedua. Data yang hanya ada
di salah satu query, akan dihapus di hasil di hasil operasi QUERY. Data nya
muncul tidak dalam keadaan duplikat '''

-- Melakukan INTERSECT
SELECT email
FROM customer
INTERSECT
SELECT email
FROM guestbooks;
	
SELECT DISTINCT email
FROM customer
INTERSECT
SELECT DISTINCT email
FROM guestbooks; -- hasil sama dengan query sebelumnya
	
-- EXCEPT
''' Note: Operasi dimana query pertama akan dihilangkan oleh query kedua.
Artinya jika ada data di query pertama yang sama dengan data yang ada di query
kedua, maka data tersebut akan dihapus dari hasil query EXCEPT '''

SELECT email
FROM customer
EXCEPT
SELECT email
FROM guestbooks;
	
SELECT DISTINCT email
FROM customer
EXCEPT
SELECT DISTINCT email
FROM guestbooks; -- hasil sama dengan query sebelumnya
	
/* Transaction */
''' Note: Database transaction adalah fitur di DBMS dimana kita bisa memungkinkan
beberapa perintah dianggap menjadi sebuah kesatuan perintah yang kita sebut
transaction. Jika terdapat satu saja proses gagal di transaction, maka secara
otomatis perintah-perintah sebelumnya akan dibatalkan. Jika sebuah transaction
sukses, maka semua perintah akan dipastikan sukses '''

-- Transaction di PostgreSQL
''' Perintah-perintah transaction di PostgreSQL:
1. START TRANSACTION: memulai proses transaksi, proses selanjutnya akan dianggap
	transaksi sampai perintah COMMIT atau ROLLBACK
2. COMMIT: menyimpan secara permanen seluruh proses transaksi
3. ROLLBACK: membatalkan secara permanen seluruh proses transaksi '''

''' Yang tidak bisa menggunakan Transaction:
1. Perintah DDL (Data Definition Language) tidakbisa menggunakan fitur transaction
2. DDL adalah perintah-perintah yang digunakan untuk merubah struktur, seperti
	membuat tabel, menambahkan kolom, menghapus tabel, menghapus database, dan
	sejenisnya
3. Transaction hanya bisa dilakukan pada perintah DML (Data Manipulation Language),
	seperti operasi INSERT, UPDATE, dan DELETE '''
	
START TRANSACTION;
	
INSERT INTO guestbooks(email, title, content)
VALUES ('transaction@pzn.com', 'transaction', 'transaction');

INSERT INTO guestbooks(email, title, content)
VALUES ('transaction@pzn.com', 'transaction', 'transaction 2');
	
INSERT INTO guestbooks(email, title, content)
VALUES ('transaction@pzn.com', 'transaction', 'transaction 3');

INSERT INTO guestbooks(email, title, content)
VALUES ('transaction@pzn.com', 'transaction', 'transaction 4');	
	
INSERT INTO guestbooks(email, title, content)
VALUES ('transaction@pzn.com', 'transaction', 'transaction 5');
	
SELECT * FROM guestbooks;
	
COMMIT; -- disimpan permanen
	
START TRANSACTION;
	
INSERT INTO guestbooks(email, title, content)
VALUES ('transaction@pzn.com', 'transaction', 'rollback');

INSERT INTO guestbooks(email, title, content)
VALUES ('transaction@pzn.com', 'transaction', 'rollback 2');
	
INSERT INTO guestbooks(email, title, content)
VALUES ('transaction@pzn.com', 'transaction', 'rollback 3');

INSERT INTO guestbooks(email, title, content)
VALUES ('transaction@pzn.com', 'transaction', 'rollback 4');	
	
INSERT INTO guestbooks(email, title, content)
VALUES ('transaction@pzn.com', 'transaction', 'rollback 5');
	
SELECT * FROM guestbooks;
	
ROLLBACK; -- menghapus permanen
	
/* Locking */
''' Note: looking adalah proses mengunci data di DBMS. Proses mengunci data
sangat pentig dilakukan, salah satunya agar data benar-benar terjamin konsistensinya.
Karena pada kenyataannya, aplikasi yang akan kita buat pasti digunakan oleh
banyak pengguna, dan banyak pengguna tersebut bisa saja akan mengakses data yang
sama, jika tidak ada proses locking, bisa dipastikan akan terjadi RACE
CONDITION, yaitu proses balapan ketika mengubah data yang sama '''

-- Locking record
''' Note: Saat kita melakukan proses TRANSACTION, lalu kita melakukan proses perubahan
data, data yang kita ubah tersebut akan secara otomatis di LOCK. Hal ini membuat
proses TRANSACTION sangat aman. Oleh karena itu, sangat disarankan untuk selalu
menggunakan fitur TRANSACTION ketika memanipulasi data di database, terutama ketika perintah
manipulasinya lebih dari satu kali. Locking ini akan membuat sebuah perubahan
yang dilakukan oleh pihak lain akan diminta untuk menunggu. Data akan di lock
sampai kita melakukan COMMIT atau ROLLBACK transaksi berikut '''

-- Update description untuk id P0001 pada tabel products
	
SELECT * 
FROM products;

START TRANSACTION;

UPDATE products
SET description = 'Mie ayam original enak'
WHERE id = 'P0001'; -- user lain tidak bisa mengubah apapun sebelum TRANSACTION ini diakhiri dengan COMMIT atau ROLLBACK. Karena sudah di lock. Jadi mereka harus menunggu
	
SELECT *
FROM products
WHERE id = 'P0001'; 
	
COMMIT;
	
-- Locking record manual
''' Note: selain secara otomatis, kadang saat kita membuat aplikasi, kita juga sering
melakukan SELECT query terlebih dahulu sebelum melakukan proses UPDATE misalnya.
Jika kita ingin melakukan locking sebuah data secara manual, kita bisa tambahkan 
perintah FOR UPDATE di belakang query SELECT. Saat kita lock record yang kita
select, maka jika ada proses lain diminta menunggu sampai kita selesai melakukan
COMMIT atau ROLLBACK transaction. '''
	
START TRANSACTION;
	
SELECT *
FROM products
WHERE id = 'P0001'
FOR UPDATE; -- FOR UPDATE utuk mengunci data. Menghindari jika user lain melakukan UPDATE data sebelum kita memulai UPDATE
	
ROLLBACK;
	
SELECT *
FROM products
WHERE id = 'P0001';
	
-- Deadlock
''' Note: Saat kita terlalu banyak melakukan proses locking. Hati-hati akan masalah
yang bisa terjadi, yaitu DEADLOCK. Deadlock adalah situasi ada 2 proses yang saling
menunggu satu sama lain, namun data yang ditunggu dua-duanya di lock oleh proses 
lainnya, sehingga proses menunggunya ini tidak akan pernah selesai '''

''' Contoh Deadlock:
- Proses 1 melakukan SELECT FOR UPDATE untuk data 001
- Proses 2 melakukan SELECT FOR UPDATE untuk data 002
- Proses 1 melakukan SELECT FOR UPDATE untuk data 002, diminta menunggu karena
	di lock oleh Proses 2
- Proses 2 melakukan SELECT FOR UPDATE untuk data 001, diminta menunggu karena
	di lock oleh Proses 1
- Akhirnya Proses 1 dan Proses 2 saling menunggu
- Deadlock terjadi '''

START TRANSACTION;
	
SELECT *
FROM products
WHERE id = 'P0001' FOR UPDATE;
	
SELECT *
FROM products
WHERE id = 'P0002' FOR UPDATE; -- Ketika terjadi deadlock, PostgreSQL secara otomatis akan menghentikan salah satunya
	
ROLLBACK;
	
/* Schema */
''' Note: Diawal, kita mengibaratkan bahwa database adalah sebuah folder, 
dan table adalah file-filenya. Di PostgreSQL, terdapat fitur bernama Schema,
anggap saja ini adalah folder didalam database. Saat kita membuat database,
secara tidak sadar sebenarnya kita menyimpan semua table kita di schema publik.
Kita bisa membuat schema lain, dan pada schema yang berbeda, kita bisa membuat
table dengan nama yang sama '''

-- Public schema
''' Note: saat kita membuat database di PostgreSQL, secara otomatis terdapat
schema bernama public. Dan saat kita membuat table, secara otomatis kita akan
membuat table tersebut di schema public '''
	
-- Melihat schema saat ini
SELECT current_schema(); -- cara 1
	
SHOW search_path; -- cara 2
	
-- Membuat dan menghapus schema
CREATE SCHEMA contoh; 
	
DROP SCHEMA contoh; -- hati-hati saat menghapus schema, karena otomatis tabel-tabel didalamnya ikut kehapus. Sama seperti ketika menghapus folder, otomatis file-file didalamnya ikut terhapus

-- Pindah schema
SET search_path TO contoh;

SHOW search_path;
	
SELECT current_schema();
	
-- Membuat table di schema
''' Note: Saat kita membuat table, secara otomatis PostgreSQL akan membuatkan
table di schema yang sedang kita pilih. Jika kita ingin menentukan schema secara
manual tanpa menggunakan schema yang sedang dipilih, kita bisa menambahkan prefix
nama schema di awal nama table nya. Misal namaschema.namatable. Termasuk jika
ingin melakukan operasi DML ke table, bisa menggunakan prefix namaschema '''

SELECT *
FROM public.products;
	
-- Membuat table
CREATE TABLE contoh.products
(
	id SERIAL NOT NULL,
	name VARCHAR(100) NOT NULL,
	PRIMARY KEY (id)
);
	
SELECT *
FROM products; -- karena kita sudah memilih schema contoh, maka tabel yang ditampilkan adalah tabel products dari schema contoh

SET search_path TO public; -- pindah ke schema public	

INSERT INTO contoh.products(name)
VALUES ('iPhone'),
	('Play Stasion');
	
SELECT *
FROM contoh.products;
	
/* User Management */

-- Root User
''' Note: Secara default, PostgreSQL membuat user utama sebagai super administrator.
Namun best practice nya, saat kita menjalankan PostgreSQL dengan aplikasi yang
kita buat, sangat disarankan tidak menggunakan user utama. Lebih baik kita buat
user khusus untuk tiap aplikasi, bahkan kita bisa batasi hak akses user tersebut,
seperti hanya bisa melakukan SELECT, dan tidak boleh melakukan INSERT, UPDATE, atau
DELETE '''

-- Hak akses dan user
''' Note: dalam user management PostgreSQL, kita akan mengenal istilah Hak
Akses dari User '''
	
-- Membuat / menghapus user
CREATE ROLE eko;
CREATE ROLE budi;

DROP ROLE eko;
DROP ROLE budi;
	
-- Menambah option ke user
ALTER ROLE eko LOGIN PASSWORD 'rahasia';
ALTER ROLE budi LOGIN PASSWORD 'rahasia';
	
-- Daftar hak akses
''' Note: setelah membuat user / role, kita bisa menambahkan hak akses ke user
tersebut, lihat dokumentasinya dengan search di web grant postgresql. Dan kita
juga bisa menghapus hak akses yang sudah kita berikan ke user, dokumentasinya
search di web revoke postgresql '''
	
-- Menambah / menghapus hak akses ke user
GRANT INSERT, UPDATE, SELECT ON ALL TABLES IN SCHEMA public TO eko; -- menambah hak akses ke eko
GRANT USAGE, SELECT, UPDATE ON guestbooks_id_seq TO eko;
GRANT INSERT, UPDATE, SELECT ON customer TO budi;
	
REVOKE INSERT, UPDATE, SELECT ON customer FROM budi; -- menghapus hak akses ke budi

/* Backup Database */
	
-- Melakukan backup database
'''pg_dump --host=localhost --port=5432 --dbname=belajar --username=postgres --format=plain --file=D:\PostgreSQL\backup.sql --password''' -- ketik di terminal
	
/* Restore Database */

-- Membuat database untuk restore
CREATE DATABASE belajar_restore;
	
-- Restore database
''' psql --host=localhost --port=5432 --dbname=belajar_restore --username=postgres --password --file=D:\PostgreSQL\backup.sql ''' -- ketik di terminal
	
