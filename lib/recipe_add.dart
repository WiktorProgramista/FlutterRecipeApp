import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/ingradient.dart';
import 'package:flutter_application_1/recipe.dart';
import 'package:image_picker/image_picker.dart';

class RecipeAdd extends StatefulWidget {

  final recipeList;

  RecipeAdd(this.recipeList);

  @override
  _RecipeAddState createState() => _RecipeAddState();
}

class _RecipeAddState extends State<RecipeAdd> {

  TextEditingController title = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController measure = TextEditingController();
  TextEditingController name = TextEditingController();

  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if(image == null){
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to load image $e");
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe Add"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Name/Nazwa Przepisu",
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                pickImage(ImageSource.gallery);
              },
              child: const Text("Choose Image"),
            ),
            const SizedBox(height: 10),
            TextField(
          controller: quantity,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Ilość",
          ),
        ),
        SizedBox(height: 10,),
        TextField(
          controller: measure,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Miara",
          ),
        ),
        SizedBox(height: 10,),
        TextField(
          controller: name,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Nazwa produktu",
          ),
        ),
        const SizedBox(height: 10,),
        ElevatedButton(
        onPressed: () {
          setState(() {
            if(title.text != "" && quantity.text != "" && measure.text != "" && name.text != "" && image != null){
              widget.recipeList.add(
              Recipe(
                title.text, 
                image!,
                1,
                [
                  Ingradient(double.parse(quantity.text), measure.text, name.text),
                ]
              ),
            );
            Navigator.pop(context);
            }else{
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Któreś pole jest puste!')));
            }
          });
          },
          child: const Text('Zatwierdź'),
          )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
        },
      ),
    );
  }
}