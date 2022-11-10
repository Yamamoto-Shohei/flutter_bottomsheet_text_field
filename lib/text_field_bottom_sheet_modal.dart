import 'package:flutter/material.dart';

class TextFieldBottomSheetModal extends StatefulWidget {
  final String input;
  final Function(String) change;
  const TextFieldBottomSheetModal(
    this.input,
    this.change, {
    Key? key,
  }) : super(key: key);

  @override
  createState() => _TextFieldBottomSheetModalState();

  static void showModal(
          BuildContext context, String input, Function(String) change) =>
      showModalBottomSheet<int>(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(14.0),
            ),
          ),
          builder: (BuildContext context) {
            return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: TextFieldBottomSheetModal(input, change));
          });

  static Widget text(
          BuildContext context, String input, Function(String) change) =>
      Container(
          width: Size.infinite.width,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                alignment: AlignmentDirectional.centerStart),
            onPressed: () => showModal(context, input, change),
            child: Text(
              input.isEmpty ? 'クリックして入力' : input,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ));
}

class _TextFieldBottomSheetModalState extends State<TextFieldBottomSheetModal> {
  final _textController = TextEditingController();

  @override
  void initState() {
    _textController.text = widget.input;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Expanded(
                child: TextField(
              controller: _textController,
              minLines: 1,
              maxLines: 5,
              autofocus: true,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                hintText: '入力してください。',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              ),
            )),
            SizedBox(
              width: 51,
              height: 45,
              child: TextButton(
                  onPressed: () {
                    widget.change(_textController.text);
                    Navigator.of(context).pop();
                  },
                  child: Text('完了',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ))),
            ),
          ]),
        ],
      ),
    );
  }
}
