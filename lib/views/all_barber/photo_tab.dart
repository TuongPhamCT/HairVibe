import 'package:flutter/material.dart';
import 'package:hairvibe/Singletons/barber_singleton.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/config/asset_helper.dart';

class PhotosBarberTab extends StatelessWidget {
  const PhotosBarberTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> urls = BarberSingleton.getInstance().getBarberImageUrls();
    List<Widget> widgets = urls.map((url) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 150,
          height: 150,
          child: Image.network(
            url,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
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

    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
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
          const SizedBox(height: 20),
          SizedBox(
            height: 450,
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: widgets,
            ),
          ),
        ],
      ),
    );
  }
}
