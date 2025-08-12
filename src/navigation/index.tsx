import { createNativeStackNavigator } from '@react-navigation/native-stack';

import BottomTabNavigation from './BottomTabNavigation';
import { RootStackParamList } from './type';

import UpdateProfileScreen from '@src/screens/profile/UpdateProfileScreen';
import useGoogle from '@src/hooks/useGoogle';
import AuthNavigation from './AuthNavigation';

const Stack = createNativeStackNavigator<RootStackParamList>();

const AppNavigation = () => {
  const { user } = useGoogle();
  return (
    <Stack.Navigator screenOptions={{ headerShown: false }}>
      {user ? (
        <>
          <Stack.Screen
            name="BottomTabNavigation"
            component={BottomTabNavigation}
          />
          <Stack.Screen name="UpdateProfile" component={UpdateProfileScreen} />
        </>
      ) : (
        <Stack.Screen name="Auth" component={AuthNavigation} />
      )}
    </Stack.Navigator>
  );
};

export default AppNavigation;
