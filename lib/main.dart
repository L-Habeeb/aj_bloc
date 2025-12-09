import 'package:aj_todo/blocs/bloc_exports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'screens/tasks_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize BlocObserver for debugging
  Bloc.observer = MyBlocObserver();
  
  // Setup HydratedBloc storage - correct syntax for hydrated_bloc 10.x
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getApplicationDocumentsDirectory()).path),
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc(),
      child: MaterialApp(
        title: 'Flutter Tasks App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const TasksScreen(),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
//
// class AppThemes {
//   static final appThemeData = {
//     AppTheme.darkTheme: ThemeData(
//       primarySwatch: Colors.grey,
//       primaryColor: Colors.black,
//       brightness: Brightness.dark,
//       backgroundColor: const Color(0xFF212121),
//       dividerColor: Colors.black54,
//       floatingActionButtonTheme: const FloatingActionButtonThemeData(
//         backgroundColor: Colors.white,
//       ),
//       textButtonTheme: TextButtonThemeData(
//         style: ButtonStyle(
//           foregroundColor: MaterialStateProperty.all(Colors.white),
//         ),
//       ),
//       textTheme: const TextTheme(
//         subtitle1: TextStyle(color: Colors.white),
//       ),
//       bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//           backgroundColor: Colors.grey, unselectedItemColor: Colors.white),
//     ),
//
//     //
//     //
//
//     AppTheme.lightTheme: ThemeData(
//       primarySwatch: Colors.grey,
//       primaryColor: Colors.white,
//       brightness: Brightness.light,
//       backgroundColor: const Color(0xFFE5E5E5),
//       dividerColor: const Color(0xff757575),
//       floatingActionButtonTheme: const FloatingActionButtonThemeData(
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//       ),
//       textButtonTheme: TextButtonThemeData(
//         style: ButtonStyle(
//           foregroundColor: MaterialStateProperty.all(Colors.black),
//         ),
//       ),
//       textTheme: const TextTheme(
//         subtitle1: TextStyle(color: Colors.black),
//       ),
//       bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//           backgroundColor: Colors.grey,
//           selectedItemColor: Colors.black,
//           unselectedItemColor: Colors.white),
//     ),
//   };
// }
