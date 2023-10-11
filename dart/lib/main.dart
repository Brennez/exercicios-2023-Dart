import 'package:flutter/material.dart';

void main() {
  runApp(const ChuvaDart());
}

class ChuvaDart extends StatelessWidget {
  const ChuvaDart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicio chuva',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Calendar(),
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

  void _changeDate(DateTime newDate) {
    setState(() {
      _currentDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: const Color(0xff456189),
          centerTitle: true,
          title: const SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Chuva',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.favorite,
                      color: Color(0xffb642f5),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Flutter',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Programação',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          leading: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 100,
              color: const Color(0xff456189),
              alignment: Alignment.center,
              child: Material(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            color: const Color(0xff306dc3),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Icon(
                          Icons.calendar_month,
                          size: 26,
                        ),
                      ),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          'Exibindo todas atividades',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
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
