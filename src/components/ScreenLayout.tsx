import {
  ImageBackground,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
} from 'react-native';
import React from 'react';
import { SafeAreaView } from 'react-native-safe-area-context';
import AppImages from '@src/assets/images';
import SvgIcon from './SvgIcon';
import { AppIconName } from '@src/assets/icons/icon';
import useAppNavigation from '@src/hooks/navigation';

type Props = {
  children: React.ReactNode;
  wallpaper?: 'main' | 'list' | 'play';
  title?: string;
  leftButtonIcon?: AppIconName;
  rightButtonIcon?: AppIconName;
  onPressLeftButton?: () => void;
  onPressRightButton?: () => void;
  headerShown?: boolean;
};

const ScreenLayout = (props: Props) => {
  const {
    children,
    wallpaper,
    title = '',
    leftButtonIcon = 'chevron-left',
    onPressLeftButton,
    onPressRightButton,
    rightButtonIcon,
    headerShown = true,
  } = props;

  const navigation = useAppNavigation();

  let finalWallpaper = null;

  switch (wallpaper) {
    case 'main':
      finalWallpaper = AppImages.mainWallpaper;
      break;
    case 'list':
      finalWallpaper = AppImages.listWallpaper;
      break;
    case 'play':
      finalWallpaper = AppImages.playWallpaper;
      break;
    default:
      finalWallpaper = AppImages.mainWallpaper;
  }

  const goBack = () => {
    if (navigation.canGoBack()) {
      navigation.goBack();
    }
  };

  return (
    <ImageBackground
      source={finalWallpaper}
      style={{ flex: 1 }}
      resizeMode="cover"
    >
      <SafeAreaView style={{ flex: 1 }}>
        {headerShown && (
          <View style={styles.header}>
            <View style={styles.buttonContainer}>
              <TouchableOpacity
                style={styles.button}
                onPress={onPressLeftButton ?? goBack}
              >
                <SvgIcon name={leftButtonIcon} color="white" />
              </TouchableOpacity>
            </View>
            <Text
              style={{
                color: 'white',
                flex: 1,
                textAlign: 'center',
                fontSize: 16,
                fontWeight: '700',
              }}
            >
              {title}
            </Text>
            <View style={styles.buttonContainer}>
              {rightButtonIcon && (
                <TouchableOpacity style={styles.button}>
                  <SvgIcon name={rightButtonIcon} color="white" />
                </TouchableOpacity>
              )}
            </View>
          </View>
        )}
        {children}
      </SafeAreaView>
    </ImageBackground>
  );
};

const styles = StyleSheet.create({
  header: {
    height: 58,
    borderColor: 'white',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
  },
  buttonContainer: {
    height: '100%',
    aspectRatio: 1,
  },
  button: {
    height: '100%',
    width: '100%',
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export default ScreenLayout;
