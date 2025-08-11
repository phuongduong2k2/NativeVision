import {
  createUserWithEmailAndPassword,
  getAuth,
  signInWithEmailAndPassword,
  signOut,
} from '@react-native-firebase/auth';
import useAuthStore from '@src/store';
import useGlobalStore from '@src/store/globalStore';

type TEmailAndPassword = {
  email: string;
  password: string;
};

const useGoogle = () => {
  const { user } = useAuthStore();
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

  const signIn = async ({
    email,
    password,
    callback,
  }: TEmailAndPassword & { callback?: () => void }) => {
    setIsLoading(true);
    try {
      await signInWithEmailAndPassword(getAuth(), email, password);
      callback?.();
    } catch (error: any) {
      console.log('Invalid email or password');
    }
    setIsLoading(false);
  };

  return {
    createAccount,
    logout,
    user,
    signIn,
  };
};

export default useGoogle;
