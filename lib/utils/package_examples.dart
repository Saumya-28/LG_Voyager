// This file contains examples and utilities for using the imported packages
// You can reference these examples when building your features

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Example 1: Using Bloc with Equatable
// Define events
abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class IncrementCounter extends CounterEvent {}
class DecrementCounter extends CounterEvent {}

// Define state
class CounterState extends Equatable {
  final int count;

  const CounterState({required this.count});

  @override
  List<Object> get props => [count];
}

// Define bloc
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(count: 0)) {
    on<IncrementCounter>((event, emit) {
      emit(CounterState(count: state.count + 1));
    });

    on<DecrementCounter>((event, emit) {
      emit(CounterState(count: state.count - 1));
    });
  }
}

// Example 2: GetIt Service Locator setup
// import 'package:get_it/get_it.dart';
//
// final getIt = GetIt.instance;
//
// void setupServiceLocator() {
//   // Register singleton
//   getIt.registerSingleton<SomeService>(SomeService());
//
//   // Register lazy singleton
//   getIt.registerLazySingleton<AnotherService>(() => AnotherService());
//
//   // Register factory
//   getIt.registerFactory<TempService>(() => TempService());
// }

// Example 3: SSH Connection (dartssh2)
// import 'package:dartssh2/dartssh2.dart';
//
// Future<SSHClient> connectSSH({
//   required String host,
//   required int port,
//   required String username,
//   required String password,
// }) async {
//   final client = SSHClient(
//     await SSHSocket.connect(host, port),
//     username: username,
//     onPasswordRequest: () => password,
//   );
//   return client;
// }
//
// Future<String> executeCommand(SSHClient client, String command) async {
//   final result = await client.run(command);
//   return utf8.decode(result);
// }

// Example 4: Riverpod Providers
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// // StateProvider
// final counterProvider = StateProvider<int>((ref) => 0);
//
// // FutureProvider
// final userProvider = FutureProvider<User>((ref) async {
//   return await fetchUser();
// });
//
// // StreamProvider
// final messagesProvider = StreamProvider<List<Message>>((ref) {
//   return messageStream();
// });
//
// // NotifierProvider
// class TodosNotifier extends Notifier<List<Todo>> {
//   @override
//   List<Todo> build() => [];
//
//   void addTodo(Todo todo) {
//     state = [...state, todo];
//   }
//
//   void removeTodo(String id) {
//     state = state.where((todo) => todo.id != id).toList();
//   }
// }
//
// final todosProvider = NotifierProvider<TodosNotifier, List<Todo>>(
//   () => TodosNotifier(),
// );

// Example 5: Google Maps usage
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapScreen extends StatefulWidget {
//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;
//
//   final LatLng _center = const LatLng(45.521563, -122.677433);
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       onMapCreated: _onMapCreated,
//       initialCameraPosition: CameraPosition(
//         target: _center,
//         zoom: 11.0,
//       ),
//     );
//   }
// }

// Example 6: Lottie Animations
// import 'package:lottie/lottie.dart';
//
// Widget buildLottieAnimation() {
//   return Lottie.asset(
//     'assets/animations/loading.json',
//     width: 200,
//     height: 200,
//     fit: BoxFit.fill,
//   );
// }
//
// Widget buildLottieFromNetwork() {
//   return Lottie.network(
//     'https://assets.example.com/animation.json',
//   );
// }

// Example 7: Progress State Button (Loading Button)
// import 'package:progress_state_button/progress_button.dart';
//
// class ButtonExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ProgressButton(
//       stateWidgets: {
//         ButtonState.idle: Text('Idle'),
//         ButtonState.loading: Text('Loading'),
//         ButtonState.fail: Text('Failed'),
//         ButtonState.success: Text('Success'),
//       },
//       stateColors: {
//         ButtonState.idle: Colors.blue,
//         ButtonState.loading: Colors.grey,
//         ButtonState.fail: Colors.red,
//         ButtonState.success: Colors.green,
//       },
//       onPressed: () async {
//         // Perform async operation
//         await Future.delayed(Duration(seconds: 2));
//       },
//       state: ButtonState.idle,
//     );
//   }
// }

// Example 8: Flutter Animated Button
// import 'package:flutter_animated_button/flutter_animated_button.dart';
//
// Widget buildAnimatedButton() {
//   return AnimatedButton(
//     height: 50,
//     width: 200,
//     text: 'Click Me',
//     isReverse: true,
//     selectedTextColor: Colors.black,
//     transitionType: TransitionType.LEFT_TO_RIGHT,
//     backgroundColor: Colors.blue,
//     borderColor: Colors.white,
//     borderRadius: 10,
//     borderWidth: 2,
//     onPress: () {
//       // Handle button press
//     },
//   );
// }

