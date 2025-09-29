// providers/app_provider.dart
import 'dart:io';
import 'package:flutter/foundation.dart';

class AppProvider with ChangeNotifier {
  File? _personImage;
  File? _clothingImage;
  String _selectedClothingType = 'dress';
  bool _isProcessing = false;
  File? _resultImage;

  File? get personImage => _personImage;
  File? get clothingImage => _clothingImage;
  String get selectedClothingType => _selectedClothingType;
  bool get isProcessing => _isProcessing;
  File? get resultImage => _resultImage;

  void setPersonImage(File image) {
    _personImage = image;
    notifyListeners();
  }

  void setClothingImage(File image) {
    _clothingImage = image;
    notifyListeners();
  }

  void setClothingType(String type) {
    _selectedClothingType = type;
    notifyListeners();
  }

  void setProcessing(bool processing) {
    _isProcessing = processing;
    notifyListeners();
  }

  void setResultImage(File image) {
    _resultImage = image;
    notifyListeners();
  }

  void resetApp() {
    _personImage = null;
    _clothingImage = null;
    _resultImage = null;
    _isProcessing = false;
    notifyListeners();
  }
}
