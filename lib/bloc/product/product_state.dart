part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoadingDelete extends ProductState {}

final class ProductLoadingUpdate extends ProductState {}

final class ProductLoadingExport extends ProductState {}

final class ProductUploaded extends ProductState {}

final class ProductExported extends ProductState {}

final class ProductDeleted extends ProductState {}

final class ProductEdited extends ProductState {}

final class ProductError extends ProductState {
  final String message;

  ProductError({required this.message});
}
