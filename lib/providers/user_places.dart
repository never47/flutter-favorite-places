import 'package:favorite_places/modal/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class FavoritePlacesNotifier extends StateNotifier<List<Place>> {
  FavoritePlacesNotifier() : super(const []);

  void addFavoritePlace(
    String title,
    File image,
    PlaceLocation placeLocation,
  ) {
    state = [
      ...state,
      Place(
        title: title,
        image: image,
        placeLocation: placeLocation,
      ),
    ];
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<Place>>(
  (ref) => FavoritePlacesNotifier(),
);
