import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedDoctorImage extends StatelessWidget {
  final String imageUrl;

  const CachedDoctorImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context){
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) {
        print('Ошибка загрузки изображения: $error');
        print('URL: $url');
        return CircleAvatar(
          backgroundColor: Colors.grey[300],
          child: Icon(
            Icons.medical_services,
            color: Colors.grey[600],
          ),
        );
      },
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: 50,
        backgroundImage: imageProvider,
      ),
    );
  }
}