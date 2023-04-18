import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UserImageWidget extends StatelessWidget {
  const UserImageWidget({
    Key? key,
    this.imageUrl,
    this.size = 100,
  }) : super(key: key);

  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Lottie.asset('assets/lotties/home_lottie.json', ),
      // child: ClipRRect(
      //   borderRadius: const BorderRadius.all(Radius.circular(100)),
      //   child: imageUrl != null
      //       ? Image.network(
      //           imageUrl!,
      //           fit: BoxFit.cover,
      //         )
      //       : FittedBox(
      //           fit: BoxFit.contain,
      //           child: Icon(
      //             Icons.person,
      //             color: Theme.of(context).colorScheme.secondary,
      //           ),
      //         ),
      // ),
    );
  }
}
