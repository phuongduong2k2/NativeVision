import { View, Text } from 'react-native';
import React from 'react';
import ScreenLayout from '@src/components/ScreenLayout';
import AppImages from '@src/assets/images';

const SettingsScreen = () => {
  return (
    <ScreenLayout wallpaper={AppImages.mainWallpaper} headerShown={false}>
      <View>
        <Text>Welcome back!</Text>
        <Text>What do you feel like today?</Text>
      </View>
    </ScreenLayout>
  );
};

export default SettingsScreen;
