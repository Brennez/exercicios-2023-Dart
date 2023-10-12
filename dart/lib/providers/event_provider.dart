import 'package:chuva_dart/models/event_model.dart';
import 'package:flutter/material.dart';

import '../http/client.dart';
import '../repositories/event_repository.dart';

class EventProvider extends ChangeNotifier {
  Future<List<EventModel>> getEvents() async {
    final events = await EventRepository(client: HttpClient()).getEvents();
    return events;
  }
}
