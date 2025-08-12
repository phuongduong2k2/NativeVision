import { View, ScrollView, StyleSheet } from 'react-native';
import React from 'react';
import ScreenLayout from '@src/components/ScreenLayout';
import AppImages from '@src/assets/images';
import Header from './components/Header';
import Categories from './components/Categories';

const HomeScreen = () => {
  return (
    <ScreenLayout wallpaper={AppImages.saveWallpaper} headerShown={false}>
      <ScrollView contentContainerStyle={{ flex: 1 }}>
        <View style={styles.container}>
          <Header />
          <Categories />
        </View>
      </ScrollView>
    </ScreenLayout>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

export default HomeScreen;
