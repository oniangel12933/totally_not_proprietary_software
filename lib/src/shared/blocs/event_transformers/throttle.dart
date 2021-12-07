import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

//import 'package:stream_transform/stream_transform.dart';
//import 'package:bloc_concurrency/bloc_concurrency.dart';

EventTransformer<E> throttle<E>(Duration duration) {
  return (events, mapper) {
    return events.throttleTime(duration).flatMap(mapper);
    //return droppable<E>().call(events.throttle(duration), mapper);
  };
}
