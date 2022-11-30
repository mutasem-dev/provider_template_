import 'package:flutter/material.dart';
import 'invoice.dart';
import 'invoice_page.dart';
import 'product.dart';
void main() {
  runApp(
      MaterialApp(
        
        home: MainPage(),
      )
  );
}
TextEditingController cnameController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController quantityController = TextEditingController();

class MainPage extends StatefulWidget {
  List<Product> products=[];
  List<Invoice> invoices = [];
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int invoiceNo = 1;
  _showDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: const Text('Product Info',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: false,
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'product name',
              ),
            ),
            TextField(
              autofocus: false,
              keyboardType: TextInputType.number,
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'price',
              ),
            ),
            TextField(
              autofocus: false,
              keyboardType: TextInputType.number,
              controller: quantityController,
              decoration: const InputDecoration(
                labelText: 'quantity',
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                int q=0;
                double p =0;
                String name='';
                if(nameController.text.isEmpty) {
                  const snackBar = SnackBar(content: Text('You must Enter product name'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }
                try {
                  q = int.parse(quantityController.text);
                  p = double.parse(priceController.text);
                } catch(e) {
                  var snackBar = SnackBar(content: Text('Error: ${e.toString()}'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }
                widget.products.add(
                    Product(
                        name: nameController.text,
                        price: p,
                        quantity: q
                    )
                );
                Navigator.of(context).pop();
                setState(() {
                  nameController.clear();
                  priceController.clear();
                  quantityController.clear();
                });
              },
              child: const Text('add'),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice# $invoiceNo'),
      ),
      body: Column(
        children: [
          TextField(
            autofocus: false,
            controller: cnameController,
            decoration: const InputDecoration(
              labelText: 'customer name',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Products:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
              ElevatedButton(
                  onPressed: () {
                    _showDialog(context);
                  },
                  child: const Text('add product'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.blue,
                      leading: Text(widget.products[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                      title: Text('price: ${widget.products[index].price}'),
                      subtitle: Text('quantity: ${widget.products[index].quantity}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                            widget.products.removeAt(index);
                            setState(() {

                            });
                        },
                      ),
                    ),
                  );
                },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(

                  onPressed: () {
                    if(cnameController.text.isEmpty) {
                      const snackBar = SnackBar(content: Text('You must Enter customer name'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if(widget.products.isEmpty) {
                      const snackBar = SnackBar(content: Text('You must add at least one product'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    widget.invoices.add(
                      Invoice(invoiceNo: invoiceNo++, cName: cnameController.text, products: widget.products)
                    );
                    cnameController.clear();
                    widget.products = [];
                    setState(() {

                    });
                  },
                  child: Text('add invoice')
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => InvoicesPage(widget.invoices),));
                  },
                  child: Text('show all invoices')
              ),
            ],
          ),
        ],
      ),
    );
  }
}