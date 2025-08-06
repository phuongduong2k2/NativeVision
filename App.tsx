/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import { useState } from 'react';
import {
  Button,
  Image,
  SafeAreaView,
  ScrollView,
  StyleSheet,
  TextInput,
  View,
} from 'react-native';
import { NativeModules } from 'react-native';

function App() {
  const { CameraModule } = NativeModules;

  const [uri, setUri] = useState('');
  const [musicUrl, setMusicUrl] = useState('');

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
      <ScrollView contentContainerStyle={{ flex: 1 }}>
        <View style={styles.container}>
          <Image
            source={{ uri }}
            style={{ height: 200, width: 100, borderWidth: 1 }}
            resizeMode="contain"
          />
          <Button title="Take a picture" color="blue" onPress={openPreview} />
          <Button
            title="Native Printer"
            color="blue"
            onPress={() => {
              CameraModule.nativePrinter('Native Printer');
            }}
          />
          <TextInput
            value={musicUrl}
            onChangeText={setMusicUrl}
            style={{ borderWidth: 1, height: 50, width: '100%' }}
          />
          <Button
            title="Play Music"
            color={'orange'}
            onPress={async () => {
              try {
                const message = await CameraModule.playMusic(musicUrl);
                console.log('result => ', message);
              } catch (error) {
                console.log(error);
              }
            }}
          />
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
  },
});

export default App;
