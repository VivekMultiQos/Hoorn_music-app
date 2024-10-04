
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class KeyboardHelper {

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static KeyboardActionsConfig keyboardActionsConfig(
      BuildContext context, List<FocusNode> list) {
    return KeyboardActionsConfig(
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: List.generate(
        list.length,
            (i) => KeyboardActionsItem(
          focusNode: list[i],
          toolbarButtons: [
                (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: _buildDoneButton(),
                ),
              );
            },
          ],
        ),
      ),
    );
  }

  static Widget _buildDoneButton() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.transparent,
      ),
      child: const Text(
        'Done',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }
}