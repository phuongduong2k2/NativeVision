/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import { useState } from 'react';
import { Button, Image, SafeAreaView, StyleSheet, View } from 'react-native';
import { NativeModules } from 'react-native';
function App() {
  const { CameraModule } = NativeModules;

  const [uri, setUri] = useState('');

  const openPreview = async () => {
    if (CameraModule) {
      try {
        const imageUri = await CameraModule.openCamera();
        console.log(imageUri);
        setUri(imageUri);
      } catch (error) {
        console.warn('some thing wrong');
      }
    } else {
      console.warn('CameraModule not found');
    }
  };

  return (
    <SafeAreaView style={{ flex: 1 }}>
      <View style={styles.container}>
        <Image
          source={{ uri }}
          style={{ height: 200, width: 100, borderWidth: 1 }}
          resizeMode="contain"
        />
        <Button title="Take a picture" color="blue" onPress={openPreview} />
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export default App;
