abstract class CardItemEvent {}

class CarItemFetchFromHiveEvent extends CardItemEvent {}

class CarItemInitPaymentEvent extends CardItemEvent {
  int finalPrice;
  CarItemInitPaymentEvent(this.finalPrice);
}

class CarItemPaymentRequestEvent extends CardItemEvent {}

class CarItemDeepLinkEvent extends CardItemEvent {}

class CardItemRemoveEvent extends CardItemEvent {
  int index;
  CardItemRemoveEvent(this.index);
}

class CardItemRemoveALLEvent extends CardItemEvent {
  CardItemRemoveALLEvent();
}
