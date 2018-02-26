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
  TabBarIOS
} from 'react-native';

import HomeViewController from '../page/HomeViewController';//首页
import RegularBasis from '../page/Welfare';//定期

export default class mainViewController extends Component {

  constructor(props) {
    super(props);

    this.state = {
        selectedTab:'首页',
        notifCount:0,
        presses:0,
    };
  }

  //进行渲染页面内容
  _renderContent(color:string, pageText:string, num?:number) {
      return (

          <View style = {[styles.tabContent, {backgroundColor: color}]}>
            <Text style = {styles.tabText}>{pageText}</Text>
            <Text style = {styles.tabText}>{num}</Text>
          </View>
      );
  }

  render() {
    return (
      <View style={{flex:1}}>
        <TabBarIOS
        style={{flex:1,alignItems:"flex-end"}}
        tintColor='#d7a653'
        barTintColor="white">
        <TabBarIOS.Item
          //显示图片颜色
          renderAsOriginal
          title="首页"
          icon = {require('../image/tab_home_icon_page.png')}
          selectedIcon = {require('../image/tab_home_selectedIcon_page.png')}
          selected={this.state.selectedTab === '首页'}
          onPress={() => {
            this.setState({
              selectedTab: '首页',
            });
          }}
          >
          <HomeViewController/>
        </TabBarIOS.Item>

        <TabBarIOS.Item
          //显示图片颜色
          renderAsOriginal
          title="定期"
          icon = {require('../image/tab_home_icon_fun.png')}
          selectedIcon={require('../image/tab_home_selectedIcon_fun.png')}
          selected={this.state.selectedTab === '定期'}
          onPress={() => {
            this.setState({
              selectedTab: '定期',
              notifCount: this.state.notifCount + 1,
            });
          }}
          >
          <RegularBasis/>
        </TabBarIOS.Item>

        <TabBarIOS.Item
          //显示图片颜色
          renderAsOriginal
          title="消息"
          icon = {require('../image/tab_home_icon_message.png')}
          selectedIcon = {require('../image/tab_home_selectedIcon_message.png')}
          selected={this.state.selectedTab === '消息'}   
          badge={this.state.notifCount > 0 ? this.state.notifCount : undefined}
          onPress={() => {
            this.setState({
              selectedTab: '消息',
              notifCount: this.state.notifCount + 1,
            });
          }}
          >
          {this._renderContent('#783E33', '消息', this.state.notifCount)}
        </TabBarIOS.Item>

        <TabBarIOS.Item
          //显示图片颜色
          renderAsOriginal
           title=" 我的"
           icon={require('../image/tab_home_icon_my.png')}
           selectedIcon = {require('../image/tab_home_selectedIcon_my.png')}
           selected={this.state.selectedTab === '我的'}
            onPress={() => {
            this.setState({
              selectedTab: '我的',
              presses: this.state.presses + 1
            });
          }}>

          {this._renderContent('#414A8C', '我的')}
        </TabBarIOS.Item>
      </TabBarIOS>
      </View>
    );
  }
}

const styles = StyleSheet.create({
    tabContent: {
    flex: 1,
    alignItems: 'center',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    marginTop: 20,
    height:40,
  },
  tabText: {
    color: 'white',
    margin: 40
  },
});

AppRegistry.registerComponent('mainViewController', () => mainViewController);
