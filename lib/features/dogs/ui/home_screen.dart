import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dogs/common/app_colors.dart';
import 'package:flutter_dogs/common/app_constants.dart';
import 'package:flutter_dogs/common/extensions/string_extension.dart';
import 'package:flutter_dogs/features/dogs/bloc/dogs_bloc.dart';
import 'package:flutter_dogs/features/dogs/models/dog_model.dart';

import 'dog_detail_popup.dart';
import 'search_widget.dart';

class HomeScreen extends StatefulWidget {
  final DogsBloc dogsBloc;
  const HomeScreen({
    Key? key,
    required this.dogsBloc,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<DogModel> dogs;
  String filter = '';
  bool isFabVisible = true;

  @override
  void initState() {
    dogs = widget.dogsBloc.dogs;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.dogsBloc,
      child: BlocConsumer<DogsBloc, DogsState>(
        bloc: widget.dogsBloc,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DogsBreedFilterSuccessful) {
            dogs = state.filteredDogs;
            filter = state.filter;
          } else if (state is DogsIsFabVisible) {
            isFabVisible = state.isFabVisible;
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text(appName),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Visibility(
              visible: isFabVisible,
              child: GestureDetector(
                onTap: () {
                  context
                      .read<DogsBloc>()
                      .add(DogsIsFabVisibleEvent(isFabVisible: false));

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    enableDrag: true,
                    barrierColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(0)),
                    ),
                    builder: (_) => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: DraggableScrollableSheet(
                        initialChildSize: 0.52,
                        minChildSize: 0.4,
                        maxChildSize: (MediaQuery.of(context).size.height -
                                kAppBarHeight -
                                MediaQuery.of(context).viewPadding.top) /
                            MediaQuery.of(context).size.height,
                        snap: true,
                        snapSizes: [
                          0.52,
                          (MediaQuery.of(context).size.height -
                                  kAppBarHeight -
                                  MediaQuery.of(context).viewPadding.top) /
                              MediaQuery.of(context).size.height
                        ],
                        builder: (_, scrollController) => Container(
                          color: Colors.white,
                          child: BlocProvider<DogsBloc>.value(
                            value: widget.dogsBloc,
                            child: ListView(
                              controller: scrollController,
                              physics: const ClampingScrollPhysics(),
                              children: [
                                Center(
                                  child: Container(
                                    height: 3,
                                    width: 32,
                                    margin: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: grey,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                    ),
                                  ),
                                ),
                                SearchWidget(filter: filter),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ).then((value) {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      context
                          .read<DogsBloc>()
                          .add(DogsIsFabVisibleEvent(isFabVisible: true));
                    });
                  });
                },
                child: Container(
                  height: 64,
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: grey, width: 2),
                  ),
                  child: Text(
                    filter.isNotEmpty ? filter : 'Search',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: filter.isNotEmpty
                          ? Colors.black
                          : versionColor.withOpacity(0.6),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            body: dogs.isNotEmpty
                ? Container(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        GridView.builder(
                          itemCount: dogs.length,
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 100),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (_) => BlocProvider<DogsBloc>.value(
                                    value: widget.dogsBloc,
                                    child: DogDetailPopup(dog: dogs[index]),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          dogs[index].image),
                                      fit: BoxFit.cover,
                                    )),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.24),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        topRight: Radius.circular(16),
                                      ),
                                    ),
                                    child: Text(
                                      dogs[index].breed.capitalize(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'No results found',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Try searching for another word',
                          style: TextStyle(
                            color: versionColor.withOpacity(0.6),
                            fontSize: 16,
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
