import 'dart:math'; // ใช้สำหรับการสุ่มตัวเลข
import 'package:flutter/material.dart';
import 'FoodMenu.dart'; // นำเข้าไฟล์ FoodMenu.dart
 
void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo : Food Order'),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
 
  final String title;
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  final List<FoodMenu> selectedMenu = []; // รายการอาหารที่ถูกเลือก
  final Random _random = Random(); // ตัวสุ่ม
 
  // คำนวณราคารวม
  int get totalPrice =>
      selectedMenu.fold(0, (total, menu) => total + menu.price);
 
  // ฟังก์ชันสุ่มเพิ่มรายการอาหาร
  void _addRandomFood() {
    setState(() {
      int randomIndex = _random.nextInt(foodMenuList.length); // สุ่ม index
      selectedMenu.add(foodMenuList[randomIndex]); // เพิ่มเมนูที่สุ่มได้
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          '${widget.title} - Total Price: $totalPrice',
          style: const TextStyle(fontSize: 18),
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: selectedMenu.length,
          itemBuilder: (context, index) {
            final food = selectedMenu[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text('${food.price}'), // แสดงราคา
              ),
              title: Text('Dish $index is ${food.name}'),
              subtitle: Text(
                'This menu ingredients are ${food.ingredients.join(", ")}',
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRandomFood, // เรียกใช้ฟังก์ชันเพิ่มอาหาร
        child: const Icon(Icons.add),
      ),
    );
  }
}