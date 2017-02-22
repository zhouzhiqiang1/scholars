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

import HomeViewController from '../page/HomeViewController';

export default class mainViewController extends Component {

  constructor(props) {
    super(props);

    this.state = {
        selectedTab:'历史',
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
        tintColor="white"
        barTintColor="darkslateblue">
        <TabBarIOS.Item
          title="首页"
          icon = {require('../image/tab_home_icon_page.png')}
          selectedIcon = {require('../image/tab_home_selectedIcon_page.png')}
          selected={this.state.selectedTab === '自定义'}
          onPress={() => {
            this.setState({
              selectedTab: '自定义',
            });
          }}
          >
          <HomeViewController/>
        </TabBarIOS.Item>

        <TabBarIOS.Item
          title="趣味"
          icon = {require('../image/tab_home_icon_fun.png')}
          selectedIcon={require('../image/tab_home_selectedIcon_fun.png')}
          selected={this.state.selectedTab === '试试'}
          onPress={() => {
            this.setState({
              selectedTab: '试试',
              notifCount: this.state.notifCount + 1,
            });
          }}
          >
          {this._renderContent('#783E33', '历史记录', this.state.notifCount)}
        </TabBarIOS.Item>

        <TabBarIOS.Item
          title="消息"
          icon = {require('../image/tab_home_icon_message.png')}
          selectedIcon = {require('../image/tab_home_selectedIcon_message.png')}
          selected={this.state.selectedTab === '历史'}   
          badge={this.state.notifCount > 0 ? this.state.notifCount : undefined}
          onPress={() => {
            this.setState({
              selectedTab: '历史',
              notifCount: this.state.notifCount + 1,
            });
          }}
          >
          {this._renderContent('#783E33', '历史记录', this.state.notifCount)}
        </TabBarIOS.Item>

        <TabBarIOS.Item
           title=" 我的"
           icon={require('../image/tab_home_icon_my.png')}
           selectedIcon = {require('../image/tab_home_selectedIcon_my.png')}
           selected={this.state.selectedTab === '下载'}
            onPress={() => {
            this.setState({
              selectedTab: '下载',
              presses: this.state.presses + 1
            });
          }}>

          {this._renderContent('#414A8C', '自定义界面')}
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
    margin: 50,
  },
});

AppRegistry.registerComponent('mainViewController', () => mainViewController);
