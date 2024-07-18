import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_frontend/core/utils/constants.dart';
import 'package:test_frontend/feature/home/presentation/pages/home.page.dart';

import '../../../../core/widgets/custom_snackBar.widget.dart';
import '../../../../injection.dart';
import '../../domain/entities/images.entity.dart';
import '../blocs/blocs.dart';

class PreviewImagePage extends StatefulWidget {
  const PreviewImagePage({super.key, required this.image});

  final ImageResultEntity image;

  @override
  State<PreviewImagePage> createState() => _PreviewImagePageState();
}

class _PreviewImagePageState extends State<PreviewImagePage> {
  late final DeleteBloc deleteBloc;

  @override
  void initState() {
    deleteBloc = Injector.getIt<DeleteBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeleteBloc>(
      create: (context) => deleteBloc,
      child: BlocListener<DeleteBloc, DeleteState>(
        bloc: deleteBloc,
        listener: (context, state) {
          if (state is DeleteSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          } else if (state is DeleteFailure) {
            ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
              message: state.message,
              onPressed: () {},
            ));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Preview Page'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    width: 400,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.0),
                      child: FadeInImage(
                        fit: BoxFit.fill,
                        fadeInDuration: const Duration(milliseconds: 200),
                        placeholder: const AssetImage(AssetsName.loadingGid),
                        image: NetworkImage(
                          widget.image.imageUrl,
                        ),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return const Placeholder();
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<DeleteBloc, DeleteState>(
                    bloc: deleteBloc,
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is DeleteInProgress
                            ? null
                            : () {
                                deleteBloc.add(
                                  DeleteImageSaved(id: widget.image.id),
                                );
                              },
                        style: const ButtonStyle(
                          minimumSize: WidgetStatePropertyAll<Size>(
                            Size(150.0, 60.0),
                          ),
                          maximumSize: WidgetStatePropertyAll<Size>(
                            Size(150.0, 60.0),
                          ),
                        ),
                        child: state is DeleteInProgress
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Eliminar',
                                style: TextStyle(
                                  fontSize: 24.0,
                                ),
                              ),
                      );
                    },
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
