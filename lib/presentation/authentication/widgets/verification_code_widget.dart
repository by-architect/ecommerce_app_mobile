import 'package:ecommerce_app_mobile/common/ui/theme/AppSizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class VerificationCodeWidget extends HookWidget {
  final ValueChanged<String> onCompleted;

  VerificationCodeWidget({required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    final controllers = useMemoized(() => List.generate(6, (_) => TextEditingController()));
    final focusNodes = useMemoized(() => List.generate(6, (_) => FocusNode()));
    final code = useState('');

    void onDigitChanged() {
      final currentCode = controllers.map((c) => c.text).join();
      if (currentCode.length == 6) {
        onCompleted(currentCode);
      }
    }

    List<Widget> buildTextFields() {
      return List.generate(6, (index) {
        return Container(
          width: 40,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: TextFormField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            onChanged: (value) {
              if (value.isNotEmpty) {
                if (index < 5) {
                  FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                }
              } else if (index > 0) {
                FocusScope.of(context).requestFocus(focusNodes[index - 1]);
              }
              onDigitChanged();
            },
            decoration: const InputDecoration(
              counterText: '', // Hide the counter text
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppSizes.defaultBorderRadius)),
              ),
            ),
          ),
        );
      });
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buildTextFields(),
    );
  }
}
