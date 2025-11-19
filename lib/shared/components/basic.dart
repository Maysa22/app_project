import 'package:flutter/material.dart';
///---------------------------الحقول-----------------------------------///
class CustomTextField extends StatefulWidget {
  String label;
  TextEditingController controller;
  bool isPassword;
  IconData? prefixIcon;
  IconData? suffixIcon;
  VoidCallback? onSuffixTap;
  String? Function(String?)? validator;
  TextInputType keyboardType;

  CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(20),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(),
          prefix: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          suffix: widget.suffixIcon != null
              ? InkWell(
            onTap: widget.onSuffixTap,
            child: Icon(widget.suffixIcon),
          )
              : null,
        ),
      ),
    );
  }
}

///---------------------------الزر-----------------------------------///
class CustomButton extends StatelessWidget {
  String text;
  VoidCallback onPressed;
  Color color;
  double height;
  double radius;
  IconData? icon;

  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.height = 50,
    this.radius = 12,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(icon, color: Colors.white),
            if (icon != null)
              SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}