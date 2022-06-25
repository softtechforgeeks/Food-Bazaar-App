import 'package:flutter/material.dart';

import 'package:flutter_login_ui/screens/home/home_screen.dart';
import 'package:flutter_login_ui/widgets/button_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../api/pdf_invoice_api.dart';
import '../../../api/pdf_api.dart';
import '/route/routing_page.dart';
import 'package:flutter_login_ui/widgets/my_button.dart';
import 'package:flutter_login_ui/appColors/app_colors.dart';
import 'package:flutter_login_ui/models/invoice.dart';
import 'package:flutter_login_ui/models/order_model.dart';
import 'package:flutter_login_ui/models/customer.dart';
import 'package:flutter_login_ui/models/supplier.dart';

class OrderConfirmation extends StatelessWidget {
  static const String routeName = '/order-confirmation';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => OrderConfirmation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Order Confirmation",
          style: TextStyle(
            color: AppColors.KblackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: 300,
                ),
                Positioned(
                  left: (MediaQuery.of(context).size.width - 100) / 2,
                  top: 85,
                  child: SvgPicture.asset(
                    'assets/svgs/garlands.svg',
                    height: 100,
                    width: 100,
                  ),
                ),
                Positioned(
                  top: 250,
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Your order is complete!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            ButtonWidget(
                text: 'Invoice PDF',
                onClicked: () async {
                  final date = DateTime.now();
                  final dueDate = date.add(Duration(days: 7));

                  final invoice = Invoice(
                    supplier: Supplier(
                      name: 'Sarah Field',
                      address: 'Sarah Street 9, Beijing, China',
                      paymentInfo: 'https://paypal.me/sarahfieldzz',
                    ),
                    customer: Customer(
                      name: 'Apple Inc.',
                      address: 'Apple Street, Cupertino, CA 95014',
                    ),
                    info: InvoiceInfo(
                      date: date,
                      dueDate: dueDate,
                      description: 'My description...',
                      number: '${DateTime.now().year}-9999',
                    ),
                    items: [
                      InvoiceItem(
                        description: 'Coffee',
                        date: DateTime.now(),
                        quantity: 3,
                        vat: 0.19,
                        unitPrice: 5.99,
                      ),
                      InvoiceItem(
                        description: 'Water',
                        date: DateTime.now(),
                        quantity: 8,
                        vat: 0.19,
                        unitPrice: 0.99,
                      ),
                      InvoiceItem(
                        description: 'Orange',
                        date: DateTime.now(),
                        quantity: 3,
                        vat: 0.19,
                        unitPrice: 2.99,
                      ),
                      InvoiceItem(
                        description: 'Apple',
                        date: DateTime.now(),
                        quantity: 8,
                        vat: 0.19,
                        unitPrice: 3.99,
                      ),
                      InvoiceItem(
                        description: 'Mango',
                        date: DateTime.now(),
                        quantity: 1,
                        vat: 0.19,
                        unitPrice: 1.59,
                      ),
                      InvoiceItem(
                        description: 'Blue Berries',
                        date: DateTime.now(),
                        quantity: 5,
                        vat: 0.19,
                        unitPrice: 0.99,
                      ),
                      InvoiceItem(
                        description: 'Lemon',
                        date: DateTime.now(),
                        quantity: 4,
                        vat: 0.19,
                        unitPrice: 1.29,
                      ),
                    ],
                  );

                  final pdfFile = await PdfInvoiceApi.generate(invoice);

                  PdfApi.openFile(pdfFile);
                }),
          ],
        ),
      ),
      bottomNavigationBar: MyButton(
        text: "Home",
        onPressed: () {
          RoutingPage.goTonext(context: context, navigateTo: HomeScreen());
        },
      ),
    );
  }
}
