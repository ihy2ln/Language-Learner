import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// A canned response for one fake HTTP call.
class FakeResponse {
  const FakeResponse({
    required this.statusCode,
    this.body,
    this.headers = const {},
  });

  final int statusCode;

  /// A `String` is sent as-is; anything else is `jsonEncode`'d.
  final Object? body;
  final Map<String, List<String>> headers;
}

/// Hand-rolled [HttpClientAdapter] for tests — no live network, no mock
/// package dependency (Dio's own adapter interface is small enough not
/// to need one). Records every request it receives and returns canned
/// responses queued via [enqueue], in FIFO order.
///
/// An empty queue means: if a test doesn't queue a response, any
/// [KeyValidationSuccess] a code path under test manages to produce did
/// *not* come from reading a real network response — see
/// "validateKey cannot report success without hitting the network" in the
/// adapter test files, which relies on exactly this.
class FakeHttpClientAdapter implements HttpClientAdapter {
  final List<RequestOptions> requests = [];
  final List<FakeResponse> _queue = [];

  void enqueue(FakeResponse response) => _queue.add(response);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    if (_queue.isEmpty) {
      throw StateError(
        'FakeHttpClientAdapter: no queued response for '
        '${options.method} ${options.uri}',
      );
    }
    final response = _queue.removeAt(0);
    final bodyText = response.body is String
        ? response.body as String
        : jsonEncode(response.body);
    return ResponseBody.fromString(
      bodyText,
      response.statusCode,
      headers: {
        'content-type': ['application/json'],
        ...response.headers,
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
