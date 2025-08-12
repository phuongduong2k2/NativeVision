export type TabStackParamList = {
  Home: undefined;
  Profile: undefined;
  Notification: undefined;
  QrCode: undefined;
  Settings: undefined;
};

export type RootStackParamList = {
  BottomTabNavigation: undefined;
  SignIn: undefined;
  SignUp: undefined;
  ForgotPassword: undefined;
  UpdateProfile: {
    name: string;
    photoURL: string;
  };
};
