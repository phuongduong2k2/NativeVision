import {
  createUserWithEmailAndPassword,
  getAuth,
  signInWithEmailAndPassword,
  signOut,
  updateProfile,
} from '@react-native-firebase/auth';
import useAuthStore from '@src/store';
import useGlobalStore from '@src/store/globalStore';

type TEmailAndPassword = {
  email: string;
  password: string;
};

const useGoogle = () => {
  const { user, setUser } = useAuthStore();
  const { setIsLoading } = useGlobalStore();

  const createAccount = async ({ email, password }: TEmailAndPassword) => {
    setIsLoading(true);
    try {
      const result = await createUserWithEmailAndPassword(
        getAuth(),
        email,
        password,
      );
      console.log(result);
    } catch (error) {
      console.log(error);
    }
    setIsLoading(false);
  };

  const logout = async () => {
    setIsLoading(true);
    try {
      await signOut(getAuth());
      console.log('User sign out');
    } catch (error) {
      console.log(error);
    }
    setIsLoading(false);
  };

  const signIn = async ({ email, password }: TEmailAndPassword) => {
    setIsLoading(true);
    try {
      await signInWithEmailAndPassword(getAuth(), email, password);
    } catch (error: any) {
      console.log('Invalid email or password');
    }
    setIsLoading(false);
  };

  const updateInfo = async ({
    displayName,
    photoURL,
    callback,
  }: {
    displayName: string;
    photoURL: string;
    callback?: () => void;
  }) => {
    setIsLoading(true);
    if (user) {
      try {
        await updateProfile(user, {
          displayName,
          photoURL,
        });
        setUser({
          ...user,
          displayName,
          photoURL,
        });
        callback?.();
      } catch (error: any) {
        console.log('Some thing wrong!');
      }
    }
    setIsLoading(false);
  };

  return {
    createAccount,
    logout,
    user,
    signIn,
    updateInfo,
  };
};

export default useGoogle;
