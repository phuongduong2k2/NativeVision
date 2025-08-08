import {
  View,
  Button,
  TextInput,
  ScrollView,
  SafeAreaView,
  ActivityIndicator,
  NativeModules,
  StyleSheet,
} from 'react-native';
import React, { useState } from 'react';

const HomeScreen = () => {
  const { AudioModule } = NativeModules;

  const [musicUrl, setMusicUrl] = useState(
    'http://codeskulptor-demos.commondatastorage.googleapis.com/pang/paza-moduless.mp3',
  );
  const [isLoading, setIsLoading] = useState(false);

  return (
    <SafeAreaView style={{ flex: 1 }}>
      <ScrollView contentContainerStyle={{ flex: 1 }}>
        <View style={styles.container}>
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
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

export default HomeScreen;
