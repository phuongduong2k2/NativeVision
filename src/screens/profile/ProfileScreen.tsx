import { Text, ScrollView, Image, View, StyleSheet } from 'react-native';
import React from 'react';
import useGoogle from '@src/hooks/useGoogle';
import ScreenLayout from '@src/components/ScreenLayout';
import ProfileSection from './components/ProfileSection';
import AppImages from '@src/assets/images';

const ProfileScreen = () => {
  const { user } = useGoogle();

  return (
    <ScreenLayout wallpaper={AppImages.listWallpaper} headerShown={false}>
      <ScrollView contentContainerStyle={styles.contentContainerStyle}>
        <View style={styles.avatarContainer}>
          {user?.photoURL && (
            <Image
              source={{
                uri: user.photoURL,
              }}
              resizeMode="cover"
              style={styles.avatarImage}
            />
          )}
        </View>

        <Text style={{ color: 'white', fontWeight: '700', fontSize: 16 }}>
          {user?.displayName ?? 'Unknown'}
        </Text>
        <Text style={{ color: 'white', fontSize: 12 }}>
          Lorem ipsum dolor sit amet consectetur adipiscing elit.
        </Text>
        <ProfileSection />
      </ScrollView>
    </ScreenLayout>
  );
};

const styles = StyleSheet.create({
  contentContainerStyle: {
    alignItems: 'center',
    flex: 1,
  },
  avatarContainer: {
    height: 100,
    aspectRatio: 1,
    borderRadius: 1000,
    borderWidth: 1,
    borderColor: 'white',
  },
  avatarImage: {
    height: '100%',
    width: '100%',
    borderRadius: 1000,
  },
});

export default ProfileScreen;
