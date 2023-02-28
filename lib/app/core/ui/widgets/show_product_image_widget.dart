// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:delivery_app_dw9/app/core/ui/styles/colors_app.dart';
import 'package:flutter/material.dart';

class ShowProductImageWidget extends StatelessWidget {
  final String urlImage;
  final double? width;
  final double? height;

  const ShowProductImageWidget(
      {super.key, required this.urlImage, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/lanche.png",
      width: width ?? 100,
      height: height ?? 100,
      fit: BoxFit.cover,
    );
    //     FadeInImage.assetNetwork(
    //   placeholder: "assets/images/loading.gif",
    //   width: width ?? 100,
    //   height: height ?? 100,
    //   image: "$urlImage+1",
    //   fit: BoxFit.cover, b
    //   fadeInDuration: const Duration(milliseconds: 5),
    //   fadeOutDuration: const Duration(milliseconds: 5),
    //   imageErrorBuilder: (c, o, s) => Image.asset("assets/images/lanche.png"),
    // );
    // CachedNetworkImage(
    //   repeat: ImageRepeat.repeat,
    // width: width ?? 100,
    // height: height ?? 100,
    //   imageUrl: urlImage,
    //   placeholder: (context, url) => CircularProgressIndicator(
    //     color: context.colors.secondary,
    //     strokeWidth: 2,
    //   ),
    //   errorWidget: (context, error, stackTrace) {
    //     return const Center(
    //       child: Icon(
    //         Icons.error_outline,
    //         color: Colors.red,
    //       ),

    //     );

    //   },
    // );
  }
}
