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
- [Tugas 9](#📱tugas-9📱)
  - [Langkah-langkah Implementasi](#langkah-langkah-implementasi-tugas-9)
  - [Pengambilan Data JSON Tanpa Model](#apakah-data-json-dapat-diambil-tanpa-membuat-model-apakah-lebih-baik-daripada-membuat-model-terlebih-dahulu)
  - [CookieRequest](#cookierequest-dan-alasan-instance-cookierequest-perlu-untuk-dibagikan-ke-semua-komponen-aplikasi)
  - [Mekanisme Pengambilan Data dari JSON ke Flutter](#mekanisme-pengambilan-data-dari-json-hingga-dapat-ditampilkan-pada-flutter)
  - [Mekanisme Autentikasi Input Flutter-Django](#mekanisme-autentikasi-input-data-flutter---autentikasi-oleh-django---ditampilkan-pada-flutter)
  - [Widget yang Digunakan dan Fungsinya](#widget-flutter-yang-digunakan)

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
Saya membuat file baru dengan nama `boardlist_form.dart` dalam folder baru bernama screens di dalam direktori lib. `TextFormField` yang digunakan akan dibuat untuk menerima tiga elemen input: nama, jumlah, dan deskripsi.

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
<summary>Membuat drawer menu untuk navigasi.</summary>
  
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

### Navigator.push() vs. Navigator.pushReplacement()
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

### Widget Flutter yang Digunakan
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



## 📱Tugas 9📱
### langkah-langkah Implementasi Tugas 9
<details>
<summary>Membuat Custom Model</summary>

```
// To parse this JSON data, do
//
// final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  String model;
  int pk;
  Fields fields;

  Product({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  String name;
  DateTime dateAdded;
  int price;
  String description;

  Fields({
    required this.user,
    required this.name,
    required this.dateAdded,
    required this.price,
    required this.description,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        dateAdded: DateTime.parse(json["date_added"]),
        price: json["price"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "date_added":
            "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
        "price": price,
        "description": description,
      };
}
```
</details>
<details>
<summary>Integrasi Django dan Flutter</summary>

Setelah membuat django app bernama `authentication`, membuat method yang diperlukan, dan menambahkan routing, saya menjalankan command ini di terminal pada project flutter saya:

```
flutter pub add provider
flutter pub add pbp_django_auth
```
Kemudian memodifikasi root widget untuk menyediakan `CookieRequest` library ke semua child widgets dengan menggunakan `Provider` sebagai berikut

```
class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Provider(
            create: (_) {
                CookieRequest request = CookieRequest();
                return request;
            },
            child: MaterialApp(
                title: 'Flutter App',
                theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
                    useMaterial3: true,
                ),
                home: MyHomePage()
            ),
       ),
    }
}
```
</details>
<details>
<summary>Membuat Login Page</summary>

Setelah menyelesaikan integrasi, saya membuat page baru bernama `login.dart` sebagai login page dari app ini:
    <details>
    <summary> login.dart setelah styling </summary>
    
    ```
import 'package:cardboard/screens/menu.dart';
import 'package:cardboard/screens/register.dart';
import 'package:cardboard/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colorz.darkgreen,
        foregroundColor: Colorz.pink,
      ),
      backgroundColor: Colorz.darkgreen,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight / 2,
              decoration: BoxDecoration(
                color: Colorz.beigebg, // color of the bottom sheet
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight / 3.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // change the icon based on the password visibility
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          // password visibility state
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    obscureText: !_passwordVisible, // Toggle
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        // action for forgot password
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colorz.ashbrown,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18.0),
                ElevatedButton(
                  onPressed: () async {
                    String username = _usernameController.text;
                    String password = _passwordController.text;

                    // Cek kredensial
                    final response = await request
                        .login("http://127.0.0.1:8000/auth/login/", {
                      'username': username,
                      'password': password,
                    });

                    if (request.loggedIn) {
                      String message = response['message'];
                      String uname = response['username'];
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            content: Text("$message Welcome, $uname.")));
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Login Failed'),
                          content: Text(response['message']),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colorz.avogreen,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(385, 50),
                    backgroundColor: Colorz.black,
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterPage()), // Navigate to RegisterPage
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colorz.ashbrown,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Don't have an account yet? ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colorz.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
    ```
  </details>
  Kemudian, mengubah `home: MyHomePage()` menjadi `home: LoginPage()` agar memunculkan login page pertama kali ketika app di run.
</details>
<details>
<summary>Menampikan Product List (Fetch Data dari Django)</summary>

Pertama, saya menjalankan command `flutter pub add http`. Kemudian, pada file baru di lib/screens bernama ` product_list.dart`, saya menambahkan code untuk menampilkan list dari product yang sudah di-input:
  <details>
  <summary>product_list.dart sebelum styling</summary>

  ```
  ...
import 'package:<APP_NAME>/widgets/left_drawer.dart';

class ProductPage extends StatefulWidget {
    const ProductPage({Key? key}) : super(key: key);

    @override
    _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
Future<List<Product>> fetchProduct() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'http://<URL_APP_KAMU>/json/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Product> list_product = [];
    for (var d in data) {
        if (d != null) {
            list_product.add(Product.fromJson(d));
        }
    }
    return list_product;
}

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Product'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return const Column(
                        children: [
                        Text(
                            "Tidak ada data produk.",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
                } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                    "${snapshot.data![index].fields.name}",
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text("${snapshot.data![index].fields.price}"),
                                    const SizedBox(height: 10),
                                    Text(
                                        "${snapshot.data![index].fields.description}")
                                ],
                                ),
                            ));
                    }
                }
            }));
    }
}
  ```
  </details>
  Setelah itu, saya menambahkan page `product_list.dart` ke `left_drawer.dart` dan mengubah fungsi tombol `My Carboard`:

  ```
  // Kode ListTile Menu
...
ListTile(
    leading: const Icon(Icons.shopping_basket),
    title: const Text('Daftar Produk'),
    onTap: () {
        // Route menu ke halaman produk
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProductPage()),
        );
    },
),
...
  ```
</details>
<details>
<summary>Integrasi Form Add Item</summary>

Setelah membuat method baru pada `main/views.py` dan menyesuaikan routingnya, saya menghubungkan page `boardlist_form.dart` dengan `CookieRequest` dengan menambahkan baris kode berikut:

```
...
@override
Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
...
```
Lalu, saya mengubah `onPressed: () {...}` pada widget Inkwell menjadi `onPressed: () async {...}`.
</details>
<details>
<summary>Membuat Fitur Logout</summary>
Setelah membuat method dan routing di Django, saya menambahkan code berikut pada lib/widgets/shop_card.dart:

```
final request = context.watch<CookieRequest>();
```
Lalu, saya mengubah `onTap: () {...}` pada widget Inkwell menjadi `onTap: () async {...}` agar widget Inkwell dapat melakukan proses logout secara asinkronus.
</details>

### Apakah data JSON dapat diambil tanpa membuat model? Apakah lebih baik daripada membuat model terlebih dahulu?
Ya, memungkinkan untuk mengambil data JSON tanpa perlu membuat model terlebih dahulu. Namun, tidak disarankan karena pembuatan model dapat memberikan kemudahan dalam mengolah data JSON tersebut, mengubahnya menjadi bentuk class Dart, sehingga lebih mudah untuk diolah Dart. Mebuat model adalah good practice, terutama ketika menghandle data yang banyak.

### CookieRequest dan alasan instance CookieRequest perlu untuk dibagikan ke semua komponen aplikasi
CookieRequest dirancang untuk memproses informasi terkait cookies, memastikan bahwa pengguna tetap terautentikasi dan diizinkan untuk melakukan request ke backend. Instance CookieRequest perlu dibagikan ke seluruh komponen agar semua komponen memiliki "single source of truth", sehingga data dapat muncul secara konsisten di seluruh bagian sistem. Practice ini mendukung konsistensi data di berbagai tempat dalam aplikasi.

### Mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter
1. Membuat model yang sesuai dengan skema data JSON yang akan diambil.
2. Membuat request untuk mendapatkan data dari backend.
3. Backend akan memberikan respons dalam bentuk JSON yang sesuai dengan skema data yang telah ditentukan sebelumnya.
4. Model yang telah dibuat sebelumnya akan digunakan untuk memproses dan mengolah data respons dari backend.
5. Menggunakan ListView.Builder untuk menampilkan hasil olahan model dalam user interface Flutter.

### Mekanisme: autentikasi input data Flutter -> autentikasi oleh Django -> ditampilkan pada Flutter
1. User memasukkan kredensial pada tampilan Flutter.
2. Selanjutnya, aplikasi mengirimkan request ke backend Django.
3. Server Django melakukan validasi terhadap kredensial yang diterima dan menghasilkan respons.
4. Jika proses validasi berhasil, server Django memberikan cookies dan respons sukses, memungkinkan user masuk ke home page.
5. Jika validasi gagal, server Django tidak memberikan cookies dan user tidak dapat mengakses home page.

 ### Widget Flutter yang Digunakan
 Widget yang digunakan pada tugas sebelumnya masih digunakan. Berikut adalah widget yang baru digunakan pada tugas kali ini:
1. `ListView.Builder`: Widget ini digunakan untuk menampilkan child widget dalam daftar yang dapat di-scroll.
2. `ElevatedButton`: Widget untuk menampilkan button.
3. `SizedBox`: Widget box yang dapat diatur ukurannya, digunakan untuk menambahkan space di antara widget lainnya.
4. `IconButton`: Widget button yang berisi Icon.
5. `CircularProgressIndicator`: Widget ini menampilkan lingkaran yang berputar, biasanya ketika loading.
6. `ClipRRect`: Widget yang mengklip child-nya dengan persegi panjang bulat.
7. `FutureBuilder:` Widget yang digunakan untuk menangani data yang akan datang atau data yang diperoleh dari operasi yang memakan waktu seperti operasi jaringan. 