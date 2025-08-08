import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { RootStackParamList } from '../types/route';
import BottomTabNavigation from './BottomTabNavigation';

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
    </Stack.Navigator>
  );
};

export default AppNavigation;
