import 'package:riverpod/riverpod.dart';
import 'package:nextflutter_app/features/products/domain/model/product_model.dart';

// 1. Product List Provider - state provider with mock data
final productListProvider = StateProvider.autoDispose((ref) => kProducts);

// 2. Filter Provider - state provider for category, price range, sort options
final filterProvider = StateProvider<(String category, double minPrice, double maxPrice, String sortBy, bool orderAsc)>(
  (ref) => ('', 0.0, double.infinity, 'name', true),
);

// 3. Filtered Products Provider - family provider for search filtering
final filteredProductsProvider = Provider.family<List<Product>, String>((ref, searchQuery) {
  final filter = ref.watch(filterProvider);
  final products = ref.watch(productListProvider);

  return products.where((product) {
    if (filter.$1.isNotEmpty && product.category != filter.$1) {
      return false;
    }
    if (product.price < filter.$2 || product.price > filter.$3) {
      return false;
    }
    final sorted = _sortProducts(products, filter.$4, filter.$5);
    if (searchQuery.isNotEmpty &&
        !sorted
            .map((p) => p.name.toLowerCase())
            .contains(searchQuery.toLowerCase())) {
      return false;
    }
    return true;
  }).toList();
});

// Helper function to sort products
List<Product> _sortProducts(
    List<Product> products, String sortBy, bool orderAsc) {
  final sorted = sortBy == 'price'
      ? List.of(products)..sort((a, b) => orderAsc ? a.price.compareTo(b.price) : b.price.compareTo(a.price))
      : List.of(products)..sort((a, b) => orderAsc ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
  return sorted;
}

// 4. Cart Provider - StateNotifier for cart management
final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) => CartNotifier());

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartState());

  void addProduct(Product product) {
    final existingIndex = state.items.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      state = state.copyWith(
        items: state.items.map((item) {
          if (item.product.id == product.id) {
            return item.copyWith(quantity: item.quantity + 1);
          }
          return item;
        }).toList(),
      );
    } else {
      state = state.copyWith(
        items: [...state.items, CartItem(product: product, quantity: 1)],
      );
    }
  }

  void removeProduct(Product product) {
    state = state.copyWith(
      items: state.items.where((item) => item.product.id != product.id).toList(),
    );
  }

  void setQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      removeProduct(product);
      return;
    }
    final existingIndex = state.items.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      state = state.copyWith(
        items: state.items.map((item) {
          if (item.product.id == product.id) {
            return item.copyWith(quantity: quantity);
          }
          return item;
        }).toList(),
      );
    }
  }

  int get totalItems => state.items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      state.items.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);
}

class CartState {
  final List<CartItem> items;
  CartState() : items = [];

  CartState copyWith({required List<CartItem> items}) => CartState(
        items: items.isEmpty ? this.items : items,
      );
}

class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, required this.quantity});

  CartItem copyWith({int? quantity}) => CartItem(
        product: product,
        quantity: quantity ?? this.quantity,
      );
}

// 5. Favorites Provider - StateNotifier for favorites management
final favoritesProvider = StateNotifierProvider<FavoriteNotifier, Set<int>>((ref) => FavoriteNotifier());

class FavoriteNotifier extends StateNotifier<Set<int>> {
  FavoriteNotifier() : super({});

  void toggleFavorite(int productId) {
    if (state.contains(productId)) {
      state = state..remove(productId);
    } else {
      state = state..add(productId);
    }
  }

  bool isFavorite(int productId) => state.contains(productId);
}

// 6. User Profile Provider - mock user data
final userProfileProvider = StateProvider((ref) => {
  'name': 'Marie Dupont',
  'email': 'marie.dupont@email.com',
  'phone': '+33 6 12 34 56 78',
  'address': '123 Rue Example, 75001 Paris',
  'avatarUrl':
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&h=100&fit=crop',
});

// 7. Search Query Provider
final searchQueryProvider = StateProvider((ref) => '');