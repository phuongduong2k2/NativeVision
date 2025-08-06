/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import { useState } from 'react';
import {
  ActivityIndicator,
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
  const { CameraModule, AudioModule } = NativeModules;

  const [uri, setUri] = useState('');
  const [musicUrl, setMusicUrl] = useState(
    'http://codeskulptor-demos.commondatastorage.googleapis.com/pang/paza-moduless.mp3',
  );
  const [isLoading, setIsLoading] = useState(false);

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
          {isLoading && <ActivityIndicator size={'large'} color="red" />}
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
                setIsLoading(true);
                let newUrl = 'https://' + musicUrl.split('://')[1];
                const message = await AudioModule.playMusic(newUrl);
                console.log('result => ', message);
              } catch (error) {
                console.log(error);
              }
              setIsLoading(false);
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
