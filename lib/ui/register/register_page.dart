import 'package:boilerplate/ui/login/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import '../../data/service/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
   final TextEditingController _namaController = new TextEditingController();
    final TextEditingController _alamatController = new TextEditingController();
    final TextEditingController _emailController = new TextEditingController();
    final TextEditingController _passwordController = new TextEditingController();
    final TextEditingController _tglAmbilSampahControler = new TextEditingController();
    
    final GlobalKey<FormState> _formKey = new GlobalKey();

    
  
  @override
  void initState() {
    _tglAmbilSampahControler.text = "";
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
   
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign Up',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          //create form with border
          Container(
            padding: EdgeInsets.all(15),
      
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //create email field
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text("Nama Lengkap",
                       style: TextStyle(
                         fontSize: 18,
                      ),),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _namaController,
                       validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nama Lengkap Harus Diisi';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.green,),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.green,
                          ),
                        ),
                       enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.green,
                          ),
                       ),
                       errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.red,
                          ),
                       ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text("Alamat",
                      style: TextStyle(
                        fontSize: 18,
                      ),),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _alamatController,
                       validator: (value) {
                        if (value!.isEmpty) {
                          return 'Alamat Harus Diisi';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.home, color: Colors.green,),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.green,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.green,
                            ),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.red,
                            ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text("Email", style: TextStyle(
                        fontSize: 18,
                      ),),
                      ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _emailController,
                       validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email Harus Diisi';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.green,),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.green,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.green,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text("Password", style: TextStyle(
                        fontSize: 18,
                      ),),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _passwordController,
                       validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password Harus Diisi';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.green,),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.green,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.green,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text("Pengambilan Sampah", style: TextStyle(
                        fontSize: 18,
                      ),),
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      controller: _tglAmbilSampahControler,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context, 
                          initialDate: DateTime.now(), 
                          firstDate: DateTime(2000), 
                          lastDate: DateTime(2030),
                          );

                        if (pickedDate != null) {
                          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                          setState(() {
                            _tglAmbilSampahControler.text = formattedDate;
                          });
                        }else{
                          print("tidak ada");
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.date_range, color: Colors.green,),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.green,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    Container(
                      width: 325,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          final String namaLengkap = _namaController.text.trim();
                          final String alamat = _alamatController.text.trim();
                          final String email = _emailController.text.trim();
                          final String password = _passwordController.text.trim();
                          final String tglAmbilSampah = _tglAmbilSampahControler.text.trim();

                          if (_formKey.currentState!.validate()) {}
                         
                         if(namaLengkap.isEmpty){
                           print("Nama Lengkap kosong");
                         }else{
                            if(alamat.isEmpty){
                              print("Alamat kosong");
                            }else{
                              if(email.isEmpty){
                                print("Email kosong");
                              }else{
                                if(password.isEmpty){
                                  print("Password kosong");
                                }else{
                                  if(tglAmbilSampah.isEmpty){
                                    print("Tanggal Pengambilan Sampah kosong");
                                  }else{
                                    context.read<AuthService>().register(
                                      email, password
                                      ).then((value) async{
                                        DatabaseReference data = FirebaseDatabase.instance.ref("warga");
                                        data.push().set({
                                          "nama": namaLengkap,
                                          "alamat": alamat,
                                          "email": email,
                                          "tglAmbilSampah": tglAmbilSampah,
                                        });
                                      });

                                    await   
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                  }
                                }
                              }
                            }
                         }
                          
                        }, 
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text("Sign Up",)
                      ),
                    ),
                    SizedBox(height: 15),
                    Container( 
                       //create hyperlink already have an account
                      child: Align(
                        alignment: Alignment.center,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                },
                              ),
                            ]
                          )
                          ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}