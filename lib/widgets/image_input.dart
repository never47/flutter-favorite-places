import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({
    required this.onPickImage,
    super.key,
  });

  final void Function(File) onPickImage;

  @override
  State<ImageInput> createState() {
    return _ImageInput();
  }
}

class _ImageInput extends State<ImageInput> {
  File? _takenImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _takenImage = File(pickedImage.path);
    });

    widget.onPickImage(_takenImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      icon: const Icon(Icons.camera),
      label: const Text(
        'Take Picture',
      ),
    );

    if (_takenImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _takenImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}
