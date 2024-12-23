import 'package:chat_app/constants/app_style.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text, required this.onPressed, required this.backgroundColor, required this.textColor, 
  });

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.sizeOf(context).height;
    double screenWidth=MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Semantics(
        button: true, 
        label:  text ,
        child: ElevatedButton(
            style:ElevatedButton.styleFrom(
                minimumSize:  Size(screenWidth, screenHeight * 0.06),
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: textColor,
                    width: 1,
                  ),
                )
            ) ,
            onPressed: onPressed,
            child: Text(text,style:AppStyle.poppins400style16.copyWith(color: textColor,))
        ),
      ),
    );
  }
}