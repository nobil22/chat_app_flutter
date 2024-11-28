import 'package:flutter/material.dart';

class CustomTextfild extends StatelessWidget {
  CustomTextfild({this.onChanged,this.hinttext,this.obsecuertext=false});
  String? hinttext;
  Function(String)? onChanged;
  bool? obsecuertext;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecuertext!,
      validator: (value) {
        if(value!.isEmpty){
          return 'field is requierd';
        }

      },
      onChanged: onChanged,
      decoration: InputDecoration(
    
        hintText: hinttext,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
