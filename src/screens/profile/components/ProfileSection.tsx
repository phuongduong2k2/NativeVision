import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';
import React from 'react';
import SvgIcon from '@src/components/SvgIcon';
import useGoogle from '@src/hooks/useGoogle';
import LinearButton from '@src/components/LinearButton';

const settings: { label: string; colors: string[] }[] = [
  {
    label: 'Account',
    colors: ['#842ED8', '#DB28A9', '#9D1DCA'],
  },
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
  },
  {
    label: 'Log out',
    colors: ['#EA2F14', '#E6521F', '#EA2F14'],
  },
];

const ProfileSection = () => {
  const { logout } = useGoogle();

  return (
    <View style={{ width: '100%', paddingHorizontal: 20 }}>
      {settings.map(item => (
        <LinearButton
          key={item.label}
          colors={item.colors}
          containerStyle={styles.linearContainer}
        >
          <TouchableOpacity style={styles.button} onPress={logout}>
            <SvgIcon name="active-gear" color="white" />
            <Text style={{ marginLeft: 10, fontWeight: '700', color: 'white' }}>
              {item.label}
            </Text>
          </TouchableOpacity>
        </LinearButton>
      ))}
    </View>
  );
};

const styles = StyleSheet.create({
  linearContainer: {
    height: 58,
    justifyContent: 'center',
    marginBottom: 10,
    borderRadius: 10,

    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 5,
    },
    shadowOpacity: 0.34,
    shadowRadius: 6.27,

    elevation: 10,
  },
  button: {
    flexDirection: 'row',
    alignItems: 'center',
    borderRadius: 10,
    paddingHorizontal: 10,
  },
});

export default ProfileSection;
