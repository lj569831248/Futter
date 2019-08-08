import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget{

 
  @override
  Widget build (BuildContext context){
    return new MaterialApp(
      title: "New App",
      home: Page1(),
      routes: {
        "page1":(context) => Page1(),
        "page2":(context) => NewRoute()
      },
    );
  }
}
class Page1 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

   
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("page1"),
      ),
      body: Center(
      child:Column(
        children:<Widget>[
          Text("new page"),
          Text("第二行"),
          FlatButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewRoute()));
            }, 
            child: Text("普通路由跳转(写法1)"),
            color: Colors.blue,
          ),
          FlatButton(
            onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewRoute())),
            child: Text("普通路由跳转(写法2)"),
            color: Colors.red,
          ),
           FlatButton(
            onPressed: ()=>  Navigator.pushNamed(context, "page2"),
            child: Text("命名路由跳转"),
            color: Colors.yellow,
          ),
         
        ],

        ),
    )
    );
  }
}
class NewRoute extends StatelessWidget {
  static const messaageChannel1 = const BasicMessageChannel("samples.flutter.io/message1", StandardMessageCodec());
  static const messaageChannel2 = const BasicMessageChannel("samples.flutter.io/message2", StandardMessageCodec());
  @override
  Widget build(BuildContext context) {
   
     messaageChannel1.setMessageHandler((message) async {
      print('接受到来自native的message: $message');
      return '接受完native端的数据之后返回的数据';
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("This is new route"),
            FlatButton(
            onPressed: ()=>  messaageChannel1.send("发送给native的数据"),
            child: Text("发送数据给native"),
            color: Colors.yellow,
          ),
          ],
        )
      ),
    );
  }
}