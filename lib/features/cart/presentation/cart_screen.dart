import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:nextflutter_app/features/products/domain/model/product_model.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Panier')),
      body: cart.items.isEmpty
          ? const Center(child: Text('Votre panier est vide'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return ListTile(
                        leading: Image.network(
                          item.product.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item.product.name),
                        subtitle: Text('${item.product.price.toStringAsFixed(0)} €'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () =>
                                  ref.read(cartProvider.notifier).setQuantity(item.product, 0),
                            ),
                            Text(item.quantity.toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () =>
                                  ref.read(cartProvider.notifier).addProduct(item.product),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Total :',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${cart.totalPrice.toStringAsFixed(0)} €',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}