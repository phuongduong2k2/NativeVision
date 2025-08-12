import { View, Text } from 'react-native';
import React from 'react';
import AppTextInput from '@src/components/AppTextInput';

const Header = () => {
  return (
    <View style={{ paddingHorizontal: 24 }}>
      <Text style={{ fontSize: 32, fontWeight: '600', color: 'white' }}>
        Welcome back!
      </Text>
      <Text style={{ color: '#A5A5A5', fontWeight: '500', marginTop: 8 }}>
        What do you feel like today?
      </Text>
      <AppTextInput
        placeholder="Search song, playlist, artist, ..."
        placeholderTextColor={'#A5A5A5'}
        leftIcon="search"
        containerStyle={{
          height: 48,
          marginTop: 24,
          backgroundColor: '#433E48',
          borderRadius: 10,
        }}
      />
    </View>
  );
};

export default Header;
