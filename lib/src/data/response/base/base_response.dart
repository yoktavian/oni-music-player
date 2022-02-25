class BaseResponse<T> {
  final int resultCount;

  final T results;

  BaseResponse(this.resultCount, this.results);
}
