import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getMethod() async {
    var Url = Uri.parse('http://192.168.0.104/conexao/getData.php');

    var resposta = await http.get(Url);
    if (resposta.statusCode == 200) {
      return jsonDecode(resposta.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter Local'),
      ),
      body: FutureBuilder<dynamic>(
        future: getMethod(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var usuarios = snapshot.data![index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(usuarios['id'].toString()),
                    ),
                    title: Text(usuarios['usuario']),
                    subtitle: Text(usuarios['senha']),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
