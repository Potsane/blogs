import 'package:flutter/material.dart';

import '../theme/app_pallete.dart';

class TwoPartRichText extends StatelessWidget {
  final String partOne;
  final String partTwo;
  final void Function() onClick;

  const TwoPartRichText({
    super.key,
    required this.partOne,
    required this.partTwo,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: onClick,
            child: RichText(
              text: TextSpan(
                text: partOne,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: AppPallete.lightBlue700,
                    ),
                children: <TextSpan>[
                  TextSpan(
                    text: " $partTwo",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: AppPallete.lightBlue300,
                        ),
                  )
                ],
              ),
            ))
      ],
    );
  }
}
