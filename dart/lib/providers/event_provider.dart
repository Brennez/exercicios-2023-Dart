import 'package:chuva_dart/models/event_model.dart';
import 'package:flutter/material.dart';

import '../http/client.dart';
import '../repositories/event_repository.dart';

class EventProvider extends ChangeNotifier {
  List<EventModel> events = [];

  Future<List<EventModel>> getEvents() async {
    events = await EventRepository(client: HttpClient()).getEvents();
    return events;
  }

  List<EventModel> getEventsById(int id) {
    final filteredList =
        events.where((item) => item.peopleId.contains(id)).toList();

    return filteredList;
  }
}
