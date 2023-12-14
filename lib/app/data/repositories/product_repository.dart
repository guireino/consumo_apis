import 'dart:convert';

import 'package:consumo_apis/app/data/http/exceptions.dart';
import 'package:consumo_apis/app/data/http/http_client.dart';
import 'package:consumo_apis/app/data/models/product_model.dart';

abstract class IProductRepository {
  Future<List<ProductModel>> getProduct();
}

class ProductRepository implements IProductRepository {

  final IHttpClient client;

  ProductRepository({required this.client});

  @override
  Future<List<ProductModel>> getProduct() async {

    //buscando variáveis no site
    final response = await client.get(
      utl: 'https://dummyjson.com/products'
    );

    // verificando se deu certo
    if (response.statusCode == 200) {

        final List<ProductModel> products = [];
        final body = jsonDecode(response.body);

        //buscando na variável products a sua list de variável do item dos produtos
        body["products"].map((item) {
          final ProductModel product = ProductModel.fromMap(item);
          products.add(product);
        }).toList();

      return products;

    }else if(response.statusCode == 404){
      throw NotFoundException(message: "A url informada não e valida");
    } else {
      throw Exception("Não foi possível carregar os produtos");
    }

  }
  
}