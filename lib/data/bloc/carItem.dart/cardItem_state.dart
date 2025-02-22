import 'package:aplle_shop_pj/data/model/card_item.dart';
import 'package:dartz/dartz.dart';

abstract class CarditemState {}

class CardItemInitState extends CarditemState {}

class CardItemfetchedState extends CarditemState {
  Either<String, List<CardItem>> cardItem;
  int cardItemFinalPrice;
  CardItemfetchedState(this.cardItem, this.cardItemFinalPrice);
}

class CardItemSuccessPaymentState extends CarditemState {}

class CardItemFaildPaymentState extends CarditemState {
  Either<String, List<CardItem>> cardItem;
  int cardItemFinalPrice;
  CardItemFaildPaymentState(this.cardItem, this.cardItemFinalPrice);
}
