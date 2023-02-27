import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextAndVoiceField extends StatefulWidget {
  const TextAndVoiceField({super.key});

  @override
  State<TextAndVoiceField> createState() => _TextAndVoiceField();
}

class _TextAndVoiceField extends State<TextAndVoiceField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }
}
