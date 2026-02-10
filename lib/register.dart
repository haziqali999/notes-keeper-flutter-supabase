import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'main.dart';


class Registerpage extends StatefulWidget{
  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  @override
  Widget build(BuildContext context) {
    final email=TextEditingController();
    final passward=TextEditingController();
    final supabase= Supabase.instance.client;

    bool loading=false;

    /////////////////////////////
    logindata() async{
      setState(() {
        loading=true;
      });

      try{
        final result=await supabase.auth.signUp(email: email.text, password: passward.text);
        if(result !=null && result.session !=null){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return Loginpage();
          }));
        }



      }catch(e){
        print(e.toString());
      }finally{
        setState(() {
          loading=false;
        });
      }
    }
    ////////////////////////
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade700,
        title: Center(child: Text("Register to Enjoy",style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800, color: Colors.white),)),

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
                controller: email,

                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                decoration: InputDecoration(

                    fillColor: Colors.deepPurple.shade700,
                    hintText: "Enter the Email",hintStyle: TextStyle(color: Colors.white70),
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
                controller: passward,

                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                decoration: InputDecoration(

                    fillColor: Colors.deepPurple.shade700,
                    hintText: "Enter the Passward",hintStyle: TextStyle(color: Colors.white70),
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
              logindata();
            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade500, // Button color
                  foregroundColor: Colors.white,      // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11), // Matching your theme!
                  ),
                ), child: Text("Register",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),)),
            SizedBox(height: 21,),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Loginpage()));
            }, child: Text("already have an account, Login!", style: TextStyle(color: Colors.white),))

          ],
        ),
      ),
    );
  }


}