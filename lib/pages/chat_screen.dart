import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String nome;
  final String foto;

  const ChatScreen({required this.nome, required this.foto, Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> mensagens = [
    {'texto': 'Olá!', 'enviado': true, 'hora': '14:00'},
    {'texto': 'Oi, tudo bem?', 'enviado': false, 'hora': '14:01'},
  ];
  
  final TextEditingController _controller = TextEditingController();

  void _enviarMensagem() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        mensagens.add({
          'texto': _controller.text,
          'enviado': true,
          'hora': TimeOfDay.now().format(context)
        });
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(widget.foto)),
            const SizedBox(width: 10),
            Text(widget.nome),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: mensagens.length,
              itemBuilder: (context, index) {
                final mensagem = mensagens[mensagens.length - 1 - index];
                final alinhamento = mensagem['enviado'] ? CrossAxisAlignment.end : CrossAxisAlignment.start;
                final cor = mensagem['enviado'] ? Colors.purple[300] : Colors.grey[300];

                return Column(
                  crossAxisAlignment: alinhamento,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(mensagem['texto']),
                    ),
                    Text(
                      mensagem['hora'],
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                );
              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration.collapsed(hintText: 'Digite sua mensagem...'),
                    onChanged: (val) => setState(() {}),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: _controller.text.isEmpty ? Colors.grey : Colors.purple),
                  onPressed: _controller.text.isEmpty ? null : _enviarMensagem,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
