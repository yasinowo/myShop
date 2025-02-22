import 'package:aplle_shop_pj/data/bloc/carItem.dart/cardItem_event.dart';
import 'package:aplle_shop_pj/data/bloc/carItem.dart/cardItem_state.dart';
import 'package:aplle_shop_pj/data/datasourse/repository/carditem_repository.dart';
import 'package:aplle_shop_pj/util/paymnet/paymebt_handler.dart';
import 'package:bloc/bloc.dart';

class CardItemBloc extends Bloc<CardItemEvent, CarditemState> {
  final ICardItemRepository cardItemRepository;
  final PaymentHandler paymentHandler;

  CardItemBloc(
    this.paymentHandler,
    this.cardItemRepository,
  ) : super(CardItemInitState()) {
    on<CarItemFetchFromHiveEvent>(
      (event, emit) async {
        var cardItemList = await cardItemRepository.getAllCardItem();
        var finalPrice = await cardItemRepository.getCardItemFinalPrice();
        emit(CardItemfetchedState(cardItemList, finalPrice));
      },
    );

    on<CarItemInitPaymentEvent>(
      (event, emit) async {
        var finalPrice = await cardItemRepository.getCardItemFinalPrice();
        bool result = await paymentHandler.initPayment(finalPrice);
        if (result) {
          emit(CardItemSuccessPaymentState());
        } else {
          var cardItemList = await cardItemRepository.getAllCardItem();
          var finalPrice = await cardItemRepository.getCardItemFinalPrice();
          emit(CardItemFaildPaymentState(cardItemList, finalPrice));
        }
      },
    );

    on<CarItemPaymentRequestEvent>(
      (event, emit) async {
        paymentHandler.sendRequestPayment();
      },
    );

    on<CardItemRemoveEvent>(
      (event, emit) async {
        cardItemRepository.removeItem(event.index);
        // cardItemRepository.removeAllItem();

        var cardItemList = await cardItemRepository.getAllCardItem();
        var finalPrice = await cardItemRepository.getCardItemFinalPrice();
        emit(CardItemfetchedState(cardItemList, finalPrice));
      },
    );
    on<CardItemRemoveALLEvent>(
      (event, emit) async {
        cardItemRepository.removeAllItem();
        await cardItemRepository.getAllCardItem();
        await cardItemRepository.getCardItemFinalPrice();
        emit(CardItemSuccessPaymentState());
      },
    );
  }
}
