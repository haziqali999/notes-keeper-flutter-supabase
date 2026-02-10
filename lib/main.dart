import 'package:flutter/material.dart';
import 'package:mini_app/add_notes.dart';
import 'package:mini_app/login.dart';
import 'package:mini_app/splash_screen.dart';
import 'package:mini_app/update.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['ANNONKEY']!
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple.shade700),
      ),
      home: Splashscreen(),
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

final supabase= Supabase.instance.client;
  List<Map<String, dynamic>> nodes= [];
  //////////////////
  @override
  void initState() {
    getNode();
    super.initState();
  }
  /////////////////
  void getNode()async{
    try{
     final result=await supabase.from('Notes').select();
     setState(() {
       nodes=result;
     });
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(onPressed: () async{
            await supabase.auth.signOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Loginpage(),

            ), (value) => false );
          },style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple.shade200, // Button color
            foregroundColor: Colors.white,      // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(21), // Matching your theme!
            ),
          ),  child: Text("Logout",style: TextStyle(fontWeight: FontWeight.w500))
          ),
        ],
        backgroundColor: Colors.deepPurple.shade700,
        title: Center(child: Text("Your's Data",style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800, color: Colors.white),)),

      ),
body: Container(
  height: double.infinity,
  width: double.infinity,
  color: Colors.deepPurple.shade300,
  child: Center(
    child: ListView(
      padding: const EdgeInsets.all(12.0),
      children: [
        for(var i in nodes)...{

          Container(

          decoration: BoxDecoration(
          color: Colors.deepPurple.shade500,
            borderRadius: BorderRadius.circular(21)
          ),
           child: Center(

               child: ListTile(
                 
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateScreen(nodes: i)));
                 },


                  title: Text(i['data'], style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.white),),
                  subtitle: Text(i['description'], style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.white)),
                  /////////////////////////////////////////////
                 trailing: IconButton(onPressed: () async{

                   await supabase.from('Notes').delete().eq('id', i['id']);

                   setState(() {
                     getNode();
                   });

                 }, icon: Icon(Icons.delete),color: Colors.white,),

                ),


           )

          ),
          SizedBox(height: 11,)
        }

      ],
    ),
  ),
),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Addscreen()));
      }, backgroundColor: Colors.deepPurple.shade200,child: Icon(Icons.add),),
      );
  }
}
