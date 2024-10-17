import 'package:go_router/go_router.dart';
import 'package:qrcode_bloc/model/product_model.dart';
import 'package:qrcode_bloc/pages/add_product.dart';
import 'package:qrcode_bloc/pages/login.dart';
import 'package:qrcode_bloc/routes/router_name.dart';
import 'package:qrcode_bloc/pages/detail_product.dart';
import 'package:qrcode_bloc/pages/home.dart';
import 'package:qrcode_bloc/pages/products.dart';
import 'package:firebase_auth/firebase_auth.dart';

// GoRouter configuration
final router = GoRouter(
  redirect: (context, state) {
    // cek kondisi login
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      // tidak sedang login
      return "/login";
    } else {
      return null;
    }
  },
  routes: [
    GoRoute(
        path: "/",
        name: AppRoute.homePage,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
              path: "product",
              name: AppRoute.productPage,
              builder: (context, state) => const ProductsPage(),
              routes: [
                GoRoute(
                  path: 'detailProduct',
                  name: AppRoute.detailProduct,
                  builder: (context, state) => DetailProductPage(
                    products: state.extra as ProductModel,
                  ),
                ),
              ]),
          GoRoute(
            path: "addProduct",
            name: AppRoute.addProduct,
            builder: (context, state) => AddProduct(),
          ),
        ]),
    GoRoute(
      path: "/login",
      name: AppRoute.login,
      builder: (context, state) => LoginPage(),
    ),
  ],
);
