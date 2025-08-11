import { FirebaseAuthTypes } from '@react-native-firebase/auth';
import { create } from 'zustand';

interface BearState {
  user: FirebaseAuthTypes.User | null;
  setUser: (user: FirebaseAuthTypes.User) => void;
  clearUser: () => void;
}

const useAuthStore = create<BearState>(set => ({
  user: null,
  setUser: user => set({ user }),
  clearUser: () => set({ user: null }),
}));
export default useAuthStore;
