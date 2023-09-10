import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/shop_app/favorites_modle.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class FavoirtesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
            condition: state is! ShopeLoading_GET_FavoritesState,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildFavoraitesItem(
                    cubit.favoritesModel!.data!.data![index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.favoritesModel!.data!.data!.length),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget buildFavoraitesItem(FavoritesData model, context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.product!.image}'),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                if (model.product!.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 8.0, color: Colors.white),
                    ),
                  )
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.product!.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, height: 1.3),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product!.price}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12.0, color: defaultColor),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (1 != 0)
                          Text(
                            '${model.product!.oldPrice}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changeFavorites(model.product!.id!);
                            },
                            icon: CircleAvatar(
                                radius: 15,
                                backgroundColor: ShopCubit.get(context)
                                        .favorites[model.product!.id!]!
                                    ? defaultColor
                                    : Colors.grey,
                                child: Icon(Icons.favorite_border,
                                    size: 20, color: Colors.white)))
                      ],
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
