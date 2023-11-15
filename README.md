<h1 align="center">
  📦Cardboard📦
</h1>
<p align="center">
  Inventory made easy. Built with Flutter leveraging Material UI.
</p>


## 📃Table of Contents📃

- [Tugas 7](#📱tugas-7📱)
  - [Langkah-langkah Implementasi](#langkah-langkah-implementasi-tugas-7)
  - [Stateless vs. Stateful Widget](#stateless-vs-stateful-widget)
  - [Widget yang Digunakan dan Fungsinya](#widget-yang-digunakan-dan-fungsinya-masing-masing)
- [Tugas 8](#📱tugas-8📱)
  - [Langkah-langkah Implementasi](#langkah-langkah-implementasi-tugas-8)
  - [Navigator.push() vs. Navigator.pushReplacement()](#navigatorpush-vs-navigatorpushreplacement)
  - [Layout Widget pada Flutter](#layout-widget-pada-flutter)
  - [Penerapan Clean Architecture pada Aplikasi Flutter](#penerapan-clean-architecture-pada-aplikasi-flutter)

## 📱Tugas 7📱

### Langkah-langkah Implementasi Tugas 7
<details>
<summary>Membuat Proyek Flutter Baru</summary>
Untuk membuat proyek flutter, saya memasukkan command ini di terminal
  
```
flutter create Cardboard #Cardboard adalah nama aplikasi
```
Saya melewati step enable web support karena sudah menggunakan iOS emulator XCode.
</details>
<details>
<summary>Merapikan Proyek dan Membuat Widget</summary>
  
Saya memindahkan beberapa baris kode dari `lib`/`main.dart` ke dalam file baru yang saya buat di dalam folder `lib` juga, `menu.dart`, untuk merapikan struktur proyek. Tidak lupa menambahkan kode berikut pada bagian paling atas file `menu.dart`:
  
```
import 'package:shopping_list/menu.dart';
```
Kemudian, saya mengganti `MyHomePage(title: 'Flutter Demo Home Page')` menjadi `MyHomePage()` pada file `main.dart` serta 
mengganti `({super.key, required this.title})` dengan `({Key? key}) : super(key: key);` dan menghapus `final String title;` pada file `menu.dart`. Saya juga menghapus fungsi `State` yang ada di bawah `MyHomePage`.
</details>
<details>
<summary>Membuat Tombol Sederhana dengan Icon dan Text</summary>
Saya men-define tipe-tipe dalam list sebagai berikut:
  
```
class CardboardItem {
  final String name;
  final IconData icon;
  final Color backgroundColor;

  CardboardItem(this.name, this.icon, this.backgroundColor);
}
```

Kemudian, saya membuat List berikut:

```
final List<CardboardItem> items = [
    CardboardItem("My Product", Icons.checklist, const Color(0xFFF28582)),
    CardboardItem("Add Product", Icons.add_shopping_cart, const Color(0xFF84A59E)),
    CardboardItem("Logout", Icons.logout, const Color(0xFFF5BD60)),
  ];
```

Setelah itu, saya menambahkan kode berikut di dalam `Widget` build:

```
return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cardboard',
        ),
      ),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'My Cardboard', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((CardboardItem item) {
                  // Iterasi untuk setiap item
                  return CardboardCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
```
</details>
<details>
<summary>Menampilkan Card dan Membuat Snackbar</summary>
Saya menambahkan widget stateless berikut untuk menampilkan card dan SnackBar:
  
```
class CardboardCard extends StatelessWidget {
  final CardboardItem item;
  const CardboardCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.backgroundColor,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```
</details>

### Stateless vs. Stateful Widget
| Atribut                   | Stateless Widget                                      | Stateful Widget                                        |
|---------------------------|-------------------------------------------------------|--------------------------------------------------------|
| **Perubahan Tampilan**    | Tidak berubah selama aplikasi berjalan.               | Dapat berubah berulang kali selama aplikasi berjalan.  |
| **Redrawn**               | Tidak dapat diperbarui.                               | Dapat diperbarui sebagai respons terhadap actions yang berbeda. |
| **Fleksibilitas**         | Kurang fleksibel karena sifatnya yang statis.         | Lebih fleksibel dan dapat beradaptasi dengan perubahan. |

### Widget yang digunakan dan fungsinya masing-masing
1. `MyApp` (Stateless Widget): Widget ini digunakan untuk menginisialisasi aplikasi. Widget ini mengembalikan MaterialApp yang merupakan widget Flutter bawaan yang menawarkan berbagai pengaturan untuk mengontrol tampilan dan perilaku aplikasi.

2. `MyHomePage` (Stateless Widget): Widget ini menentukan tampilan layar utama dengan mengatur tampilan yang terorganisir, termasuk top bar, area yang dapat di-scroll, judul, dan tata letak berbentuk grid untuk menampilkan sejumlah item (direpresentasikan oleh objek `CardboardItem`) sebagai widget `CardboardCard`.

3. `CardboardCard` (Stateless Widget): Widget ini mengatur tampilan satu item inventory dalam bentuk card, menampilkan icon dan nama item. Widget ini juga memungkinkan interaksi dengan merespon ketukan, menampilkan pesan singkat (SnackBar) tentang item tertentu ketika diklik.


## 📱Tugas 8📱

### Langkah-langkah Implementasi Tugas 8
<details>
<summary>Membuat Form 'Add Product'</summary>
Saya membuat file baru dengan nama boardlist_form.dart dalam folder baru bernama screens di dalam direktori lib. TextFormField yang digunakan akan dibuat untuk menerima tiga elemen input: nama, jumlah, dan deskripsi.

```
children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Product Name",
                    labelText: "Product Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Name cannot be empty!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Quantity",
                    labelText: "Quantity",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _amount = int.parse(value!);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Quantity cannot be empty!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Quantity must be a number!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Description",
                    labelText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Description cannot be empty!";
                    }
                    return null;
                  },
                ),
              ),

```
Kemudian, saya menambahkan tombol 'Save'.

```
child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFF8B3CA)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Product successfully saved'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name: $_name'),
                                    Text('Quantity: $_amount'),
                                    Text('Description: $_description'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        _formKey.currentState!.reset();
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
```
</details>

<details>
<summary>Mengarahkan user ke halaman form penambahan produk saat mengklik tombol 'Add Product' di Home Page.</summary>
Saya menambahkan kode berikut ke dalam `board_list.dart`:

```
// Navigate to the appropriate route (depending on the button type)
          if (item.name == "Add Product") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ShopFormPage()),
            );
          }
```
</details>

<details>
<summary>Menampilkan data dalam sebuah pop-up setelah mengklik tombol 'Save' di halaman 'Add Product'.</summary>
Saya menambahkan kode berikut ke dalam file `boardlist_form.dart` di dalam folder screens:

```
onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Product successfully saved'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name: $_name'),
                                    Text('Amount: $_amount'),
                                    Text('Description: $_description'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        _formKey.currentState!.reset();
                      }
                    },
```
</details>

<details>
<summary>Membuat drawer menu untuk navigasi</summary>
Saya membuat file baru bernama `left_drawer.dart` di dalam direktori `lib/widgets` dan menambahkan kode berikut:

```
import 'package:cardboard/screens/product_list.dart';
import 'package:flutter/material.dart';
import 'package:cardboard/globals.dart';
import 'package:cardboard/screens/menu.dart';
import 'package:cardboard/screens/boardlist_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFF8B3CA),
            ),
            child: Column(
              children: [
                Text(
                  'Cardboard',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Inventory made easy.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home Page'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text('My Product'),
            // Redirection to ProductList
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProductListPage(products: globalProductList)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Add Product'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CardboardFormPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

```
</details>

### Navigator.push() vs, Navigator.pushReplacement()
`Navigator.push()` berfungsi untuk menambahkan rute baru ke tumpukan navigasi, memungkinkan user untuk menavigasi ke halaman baru dan juga kembali ke halaman sebelumnya menggunakan tombol kembali atau mekanisme serupa. Berikut contoh impelementasinya:

```
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => MyHomePage(),
  ),
);
```

`Navigator.pushReplacement()` juga berfungsi untuk menambahkan rute baru, tetapi menggantikan rute (halaman) saat ini dalam tumpukan navigasi. Artinya, user tidak dapat kembali ke halaman sebelumnya karena halaman tersebut efektif dihapus dari tumpukan. Berikut contoh implementasinya:

```
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => MyHomePage(),
  ),
);
```

### Layout Widget pada Flutter
1. `Drawer`: Widget untuk membuat menu yang biasanya muncul dari sisi kiri layar.
2. `ListView`: Widget ini digunakan untuk menampilkan child widget dalam daftar yang dapat di-scroll.
3. `DrawerHeader`: Widget ini digunakan untuk menyimpan detail deskriptif seperti judul dan gambar.
4. `Column`: Widget ini digunakan untuk menumpuk widget dalam user interface dan mengaturnya secara vertikal.
5. `Text Widgets`: Widget yang digunakan untuk menampilkan dan styling teks dalam user interface.
6. `Padding`: Widget ini digunakan untuk menambahkan padding atau ruang kosong di sekitar child widget.
7. `Material`: Widget ini digunakan untuk membuat tampilan yang bagus dan interaktif dengan menambahkan bayangan dan efek gelombang, mengikuti gaya desain yang disebut Material Design.
8. `InkWell`: Widget ini digunakan untuk membuat widget merespons ketika disentuh.
9. `Container`: Widget yang menggabungkan widget umum untuk menggambar, menetapkan penempatan, dan menentukan ukuran.
10. `Center`: Widget ini digunakan untuk menempatkan child widget tepat di tengah, memastikan bahwa widget tersebut selaras secara horizontal dan vertikal.

### Elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!
Pada tugas kali ini, saya menggunakan elemen input teks, yaitu TextFormField, yang berfungsi sebagai field yang memungkinkan user memasukkan teks. Saya menggunakan elemen input ini karena adanya beberapa fitur berikut:

1. **Text Input Requirement**: Dalam banyak aplikasi, termasuk formulir, seringkali diperlukan user untuk memasukkan informasi berupa teks seperti nama, alamat, deskripsi, dan lainnya. TextFormField dirancang khusus untuk mengelola input teks, menjadikannya pilihan yang sesuai ketika kita perlu mengumpulkan data teks dari user.

2. **Built-In Validation**: TextFormField dilengkapi dengan kemampuan built-in validation, memungkinkan kita untuk menentukan aturan bagi data masukan. Saya dapat menentukan persyaratan seperti panjang minimum dan maksimum, input numerik, format email, dan lainnya. Hal ini memastikan bahwa data yang dimasukkan oleh user memenuhi kriteria yang diharapkan, mengurangi kemungkinan data yang salah dimasukkan.

3. **Error Handling**: Ketika seorang user memasukkan data yang tidak memenuhi kriteria validasi, TextFormField dapat secara otomatis menampilkan pesan kesalahan untuk membimbing user dalam memperbaiki masukan mereka. Ini sangat penting untuk memberikan pengalaman yang ramah userdan mencegah data yang salah diproses.

4. **Customization**: TextFormField menawarkan tingkat kustomisasi yang tinggi. Saya dapat menggaya sesuai desain aplikasi dan memberikan umpan balik visual kepada user. Saya juga dapat mengkustomisasi dan tindakan yang akan diambil saat terjadi peristiwa tertentu, memberikan kendali atas perilaku formulir tersebut.

5. **Integrasi dengan Widget `Form`**: Dalam Flutter, TextFormField sering digunakan dalam widget Form. Kombinasi ini mempermudah pengelolaan status formulir, termasuk pengiriman, validasi, dan pengaturan ulang bidang formulir. Ini membantu dalam mengorganisir dan mengelola elemen-elemen input dengan efektif.

### Penerapan Clean Architecture pada Aplikasi Flutter
Dalam Flutter, Clean Architecture melibatkan pengorganisasian kode ke dalam tiga lapisan (layer):
1. **Presentation Layer**: Layer ini berisi komponen-komponen user interface (UI) dan berkomunikasi dengan domain layer untuk mendapatkan data. Di sini, developer dapat mengatur tampilan dan berinteraksi dengan domain layer untuk mendapatkan data. Presentation layer ini bertanggung jawab atas tampilan dan interaksi dengan user.

2. **Domain Layer**: Layer ini mendefinisikan logika bisnis dan kasus user, menjaga independency dan reusability. Domain layer dirancang untuk berdiri sendiri tanpa tergantung pada detail implementasi atau teknologi tertentu.

3. **Data Layer**: Layer ini mengelola sumber data dan repositori. Data layer berperan sebagai perantara antara domain layer dan sumber data sebenarnya seperti database, API, atau penyimpanan lokal. Selain itu, layer ini dapat mengimplementasikan logika pemetaan data, caching, dan komunikasi dengan sumber data eksternal.

Penggunaan ketiga layer ini bertujuan untuk meningkatkan modularity, maintenance, dan testing dalam aplikasi. Hal ini rancang untuk meningkatkan skalabilitas kode dan kemampuan aplikasi untuk beradaptasi dengan perubahan.