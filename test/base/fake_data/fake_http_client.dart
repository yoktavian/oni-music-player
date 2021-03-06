import 'dart:async';
import 'dart:io';
import 'dart:convert';

/// To override http request in test environment.
/// as you know that our widget contain an image network that using
/// http request to get image from network, in test environment
/// it going to be failed because the http API will directly return 400
/// so that the reason why we have to create this fake http override.
/// with this fake http override we just returning fake image if any
/// network image used in the screen.
class FakeHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => _FakeHttpClient();
}

class _FakeHttpClient implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri? url) {
    return Future.value(_FakeHttpClientRequest());
  }

  @override
  bool autoUncompress = false;

  @override
  Duration? connectionTimeout;

  @override
  late Duration idleTimeout;

  @override
  int? maxConnectionsPerHost;

  @override
  String? userAgent;

  @override
  void addCredentials(
      Uri url, String realm, HttpClientCredentials credentials) {
    // do nothing.
  }

  @override
  void addProxyCredentials(
      String host, int port, String realm, HttpClientCredentials credentials) {
    // do nothing.
  }

  @override
  set authenticate(
      Future<bool> Function(Uri url, String scheme, String realm)? f) {
    // do nothing.
  }

  @override
  set authenticateProxy(
      Future<bool> Function(String host, int port, String scheme, String realm)?
          f) {
    // do nothing.
  }

  @override
  set badCertificateCallback(
      bool Function(X509Certificate cert, String host, int port)? callback) {
    // do nothing.
  }

  @override
  void close({bool force = false}) {
    // do nothing.
  }

  @override
  Future<HttpClientRequest> delete(String host, int port, String path) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> deleteUrl(Uri url) {
    // TODO: implement deleteUrl
    throw UnimplementedError();
  }

  @override
  set findProxy(String Function(Uri url)? f) {
    // do nothing.
  }

  @override
  Future<HttpClientRequest> get(String host, int port, String path) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> head(String host, int port, String path) {
    // TODO: implement head
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> headUrl(Uri url) {
    // TODO: implement headUrl
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> open(
      String method, String host, int port, String path) {
    // TODO: implement open
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) {
    // TODO: implement openUrl
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> patch(String host, int port, String path) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> patchUrl(Uri url) {
    // TODO: implement patchUrl
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> post(String host, int port, String path) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> postUrl(Uri url) {
    // TODO: implement postUrl
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> put(String host, int port, String path) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<HttpClientRequest> putUrl(Uri url) {
    // TODO: implement putUrl
    throw UnimplementedError();
  }
}

class _FakeHttpClientRequest implements HttpClientRequest {
  @override
  HttpHeaders get headers => _FakeHttpHeaders();

  @override
  Future<HttpClientResponse> close() => Future.value(_FakeHttpClientResponse());

  @override
  bool bufferOutput = false;

  @override
  int contentLength = 0;

  @override
  late Encoding encoding;

  @override
  bool followRedirects = false;

  @override
  int maxRedirects = 0;

  @override
  bool persistentConnection = false;

  @override
  void abort([Object? exception, StackTrace? stackTrace]) {
    // do nothing
  }

  @override
  void add(List<int> data) {
    // do nothing
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    // do nothing
  }

  @override
  Future addStream(Stream<List<int>> stream) {
    // TODO: implement addStream
    throw UnimplementedError();
  }

  @override
  HttpConnectionInfo? get connectionInfo => throw UnimplementedError();

  @override
  List<Cookie> get cookies => throw UnimplementedError();

  @override
  Future<HttpClientResponse> get done => throw UnimplementedError();

  @override
  Future flush() {
    // TODO: implement flush
    throw UnimplementedError();
  }

  @override
  String get method => throw UnimplementedError();

  @override
  // TODO: implement uri
  Uri get uri => throw UnimplementedError();

  @override
  void write(Object? object) {
    // TODO: implement write
  }

  @override
  void writeAll(Iterable objects, [String separator = ""]) {
    // TODO: implement writeAll
  }

  @override
  void writeCharCode(int charCode) {
    // TODO: implement writeCharCode
  }

  @override
  void writeln([Object? object = ""]) {
    // TODO: implement writeln
  }
}

class _FakeHttpHeaders implements HttpHeaders {
  @override
  bool chunkedTransferEncoding = false;

  @override
  late int contentLength;

  @override
  ContentType? contentType;

  @override
  DateTime? date;

  @override
  DateTime? expires;

  @override
  String? host;

  @override
  DateTime? ifModifiedSince;

  @override
  bool persistentConnection = false;

  @override
  int? port;

  @override
  List<String>? operator [](String name) {
    // TODO: implement []
    throw UnimplementedError();
  }

  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {
    // do nothing.
  }

  @override
  void clear() {
    // do nothing.
  }

  @override
  void forEach(void Function(String name, List<String> values) action) {
    // do nothing.
  }

  @override
  void noFolding(String name) {
    // do nothing.
  }

  @override
  void remove(String name, Object value) {
    // do nothing.
  }

  @override
  void removeAll(String name) {
    // do nothing.
  }

  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {
    // do nothing.
  }

  @override
  String? value(String name) {
    // TODO: implement value
    throw UnimplementedError();
  }
}

class _FakeHttpClientResponse implements HttpClientResponse {
  @override
  HttpClientResponseCompressionState get compressionState {
    return HttpClientResponseCompressionState.notCompressed;
  }

  @override
  int get contentLength => _fakeImage.length;

  @override
  int get statusCode => HttpStatus.ok;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int>)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable(<List<int>>[_fakeImage]).listen(
      onData,
      onDone: onDone,
      onError: onError,
      cancelOnError: cancelOnError,
    );
  }

  @override
  Future<bool> any(bool Function(List<int> element) test) {
    // TODO: implement any
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> asBroadcastStream({
    void Function(StreamSubscription<List<int>> subscription)? onListen,
    void Function(StreamSubscription<List<int>> subscription)? onCancel,
  }) {
    // TODO: implement asBroadcastStream
    throw UnimplementedError();
  }

  @override
  Stream<E> asyncExpand<E>(Stream<E>? Function(List<int> event) convert) {
    // TODO: implement asyncExpand
    throw UnimplementedError();
  }

  @override
  Stream<E> asyncMap<E>(FutureOr<E> Function(List<int> event) convert) {
    // TODO: implement asyncMap
    throw UnimplementedError();
  }

  @override
  Stream<R> cast<R>() {
    // TODO: implement cast
    throw UnimplementedError();
  }

  @override
  X509Certificate? get certificate => throw UnimplementedError();

  @override
  HttpConnectionInfo? get connectionInfo => throw UnimplementedError();

  @override
  Future<bool> contains(Object? needle) {
    // TODO: implement contains
    throw UnimplementedError();
  }

  @override
  List<Cookie> get cookies => throw UnimplementedError();

  @override
  Future<Socket> detachSocket() {
    // TODO: implement detachSocket
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> distinct([
    bool Function(List<int> previous, List<int> next)? equals,
  ]) {
    // TODO: implement distinct
    throw UnimplementedError();
  }

  @override
  Future<E> drain<E>([E? futureValue]) {
    // TODO: implement drain
    throw UnimplementedError();
  }

  @override
  Future<List<int>> elementAt(int index) {
    // TODO: implement elementAt
    throw UnimplementedError();
  }

  @override
  Future<bool> every(bool Function(List<int> element) test) {
    // TODO: implement every
    throw UnimplementedError();
  }

  @override
  Stream<S> expand<S>(Iterable<S> Function(List<int> element) convert) {
    // TODO: implement expand
    throw UnimplementedError();
  }

  @override
  Future<List<int>> get first => throw UnimplementedError();

  @override
  Future<List<int>> firstWhere(
    bool Function(List<int> element) test, {
    List<int> Function()? orElse,
  }) {
    // TODO: implement firstWhere
    throw UnimplementedError();
  }

  @override
  Future<S> fold<S>(
    S initialValue,
    S Function(S previous, List<int> element) combine,
  ) {
    // TODO: implement fold
    throw UnimplementedError();
  }

  @override
  Future forEach(void Function(List<int> element) action) {
    // TODO: implement forEach
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> handleError(
    Function onError, {
    bool Function(dynamic)? test,
  }) {
    // TODO: implement handleError
    throw UnimplementedError();
  }

  @override
  HttpHeaders get headers => throw UnimplementedError();

  @override
  bool get isBroadcast => throw UnimplementedError();

  @override
  Future<bool> get isEmpty => throw UnimplementedError();

  @override
  bool get isRedirect => throw UnimplementedError();

  @override
  Future<String> join([String separator = ""]) {
    // TODO: implement join
    throw UnimplementedError();
  }

  @override
  // TODO: implement last
  Future<List<int>> get last => throw UnimplementedError();

  @override
  Future<List<int>> lastWhere(
    bool Function(List<int> element) test, {
    List<int> Function()? orElse,
  }) {
    // TODO: implement lastWhere
    throw UnimplementedError();
  }

  @override
  Future<int> get length => throw UnimplementedError();

  @override
  Stream<S> map<S>(S Function(List<int> event) convert) {
    // TODO: implement map
    throw UnimplementedError();
  }

  @override
  bool get persistentConnection => throw UnimplementedError();

  @override
  Future pipe(StreamConsumer<List<int>> streamConsumer) {
    // TODO: implement pipe
    throw UnimplementedError();
  }

  @override
  String get reasonPhrase => throw UnimplementedError();

  @override
  Future<HttpClientResponse> redirect([
    String? method,
    Uri? url,
    bool? followLoops,
  ]) {
    // TODO: implement redirect
    throw UnimplementedError();
  }

  @override
  List<RedirectInfo> get redirects => throw UnimplementedError();

  @override
  Future<List<int>> reduce(
    List<int> Function(List<int> previous, List<int> element) combine,
  ) {
    // TODO: implement reduce
    throw UnimplementedError();
  }

  @override
  // TODO: implement single
  Future<List<int>> get single => throw UnimplementedError();

  @override
  Future<List<int>> singleWhere(
    bool Function(List<int> element) test, {
    List<int> Function()? orElse,
  }) {
    // TODO: implement singleWhere
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> skip(int count) {
    // TODO: implement skip
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> skipWhile(bool Function(List<int> element) test) {
    // TODO: implement skipWhile
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> take(int count) {
    // TODO: implement take
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> takeWhile(bool Function(List<int> element) test) {
    // TODO: implement takeWhile
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> timeout(
    Duration timeLimit, {
    void Function(EventSink<List<int>> sink)? onTimeout,
  }) {
    // TODO: implement timeout
    throw UnimplementedError();
  }

  @override
  Future<List<List<int>>> toList() {
    // TODO: implement toList
    throw UnimplementedError();
  }

  @override
  Future<Set<List<int>>> toSet() {
    // TODO: implement toSet
    throw UnimplementedError();
  }

  @override
  Stream<S> transform<S>(StreamTransformer<List<int>, S> streamTransformer) {
    // TODO: implement transform
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> where(bool Function(List<int> event) test) {
    // TODO: implement where
    throw UnimplementedError();
  }
}

// Fake image, just a transparent pixel.
final _fakeImage = base64Decode(
  "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==",
);
