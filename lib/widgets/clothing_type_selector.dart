import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class ClothingTypeSelector extends StatelessWidget {
  final List<Map<String, dynamic>> clothingTypes = [
    {'type': 'dress', 'label': 'Dress', 'icon': Icons.woman},
    {'type': 'tshirt', 'label': 'T-Shirt', 'icon': Icons.checkroom},
    {'type': 'skirt', 'label': 'Skirt', 'icon': Icons.woman_2},
    {'type': 'pants', 'label': 'Pants', 'icon': Icons.man},
    {'type': 'shirt', 'label': 'Shirt', 'icon': Icons.person},
    {'type': 'jacket', 'label': 'Jacket', 'icon': Icons.checkroom_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: clothingTypes.length,
            itemBuilder: (context, index) {
              final item = clothingTypes[index];
              final isSelected = provider.selectedClothingType == item['type'];
              
              return Container(
                margin: EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => provider.setClothingType(item['type']),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: 80,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.purple : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item['icon'],
                          size: 32,
                          color: isSelected ? Colors.white : Colors.purple,
                        ),
                        SizedBox(height: 8),
                        Text(
                          item['label'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.purple[700],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
