import {
  View,
  Text,
  SafeAreaView,
  Button,
  TextInput,
  ScrollView,
  Image,
  TouchableOpacity,
} from 'react-native';
import React, { useCallback, useEffect, useState } from 'react';
import { getAuth, onAuthStateChanged } from '@react-native-firebase/auth';
import useGoogle from '@src/hooks/useGoogle';
import ScreenLayout from '@src/components/ScreenLayout';
import ProfileSection from './components/ProfileSection';
import LinearButton from '@src/components/LinearButton';
import useAppNavigation from '@src/hooks/navigation';

const ProfileScreen = () => {
  const { user } = useGoogle();
  const navigation = useAppNavigation();

  return (
    <ScreenLayout wallpaper="main" headerShown={false}>
      <ScrollView
        contentContainerStyle={{
          alignItems: 'center',
          flex: 1,
        }}
      >
        {user ? (
          <>
            <Image
              source={{
                uri: 'https://dvqlxo2m2q99q.cloudfront.net/000_clients/657152/file/657152aPuXQUMx.jpg',
              }}
              resizeMode="cover"
              style={{
                height: 100,
                aspectRatio: 1,
                borderRadius: 1000,
                borderColor: 'white',
              }}
            />
            <Text style={{ color: 'white', fontWeight: '700', fontSize: 16 }}>
              {user?.displayName}
            </Text>
            <Text style={{ color: 'white', fontSize: 12 }}>
              Lorem ipsum dolor sit amet consectetur adipiscing elit.
            </Text>
          </>
        ) : (
          <LinearButton
            colors={['#FF4545', '#FF9C73', '#FF4545']}
            containerStyle={{
              width: 100,
              marginBottom: 10,
              borderRadius: 10,
              height: 58,
              alignItems: 'center',
              justifyContent: 'center',
            }}
            onPress={() => {
              navigation.navigate('SignIn');
            }}
          >
            <Text style={{ fontSize: 16, fontWeight: '700', color: 'white' }}>
              Log in now
            </Text>
          </LinearButton>
        )}
        <ProfileSection />
      </ScrollView>
    </ScreenLayout>
  );
};

export default ProfileScreen;
