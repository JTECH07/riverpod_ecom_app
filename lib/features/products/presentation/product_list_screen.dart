import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:nextflutter_app/features/products/domain/model/product_model.dart';
import 'package:nextflutter_app/features/products/providers/product_providers.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredProducts = ref.watch(filteredProductsProvider('',));
    final cart = ref.watch(cartProvider);
    final favorites = ref.watch(favoritesProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits'),
        actions: [
          IconButton(
            icon: Icon(favorites.isFavorite(1) ? Icons.favorite : Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
            },
          ),
        ],
      ),
      body: filteredProducts.isEmpty
          ? const Center(child: Text('Aucun produit disponible'))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return _ProductCard(product: product, cart: cart, favorites: favorites);
              },
            ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  final CartNotifier cart;
  final FavoriteNotifier favorites;

  const _ProductCard({
    required this.product,
    required this.cart,
    required this.favorites,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Expanded(
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 50);
                  },
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(favorites.isFavorite(product.id) ? Icons.favorite : Icons.favorite_border),
                  color: Colors.white,
                  onPressed: () {
                    ref.read(favoritesProvider.notifier).toggleFavorite(product.id);
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${product.price.toStringAsFixed(0)} €',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      '${product.reviewCount} avis',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
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
    );
  }
}