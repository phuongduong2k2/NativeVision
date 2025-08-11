import { createNativeStackNavigator } from '@react-navigation/native-stack';

import BottomTabNavigation from './BottomTabNavigation';
import { RootStackParamList } from './type';
import SignInScreen from '@src/screens/auth/signIn/SignInScreen';
import SignUpScreen from '@src/screens/auth/signUp/SignUpScreen';
import ForgotPasswordScreen from '@src/screens/auth/forgotPassword/ForgotPasswordScreen';

const Stack = createNativeStackNavigator<RootStackParamList>();

const AppNavigation = () => {
  return (
    <Stack.Navigator
      initialRouteName="BottomTabNavigation"
      screenOptions={{ headerShown: false }}
    >
      <Stack.Screen
        name="BottomTabNavigation"
        component={BottomTabNavigation}
      />
      <Stack.Screen name="SignIn" component={SignInScreen} />
      <Stack.Screen name="SignUp" component={SignUpScreen} />
      <Stack.Screen name="ForgotPassword" component={ForgotPasswordScreen} />
    </Stack.Navigator>
  );
};

export default AppNavigation;
