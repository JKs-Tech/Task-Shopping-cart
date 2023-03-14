class CartItemModel {
  List<Cart>? cart;
  String? subtotal;
  String? tax;
  String? totalItems;
  String? status;

  CartItemModel(
      {this.cart, this.subtotal, this.tax, this.totalItems, this.status});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    subtotal = json['subtotal'];
    tax = json['tax'];
    totalItems = json['total_items'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (cart != null) {
      data['cart'] = cart!.map((v) => v.toJson()).toList();
    }
    data['subtotal'] = subtotal;
    data['tax'] = tax;
    data['total_items'] = totalItems;
    data['status'] = status;
    return data;
  }
}

class Cart {
  String? subProductId;
  String? productId;
  String? cartId;
  String? productImage;
  String? productName;
  String? subProductName;
  String? quantity;
  String? price;
  String? productSalePrice;
  String? bulkQty;
  String? size;
  String? colors;

  Cart(
      {this.subProductId,
      this.productId,
      this.cartId,
      this.productImage,
      this.productName,
      this.subProductName,
      this.quantity,
      this.price,
      this.productSalePrice,
      this.bulkQty,
      this.size,
      this.colors});

  Cart.fromJson(Map<String, dynamic> json) {
    subProductId = json['sub_product_id'];
    productId = json['product_id'];
    cartId = json['cart_id'];
    productImage = json['product_image'];
    productName = json['product_name'];
    subProductName = json['sub_product_name'];
    quantity = json['quantity'];
    price = json['price'];
    productSalePrice = json['product_sale_price'];
    bulkQty = json['bulk_qty'];
    size = json['size'];
    colors = json['colors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_product_id'] = subProductId;
    data['product_id'] = productId;
    data['cart_id'] = cartId;
    data['product_image'] = productImage;
    data['product_name'] = productName;
    data['sub_product_name'] = subProductName;
    data['quantity'] = quantity;
    data['price'] = price;
    data['product_sale_price'] = productSalePrice;
    data['bulk_qty'] = bulkQty;
    data['size'] = size;
    data['colors'] = colors;
    return data;
  }
}
