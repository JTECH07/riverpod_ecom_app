import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:nextflutter_app/features/products/domain/model/product_model.dart';

class ProductDetailScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: Icon(favorites.isFavorite(product.id) ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              ref.read(favoritesProvider.notifier).toggleFavorite(product.id);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
              const SizedBox(height: 16),
              Text(
                product.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                '${product.price.toStringAsFixed(0)} €',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                product.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).addProduct(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Produit ajouté au panier')),
                  );
                },
                child: const Text('Ajouter au panier'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}