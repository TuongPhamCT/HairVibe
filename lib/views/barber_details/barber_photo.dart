import 'package:flutter/material.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';

class BarberPhotoTab extends StatelessWidget {
  const BarberPhotoTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> urls = [
      'https://example.com/image1.jpg',
      'https://example.com/image2.jpg',
      // Add more URLs as needed
    ];

    List<Widget> widgets = urls.map((url) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            url,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Image(image: AssetImage(AssetHelper.barberAvatar));
            },
          ),
        ),
      );
    }).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = (constraints.maxWidth / 200).floor();

        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Photos',
                    style: TextDecor.nameBarberBook,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "(${urls.length})",
                    style: TextDecor.nameBarberBook.copyWith(
                      color: Palette.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: widgets.length,
                  itemBuilder: (context, index) {
                    return widgets[index];
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
