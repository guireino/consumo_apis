import 'package:consumo_apis/app/data/http/exceptions.dart';
import 'package:consumo_apis/app/data/models/product_model.dart';
import 'package:consumo_apis/app/data/repositories/product_repository.dart';
import 'package:flutter/material.dart';

// essa class vai cuidar dos produtos que vai aparecer na tela.
class ProductStore {

  final IProductRepository repository;

  // Variável reativa para o loading da tela
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Variável reativa para o state da tela
  final ValueNotifier<List<ProductModel>> state = ValueNotifier<List<ProductModel>>([]);

  // Variável reativa para o erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');
  
  ProductStore({required this.repository});

  Future getProducts() async {
    
    isLoading.value = true;

    try {
      final result = await repository.getProduct();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    }catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }

}