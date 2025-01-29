// ignore_for_file: non_constant_identifier_names

import 'dart:async';

Future<T> PendingFuture<T>() => Completer<T>().future;