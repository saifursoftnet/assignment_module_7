import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductList(),
      title: "Counter App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: TextTheme(
            bodyLarge: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          )
      ),
    );
  }

}

//=======CART ROUTE ========
class ProductList extends StatefulWidget{
  const ProductList({super.key});

  @override
  State<StatefulWidget> createState() {
    return ProductListUI();
  }

}

class ProductListUI extends State<ProductList>{
  Map<String, int> totalProducts = {
    "Apple": 30,
    "Jack Fruit": 65,
    "Mango": 20,
    "Banana": 10,
    "Strawberry": 15,
    "Guava": 35,
    "Water Melon": 100,
    "Orange": 80
  };
  List<int> addToCart = [0,0,0,0,0,0,0,0];

  //======CUSTOM ALERT DIALOG=======
  AlertDialog MyAlertDialog(String ProductName){
    return AlertDialog(
      title: Text("Congratulations!"),
      content: Text("You've bought 5 $ProductName!"),
      actions: [
        TextButton(onPressed: (){Navigator.pop(context);}, child: Text("OK")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Product List")),
      ),
      body: ListView.builder(
        itemCount: totalProducts.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text("${totalProducts.keys.elementAt(index)}"),
            subtitle: Text("\$${totalProducts.values.elementAt(index)}"),
            trailing: Column(
              children: [
                Text("counter ${addToCart[index]}"),
                ElevatedButton(
                  onPressed: (){
                    if(addToCart[index] < 5){
                      addToCart[index]++;
                      setState(() {});
                    }else{
                      showDialog(context: context, barrierDismissible: false ,builder: (context){
                        return MyAlertDialog(totalProducts.keys.elementAt(index));
                      });
                    }
                  },
                  child: Text("Buy Now"),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return AddToCartState(addToCart: addToCart);
          }));
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }

}

//=======CART ROUTE ========
class AddToCartState extends StatefulWidget{
  late List<int> addToCart;
  AddToCartState({super.key, required this.addToCart});

  @override
  State<StatefulWidget> createState() {
    return AddToCartScreen();
  }

}
class AddToCartScreen extends State<AddToCartState>{
  int totalProductsCount = 0;

  @override
  initState(){
    super.initState();
    for(int eachCartItems in widget.addToCart){
      if(eachCartItems != 0){
        totalProductsCount += 1;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Total Product: ${totalProductsCount}", style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),
      ),
    );
  }

}