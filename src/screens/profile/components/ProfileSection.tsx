import { View, Text, StyleSheet } from 'react-native';
import React from 'react';
import SvgIcon from '@src/components/SvgIcon';
import useGoogle from '@src/hooks/useGoogle';
import LinearButton from '@src/components/LinearButton';
import { RootStackParamList } from '@src/navigation/type';
import useAppNavigation from '@src/hooks/navigation';

const ProfileSection = () => {
  const { logout, user } = useGoogle();
  const navigation = useAppNavigation();

  const settings: {
    label: string;
    colors: string[];
    screen?: keyof RootStackParamList;
    isHidden?: boolean;
  }[] = [
    {
      label: 'Settings',
      colors: ['#842ED8', '#DB28A9', '#9D1DCA'],
    },
    {
      label: 'History',
      colors: ['#842ED8', '#DB28A9', '#9D1DCA'],
    },
    {
      label: 'Liked songs',
      colors: ['#842ED8', '#DB28A9', '#9D1DCA'],
      isHidden: !user,
    },
  ];

  return (
    <View style={styles.container}>
      {user && (
        <LinearButton
          colors={['#842ED8', '#DB28A9', '#9D1DCA']}
          onPress={() => {
            navigation.navigate('UpdateProfile', {
              name: user?.displayName ?? '',
              photoURL: user?.photoURL ?? '',
            });
          }}
          containerStyle={styles.containerButtonStyle}
          linearContainerStyle={{ borderRadius: 10 }}
          contentStyle={styles.contentButtonStyle}
        >
          <SvgIcon name="active-gear" color="white" />
          <Text style={styles.label}>Update Profile</Text>
        </LinearButton>
      )}
      {settings.map(
        item =>
          !item.isHidden && (
            <LinearButton
              key={item.label}
              colors={item.colors}
              onPress={() => {
                if (item.screen) {
                  navigation.navigate(item.screen as any);
                }
              }}
              containerStyle={styles.containerButtonStyle}
              linearContainerStyle={{ borderRadius: 10 }}
              contentStyle={styles.contentButtonStyle}
            >
              <SvgIcon name="active-gear" color="white" />
              <Text style={styles.label}>{item.label}</Text>
            </LinearButton>
          ),
      )}
      {user && (
        <LinearButton
          colors={['#EA2F14', '#E6521F', '#EA2F14']}
          onPress={logout}
          containerStyle={styles.containerButtonStyle}
          linearContainerStyle={{ borderRadius: 10 }}
          contentStyle={styles.contentButtonStyle}
        >
          <SvgIcon name="active-gear" color="white" />
          <Text style={styles.label}>Log out</Text>
        </LinearButton>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: { width: '100%', paddingHorizontal: 20, marginTop: 100 },
  contentButtonStyle: {
    flexDirection: 'row',
    flex: 1,
    alignItems: 'center',
    paddingHorizontal: 16,
  },
  containerButtonStyle: {
    height: 50,
    marginBottom: 10,
  },
  label: { marginLeft: 10, fontWeight: '700', color: 'white' },
});

export default ProfileSection;
