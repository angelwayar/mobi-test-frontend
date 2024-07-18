import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_frontend/feature/home/presentation/pages/home.page.dart';

import '../../../../core/widgets/custom_snackBar.widget.dart';
import '../../../../core/widgets/error.widget.dart';
import '../../../../injection.dart';
import '../blocs/register/register_bloc.dart';

class PreviewBeforeSavePage extends StatefulWidget {
  const PreviewBeforeSavePage({super.key, required this.images});

  final List<XFile> images;

  @override
  State<PreviewBeforeSavePage> createState() => _PreviewBeforeSavePageState();
}

class _PreviewBeforeSavePageState extends State<PreviewBeforeSavePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => Injector.getIt<RegisterBloc>(),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
              message: state.message,
              onPressed: () {},
            ));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Preview antes de guardar'),
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
                    child: PageView.builder(
                      itemCount: widget.images.length,
                      itemBuilder: (context, index) {
                        final path = widget.images[index].path;

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: Image.file(
                            File(path),
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return const ErrorImage();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is RegisterInProgress
                            ? null
                            : () {
                                context.read<RegisterBloc>().add(
                                      RegisterImageSaved(image: widget.images),
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
                        child: state is RegisterInProgress
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Guardar',
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
