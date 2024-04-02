import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';
import '../../../data/models/cart/cart_item_model.dart';
import '../../../logic/cubits/cart_cubit/cart_cubit.dart';
import '../../../logic/services/formatter.dart';
import 'link_button.dart';

class CartListView extends StatelessWidget {
  final List<CartItemModel> items;
  final bool shrinkWrap;
  final bool noScroll;

  const CartListView(
      {super.key,
      required this.items,
      this.shrinkWrap = false,
      this.noScroll = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: (noScroll) ? const NeverScrollableScrollPhysics() : null,
      shrinkWrap: shrinkWrap,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
          leading: CachedNetworkImage(
            width: 50,
            imageUrl: item.product!.images![0],
          ),
          title: Text("${item.product?.title}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${Formatter.formatPrice(item.product!.price!)} x ${item.quantity} = ${Formatter.formatPrice(item.product!.price! * item.quantity!)}"),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red.shade300,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirmation"),
                        content: const Text(
                            "Are you sure you want to remove this item from your cart?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text(
                              "No",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Remove the item from the cart
                              BlocProvider.of<CartCubit>(context)
                                  .removeFromCart(item.product!);
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          trailing: InputQty(
            qtyFormProps: const QtyFormProps(enableTyping: false),
            minVal: 1,
            maxVal: 99,
            initVal: item.quantity!,
            onQtyChanged: (value) {
              if (value != item.quantity) return;
              BlocProvider.of<CartCubit>(context)
                  .addToCart(item.product!, value as int);
            },
          ),
        );
      },
    );
  }
}
