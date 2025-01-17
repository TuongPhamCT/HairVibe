abstract class HandlerInterface<T> {
  void setNext(HandlerInterface handler);
  void handle(T request);
}