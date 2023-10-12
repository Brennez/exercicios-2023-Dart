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
    final response = await client.get(
        url:
            'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json');

    if (response.statusCode == 200) {
      // print('AQUI: ${response.body}');
      List<EventModel> items = [];

      final body = jsonDecode(response.body);

      body['data'].map((item) {
        final eventModel = EventModel.fromJson(item);
        items.add(eventModel);
      }).toList();

      return items;
    } else if (response.statusCode == 404) {
      throw NotFoundError(message: 'Url não encontrada');
    } else {
      throw Exception('Erro inesperado');
    }
  }
}
