import 'dart:collection';
import 'dart:developer';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:launcher/persitence/local-persistence.dart';

class FavoriteApps extends ChangeNotifier {
  static const FAVORITE_PERSISTENCE_KEY = 'favorites';

  final List<Application> _favorites = [];

  UnmodifiableListView<Application> get favorites =>
      UnmodifiableListView(_favorites);

  FavoriteApps() {
    _load();
  }

  void _load() async {
    final apps = await LocalPersistence.getFavorites(FAVORITE_PERSISTENCE_KEY);
    apps.forEach((app) => _favorites.add(app));
  }

  void _save() async {
    await LocalPersistence.saveFavorite(FAVORITE_PERSISTENCE_KEY, _favorites);
  }

  void add(Application application) {
    _favorites.add(application);
    _save();
    notifyListeners();
  }

  void addMany(List<Application> apps) {
    apps.forEach((app) => _favorites.add(app));
    notifyListeners();
  }

  void delete(Application application) {
    final index = _favorites
        .indexWhere((app) => app.packageName == application.packageName);

    if (index < 0) return;
    deleteByIndex(index);
  }

  void deleteByIndex(int index) {
    _favorites.removeAt(index);
    _save();
    notifyListeners();
  }
}
