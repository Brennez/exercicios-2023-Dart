import 'dart:convert';

import 'package:chuva_dart/http/client.dart';
import 'package:chuva_dart/http/errors.dart';
import 'package:chuva_dart/models/event_model.dart';

abstract class IEventRepository {
  Future<List<EventModel>> getEvents();
}

class EventRepository implements IEventRepository {
  final HttpClient client;

  EventRepository({
    required this.client,
  });

  @override
  Future<List<EventModel>> getEvents() async {
    final response1 = await client.get(
        url:
            'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json');

    final response2 = await client.get(
        url:
            'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities-1.json');

    if (response1.statusCode == 200 && response2.statusCode == 200) {
      final mergedItems = _responsesToListConverter(response1, response2);

      return mergedItems;
    } else if (response1.statusCode == 404 || response2.statusCode == 404) {
      throw NotFoundError(message: 'Url não encontrada');
    } else {
      throw Exception('Erro inesperado');
    }
  }

  List<EventModel> _responsesToListConverter(
      dynamic response1, dynamic response2) {
    List<EventModel> items = [];

    final body1 = jsonDecode(response1.body);

    final body2 = jsonDecode(response2.body);

    body1['data'].map((item) {
      final eventModel = EventModel.fromJson(item);
      items.add(eventModel);
    }).toList();

    body2['data'].map((item) {
      final eventModel = EventModel.fromJson(item);
      items.add(eventModel);
    }).toList();

    return items;
  }
}
