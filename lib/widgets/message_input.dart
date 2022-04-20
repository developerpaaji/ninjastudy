import 'package:flutter/material.dart';
import 'package:study/widgets/mic_input.dart';

class MessageInputWidget extends StatefulWidget {
  final Function(String text) onSubmitted;
  final bool canSend;
  const MessageInputWidget({
    Key? key,
    required this.onSubmitted,
    this.canSend = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends State<MessageInputWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late bool _isMicOn;

  @override
  void initState() {
    super.initState();
    _isMicOn = false;
  }

  @override
  Widget build(BuildContext context) {
    if (_isMicOn) {
      return MicInputWidget(
        onStopped: (val) {
          _isMicOn = false;
          setState(() {});
          _onSubmitted(val);
        },
        onCancelled: () {
          setState(() {
            _isMicOn = false;
          });
        },
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
                color: (Theme.of(context)
                            .inputDecorationTheme
                            .border
                            ?.borderSide
                            .color ??
                        Colors.black)
                    .withOpacity(0.15)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.07),
                  blurStyle: BlurStyle.outer,
                  blurRadius: 12)
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: !widget.canSend,
                  scrollPadding: const EdgeInsets.symmetric(horizontal: 12),
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: const InputDecoration(
                    hintText: "Start Typing...",
                    contentPadding: EdgeInsets.symmetric(horizontal: 18),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                  onPressed: !widget.canSend || _isMicOn
                      ? null
                      : () {
                          setState(() {
                            _isMicOn = true;
                          });
                        },
                  icon: Icon(
                    Icons.mic_outlined,
                    color: Theme.of(context).primaryColor,
                  )),
              const SizedBox(height: 32, width: 4, child: VerticalDivider()),
              IconButton(
                  onPressed: !widget.canSend || _isMicOn
                      ? null
                      : () {
                          _onSubmitted(_controller.text);
                          _controller.text = '';
                          _focusNode.unfocus();
                        },
                  icon: Icon(
                    Icons.send_outlined,
                    color: Theme.of(context).primaryColor,
                  )),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ],
    );
  }

  void _onSubmitted(String text) {
    String messageText = text.trim();
    if (messageText.isNotEmpty) {
      widget.onSubmitted(messageText);
    }
  }
}
