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
  Navigator
} from 'react-native';

import mainViewController from './container/mainViewController';
import navigationBar from './container/navigationBar';


export default class scholars extends Component {
  constructor (props){
    super(props);
  }
  render() {
    return (
      <Navigator          //根界面             //component参数的值
        initialRoute = {{ name: 'mainViewController', component: mainViewController }}
        configureScene = {(route) => {//描述界面之间的过渡动画的
          return Navigator.SceneConfigs.HorizontalSwipeJump ;
        }}
        renderScene = {(route, navigator) => {
          let Component = route.component;
          return <Component  {...this.props} {...route.params} navigator = {navigator} />//return了一个Navigator容器
        }} />
    );
  }
}

AppRegistry.registerComponent('scholars', () => scholars);
