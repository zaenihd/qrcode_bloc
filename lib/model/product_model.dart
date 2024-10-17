class ProductModel {
    String? code;
    String? name;
    int? qty;
    String? productId;

    ProductModel({
        this.code,
        this.name,
        this.qty,
        this.productId,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        code: json["code"],
        name: json["name"],
        qty: json["qty"],
        productId: json["productId"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "qty": qty,
        "productId": productId,
    };
}
