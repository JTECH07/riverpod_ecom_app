# NextFlutter E-commerce App

A complete e-commerce Flutter application using **Riverpod** as the exclusive state management solution.

## Architecture

The application follows a clean separation of concerns with three layers:

### Data Layer
- Product model (`lib/features/products/domain/model/product_model.dart`)
- Mock product data (`kProducts`)
- Local storage (Hive ready)

### Business Logic Layer (Riverpod)
7 exclusive providers managing all app state:

1. **`productListProvider`** - `StateProvider.autoDispose` containing the mock product list
2. **`filterProvider`** - `StateProvider` for category, price range, sort criteria
3. **`filteredProductsProvider`** - `Provider.family` combining filters + search
4. **`cartProvider`** - `StateNotifierProvider<CartNotifier, CartState>` with add/remove/setQuantity
5. **`favoritesProvider`** - `StateNotifierProvider<FavoriteNotifier, Set<int>>` for toggle favorite
6. **`userProfileProvider`** - `StateProvider` with user profile data
7. **`searchQueryProvider`** - `StateProvider` for search query text

### Presentation Layer
- Product list screen with filtering UI (categories, price range, sort by/rating)
- Product detail screen
- Cart screen with item management (add/remove/quantity)
- Favorites screen
- Profile screen with avatar and info rows

## State Management

All state is managed exclusively with Riverpod:

- `StateProvider` for simple state (user profile, search query)
- `StateProvider.autoDispose` for ephemeral state (product list)
- `StateNotifierProvider` + `StateNotifier` for complex state (cart, favorites)
- `Provider.family` for computed/filtered data

## Features

- Product catalog with filtering (category, price range)
- Sorting by name/price (ascending/descending)
- Shopping cart with quantity management
- Favorites toggle persistence
- Light/dark theme support
- User profile display

## Project Structure

```
lib/
├── core/
│   ├── theme/app_theme.dart      # Light/dark ColorScheme
│   └── widgets/                  # Reusable widgets
├── features/
│   ├── products/
│   │   ├── domain/               # Product model
│   │   ├── providers/            # 7 Riverpod providers
│   │   └── presentation/         # Screens
│   ├── cart/                     # Cart screen
│   ├── favorites/                # Favorites screen
│   └── profile/                  # Profile screen
└── main.dart                     # App entry point
```

## Getting Started

```bash
flutter pub get
flutter run
```

or build for web:

```bash
flutter build web
```

## Dependencies

Key dependencies in `pubspec.yaml`:
- `riverpod: ^2.4.0` - State management
- `riverpod_generator: ^2.4.0` - Code generator
- `dio: ^5.4.0` - HTTP client (API ready)
- `connectivity_plus: ^6.0.3` - Connectivity monitoring
- `provider: ^6.0.5` - Additional provider support
- `hive: ^2.2.3` + `hive_flutter: ^1.1.0` - Local storage