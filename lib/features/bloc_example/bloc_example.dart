import 'dart:ui';

import 'package:contact_name/features/bloc_example/bloc/example_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocExample extends StatelessWidget {
  const BlocExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Example'),
      ),
      body: BlocListener<ExampleBloc, ExampleState>(
        listenWhen: (previous, current) {
          return current is ExampleStateInitial;
        },
        listener: (context, state) {
          if (state is ExampleStateData) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('A quantidade de nome é ${state.name.length}')));
          }
        },
        child: Column(
          children: [
            BlocConsumer<ExampleBloc, ExampleState>(
                listener: (conxtext, state) {
              print('Ido para o ${state.runtimeType}}');
            }, builder: (context, state) {
              if (state is ExampleStateData) {
                return Text('Total de nome é ${state.name.length}}');
              }
              return const Text('Não carregado');
            }),
            BlocSelector<ExampleBloc, ExampleState, bool>(
              selector: (state) {
                if (state is ExampleStateInitial) {
                  return true;
                }
                return false;
              },
              builder: (context, showLoader) {
                if (showLoader) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            BlocSelector<ExampleBloc, ExampleState, List<String>>(
              selector: (state) {
                if (state is ExampleStateData) {
                  return state.name;
                } else {
                  return [];
                }
              },
              builder: ((context, names) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: names.length,
                  itemBuilder: (context, index) {
                    final name = names[index];

                    return ListTile(
                      onTap: () {
                        context
                            .read<ExampleBloc>()
                            .add(ExampleRemoveNameEvent(name: name));
                      },
                      title: Text(name),
                    );
                  },
                );
              }),
            ),

            BlocSelector<ExampleBloc, ExampleState, List<String>>(
              selector: (state) {
                if (state is ExampleAddNameEvent) {
                  return [];
                }
                return [];
              },
              builder: (context, name) {
                return TextButton.icon(
                    onPressed: () {
                      context
                          .read<ExampleBloc>()
                          .add(ExampleAddNameEvent(name: 'JUlia'));
                    },
                    icon: Icon(Icons.add),
                    label: Text('Adicionar'));
              },
            )
            // BlocBuilder<ExampleBloc, ExampleState>(
            //   builder: (context, state) {
            //     if (state is ExampleStateData) {
            //       return ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: state.name.length,
            //         itemBuilder: (context, index) {
            //           final name = state.name[index];
            //           return ListTile(
            //             title: Text(name),
            //           );
            //         },
            //       );
            //     }
            //     return const Text('Nenhum nome Cadastrado');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
