import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dogs/common/extensions/string_extension.dart';
import 'package:flutter_dogs/features/dogs/models/dog_model.dart';

import '../../../common/app_colors.dart';
import '../../../common/assets.dart';
import '../bloc/dogs_bloc.dart';
import 'random_dog_popup.dart';

class DogDetailPopup extends StatelessWidget {
  final DogModel dog;
  const DogDetailPopup({
    Key? key,
    required this.dog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: BlocConsumer<DogsBloc, DogsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: contextHeight * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Stack(
                children: [
                  Scaffold(
                    extendBodyBehindAppBar: true,
                    bottomSheet: GestureDetector(
                      onTap: () {
                        context
                            .read<DogsBloc>()
                            .add(DogsRandomImageEvent(breed: dog.breed));

                        showCupertinoModalPopup(
                          context: context,
                          barrierDismissible: false,
                          barrierColor: Colors.black.withOpacity(0.5),
                          builder: (_) => BlocProvider<DogsBloc>.value(
                            value: context.read<DogsBloc>(),
                            child: const RandomDogPopup(),
                          ),
                        );
                      },
                      child: Container(
                        height: 56,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "Generate",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    body: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: contextHeight * 0.4,
                          child: CachedNetworkImage(
                            imageUrl: dog.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: contextHeight * 0.01),
                        const Text(
                          "Breed",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: contextHeight * 0.01),
                        Text(
                          dog.breed.capitalize(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: contextHeight * 0.02),
                        Visibility(
                          visible: dog.subBreeds.isNotEmpty,
                          child: Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Sub Breeds",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: contextHeight * 0.01),
                                Expanded(
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemCount: dog.subBreeds.length,
                                    separatorBuilder: (context, subIndex) =>
                                        const SizedBox(height: 4),
                                    itemBuilder: (context, subIndex) {
                                      return Center(
                                        child: Text(
                                          dog.subBreeds[subIndex].capitalize(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Close Button
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(top: 8, right: 8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(Assets.close, height: 16, width: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
