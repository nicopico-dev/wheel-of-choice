import 'package:flutter/material.dart';
import 'package:wheel_of_choice/model.dart';

const MAX_CHOICE = 12;

class ChoiceEditionPage extends StatefulWidget {
  @override
  ChoiceEditionPageState createState() => new ChoiceEditionPageState();
}

class ChoiceEditionPageState extends State<ChoiceEditionPage> {
  final List<Choice> choices = <Choice>[
    Choice(name: 'Boulangerie'),
    Choice(name: 'Japonais'),
    Choice(name: 'Pizza'),
    Choice(name: 'Brasserie'),
  ];
  int _editIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choices')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildListView(),
            Flexible(child: Container()),
            Container(
              width: 200.0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text("Valider"),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: choices.length < MAX_CHOICE && _editIndex == -1
          ? choices.length + 1
          : choices.length,
      itemBuilder: (context, index) {
        if (index >= choices.length) {
          return _buildNewEntryListTile();
        }

        final c = choices[index];
        if (_editIndex == index) {
          return _buildEditListTile(c, index);
        } else {
          return buildDefaultListTile(c, index);
        }
      },
      shrinkWrap: true,
    );
  }

  Widget buildDefaultListTile(Choice c, int index) {
    return Dismissible(
      key: Key(c.name),
      direction: DismissDirection.endToStart,
      background: new Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "supprimer",
            style: TextStyle(
                inherit: true, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onDismissed: (direction) {
        setState(() {
          choices.removeAt(index);
        });
        Scaffold
            .of(context)
            .showSnackBar(SnackBar(content: Text("\"${c.name}\" supprimé")));
      },
      child: ListTile(
          title: Text(c.name),
          onTap: () {
            setState(() {
              _editIndex = index;
            });
          }),
    );
  }

  Widget _buildEditListTile(Choice c, int index) {
    var focusNode = FocusNode();
    var editingController = TextEditingController(text: c.name);

    var listTile = ListTile(
        title: TextField(
      controller: editingController,
      focusNode: focusNode,
      onSubmitted: (newValue) {
        setState(() {
          _editIndex = -1;
          choices.removeAt(index);
          if (newValue.isNotEmpty) {
            choices.insert(index, Choice(name: newValue));
          }
        });
      },
    ));

    FocusScope.of(context).requestFocus(focusNode);
    editingController.selection = TextSelection(
        baseOffset: 0, extentOffset: editingController.text.length);

    return listTile;
  }

  Widget _buildNewEntryListTile() {
    return ListTile(
        title: TextField(
      decoration: InputDecoration(hintText: "Choix supplémentaire"),
      onSubmitted: (value) {
        if (value.isEmpty) return;
        setState(() {
          choices.add(Choice(name: value));
        });
      },
    ));
  }
}
