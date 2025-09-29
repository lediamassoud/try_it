import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../services/bmad_service.dart';

class TryOnButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        final bool canTryOn = provider.personImage != null && 
                             provider.clothingImage != null;

        return Container(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: canTryOn && !provider.isProcessing
                ? () => _performTryOn(context, provider)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              elevation: 8,
              shadowColor: Colors.purple.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: provider.isProcessing
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Processing...', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : Text(
                    'Try On Clothing',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Future<void> _performTryOn(BuildContext context, AppProvider provider) async {
    try {
      provider.setProcessing(true);
      
      final bmadService = BMADService();
      final result = await bmadService.performVirtualTryOn(
        personImage: provider.personImage!,
        clothingImage: provider.clothingImage!,
        clothingType: provider.selectedClothingType,
      );

      if (result != null) {
        provider.setResultImage(result);
      } else {
        _showErrorDialog(context, 'Failed to process the try-on. Please try again.');
      }
    } catch (e) {
      _showErrorDialog(context, 'An error occurred: ${e.toString()}');
    } finally {
      provider.setProcessing(false);
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
