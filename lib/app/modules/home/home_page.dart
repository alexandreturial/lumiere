import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lumiere/app/modules/home/counter_cubit.dart';
import 'package:lumiere/app/utils/responsive.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CounterCubit _counterCubit = Modular.get();
  
  DateTime _selectedDay = DateTime.now();
  late DraggableScrollableController controllerScrollable;
  CalendarFormat format = CalendarFormat.twoWeeks;

  @override
  void initState() {
    controllerScrollable = DraggableScrollableController();

    controllerScrollable.addListener(() {
      getCalendarSize();
    });
    super.initState();
  }

  void getCalendarSize() {
    // ignore: invalid_use_of_protected_member
    if (controllerScrollable.size == 1) {
      setState(() {
        format = CalendarFormat.twoWeeks;
      });
    } else {
      setState(() {
        format = CalendarFormat.month;
      });
    }
  }


  @override
  void dispose() {
    _counterCubit.close();
    super.dispose();
  }


  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text("Home")),
  //     floatingActionButton: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         FloatingActionButton(
  //           child: Icon(Icons.remove),
  //           onPressed: _counterCubit.decrement,
  //         ),
  //         FloatingActionButton(
  //           child: Icon(Icons.add),
  //           onPressed: _counterCubit.increment,
  //         ),
  //       ],
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text("Button Tapped:"),
  //           BlocBuilder<CounterCubit, int>(
  //             bloc: _counterCubit,
  //             builder: (context, count) {
  //               return Text(
  //                 "$count",
  //                 style: Theme.of(context).textTheme.headline3,
  //               );
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
      body: Container(
        width: responsive.width,
        height: responsive.height,
        child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _selectedDay,
                  calendarFormat: format,
                  calendarStyle: const CalendarStyle(),
                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  locale: 'pt_BR',
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                    });
                  },
                ),
                Expanded(
                  child: Container(
                    height: responsive
                        .hp(format == CalendarFormat.twoWeeks ? 64.3 : 43.5),
                    width: responsive.width,
                    child: DraggableScrollableSheet(
                      controller: controllerScrollable,
                      maxChildSize: 1,
                      minChildSize: 0.9,
                      snapSizes: const [0.9, 1],
                      initialChildSize: 1,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          color: Colors.blue[100],
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: 25,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(title: Text('Item $index'));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     store.increment();
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}