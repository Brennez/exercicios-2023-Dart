class EventModel {
  final int eventId;
  final String start;
  final String end;
  final String title;
  final String? description;
  final bool isFavorite;

  final int categoryId;
  final String categoryTitle;
  final String? categoryColor;
  final String? categoryBackgroundColor;

  final List<dynamic> locations;

  final String typeOfEvent;

  final List<dynamic> peopleId;
  final List<dynamic> peopleTitle;
  final List<dynamic> peopleName;
  final List<dynamic> peopleInstitution;
  final List<dynamic> peopleBio;
  final List<dynamic> peopleUrlPicture;
  final List<dynamic> peopleLabel;

  EventModel({
    required this.eventId,
    required this.start,
    required this.end,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryColor,
    required this.categoryBackgroundColor,
    required this.locations,
    required this.typeOfEvent,
    required this.peopleId,
    required this.peopleTitle,
    required this.peopleName,
    required this.peopleInstitution,
    required this.peopleBio,
    required this.peopleUrlPicture,
    required this.peopleLabel,
    this.isFavorite = false,
  });

  factory EventModel.fromJson(Map<String, dynamic> map) {
    return EventModel(
      eventId: map['id'],
      start: map['start'],
      end: map['end'],
      title: map['title']['pt-br'],
      description: map['description']['pt-br'] ?? 'without description',
      categoryId: map['category']['id'],
      categoryTitle: map['category']['title']['pt-br'],
      categoryColor: map['category']['color'] ?? '#456189',
      categoryBackgroundColor: map['category']['background-color'] ?? '#7FFFD4',
      locations:
          map['locations'].map((item) => item['title']['pt-br']).toList(),
      typeOfEvent: map['type']['title']['pt-br'],
      peopleId: map['people'].map((item) => item['id']).toList(),
      peopleTitle: map['people'].map((item) => item['title']).toList(),
      peopleName: map['people'].map((item) => item['name']).toList(),
      peopleInstitution:
          map['people'].map((item) => item['institution']).toList(),
      peopleBio: map['people'].map((item) => item['bio']['pt-br']).toList(),
      peopleUrlPicture: map['people'].map((item) => item['picture']).toList(),
      peopleLabel:
          map['people'].map((item) => item['role']['label']['pt-br']).toList(),
    );
  }
}
