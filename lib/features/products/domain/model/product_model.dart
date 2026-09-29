class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.category,
  });

  factory Product.fromMap(Map<String, dynamic> map) => Product(
    id: map['id'] as int,
    name: map['name'] as String,
    description: map['description'] as String,
    price: (map['price'] as num).toDouble(),
    imageUrl: map['imageUrl'] as String,
    rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
    reviewCount: map['reviewCount'] as int ?? 0,
    category: map['category'] as String,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'imageUrl': imageUrl,
    'rating': rating,
    'reviewCount': reviewCount,
    'category': category,
  };

  @override
  String toString() => 'Product(id: $id, name: $name)';
}

// Produits mock
final List<Product> kProducts = [
  Product(
    id: 1,
    name: 'Casque Audio Premium',
    description: 'Annulation de bruit active, autonomie 30h',
    price: 299.99,
    imageUrl:
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&h=500&fit=crop',
    rating: 4.5,
    reviewCount: 128,
    category: 'Électronique',
  ),
  Product(
    id: 2,
    name: 'Montre Connectée',
    description: 'Suivi de santé, autonomie 1 semaine',
    price: 199.50,
    imageUrl:
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500&h=500&fit=crop',
    rating: 4.3,
    reviewCount: 87,
    category: 'High-Tech',
  ),
  Product(
    id: 3,
    name: 'Sac à Dos Rando',
    description: 'Imperméable, capacity 30L, sangles confortables',
    price: 89.99,
    imageUrl:
        'https://images.unsplash.com/photo-1553056669-b5b6e6e0df34?w=500&h=500&fit=crop',
    rating: 4.8,
    reviewCount: 45,
    category: 'Accessoires',
  ),
  Product(
    id: 4,
    name: 'Vélo Tout Terrain',
    description: 'Cadres en aluminium, 21 vitesses',
    price: 549.99,
    imageUrl:
        'https://images.unsplash.com/photo-1549957470-7b41284e127f?w=500&h=500&fit=crop',
    rating: 4.6,
    reviewCount: 32,
    category: 'Sport',
  ),
];