import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/recipe.dart';

class RecipeDetails extends StatefulWidget {

  final Recipe recipe;
  final File image;
  final List<Recipe> list;

  RecipeDetails(this.recipe, this.list, this.image, {Key? key}) : super(key: key);

  int sliderValue = 1;

  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.recipe.name,
              style: const TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(7.0),
                itemCount: widget.recipe.ingradients.length,
                itemBuilder: (BuildContext context, int index) {
                  final ingredient = widget.recipe.ingradients[index];
                  return Text(
                      '${ingredient.quantity * widget.sliderValue} ${ingredient.measure} ${ingredient.name}');
                },
              ),
            ),
            Slider(
              min: 1,
              max: 10,
              divisions: 10,
              label: "${widget.sliderValue * widget.recipe.serving}",
              value: widget.sliderValue.toDouble(),
              onChanged: (value){
                setState(() {
                  widget.sliderValue = value.round();
                });
              },
              activeColor: Colors.green,
              inactiveColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}