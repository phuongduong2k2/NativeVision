/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import { SafeAreaProvider } from 'react-native-safe-area-context';
import AppNavigation from './src/navigation';
import { NavigationContainer } from '@react-navigation/native';
import { useCallback, useEffect } from 'react';
import { getAuth, onAuthStateChanged } from '@react-native-firebase/auth';
import useAuthStore from '@src/store';
import GlobalLoading from '@src/components/GlobalLoading';

function App() {
  const { setUser } = useAuthStore();

  const handleAuthStateChanged = useCallback(
    (user: any) => {
      setUser(user);
    },
    [setUser],
  );

  useEffect(() => {
    const subscriber = onAuthStateChanged(getAuth(), handleAuthStateChanged);

    return subscriber;
  }, [handleAuthStateChanged]);

  return (
    <SafeAreaProvider>
      <NavigationContainer>
        <GlobalLoading />
        <AppNavigation />
      </NavigationContainer>
    </SafeAreaProvider>
  );
}

export default App;
