import 'product.dart';

class Invoice {
  int invoiceNo;
  String cName;
  List<Product> products;

  Invoice({required this.invoiceNo, required this.cName,required this.products});
}