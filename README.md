<h1 align="center">
  📦Cardboard📦
</h1>
<p align="center">
  Inventory made easy. Built with Flutter leveraging Material UI.
</p>


## 📃Table of Contents📃

- [Tugas 7](#tugas-7)
    - [Langkah-langkah Implementasi](#langkah-langkah-implementasi-tugas-7)
    - [Stateless vs. Stateful Widget](#stateless-vs-stateful-widget)
    - [Widget yang Digunakan dan Fungsinya](#widget-yang-digunakan-dan-fungsinya-masing-masing)

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
