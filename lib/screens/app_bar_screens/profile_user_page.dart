import 'package:flutter/material.dart';

class ProfileUserPage extends StatelessWidget {
  const ProfileUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile User',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PersonWidget(),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;
  int _favoriteCount = 375;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: IconButton(
            onPressed: _toggleFavorite,
            color: Colors.red[500],
            icon: (_isFavorited
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border)),
          ),
        ),
        SizedBox(
          width: 40,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
        _favoriteCount -= 1;
      } else {
        _isFavorited = true;
        _favoriteCount += 1;
      }
    });
  }
}

class PersonWidget extends StatelessWidget {
  const PersonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Container(
        child: _buildMainColumn(),
      ),
    );
  }

  Widget _buildMainColumn() => ListView(
        children: [
          _builTopImage(),
          Center(
            child: Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: _buildRaiting(),
                  ),
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(5),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: _buildAction(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: _buildDesc(),
                  ),
                ],
              ),
            ),
          )
        ],
      );
  Widget _builTopImage() => Card(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
        ),
        elevation: 5,
        child: Image.asset(
          'assets/images/angel.jpg',
          fit: BoxFit.cover,
        ),
      );

  Widget _buildRaiting() => ListTile(
        title: const Text(
          'Великий Психолог',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        subtitle: const Text('Москва'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [FavoriteWidget()],
        ),
      );
  Widget _buildAction() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildButton('38 советов', Icons.star, Colors.black),
          _buildButton('Диплом', Icons.topic, Colors.black),
          _buildButton('Стаж 5 лет', Icons.auto_graph, Colors.black),
        ],
      );

  Widget _buildButton(String label, IconData icon, Color color) => Column(
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          Container(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
  Widget _buildDesc() => const Text(
        'Профессиональный психолог. Помогаю людям прожить кризисные состояния. Работаю с низкой самооценкой, проблемами в личной жизни, с детскими травмами. ',
        softWrap: true,
        style: TextStyle(fontSize: 16),
      );
}
