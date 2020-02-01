import 'dart:async';

import 'package:dio/dio.dart';

class ListBloc {
  StreamController<List<dynamic>> _streamController = StreamController<List<dynamic>>();

  Stream<List<dynamic>> get output => _streamController.stream;

  StreamSink<List<dynamic>> get _input => _streamController.sink;

  Dio _dio = Dio();

  String endpoint = 'http://192.168.0.176:61093';

  ListBloc() {
    getList();
  }

  void getList() async {
    Response resp = await _dio.get('$endpoint/api/ContasPagar/ListarTodosBancos');

    _input.add(resp.data["dado"]);
  }

  void create() async {
    await _dio.post('$endpoint/aulas/', data: {
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'name': 'Um novo registro',
      'desc': 'Este registro foi gerado automaticamente',
    });
    getList();
  }

  void update(String id) async {
    await _dio.put('$endpoint/aulas/$id', data: {
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'name': 'Registro modificado',
      'desc': 'Este registro foi modificado dentro do sistema',
    });
    getList();
  }

  void delete(String id) async {
    await _dio.delete('$endpoint/aulas/$id');
    getList();
  }

  void dispose() {
    _streamController.close();
  }
}