import {
  View,
  TouchableOpacity,
  Text,
  StyleSheet,
  NativeModules,
} from 'react-native';
import React from 'react';

import LottieView from 'lottie-react-native';
import LottieFiles from '@src/assets/animations';

const QrCodeTabBar = () => {
  const { CameraModule } = NativeModules;

  const onPress = async () => {
    if (CameraModule.openCamera) {
      const imageUrl = await CameraModule.openCamera();
      console.log(imageUrl);
    }
  };

  return (
    <TouchableOpacity
      activeOpacity={1}
      style={styles.pressView}
      onPress={onPress}
    >
      <View style={styles.scanContainer}>
        <View style={styles.scanContent}>
          <LottieView
            source={LottieFiles.scanMatrix}
            style={{
              width: '100%',
              aspectRatio: 1,
            }}
            resizeMode="contain"
            autoPlay
            loop
          />
        </View>
      </View>
      <Text style={{ fontSize: 12 }}>Scan Now</Text>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  pressView: {
    flex: 1,
    width: '100%',
    alignItems: 'center',
    justifyContent: 'center',
  },
  scanContainer: {
    height: 24,
    width: '100%',
    alignItems: 'center',
  },
  scanContent: {
    borderWidth: 2,
    borderColor: '#FED16A',
    position: 'absolute',
    width: 60,
    height: undefined,
    backgroundColor: 'white',
    overflow: 'hidden',
    aspectRatio: 1,
    bottom: 0,
    borderRadius: 1000,
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export default QrCodeTabBar;
