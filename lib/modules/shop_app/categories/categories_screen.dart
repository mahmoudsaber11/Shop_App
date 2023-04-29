import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/shop_app/cubit/cubit.dart';
import 'package:news_app/layout/shop_app/cubit/states.dart';
import 'package:news_app/models/shop_app/categories_model.dart';
import 'package:news_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        return ListView.separated(
            itemBuilder: ((context, index) => buildCatItem(
                ShopCubit.get(context).categoriesModel!.data.data[index])),
            separatorBuilder: ((context, index) => myDivider()),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data.data.length);
      }),
    );
  }
}

Widget buildCatItem(DataModel model) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 20.0,
        ),
        Text(
          model.name,
          style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange),
        ),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios,
          color: Colors.deepOrange,
        )
      ],
    ),
  );
}
