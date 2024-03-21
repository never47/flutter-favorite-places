import 'package:favorite_places/modal/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlacesNotifier extends StateNotifier<List<Place>> {
  FavoritePlacesNotifier() : super(const []);

  void addFavoritePlace(String title) {
    state = [
      ...state,
      Place(title: title),
    ];
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<Place>>(
  (ref) => FavoritePlacesNotifier(),
);
