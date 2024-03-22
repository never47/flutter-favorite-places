import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  const AddItemScreen({super.key});

  @override
  ConsumerState<AddItemScreen> createState() {
    return _AddItemScreen();
  }
}

class _AddItemScreen extends ConsumerState<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = '';
  File? _selectedImage;

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_selectedImage == null) {
        return;
      }

      ref.read(favoritePlacesProvider.notifier).addFavoritePlace(
            _enteredTitle,
            _selectedImage!,
          );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredTitle = value!;
                },
                decoration: const InputDecoration(labelText: 'Title'),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(height: 10),
              ImageInput(
                onPickImage: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: _saveItem,
                icon: const Icon(Icons.add),
                label: const Text('Add Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
