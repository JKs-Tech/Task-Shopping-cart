import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoping_cart/constraint.dart';
import 'package:http/http.dart' as http;
import 'package:shoping_cart/models/cartItem_model.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    fatchCartItem();
    print("jk");
  }

  var data;
  Future<CartItemModel> fatchCartItem() async {
    //here we fetch shared prefrence token id
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? tokenId = await preferences.getString("Login");
    print(tokenId);

    final response = await http.post(
        Uri.parse("https://ecommerce.theprimoapp.com/api/get_cart_items"),
        body: ({"user_id": tokenId}));
    data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print(response.body);
      return CartItemModel.fromJson(data);
    } else {
      return CartItemModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textFiledbgColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  controller: search,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      suffixIcon: IconButton(
                          onPressed: () {
                            search.clear();
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ))),
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(224, 232, 232, 232),
                          borderRadius: BorderRadius.circular(3)),
                      child: const Center(
                          child: Icon(
                        Icons.card_giftcard_outlined,
                        size: 15,
                        color: Color.fromARGB(255, 116, 110, 110),
                      )),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(224, 232, 232, 232),
                            borderRadius: BorderRadius.circular(3)),
                        child: Center(
                            child: Text(
                          "USE DISCOUNT CODE",
                          style: GoogleFonts.abel(fontWeight: FontWeight.bold),
                        )),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              Expanded(
                child: FutureBuilder<CartItemModel>(
                    future: fatchCartItem(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        );
                      } else if (data["response_code"] == "1") {
                        return Column(
                          children: [
                            Container(
                              child: ListView.separated(
                                itemCount: snapshot.data!.cart!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 100,
                                            child: Image.network(
                                              data["cart"][0]["product_image"],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(data['cart'][0]
                                                  ['product_name']),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                data['cart'][0]
                                                    ['sub_product_name'],
                                                style: TextStyle(fontSize: 17),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(data['cart'][0]['size']),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Quantity",
                                                    style: GoogleFonts.aldrich(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 16),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                                Icons.remove)),
                                                        Text(data['cart'][0]
                                                            ['quantity']),
                                                        IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                                Icons.add)),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      data['cart'][0]['price']),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 16),
                                                    child: Icon(Icons.delete),
                                                  )
                                                ],
                                              )
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1.0, offset: Offset(3, 0)),
                                  ]),
                              width: double.infinity,
                              height: 140,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // discount tag
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Chip(
                                                label: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: const [
                                                Icon(Icons.local_offer),
                                                Text("0")
                                              ],
                                            ))
                                          ],
                                        ),
                                        // subtotal
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text("SUBTOTAL  "),
                                            Text(
                                              data["subtotal"],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            ),
                                          ],
                                        ),
                                        //chekout button
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.1,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Center(
                                                  child: Text(
                                                "CHECKOUT",
                                                style: GoogleFonts.anekLatin(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text("No cart Item"),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
