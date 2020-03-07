import 'dart:collection';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:launcher/persitence/local-persistence.dart';

class FavoriteApps extends ChangeNotifier {
  static const FAVORITE_PERSISTENCE_KEY = 'favorites';
  static const MAX_FAVORITE_APPLICATIONS = 8;

  final Set<Application> _favorites = new Set();

  UnmodifiableListView<Application> get favorites =>
      UnmodifiableListView(_favorites.toList());

  FavoriteApps() {
    _load();
  }

  void _load() async {
    final apps = await LocalPersistence.getFavorites(FAVORITE_PERSISTENCE_KEY);
    apps.forEach((app) => _favorites.add(app));
  }

  void _save() async {
    await LocalPersistence.saveFavorite(
        FAVORITE_PERSISTENCE_KEY, _favorites.toList());
  }

  void add(Application application) {
    if (_favorites.length >= MAX_FAVORITE_APPLICATIONS) return;

    _favorites.add(application);
    _save();
    notifyListeners();
  }

  void addMany(List<Application> apps) {
    apps.forEach((app) => _favorites.add(app));
    notifyListeners();
  }

  void delete(Application application) {
    _favorites.removeWhere((app) => app.packageName == application.packageName);
    notifyListeners();
  }
//
//  void deleteByIndex(int index) {
//    _favorites.removeAt(index);
//    _save();
//    notifyListeners();
//  }
}
