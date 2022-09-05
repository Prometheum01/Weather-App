mixin LoadingMixin {
  bool isLoading = false;

  changeLoading() {
    isLoading = !isLoading;
  }
}
