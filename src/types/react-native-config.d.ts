declare module 'react-native-config' {
  export interface NativeConfig {
    ACCESS_TOKEN?: string;
  }

  export const Config: NativeConfig;
  export default Config;
}
