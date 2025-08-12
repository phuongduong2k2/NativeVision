import { View, Text } from 'react-native';
import React from 'react';
import ScreenLayout from '@src/components/ScreenLayout';
import AppImages from '@src/assets/images';

const NotificationScreen = () => {
  return (
    <ScreenLayout wallpaper={AppImages.playWallpaper} headerShown={false}>
      <View>
        <Text>NotificationScreen</Text>
      </View>
    </ScreenLayout>
  );
};

export default NotificationScreen;
