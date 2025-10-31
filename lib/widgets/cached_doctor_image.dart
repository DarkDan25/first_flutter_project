import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedDoctorImage extends StatelessWidget {
  final String imageUrl;
  final String localAsset;
  final double width;
  final double height;

  const CachedDoctorImage({
    Key? key,
    required this.imageUrl,
    required this.localAsset,
    this.width = 60,
    this.height = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) => CircleAvatar(
        radius: width / 2,
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.medical_services, color: Colors.grey[600]),
      ),
      errorWidget: (context, url, error) => CircleAvatar(
        radius: width / 2,
        backgroundColor: Colors.grey[300],
        child: Image.asset(
          localAsset,
          width: width - 10,
          height: height - 10,
        ),
      ),
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: width / 2,
        backgroundImage: imageProvider,
      ),
    );
  }
}