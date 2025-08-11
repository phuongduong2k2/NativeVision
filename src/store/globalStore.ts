import { create } from 'zustand';

interface GlobalState {
  isLoading: boolean;
  setIsLoading: (isLoading: boolean) => void;
}

const useGlobalStore = create<GlobalState>(set => ({
  isLoading: false,
  setIsLoading: isLoading => set({ isLoading }),
}));
export default useGlobalStore;
