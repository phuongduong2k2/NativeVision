import { TextInput, StyleSheet, Text, View } from 'react-native';
import React, { useState } from 'react';
import ScreenLayout from '@src/components/ScreenLayout';
import { RootStackParamList } from '@src/navigation/type';
import { NativeStackScreenProps } from '@react-navigation/native-stack';
import useGoogle from '@src/hooks/useGoogle';
import LinearButton from '@src/components/LinearButton';
import AppImages from '@src/assets/images';

type Props = NativeStackScreenProps<RootStackParamList, 'UpdateProfile'>;

const UpdateProfileScreen = (props: Props) => {
  const { navigation, route } = props;
  const { name, photoURL } = route.params;

  const [newName, setNewName] = useState(name);
  const [newPhotoURL, setNewPhotoURL] = useState(photoURL);

  const { updateInfo } = useGoogle();

  return (
    <ScreenLayout wallpaper={AppImages.playWallpaper} title="Update Profile">
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
          containerStyle={styles.buttonContainer}
          linearContainerStyle={{ borderRadius: 10 }}
          contentStyle={styles.buttonContent}
          onPress={() => {
            updateInfo({
              displayName: newName,
              photoURL: newPhotoURL,
              callback: navigation.goBack,
            });
          }}
        >
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
  label: { fontWeight: '700', color: 'white' },
  buttonContainer: {
    height: 48,
    width: 100,
    alignSelf: 'center',
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 5,
    },
    shadowOpacity: 0.34,
    shadowRadius: 6.27,
    marginTop: 20,
    elevation: 10,
  },
  buttonContent: {
    height: '100%',
    width: '100%',
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'center',
  },
});

export default UpdateProfileScreen;
