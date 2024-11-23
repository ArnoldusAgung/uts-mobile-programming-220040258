import 'package:flutter/material.dart';

void main() {
  runApp(const CountryApp());
}

class CountryApp extends StatelessWidget {
  const CountryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CountryHomePage(),
    );
  }
}

class Country {
  final String code;
  final String name;
  final String description;
  final String flagUrl;

  Country({
    required this.code,
    required this.name,
    required this.description,
    required this.flagUrl,
  });
}

class CountryHomePage extends StatefulWidget {
  const CountryHomePage({super.key});

  @override
  _CountryHomePageState createState() => _CountryHomePageState();
}

class _CountryHomePageState extends State<CountryHomePage> {
  final List<Country> _countries = [
    Country(
      code: "ID",
      name: "Indonesia",
      description:
          "Negara kepulauan terbesar di dunia dengan ribuan budaya dan tradisi.",
      flagUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Flag_of_Indonesia.svg/2560px-Flag_of_Indonesia.svg.png",
    ),
    Country(
      code: "US",
      name: "Amerika Serikat",
      description:
          "Negara dengan ekonomi terbesar di dunia dan beragam budaya.",
      flagUrl:
          "https://upload.wikimedia.org/wikipedia/en/thumb/a/a4/Flag_of_the_United_States.svg/1280px-Flag_of_the_United_States.svg.png",
    ),
  ];

  void _addCountry(Country country) {
    setState(() {
      _countries.add(country);
    });
  }

  void _updateCountry(int index, Country updatedCountry) {
    setState(() {
      _countries[index] = updatedCountry;
    });
  }

  void _deleteCountry(int index) {
    setState(() {
      _countries.removeAt(index);
    });
  }

  void _showCountryForm([int? index]) {
    final isEditing = index != null;
    final country = isEditing ? _countries[index!] : null;

    final codeController = TextEditingController(text: country?.code);
    final nameController = TextEditingController(text: country?.name);
    final descriptionController =
        TextEditingController(text: country?.description);
    final flagUrlController = TextEditingController(text: country?.flagUrl);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? "Edit Country" : "Add Country"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: codeController,
                decoration: const InputDecoration(labelText: "Kode Negara"),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nama Negara"),
              ),
              TextField(
                controller: descriptionController,
                decoration:
                    const InputDecoration(labelText: "Deskripsi Negara"),
              ),
              TextField(
                controller: flagUrlController,
                decoration:
                    const InputDecoration(labelText: "URL Gambar Bendera"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final newCountry = Country(
                code: codeController.text,
                name: nameController.text,
                description: descriptionController.text,
                flagUrl: flagUrlController.text,
              );

              if (isEditing) {
                _updateCountry(index!, newCountry);
              } else {
                _addCountry(newCountry);
              }
              Navigator.pop(context);
            },
            child: Text(isEditing ? "Update" : "Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Country Manager"),
      ),
      body: ListView.builder(
        itemCount: _countries.length,
        itemBuilder: (context, index) {
          final country = _countries[index];
          return Card(
            child: ListTile(
              leading: Image.network(country.flagUrl,
                  width: 50, height: 50, fit: BoxFit.cover),
              title: Text("${country.code} - ${country.name}"),
              subtitle: Text(country.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showCountryForm(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteCountry(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCountryForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
