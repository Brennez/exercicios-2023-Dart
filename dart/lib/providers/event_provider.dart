import 'package:chuva_dart/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http/client.dart';
import '../repositories/event_repository.dart';

class EventProvider extends ChangeNotifier {
  List<EventModel> _items = [];

  List<EventModel> get items => [..._items];

  Future<List<EventModel>> getEvents() async {
    final events = await EventRepository(client: HttpClient()).getEvents();
    _items = events;
    await _loadFavoriteEvents();
    return events;
  }

  List<EventModel> getEventsById(int id) {
    final filteredList =
        _items.where((item) => item.peopleId.contains(id)).toList();

    return filteredList;
  }

  Future<void> setEventFavorite(int eventId) async {
    EventModel event =
        _items.firstWhere((element) => element.eventId == eventId);

    final value = event.isFavorite = !event.isFavorite;

    await _saveEventFavorite(eventId, value);
  }

  Future<void> _loadFavoriteEvents() async {
    for (var item in _items) {
      item.isFavorite = await _loadIsFavoritPreferences(item.eventId) ?? false;
    }
  }

  Future<void> _saveEventFavorite(int eventId, bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(eventId.toString(), value);
  }

  Future<bool?> _loadIsFavoritPreferences(int eventId) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(eventId.toString());
  }
}
