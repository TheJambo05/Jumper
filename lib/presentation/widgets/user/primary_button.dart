import 'package:flutter/cupertino.dart';
import '../../../core/design.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? color;

  const PrimaryButton(
      {super.key, required this.text, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
        onPressed: onPressed,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: color ?? AppColors.black,
        child: Text(text),
      ),
    );
  }
}
