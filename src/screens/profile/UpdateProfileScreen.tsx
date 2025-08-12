import { TextInput, StyleSheet, Text, View } from 'react-native';
import React, { useState } from 'react';
import ScreenLayout from '@src/components/ScreenLayout';
import { RootStackParamList } from '@src/navigation/type';
import { NativeStackScreenProps } from '@react-navigation/native-stack';
import useGoogle from '@src/hooks/useGoogle';
import LinearButton from '@src/components/LinearButton';
import SvgIcon from '@src/components/SvgIcon';

type Props = NativeStackScreenProps<RootStackParamList, 'UpdateProfile'>;

const UpdateProfileScreen = (props: Props) => {
  const { navigation, route } = props;
  const { name, photoURL } = route.params;

  const [newName, setNewName] = useState(name);
  const [newPhotoURL, setNewPhotoURL] = useState(photoURL);

  const { updateInfo } = useGoogle();

  return (
    <ScreenLayout title="Update Profile">
      <View style={{ paddingHorizontal: 16, flex: 1 }}>
        <TextInput
          value={newName}
          onChangeText={setNewName}
          placeholder="Name"
          style={[styles.textInput, { marginBottom: 10 }]}
          placeholderTextColor={'grey'}
        />
        <TextInput
          value={newPhotoURL}
          onChangeText={setNewPhotoURL}
          placeholder="Password"
          style={styles.textInput}
          placeholderTextColor={'grey'}
        />
        <LinearButton
          colors={['#842ED8', '#DB28A9', '#9D1DCA']}
          containerStyle={styles.linearContainer}
          onPress={() => {
            updateInfo({
              displayName: newName,
              photoURL: newPhotoURL,
              callback: navigation.goBack,
            });
          }}
          contentStyle={styles.contentStyle}
        >
          <SvgIcon name="active-gear" color="white" />
          <Text style={styles.label}>Update</Text>
        </LinearButton>
      </View>
    </ScreenLayout>
  );
};

const styles = StyleSheet.create({
  textInput: {
    paddingVertical: 15,
    borderWidth: 1,
    borderColor: 'white',
    backgroundColor: 'white',
    borderRadius: 10,
    paddingHorizontal: 10,
  },
  linearContainer: {
    height: 50,
    marginTop: 20,
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
  contentStyle: {
    flex: 1,
    borderRadius: 10,
    flexDirection: 'row',
    alignItems: 'center',
    width: '100%',
  },
  label: { marginLeft: 10, fontWeight: '700', color: 'white' },
});

export default UpdateProfileScreen;
