import { View, Text } from 'react-native';
import React from 'react';
import ScreenLayout from '@src/components/ScreenLayout';

const NotificationScreen = () => {
  return (
    <ScreenLayout headerShown={false}>
      <View>
        <Text>NotificationScreen</Text>
      </View>
    </ScreenLayout>
  );
};

export default NotificationScreen;
