'use strict'

import { NativeModules } from 'react-native';

const { UniversalGoogleAnalytics } = NativeModules;

const setUniversalGAId = (id) => {
 UniversalGoogleAnalytics.setUniversalGAId(id)
}

const trackEvent = (category, action, label, value) => {
  UniversalGoogleAnalytics.trackEvent(category, action, label, value)
}

const trackScreen = (screenName) => {
  UniversalGoogleAnalytics.trackScreen(screenName)
}

const setCustomDimension = (key, value) => {
  UniversalGoogleAnalytics.setCustomDimension(key, value)
}

const trackProductImpression = (products, list, screenName) => {
  UniversalGoogleAnalytics.trackProductImpression(products, list, screenName)
}

const trackProductClick = (products, list) => {
  UniversalGoogleAnalytics.trackProductClick(products, list)
}

const trackAddToCart = (products, list) => {
  UniversalGoogleAnalytics.trackAddToCart(products, list)
}

const trackPurchase = (products, list, transactionId, affiliation, couponCode, revenue, shipping, tax) => {
  UniversalGoogleAnalytics.trackPurchase(products, list, transactionId, affiliation, couponCode, revenue, shipping, tax)
}

export default UniversalGoogleAnalytics;
