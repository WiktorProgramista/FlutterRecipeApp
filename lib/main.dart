import 'package:flutter/material.dart';
import 'package:flutter_application_1/recipe.dart';
import 'package:flutter_application_1/recipe_add.dart';
import 'package:flutter_application_1/recipe_details.dart';

void main() => runApp(const MyRecipeApp());

class MyRecipeApp extends StatelessWidget {
  const MyRecipeApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<void> refreshList() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      recipes = recipes;
    });
  }

  @override
  void initState() {
    super.initState();
    recipes = recipes;
  }

  removeRecipe(int index){
    setState(() {
      recipes.removeAt(index);
    });
  }

  List<Recipe> recipes = [];

  Widget myCardWidget(Recipe recipe, int index){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return RecipeDetails(recipe, recipes, recipe.imgFile);
            },
          ));
        },
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            removeRecipe(index);
          },
          child: Card(
            child: Column(
              children: [
                Image.file(recipe.imgFile),
                Text(recipe.name),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe App"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeAdd(recipes)));
            }, 
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (BuildContext context, int index){
            return myCardWidget(recipes[index], index);
          }
        ),
      ),
    );
  }
}