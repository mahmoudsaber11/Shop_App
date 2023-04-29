import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:news_app/modules/shop_app/search/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: ((context, state) {}),
          builder: ((context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter text to search';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            SearchCubit.get(context).search(value);
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Search',
                              prefixIcon: Icon(Icons.search)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (state is SearchLoadingState)
                          const LinearProgressIndicator(),
                        const SizedBox(
                          height: 10,
                        ),
                        if (state is SearchSuccesslState)
                          Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => buildListProduct(
                                SearchCubit.get(context)
                                    .model!
                                    .data!
                                    .data![index],
                                context,
                                isOldPrice: false,
                              ),
                              separatorBuilder: (context, index) => myDivider(),
                              itemCount: SearchCubit.get(context)
                                  .model!
                                  .data!
                                  .data!
                                  .length,
                            ),
                          ),
                      ],
                    ),
                  )),
            );
          }),
        ));
  }
}
