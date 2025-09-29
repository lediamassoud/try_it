import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/image_picker_widget.dart';
import '../widgets/clothing_type_selector.dart';
import '../widgets/try_on_button.dart';
import '../widgets/result_display.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Virtual Try-On',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              context.read<AppProvider>().resetApp();
            },
          ),
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          if (provider.resultImage != null) {
            return ResultDisplay();
          }
          
          return SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Step 1: Select Your Photo'),
                SizedBox(height: 10),
                ImagePickerWidget(
                  label: 'Your Photo',
                  image: provider.personImage,
                  onImageSelected: provider.setPersonImage,
                  icon: Icons.person,
                ),
                SizedBox(height: 30),
                
                _buildSectionTitle('Step 2: Choose Clothing Type'),
                SizedBox(height: 10),
                ClothingTypeSelector(),
                SizedBox(height: 30),
                
                _buildSectionTitle('Step 3: Select Clothing Item'),
                SizedBox(height: 10),
                ImagePickerWidget(
                  label: 'Clothing Item',
                  image: provider.clothingImage,
                  onImageSelected: provider.setClothingImage,
                  icon: Icons.checkroom,
                ),
                SizedBox(height: 40),
                
                TryOnButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
