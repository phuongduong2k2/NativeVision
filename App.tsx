/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import { Button, SafeAreaView, StyleSheet, View } from 'react-native';
import { NativeModules } from 'react-native';
function App() {
  const { CalendarModule, CameraModule } = NativeModules;

  const onPress = () => {
    if (CalendarModule) {
      CalendarModule.createCalendarEvent('Meeting', 'Office');

      // For the synchronous method, it should be called synchronously in JS
      // But usually, you'd wrap it in a try-catch for safety if it might fail.
      try {
        const deviceName = CalendarModule.getName();
        console.log('Device Name:', deviceName);
      } catch (e) {
        console.error('Error getting device name:', e);
      }
    } else {
      console.warn(
        'CalendarModule not found. Make sure it is correctly linked.',
      );
    }
  };

  const openPreview = () => {
    if (CameraModule) {
      CameraModule.openPreview();
    } else {
      console.warn('CameraModule not found');
    }
  };

  return (
    <SafeAreaView style={{ flex: 1 }}>
      <View style={styles.container}>
        <Button
          title="Click to invoke your native module!"
          color="#841584"
          onPress={onPress}
        />
        <Button title="Take a picture" color="blue" onPress={openPreview} />
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

export default App;
