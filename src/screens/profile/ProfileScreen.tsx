import { Text, ScrollView, Image, View } from 'react-native';
import React from 'react';
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
            <View
              style={{
                height: 100,
                aspectRatio: 1,
                borderRadius: 1000,
                borderWidth: 1,
                borderColor: 'white',
              }}
            >
              {user.photoURL && (
                <Image
                  source={{
                    uri: user.photoURL,
                  }}
                  resizeMode="cover"
                  style={{
                    height: '100%',
                    width: '100%',
                    borderRadius: 1000,
                  }}
                />
              )}
            </View>

            <Text style={{ color: 'white', fontWeight: '700', fontSize: 16 }}>
              {user?.displayName ?? 'Unknown'}
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
              height: 45,
              alignItems: 'center',
              justifyContent: 'center',
            }}
            contentStyle={{
              alignItems: 'center',
              justifyContent: 'center',
              height: '100%',
              width: '100%',
              borderRadius: 10,
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
