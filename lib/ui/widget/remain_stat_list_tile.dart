import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermaskapp/model/store.dart';
import 'package:url_launcher/url_launcher.dart';

class RemainStatListTile extends StatelessWidget {
  final Store store;

  RemainStatListTile(this.store);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(store.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(store.addr),
          Text('${store.distance} m'),
        ],
      ),
      trailing: _buildRemainStatWidget(store),
      onTap: (){
        _launcerURL(store.name,store.lat, store.lng);
      },
    );
  }

  Widget _buildRemainStatWidget(Store store) {
    var remainStat = '판매 중지';
    var description = '';
    var color = Colors.black;

    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30 ~ 100개';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        description = '2 ~ 30개';
        color = Colors.red;
        break;
      case 'plenty':
        remainStat = '소진박 임';
        description = '1개 이';
        color = Colors.grey;
        break;
      default:
    }

    return Column(
      children: <Widget>[
        Text(
          remainStat,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(
          description,
          style: TextStyle(color: color),
        ),
      ],
    );
  }

  _launcerURL(String name, double lat, double lng) async{

    //final url = 'https://map.kakao.com/link/map/$name,$lng,$lat';
    final url = 'https://google.com/maps/search/?api=1&query=$lat,$lng';
    if(await canLaunch((url))){
      await launch(url);
    }else{
      throw 'Could not launch $url';
      //https://google.com/maps/search/?api=1&query=$
    }
  }
}
