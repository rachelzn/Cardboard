import 'dart:convert';
import 'package:cardboard/styles/colors.dart';
import 'package:cardboard/styles/fonts.dart';
import 'package:cardboard/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:cardboard/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CardboardFormPage extends StatefulWidget {
  const CardboardFormPage({super.key});

  @override
  State<CardboardFormPage> createState() => _CardboardFormPageState();
}

class _CardboardFormPageState extends State<CardboardFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  String _description = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        /*
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colorz.black),
          onPressed: () {
            // Navigator.pop(context);
          },
        ),*/
        title: Text(
          'Add New Item',
          style: Fontz.B28,
        ),
        backgroundColor: Colorz.beigebg,
        foregroundColor: Colorz.black,
      ),
      backgroundColor: Colorz.beigebg,
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "name...",
                    labelText: "item name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "name cannot be blank!";
                    }
                    return null;
                  },
                ),
              ),
              /*const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "quantity...",
                    labelText: "quantity",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _price = int.parse(value!);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "quantity cannot be blank!";
                    }
                    if (int.tryParse(value) == null) {
                      return "quantity must be an integer!";
                    }
                    return null;
                  },
                ),
              ),*/
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "enter item description...",
                    labelText: "description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "description cannot be blank!";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_price > 0) {
                            _price--;
                          }
                        });
                      },
                      child: Icon(Icons.remove, color: Colorz.black),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.all(12.0),
                        primary: Colorz.avogreen,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(_price.toString(),
                          style: TextStyle(fontSize: 18.0)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _price++;
                        });
                      },
                      child: Icon(Icons.add, color: Colorz.black),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: EdgeInsets.all(12.0),
                        primary: Colorz.avogreen,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colorz.black),
                      minimumSize: MaterialStateProperty.all(Size(380, 48)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Kirim ke Django dan tunggu respons
                        final response = await request.postJson(
                            "http://127.0.0.1:8000/create-flutter/",
                            jsonEncode(<String, String>{
                              'name': _name,
                              'price': _price.toString(),
                              'description': _description,
                            }));
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Product successfully saved."),
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("An error occured, please try again."),
                          ));
                        }
                        _formKey.currentState!.reset();
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colorz.avogreen),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
