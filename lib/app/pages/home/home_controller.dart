import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delivery_app_dw9/app/dto/order_product_dto.dart';

import '../../repositories/products/products_repository.dart';
import 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final ProductsRepository _productsRepository;
  HomeController(
    this._productsRepository,
  ) : super(const HomeState.initial());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      final products = await _productsRepository.findAllProducts();
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: HomeStateStatus.loaded, products: products));
    } on Exception catch (e, s) {
      log("Erro ao buscar produtos!", error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: HomeStateStatus.error,
          errorMessage: "Erro ao buscar produtos!",
        ),
      );
    }
    emit(state.copyWith(status: HomeStateStatus.loaded));
  }

  void addOrUpdateBag(OrderProductDto orderProduct) {
    final shoppingBag = [...state.shoppingBag]; // duplicando lista
    final orderIndex = shoppingBag
        .indexWhere((orderP) => orderP.product == orderProduct.product);

    if (orderIndex > -1) { // if (orderIndex != -1) ?
      if (orderProduct.amount == 0) {
        shoppingBag.removeAt(orderIndex);
      } else {
        shoppingBag[orderIndex] = orderProduct;
      }
    } else {
      shoppingBag.add(orderProduct);
    }
    emit(state.copyWith(shoppingBag: shoppingBag));
  }

  void updateBag(List<OrderProductDto> updatedBag) {
    emit(
      state.copyWith(
        shoppingBag: updatedBag,
        // status: HomeStateStatus.bagUpdated,
      ),
    );
  }
}
