import {
  Text,
  TextInput,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  Alert,
  View,
  Image,
  Platform,
  UIManager,
  LayoutAnimation,
} from 'react-native';
import React, { useState } from 'react';
import ScreenLayout from '@src/components/ScreenLayout';
import LinearButton from '@src/components/LinearButton';
import useGoogle from '@src/hooks/useGoogle';
import AppImages from '@src/assets/images';

if (Platform.OS === 'android') {
  if (UIManager.setLayoutAnimationEnabledExperimental) {
    UIManager.setLayoutAnimationEnabledExperimental(true);
  }
}

const SignInScreen = () => {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const { signIn } = useGoogle();
  const [mode, setMode] = useState<'signIn' | 'signUp'>('signIn');

  return (
    <ScreenLayout wallpaper={AppImages.bestWallpaper} headerShown={false}>
      <ScrollView contentContainerStyle={styles.contentContainerStyle}>
        <View style={{ marginBottom: 20 }}>
          <Image
            source={AppImages.logo}
            style={{ height: 100, aspectRatio: 1, alignSelf: 'center' }}
          />
          <Text style={styles.appLabel}>Native Vision</Text>
        </View>
        <View>
          {mode === 'signUp' && (
            <TextInput
              value={name}
              onChangeText={setName}
              placeholder="Name"
              style={[styles.textInput, { marginBottom: 10 }]}
              placeholderTextColor={'grey'}
            />
          )}
          <TextInput
            value={email}
            onChangeText={setEmail}
            placeholder="Email"
            style={[styles.textInput, { marginBottom: 10 }]}
            placeholderTextColor={'grey'}
          />
          <TextInput
            value={password}
            onChangeText={setPassword}
            placeholder="Password"
            style={styles.textInput}
            placeholderTextColor={'grey'}
          />
          <TouchableOpacity
            activeOpacity={1}
            style={{ alignSelf: 'center', marginVertical: 20 }}
            onPress={() => {
              setMode(mode === 'signIn' ? 'signUp' : 'signIn');
              LayoutAnimation.configureNext(LayoutAnimation.Presets.spring);
            }}
          >
            <Text style={{ color: 'white' }}>
              {mode === 'signIn' ? 'Create account now' : 'Sign in now'}
            </Text>
          </TouchableOpacity>
          <LinearButton
            colors={['#842ED8', '#DB28A9', '#9D1DCA']}
            containerStyle={styles.buttonContainer}
            contentStyle={styles.buttonContent}
            onPress={() => {
              if (email && password && (mode === 'signUp' ? name : true)) {
                signIn({ email, password });
              } else {
                Alert.alert('Error', 'Please enter all fields');
              }
            }}
          >
            <Text style={{ color: 'white' }}>
              Sign {mode === 'signIn' ? 'In' : 'Up'}
            </Text>
          </LinearButton>
        </View>
      </ScrollView>
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
  contentContainerStyle: {
    flex: 1,
    paddingHorizontal: 16,
    paddingTop: 100,
  },
  appLabel: {
    color: 'white',
    fontSize: 20,
    fontWeight: '700',
    textAlign: 'center',
  },
  buttonContainer: {
    alignSelf: 'center',
    height: 40,
    width: 100,
  },
  buttonContent: {
    height: '100%',
    borderRadius: 10,
    width: '100%',
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export default SignInScreen;
