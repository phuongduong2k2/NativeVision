import { View, Text, Modal, ActivityIndicator } from 'react-native';
import React from 'react';
import useGlobalStore from '@src/store/globalStore';

const GlobalLoading = () => {
  const { isLoading } = useGlobalStore();
  return (
    <Modal visible={isLoading} animationType="fade" transparent={true}>
      <View
        style={{
          flex: 1,
          width: '100%',
          alignItems: 'center',
          backgroundColor: 'rgba(0,0,0,0.3)',
          justifyContent: 'center',
        }}
      >
        <View
          style={{
            height: 100,
            backgroundColor: 'white',
            aspectRatio: 1,
            justifyContent: 'center',
            alignItems: 'center',
            borderRadius: 20,
          }}
        >
          <ActivityIndicator size={'large'} color={'#842ED8'} />
          <Text style={{ fontSize: 16, fontWeight: '700' }}>Loading...</Text>
        </View>
      </View>
    </Modal>
  );
};

export default GlobalLoading;
