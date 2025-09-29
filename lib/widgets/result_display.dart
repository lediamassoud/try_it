import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'dart:io';

class ResultDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => provider.resetApp(),
            ),
            title: Text(
              'Try-On Result',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.share, color: Colors.white),
                onPressed: () => _shareResult(context, provider.resultImage!),
              ),
              IconButton(
                icon: Icon(Icons.save_alt, color: Colors.white),
                onPressed: () => _saveResult(context, provider.resultImage!),
              ),
            ],
          ),
          body: Center(
            child: InteractiveViewer(
              child: Image.file(
                provider.resultImage!,
                fit: BoxFit.contain,
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(20),
            color: Colors.black87,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => provider.resetApp(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white24,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Try Another'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _shareResult(context, provider.resultImage!),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Share Result'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _shareResult(BuildContext context, File image) {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Share functionality would be implemented here')),
    );
  }

  void _saveResult(BuildContext context, File image) {
    // Implement save functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image saved to gallery')),
    );
  }
}
