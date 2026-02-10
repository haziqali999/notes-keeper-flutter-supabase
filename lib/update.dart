import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



class UpdateScreen extends StatefulWidget{
  final Map<String, dynamic> nodes;////catching the node required  to update...
  const UpdateScreen({super.key, required this.nodes});
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final data=TextEditingController();

  final desc=TextEditingController();

  final supabase= Supabase.instance.client;

  bool loading=false;
  bool c=false,d=false;

  void initState() {
    data.text= widget.nodes['data'];
    desc.text=widget.nodes['description'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade700,
        title: Center(child: Text("Add New Notes",style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800, color: Colors.white),)),

      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.deepPurple.shade300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /////////////////////////
            TextField(
                controller: data,
                onTap: (){
                  setState(() {
                    c= true;
                    d=false;
                  });
                },
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                decoration: InputDecoration(
                    filled: c,
                    fillColor: Colors.deepPurple.shade700,
                    hintText: "Enter the data",hintStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(11)
                    ),
                    focusedBorder: OutlineInputBorder(

                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(11)
                    )
                )
            ),
            SizedBox(height: 15,),
            TextField(
                controller: desc,
                onTap: (){
                  setState(() {
                    c=false;
                    d=true;
                  });
                },
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                decoration: InputDecoration(
                    filled: d,
                    fillColor: Colors.deepPurple.shade700,
                    hintText: "Enter the description",hintStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(11)
                    )
                )
            ),
            SizedBox(height: 25,),
            loading? Center(child: CircularProgressIndicator(),):
            ElevatedButton(onPressed: (){
              Updatedata();
              Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage(title: "Notes Taker")));
            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade500, // Button color
                  foregroundColor: Colors.white,      // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11), // Matching your theme!
                  ),
                ), child: Text("Update",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),))

          ],
        ),
      ),
    );
  }

  void Updatedata() async{
    setState(() {
      loading=true;
    });
    try{
      await supabase.from('Notes').update({
        'data': data.text,
        'description': desc.text
      }).eq('id', widget.nodes['id']);
    }catch(e){
      print(e);
    }
    setState(() {
      loading=false;
    });
  }


}