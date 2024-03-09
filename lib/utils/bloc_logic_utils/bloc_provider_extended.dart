import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExtendedMultiBlocProvider extends StatelessWidget {
  final List<BlocProvider> providers;
  final BuilderWidget builder;
  const ExtendedMultiBlocProvider({required this.providers,required this.builder,super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: providers, child: Builder(builder: (context) => tabBodyBuilderWidget(context,builder),));
  }
}

typedef BuilderWidget = Widget Function(BuildContext context);

Widget tabBodyBuilderWidget(BuildContext context, BuilderWidget builder) {
  return builder(context);
}