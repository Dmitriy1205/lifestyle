class Status {
  final bool isInitial;
  final bool isLoading;
  final bool isVideoLoading;
  final bool isError;
  final bool isLoaded;
  final bool isVideoLoaded;
  final String? errorMessage;
  final String? attribute;

  Status._({
    this.isInitial = false,
    this.isLoading = false,
    this.isVideoLoading = false,
    this.isError = false,
    this.isLoaded = false,
    this.isVideoLoaded = false,
    this.errorMessage,
    this.attribute,
  });

  factory Status.initial() {
    return Status._(isInitial: true);
  }

  factory Status.loading() {
    return Status._(isLoading: true);
  }

  factory Status.videoLoading() {
    return Status._(isVideoLoading: true);
  }

  factory Status.loaded() {
    return Status._(isLoaded: true, isLoading: false);
  }
  factory Status.videoLoaded() {
    return Status._(isVideoLoaded: true, isVideoLoading: false);
  }

  factory Status.error([String? message, String? attribute]) {
    return Status._(
      isError: true,
      isLoading: false,
      isVideoLoading: false,
      errorMessage: message,
      attribute: attribute,
    );
  }
}
