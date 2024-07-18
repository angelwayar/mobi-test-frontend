import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_frontend/core/widgets/custom_snackBar.widget.dart';
import 'package:test_frontend/feature/home/domain/entities/images.entity.dart';
import 'package:test_frontend/feature/home/presentation/pages/preview_image.page.dart';

import '../../../../core/widgets/error_message.widget.dart';
import '../../../../injection.dart';
import '../blocs/blocs.dart';
import 'preview_before_save.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ImagePicker picker;
  late final List<XFile> imageList;
  final scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late final ListImagesBloc listImagesBloc;

  @override
  void initState() {
    imageList = [];
    picker = ImagePicker();
    listImagesBloc = Injector.getIt<ListImagesBloc>();

    super.initState();
  }

  Future<void> imageSelect() async {
    final List<XFile> selectedImage = await picker.pickMultiImage();
    if (selectedImage.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PreviewBeforeSavePage(images: selectedImage)),
      );
    }
  }

  Future<void> _refreshIndicatorImages() async {
    listImagesBloc.add(ListImagesSaved());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListImagesBloc>(
      create: (context) => listImagesBloc..add(ListImagesSaved()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: BlocListener<ListImagesBloc, ListImagesState>(
          listener: (context, state) {
            if (state is ListImageFailure) {
              ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                message: state.message,
                onPressed: () {},
              ));
            }
          },
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            color: Colors.white,
            backgroundColor: Colors.blue,
            strokeWidth: 4.0,
            onRefresh: _refreshIndicatorImages,
            child: BlocBuilder<ListImagesBloc, ListImagesState>(
              builder: (context, state) {
                if (state is ListImageFailure) {
                  return const Center(
                    child: ErrorMessage(
                      message: 'Intente más tarde',
                    ),
                  );
                } else if (state is ListImageSuccess) {
                  if (state.images.isNotEmpty) {
                    return GridView.builder(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2.5,
                        mainAxisSpacing: 2.5,
                      ),
                      itemCount: state.images.length,
                      itemBuilder: (context, index) {
                        final ImageResultEntity image = state.images[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PreviewImagePage(
                                  image: image,
                                ),
                              ),
                            );
                          },
                          child: FadeInImage(
                            fit: BoxFit.fill,
                            fadeInDuration: const Duration(milliseconds: 200),
                            placeholder:
                                const AssetImage('assets/gif/loading_gif.gif'),
                            image: NetworkImage(image.imageUrl),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return const Placeholder();
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        "Agregue imagenes para visualizar",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    );
                  }
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: imageSelect,
          child: const Icon(Icons.add_a_photo_outlined),
        ),
      ),
    );
  }
}
