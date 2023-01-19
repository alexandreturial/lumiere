// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter_triple/flutter_triple.dart';
// import 'package:lumiere/app/utils/responsive.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'home_store.dart';

// class HomePage extends StatefulWidget {
//   final String title;
//   const HomePage({Key? key, this.title = "Home"}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends ModularState<HomePage, HomeStore> {
//   CalendarFormat format = CalendarFormat.twoWeeks;
//   late DraggableScrollableController controllerScrollable;

//   @override
//   void initState() {
//     controllerScrollable = DraggableScrollableController();

//     controllerScrollable.addListener(() {
//       getCalendarSize();
//     });
//     super.initState();
//   }

//   void getCalendarSize() {
//     // ignore: invalid_use_of_protected_member
//     if (controllerScrollable.size == 1) {
//       setState(() {
//         format = CalendarFormat.twoWeeks;
//       });
//     } else {
//       setState(() {
//         format = CalendarFormat.month;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Responsive responsive = Responsive(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Counter'),
//       ),
//       body: Container(
//         width: responsive.width,
//         height: responsive.height,
//         child: ScopedBuilder<HomeStore, Exception, int>(
//           store: store,
//           onState: (_, counter) {
//             return Column(
//               children: [
//                 TableCalendar(
//                   firstDay: DateTime.now(),
//                   lastDay: DateTime.utc(2030, 3, 14),
//                   focusedDay: DateTime.now(),
//                   calendarFormat: format,
//                   calendarStyle: const CalendarStyle(),
//                   headerStyle: const HeaderStyle(
//                       formatButtonVisible: false, titleCentered: true),
//                   locale: 'pt_BR',
//                 ),
//                 Expanded(
//                   child: Container(
//                     height: responsive
//                         .hp(format == CalendarFormat.twoWeeks ? 64.3 : 43.5),
//                     width: responsive.width,
//                     child: DraggableScrollableSheet(
//                       controller: controllerScrollable,
//                       maxChildSize: 1,
//                       minChildSize: 0.9,
//                       snapSizes: const [0.9, 1],
//                       initialChildSize: 1,
//                       builder: (BuildContext context,
//                           ScrollController scrollController) {
//                         return Container(
//                           color: Colors.blue[100],
//                           child: ListView.builder(
//                             controller: scrollController,
//                             itemCount: 25,
//                             itemBuilder: (BuildContext context, int index) {
//                               return ListTile(title: Text('Item $index'));
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//           onError: (context, error) => Center(child: Container()),
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     store.increment();
//       //   },
//       //   child: Icon(Icons.add),
//       // ),
//     );
//   }
// }
