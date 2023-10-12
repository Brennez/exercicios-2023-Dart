import 'package:chuva_dart/components/card_info_component.dart';
import 'package:chuva_dart/components/header_top_component.dart';
import 'package:chuva_dart/http/client.dart';
import 'package:chuva_dart/models/event_model.dart';
import 'package:chuva_dart/providers/event_provider.dart';
import 'package:chuva_dart/repositories/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/app_bar_component.dart';

void main() {
  runApp(const ChuvaDart());
}

class ChuvaDart extends StatelessWidget {
  const ChuvaDart({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EventProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Exercicio chuva',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Calendar(),
      ),
    );
  }
}

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _currentDate = DateTime(2023, 11, 26);

  bool _clicked = false;

  final List<String> days_month = ['26', '27', '28', '29', '30'];

  void _changeDate(DateTime newDate) {
    setState(() {
      _currentDate = newDate;
    });
  }

  int current_page = 0;

  Future<void> getItems() async {
    List<EventModel> items =
        await EventRepository(client: HttpClient()).getEvents();
    items.forEach((element) {
      print(element.categoryTitle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color(0xff456189),
        centerTitle: true,
        title: const AppBarComponent(),
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          const HeaderComponent(),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  color: Colors.white,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nov',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '2023',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  color: const Color(0xff306dc3),
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: days_month.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                current_page = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                days_month[index],
                                style: TextStyle(
                                  color: current_page == index
                                      ? Colors.white
                                      : const Color(0xffb0c3e1),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<EventProvider>(context, listen: false)
                  .getEvents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text('Sem dados por enquanto...'),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return CardInfoComponent(
                          eventModel: snapshot.data![index],
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  bool _favorited = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Column(children: [
        Text(
          'Activity title',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Text('A Física dos Buracos Negros Supermassivos'),
        const Text('Mesa redonda'),
        const Text('Domingo 07:00h - 08:00h'),
        const Text('Sthepen William Hawking'),
        const Text('Maputo'),
        const Text('Astrofísica e Cosmologia'),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _favorited = !_favorited;
            });
          },
          icon: _favorited
              ? const Icon(Icons.star)
              : const Icon(Icons.star_outline),
          label: Text(
              _favorited ? 'Remover da sua agenda' : 'Adicionar à sua agenda'),
        )
      ]),
    );
  }
}
