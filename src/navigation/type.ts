export type TabStackParamList = {
  Home: undefined;
  Profile: undefined;
  Notification: undefined;
  QrCode: undefined;
  Settings: undefined;
};

export type RootStackParamList = {
  BottomTabNavigation: undefined;
  UpdateProfile: {
    name: string;
    photoURL: string;
  };
  Auth: undefined;
};

export type AuthStackParamList = {
  SignIn: undefined;
  SignUp: undefined;
  ForgotPassword: undefined;
};
