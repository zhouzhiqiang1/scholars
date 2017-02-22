/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Image
} from 'react-native';

var imageAddress = 'http://qq.111cn.net/uploads/allimg/140712/22020H9C-22.jpg'

export default class RNHighScores extends Component {
  render() {
    return (
      <View>

        <View style = {[styles.height160, styles.row,{marginTop:18}]}>
            <View style = {[styles.height160, styles.part_l_left]}>
              <Text style = {[styles.marTop18, styles.marLeft10,{color:'#55A44B',fontSize:15}]}>
                 我们约会吧
              </Text>
              <Text style = {[styles.marLeft10,{marginTop: 10,fontSize:13}]}>
                 恋人家人好朋友
              </Text>
              <Image style = {[{height:100, backgroundColor:'red'}]} source = {require('./image/lianai.png')}></Image>
            </View>    

            <View style = {[styles.height160, styles.part_l_right]}>
                <View style = {[styles.row,{flex:1,backgroundColor:'#ffffff',borderBottomWidth:1,borderColor: 'red'}]}>
                    <View style = {{flex:1,backgroundColor:'#ffffff'}}>
                         <Text style = {[styles.marTop18,{fontSize:15,marginLeft:30,color:'red'}]}>
                                    超低价值
                          </Text>
                          <Text style = {[{fontSize:12,marginLeft:30,marginTop:10}]}>
                            十元惠生活
                          </Text>
                    </View>

                    <View style = {{flex:1,backgroundColor:'#ffffff',justifyContent:'center',alignItems:'center'}}>
                      <Image style = {{height:70}} source = {require('./image/lianai.png')}></Image>
                    </View>
                </View>

                <View style = {[styles.row,{flex:1,backgroundColor:'#ffffff'}]}>
                  <View style = {{flex:1,borderRightWidth:1,borderColor:'red'}}> 
                    <Text style = {[styles.marLeft10,{fontSize:16,color:'#d95ea5',marginTop:7}]}> 
                        聚餐邀请
                    </Text>
                    <Text style = {[styles.marLeft10,{marginTop:10,fontSize:14}]}>
                        朋友家人常聚聚
                    </Text>
                    <Image style = {[styles.center,{height:30,width:30}]} source = {require('./image/lianai.png')}></Image>
                  </View>

                  <View style = {{flex:1,backgroundColor:'#ffffff'}}> 
                      <Text style = {[styles.marLeft10,{marginTop:7,color:'#e6913a',fontSize:16}]}>
                          名店抢购
                      </Text>
                      <Text style = {[styles.marLeft10,{marginTop:10,fontSize:13}]}>
                          距离结束还有
                      </Text>

                      <Text style={[{marginLeft:10, fontSize:12,marginTop:4}]}>
                        12:06:12分
                      </Text>
                  </View>
                </View>
            </View>   
        </View>

        <View style = {[styles.row,{marginTop:20,borderColor:'red',borderWidth:1}]}>
            <View style = {{flex:1}}>
                <Text style = {[styles.textStyle,{color:'#e69174'}]}>
                    一元吃大餐
                </Text>
                <Text style = {[styles.marLeft10,{fontSize:15,marginTop:5}]}>
                    新用户专享
                </Text>
            </View>
            <View style = {{flex:1}}>
                <Image style = {styles.imageSize}  source = {require('./image/tupian.png')}></Image>
            </View>
        </View>

        <View style = {[styles.row,styles.height160,{borderBottomWidth:1,borderColor:'red'}]}>
            <View style = {{flex:1}}>
                <View style = {{flex:1,flexDirection:'row'}}>
                    <View style = {{flex:2}}>
                      <Text style = {[styles.textStyle,{color:'#e69174'}]}>
                          撸串节狂欢
                      </Text>
                      <Text style = {{fontSize:15,marginTop:5,marginLeft:10}}>
                          烧烤6.6元起
                      </Text>
                    </View>
                    <View style = {{flex:1}}>
                      <Image source = {require('./image/chuanchuan.png')}></Image>
                    </View>
                </View>

                <View style = {{flex:1,flexDirection:'row',borderTopWidth:1,borderColor:'red'}}>
                    <View style = {{flex:2}}>
                        <Text style = {[styles.textStyle,{color:'#88b807'}]}>
                            0元餐来袭
                        </Text>

                        <Text style = {[styles.marLeft10,{marginTop:5,fontSize:15}]}>
                            免费吃喝玩乐购
                        </Text>
                    </View>

                    <View style = {{flex:1}}>
                        <Image source = {require('./image/chuanchuan.png')}></Image>
                    </View>
                </View>
            </View>

             <View style = {{flex:1}}>
               <View style = {{flex:1,flexDirection:'row'}}>
                    <View style = {{flex:2}}>
                      <Text style = {[styles.textStyle,{color:'#e69174'}]}>
                          毕业旅行
                      </Text>
                      <Text style = {{fontSize:15,marginTop:5,marginLeft:10}}>
                          选好酒店才安心
                      </Text>
                    </View>
                    <View style = {{flex:1}}>
                      <Image source = {require('./image/chuanchuan.png')}></Image>
                    </View>
                </View>

                <View style = {{flex:1,flexDirection:'row',borderTopWidth:1,borderColor:'red'}}>
                    <View style = {{flex:2}}>
                        <Text style = {[styles.textStyle,{color:'#7a88ee'}]}>
                            热门团购
                        </Text>

                        <Text style = {[styles.marLeft10,{marginTop:5,fontSize:15}]}>
                            大家都在买什么
                        </Text>
                    </View>

                    <View style = {{flex:1}}>
                        <Image source = {require('./image/chuanchuan.png')}></Image>
                    </View>
                </View>
            </View>
        </View>


        <View style = {{marginTop:20,borderColor:'red',borderWidth:1}}>
          <Image source = {require('./image/BottomTu.png')}></Image>
        </View>

      </View>
    );
  }
}

const styles = StyleSheet.create({
  row : {//column   column-reverse  row  row-reverse
    flexDirection:'row'
  },
  column : {
    flexDirection: 'column',
  },
  font30 : {
    fontSize : 90
  },
  marTop18: {
    marginTop: 18
  },
  marLeft10: {
    marginLeft: 10
  },
  height160 : {
    height : 160
  },
  part_l_left : {//边框 borderWidth borderTopWidth  borderBottomWidth borderLeftWidth borderRightWidth borderRadius//角
    flex: 1,
    // borderWidth: 0.5,
    borderRightWidth: 1,
    borderBottomWidth: 1,
    borderColor: 'red'
  },
  part_l_right : {
    flex: 2,
    borderBottomWidth: 1,
    borderColor: 'red'
  },
  imageSize : {
    height: 70
  },
  center : {//View内居中
    alignSelf: 'center'
  },
  textStyle : {
    fontSize:20,
    marginLeft:10,
    marginTop:10,
    fontWeight:'900'
  }
});

AppRegistry.registerComponent('RNHighScores', () => RNHighScores);
