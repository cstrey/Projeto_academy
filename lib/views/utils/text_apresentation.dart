import 'package:flutter/material.dart';

/// provides a pre-defined introduction for Anderson Automóveis.
const String apresentationText = '''
Bem-vindo à Anderson Automóveis:
O Seu Destino para Carros de Qualidade e Atendimento Excepcional!

Na Anderson Automóveis, estamos comprometidos em oferecer a você
uma experiência única e gratificante na busca pelo seu veículo dos sonhos.
Há anos, nossa concessionária tem sido o destino preferido 
de clientes que valorizam qualidade, confiança e um atendimento personalizado.
Na Anderson Automóveis, acreditamos que a satisfação do cliente
é a nossa maior conquista. 
Nossa missão é ajudar você a encontrar o carro dos seus sonhos 
e proporcionar uma experiência de compra que você nunca esquecerá.
''';

/// Declaration of a widget class named [TextPattern]
/// that extends StatelessWidget.
class TextPattern extends StatelessWidget {
  /// Define a constructor [TextPattern].
  const TextPattern({
    super.key,
    this.alignText,
    this.textStyle,
  });

  /// Used within a widget to customize the alignment of text
  final TextAlign? alignText;

  /// Used within a widget to customize the appearance of text
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        apresentationText,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
