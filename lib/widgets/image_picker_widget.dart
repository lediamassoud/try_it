import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  final String label;
  final File? image;
  final Function(File) onImageSelected;
  final IconData icon;

  const ImagePickerWidget({
    Key? key,
    required this.label,
    required this.image,
    required this.onImageSelected,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showImageSourceDialog(context),
          child: image == null
              ? _buildPlaceholder()
              : _buildImageDisplay(),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 48,
          color: Colors.purple[300],
        ),
        SizedBox(height: 12),
        Text(
          'Tap to add $label',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.purple[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Camera or Gallery',
            style: TextStyle(
              fontSize: 12,
              color: Colors.purple[700],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageDisplay() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            image!,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: Icon(Icons.edit, color: Colors.white, size: 20),
              onPressed: () => _showImageSourceDialog(null),
            ),
          ),
        ),
      ],
    );
  }

  void _showImageSourceDialog(BuildContext? context) {
    showModalBottomSheet(
      context: context ?? navigatorKey.currentContext!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Image Source',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSourceOption(
                    context,
                    Icons.camera_alt,
                    'Camera',
                    ImageSource.camera,
                  ),
                  _buildSourceOption(
                    context,
                    Icons.photo_library,
                    'Gallery',
                    ImageSource.gallery,
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSourceOption(
    BuildContext context,
    IconData icon,
    String label,
    ImageSource source,
  ) {
    return GestureDetector(
      onTap: () async {
        Navigator.pop(context);
        await _pickImage(source);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.purple[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.purple),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.purple[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        onImageSelected(File(pickedFile.path));
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}

// Add this global key for navigation
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
