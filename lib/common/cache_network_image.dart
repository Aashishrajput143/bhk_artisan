import 'package:bhk_artisan/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class AvatarWithBlurHash {
  Widget circleAvatarWithBlurHash({required String blurHash, String? imageUrl, double radius = 70}) {
    return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[200],
        child: ClipOval(
            child: SizedBox(
                width: radius * 2,
                height: radius * 2,
                child: (imageUrl == null || imageUrl.isEmpty)
                    ? BlurHash(hash: blurHash, imageFit: BoxFit.cover)
                    : CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        width: radius * 2,
                        height: radius * 2,
                        placeholder: (context, url) => BlurHash(hash: blurHash, imageFit: BoxFit.cover),
                        errorWidget: (context, url, error) => BlurHash(hash: blurHash, imageFit: BoxFit.cover),
                      ))));
  }

  Widget avatarWithBlurHash({required String blurHash, String? imageUrl, double? width, double? height, BoxFit fit = BoxFit.cover, BorderRadius? borderRadius,String? defaultImage}) {
    return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        child: Container(
            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12.0)),
            width: width,
            height: height,
            child: (imageUrl == null || imageUrl.isEmpty)
                ? BlurHash(hash: blurHash, imageFit: fit)
                : CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: fit,
                    width: width,
                    height: height,
                    placeholder: (context, url) => BlurHash(hash: blurHash, imageFit: fit),
                    errorWidget: (context, url, error) => Image.asset(defaultImage??appImages.profile, fit: fit),
                  )));
  }
}