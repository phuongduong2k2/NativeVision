import {
  Text,
  TextInput,
  ScrollView,
  StyleSheet,
  TouchableOpacity,
  Alert,
} from 'react-native';
import React, { useState } from 'react';
import ScreenLayout from '@src/components/ScreenLayout';
import LinearButton from '@src/components/LinearButton';
import useGoogle from '@src/hooks/useGoogle';
import useAppNavigation from '@src/hooks/navigation';

const SignInScreen = () => {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const { signIn } = useGoogle();
  const navigation = useAppNavigation();
  const [mode, setMode] = useState<'signIn' | 'signUp'>('signIn');

  return (
    <ScreenLayout title="Sign In">
      <ScrollView
        contentContainerStyle={{
          flex: 1,
          paddingHorizontal: 16,
          paddingTop: 100,
        }}
      >
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
        <LinearButton
          colors={['#842ED8', '#DB28A9', '#9D1DCA']}
          containerStyle={{
            alignSelf: 'center',
            height: 40,
            width: 100,
            marginTop: 100,
          }}
          contentStyle={{
            height: '100%',
            borderRadius: 10,
            width: '100%',
            alignItems: 'center',
            justifyContent: 'center',
          }}
          onPress={() => {
            if (email && password) {
              signIn({ email, password, callback: navigation.goBack });
            } else {
              Alert.alert('Error', 'Please enter all fields');
            }
          }}
        >
          <Text style={{ color: 'white' }}>Sign In</Text>
        </LinearButton>
        <TouchableOpacity
          style={{ alignSelf: 'center', marginTop: 10 }}
          onPress={() => {
            setMode(mode === 'signIn' ? 'signUp' : 'signIn');
          }}
        >
          <Text style={{ color: 'white' }}>
            {mode === 'signIn' ? 'Create account now' : 'Sign in now'}
          </Text>
        </TouchableOpacity>
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
});

export default SignInScreen;
