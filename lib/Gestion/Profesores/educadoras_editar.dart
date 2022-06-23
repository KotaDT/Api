import 'package:flutter/material.dart';
import 'package:trabajo/providers/educadoras_provider.dart';

class EducadoraEditarPage extends StatefulWidget {
  String codTia;
  EducadoraEditarPage(this.codTia, {Key? key}) : super(key: key);

  @override
  State<EducadoraEditarPage> createState() => _EducadoraEditarPageState();
}

class _EducadoraEditarPageState extends State<EducadoraEditarPage> {
  TextEditingController codigoCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController nivelCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Educadora'),
        backgroundColor: Color.fromARGB(255, 186, 53, 97),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: EducadorasProvider().getEducadora(widget.codTia),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var data = snapshot.data;
              codigoCtrl.text = data['cod_tia'];
              nombreCtrl.text = data['nombre'];
              telefonoCtrl.text = data['telefono'].toString();
              nivelCtrl.text = data['cod_curso'].toString();

              return Form(
                key: formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: codigoCtrl,
                      decoration: InputDecoration(labelText: 'Código'),
                    ),
                    TextFormField(
                      controller: nombreCtrl,
                      decoration: InputDecoration(labelText: 'Nombre'),
                    ),
                    TextFormField(
                      controller: telefonoCtrl,
                      decoration: InputDecoration(labelText: 'Telefono'),
                    ),
                    TextFormField(
                      controller: nivelCtrl,
                      decoration: InputDecoration(labelText: 'Nivel'),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text('Editar'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.pinkAccent)),
                        onPressed: () {
                          EducadorasProvider().educadorasEditar(
                            widget.codTia,
                            codigoCtrl.text.trim(),
                            nombreCtrl.text.trim(),
                            int.tryParse(telefonoCtrl.text.trim()) ?? 0,
                            nivelCtrl.text.trim(),
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
