
import React, { Component } from 'react';//这样写别的文件才可以调到
//图片轮播使用的是第三方组件
import Swiper from 'react-native-swiper';
import {
  StyleSheet,
  TouchableOpacity,
  Text,
  Image,
  View,
  ListView,
  PanResponder,
  RefreshControl,
  ScrollView
} from 'react-native';

// 初始化数据
var sliderImgs = [
    'http://images3.c-ctrip.com/SBU/apph5/201505/16/app_home_ad16_640_128.png',
    'http://images3.c-ctrip.com/rk/apph5/C1/201505/app_home_ad49_640_128.png',
    'http://images3.c-ctrip.com/rk/apph5/D1/201506/app_home_ad05_640_128.jpg'
];

//组件化
var Slider = React.createClass({
    render() {
      return (
        <Swiper showsButtons = {false} autoplay = {true} height = {140} showsPagination = {true}>
          <Image style = {[styles.slide,]} source = {{uri: sliderImgs[0]}}></Image>
          <Image style = {[styles.slide,]} source = {{uri: sliderImgs[1]}}></Image>
          <Image style = {[styles.slide,]} source = {{uri: sliderImgs[2]}}></Image>
        </Swiper>
      );
    }
});

export default class HomeViewController extends Component {
 constructor(props) {
    super(props);
    var ds = new ListView.DataSource({
        rowHasChanged: (r1, r2) => r1 !== r2,
        sectionHeaderHasChanged: (s1, s2) => s1 != s2 //使用字典时必须在构造方法里面传入
      });

    this.state = {
      eventName:'',
      pos: '',
      dataSource :ds.cloneWithRowsAndSections({a:['John', 'Joel'], b:['James', 'Jimmy'], c:['Jackson', 'Jillian'], e:['Julie', 'Devin'],f:['Julie', 'Devin'],g:['Julie', 'Devin']})//字典
      // dataSource :ds.cloneWithRows(['John', 'Joel', 'James', 'Jimmy', 'Jackson', 'Jillian', 'Julie', 'Devin'])

    };
  }

  _pressRow(rowData) {
    setTimeout(()=> {
            alert(rowData);
        },100);
  }

  _renderRow(rowData,rowId,sectionId) {
    return(
        <View>
          <TouchableOpacity onPress = {() =>this._pressRow(rowData)} underlayColor = "transparent" >
                    <View style = {[styles.row,{marginTop:18,height : 52}]}>
                      
                      <View style = {[styles.part_l_left,{height:52}]}> 
                          <Image style = {[{height:45, backgroundColor:'red'}]} resizeMode={Image.resizeMode.cover}  source = {{uri: sliderImgs[0]}}></Image>
                      </View>  

                      <View style = {[styles.part_l_right]}> 
                          <Text style = {[styles.marLeft10,{marginTop:5,fontSize:14}]}  numberOfLines = {1}  >
                             恋人家人好朋友恋人家人好朋友恋人家人好朋友恋人家人好朋友恋人家人好朋友
                          </Text>
                          <Text style = {[styles.marLeft10,{marginTop:5, color:'#e06752',fontSize:15}]}>
                             {rowData + rowId + sectionId}
                          </Text>
                      </View>
                   </View>
           </TouchableOpacity>
         </View>
      )
  }

  //滑动事处理
  componentWillMount() {
      this.myPanResponder = PanResponder.create({
      //要求成为响应者：
      //用户开始触摸屏幕的时候，是否愿意成为响应者；
      onStartShouldSetPanResponder: (evt, gestureState) => true,
      onStartShouldSetPanResponderCapture: (evt, gestureState) => true,
      ////在每一个触摸点开始移动的时候，再询问一次是否响应触摸交互； 
      onMoveShouldSetPanResponder: (evt, gestureState) => true,
      onMoveShouldSetPanResponderCapture: (evt, gestureState) => true,
      onPanResponderTerminationRequest: (evt, gestureState) => true,  
 
      //响应对应事件后的处理:
      onPanResponderGrant: (evt, gestureState) => {
        this.state.eventName='触摸开始';
        this.forceUpdate();
      },
      //最近一次的移动距离.如:(获取x轴y轴方向的移动距离 gestureState.dx,gestureState.dy)
      onPanResponderMove: (evt, gestureState) => {
        var _pos = 'x:' + gestureState.moveX + ',y:' + gestureState.moveY;
        this.setState( {eventName:'移动',pos : _pos} );
      },
      //用户放开了所有的触摸点，且此时视图已经成为了响应者。
      onPanResponderRelease: (evt, gestureState) => {
        this.setState( {eventName:'',pos:''} );

      },
      //另一个组件已经成为了新的响应者，所以当前手势将被取消。
      onPanResponderTerminate: (evt, gestureState) => {
        this.setState( {eventName:'另一个组件已经成为了新的响应者'} )
      },
    });
  }

 render() {
    return (
          <View style = {styles.container}>
            <Slider/>
            <ListView
              dataSource = {this.state.dataSource}
              renderRow = {(rowData,sectionId,rowId) => this._renderRow(rowData,rowId,sectionId)}
              showsVerticalScrollIndicator = {false}
              // refreshControl={
              //   <RefreshControl
              //     refreshing={this.state.isLoadingFullSubscribes}
              //     onRefresh={this.onRefresh}
              //     colors={['red','#ffd500','#0080ff','#99e600']}
              //     // tintColor={theme.themeColor}
              //     title="正在加载"
              //     // titleColor={theme.themeColor}
              //   />
              // }
            />
          </View>
    );
  }
}

const styles = StyleSheet.create({
container: {
      flex: 1,
      marginTop:0,
      // justifyContent: 'center',
      // alignItems: 'center',
      backgroundColor: '#F5FCFF',
  },
  //图片轮播 image 大小样式
  slide: {
      height:130,
      resizeMode: 'cover',
  },
  row : {//column   column-reverse  row  row-reverse
    flexDirection:'row'
  },
   part_l_left : {//边框 borderWidth borderTopWidth  borderBottomWidth borderLeftWidth borderRightWidth borderRadius//角
    flex: 1,
    // borderWidth: 0.5,
    // borderRightWidth: 1,
    borderBottomWidth: 1,
    borderColor: 'red'
  },
  part_l_right : {
    flex: 3,
    borderBottomWidth: 1,
    borderColor: 'red'
  },
})

