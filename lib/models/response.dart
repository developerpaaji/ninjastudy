class VoidResponse {
  final dynamic error;

  VoidResponse({this.error});

  bool get isSuccess => error == null;
}

class ApiResponse<T> extends VoidResponse {
  final T? data;

  ApiResponse({this.data, dynamic error})
      : assert(data != null || error != null),
        super(error: error);
}
