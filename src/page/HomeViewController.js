
import React, { Component } from 'react';
import {
  Navigator ,
  View ,
  Text,
  StyleSheet,
  TouchableOpacity
} from 'react-native';

export default class HomeViewController extends Component {
  constructor (props){
    super(props);
  }
  
  onPressButtonA() {
    alert('按钮事件');
  }



  render (){
    return (
      <View style={[styles.container]}>
      <TouchableOpacity onPress={this.onPressButtonA.bind(this)}> 

        <Text style={{fontSize:30,color:'#fff'}}>Hello React-native</Text>
      </TouchableOpacity>

      </View>
    )
  }
}

const styles = StyleSheet.create({
  container : {
    flex : 1,
    alignItems : 'center',
    justifyContent : 'center',
    backgroundColor : '#666'
  }
})

