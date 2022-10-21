import 'package:flutter/material.dart';
import 'package:omusubi/keyboard.dart';
import 'package:omusubi/provider.dart';

class OmusubiPage extends StatefulWidget {
  // :super(key:key) :親クラス(StatefulWidget)のコンストラクタに渡す引数をここで定義
  const OmusubiPage({Key? key}) : super(key: key);

  @override
  State<OmusubiPage> createState() => _OmusubiPageState();
}

class _OmusubiPageState extends State<OmusubiPage> {
  // newしたOmusubiGameクラスの中で実装していく
  OmusubiGame _game = OmusubiGame();

  @override
  // 大元のstate初期化時にゲームの初期状態にセット
  void initState() {
    super.initState();
    OmusubiGame.initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GameKeyboard(_game),
          ],
        ),
      ),
    );
  }
}
