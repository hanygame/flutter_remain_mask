//View
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermaskapp/ui/widget/remain_stat_list_tile.dart';
import 'package:fluttermaskapp/viewmodel/store_viewmodel.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    final storeVM = Provider.of<StoreViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${storeVM.stores.length}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              storeVM.fetch();
            },
          )
        ],
      ),
      body: _buildBody(storeVM),
    );
  }

  Widget _buildBody(StoreViewModel storeVM){
    if(storeVM.isLoading == true){
      return loadingWidget();
    }

    if(storeVM.stores.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('반경 5km 이내에 재고가 있는 매장이 없습니다.'),
            Text('또는 인터넷 연결이 되었는지 확인해주세요.')
          ],
        ),
      );
    }

    return ListView(
      //이거 체크해보 : 메인 화면 UI 작성 3분
      children: storeVM.stores.map((e) {
        return RemainStatListTile(e);
      }).toList(),
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Loading...'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
