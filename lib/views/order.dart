import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order/models/app_data_model.dart';
import 'package:http/http.dart' as http;
import '../services/http_request.dart';

class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            // Container(height: MediaQuery.of(context).size.height*0.25,
            // decoration: const BoxDecoration(color: Color(0xffE73D6F),
            //   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70),
            //   bottomRight: Radius.circular(70),
            //   )
            // ),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: const [Text("Order"), Text("close")],),),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Order",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                  const Text(
                    "close",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            OrderCard(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 5, right: 5, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const OrderPrice(
                      price: "\$49.50",
                      title: "Subtotal",
                    ),
                    const OrderPrice(
                      price: "\$2.75",
                      title: "Tax & Fees",
                    ),
                    const OrderPrice(
                      price: "Free",
                      title: "Delivery",
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const SizedBox(
                        width: 300,
                        child: Divider(
                          height: 1.0,
                          color: Colors.grey,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Total",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 25),
                        ),
                        Text("\$52.25",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 25)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            OrderCard(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: ListView(
                  children: [
                    FutureBuilder<List<UserInfo>>(
                      future: fetchUsers(
                        http.Client(),
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Orderlist(
                                    id: snapshot.data![index].id.toString(),
                                    firstname: snapshot.data![index].firstname,
                                    lastname: snapshot.data![index].lastname,
                                    image: snapshot.data![index].imageUrl,
                                    email: snapshot.data![index].email,
                                  ),
                                  Divider(),
                                ],
                              );
                            },
                          );
                          //ContentCard();

                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50.0,
          margin: const EdgeInsets.only(top: 25.0, bottom: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xffE73D6F),
              border: Border.all(color: Colors.grey)),
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
              child: Center(
                  child: Text(
                'Checkout',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ))),
        ),
      ),
    );
  }
}

class OrderPrice extends StatelessWidget {
  final String title;
  final String price;

  const OrderPrice({
    Key? key,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        Text(price, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class Orderlist extends StatelessWidget {
  final String id;
  final String firstname;
  final String lastname;
  final String image;
  final String email;
  const Orderlist({
    Key? key,
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.image,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4.0),
      width: double.infinity,
      height: 70.0,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(image)),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
            ),
          ),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.0),
              Text(
                firstname + ' ' + lastname,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                email,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
              SizedBox(height: 6.0),
              Text(
                '\$29.50',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.pink),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Widget child;
  final double height;
  const OrderCard({
    Key? key,
    required this.child,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: height,
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 1),
              )
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            color: Colors.white),
        child: child,
      ),
    );
  }
}
