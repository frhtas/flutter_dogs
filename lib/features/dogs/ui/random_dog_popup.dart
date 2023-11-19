import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/assets.dart';
import '../bloc/dogs_bloc.dart';

class RandomDogPopup extends StatelessWidget {
  const RandomDogPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: BlocConsumer<DogsBloc, DogsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DogsRandomImageSuccessful && state.imageUrl.isNotEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: state.imageUrl,
                    placeholder: (context, url) => Container(
                      height: 256,
                      width: 256,
                      color: Colors.grey[300],
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 256,
                      width: 256,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Text(
                          'Can not generate a random image! Please try again...',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    fit: BoxFit.cover,
                    height: 256,
                    width: 256,
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Image.asset(Assets.close, height: 16, width: 16),
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
