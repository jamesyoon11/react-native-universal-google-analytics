import React, { Component } from 'react';
import { Platform, StyleSheet, Text, View, Button } from 'react-native';
import UniversalGoogleAnalytics from 'react-native-universal-google-analytics';

class App extends Component {
  constructor(props) {
    super(props);

    this.state = {
      title: 'UniversalGoogleAnalytics example',
      setGAId: 'Click to set GA ID',
      trackEvent: 'Click to track event',
      trackScreen: 'Click to track screen',
      setCustomDimension: 'Click to set custom dimension',
      trackProductImpression: 'Click to track product impression',
      trackProductClick: 'Click to track product click',
      trackAddToCart: 'Click to track add to cart',
      trackPurchase: 'Click to purchase'
    };
    this._setGAId = this._setGAId.bind(this);
    this._trackEvent = this._trackEvent.bind(this);
    this._trackScreen = this._trackScreen.bind(this);
    this._setCustomDimension = this._setCustomDimension.bind(this);
    this._trackProductImpression = this._trackProductImpression.bind(this);
    this._trackProductClick = this._trackProductClick.bind(this);
    this._trackAddToCart = this._trackAddToCart.bind(this);
    this._trackPurchase = this._trackPurchase.bind(this);
  }

  _setGAId() {
      UniversalGoogleAnalytics.setUniversalGAId('1111');
  }

  _trackEvent() {
      UniversalGoogleAnalytics.trackEvent('event category', 'event action', 'event label', 1);
  }

  _trackScreen() {
      UniversalGoogleAnalytics.trackScreen('welcome screen');
  }

  _setCustomDimension() {
      UniversalGoogleAnalytics.setCustomDimension(1, 'cd 1');
  }

  _trackProductImpression() {
      const products =[{
        id: 'P12345',
        name: 'Android Warhol T-Shirt',
        price: 29,
        position: 1,
        variant: 'Black'
      }];

      UniversalGoogleAnalytics.trackProductImpression(products, 'search result', 'result screen');
  }

  _trackProductClick() {
      const products =[{
        id: 'P12345',
        name: 'Android Warhol T-Shirt',
        price: 29,
        position: 1,
        variant: 'Black'
      }];

      UniversalGoogleAnalytics.trackProductClick(products, 'search result');
  }

  _trackAddToCart() {
      const products =[{
        id: 'P12345',
        name: 'Android Warhol T-Shirt',
        price: 29,
        position: 1,
        quantity: 1,
        variant: 'Black'
      }];

      UniversalGoogleAnalytics.trackAddToCart(products, 'search result');
  }

  _trackPurchase() {
      const products =[{
        id: 'P12345',
        name: 'Android Warhol T-Shirt',
        price: 29,
        position: 1,
        quantity: 1,
        variant: 'Black'
      }];

      UniversalGoogleAnalytics.trackPurchase(products, 'search result', 'T12345', 'My Store - Online', 'SUMMER2013', 37, 5, 3);
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>{this.state.title}</Text>
        <Button onPress={ () => {this._setGAId()} } title={this.state.setGAId}></Button>
        <Button onPress={ () => {this._trackEvent()} } title={this.state.trackEvent}></Button>
        <Button onPress={ () => {this._trackScreen()} } title={this.state.trackScreen}></Button>
        <Button onPress={ () => {this._setCustomDimension()} } title={this.state.setCustomDimension}></Button>
        <Button onPress={ () => {this._trackProductImpression()} } title={this.state.trackProductImpression}></Button>
        <Button onPress={ () => {this._trackProductClick()} } title={this.state.trackProductClick}></Button>
        <Button onPress={ () => {this._trackAddToCart()} } title={this.state.trackAddToCart}></Button>
        <Button onPress={ () => {this._trackPurchase()} } title={this.state.trackPurchase}></Button>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

export default App;