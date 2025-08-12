import { TouchableOpacity, View, ViewStyle } from 'react-native';
import React from 'react';
import LinearGradient from 'react-native-linear-gradient';

type Props = {
  colors: string[];
  children: React.ReactNode;
  containerStyle?: ViewStyle;
  onPress?: () => void;
  contentStyle?: ViewStyle;
  linearContainerStyle?: ViewStyle;
};

const LinearButton = (props: Props) => {
  const {
    colors,
    children,
    containerStyle,
    onPress,
    contentStyle,
    linearContainerStyle,
  } = props;
  return (
    <TouchableOpacity
      onPress={onPress}
      style={[{ height: 58 }, containerStyle]}
    >
      <LinearGradient
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 0 }}
        colors={colors}
        useAngle={true}
        angle={45}
        angleCenter={{ x: 0.5, y: 0.5 }}
        style={[{ height: '100%' }, linearContainerStyle]}
      >
        <View style={contentStyle}>{children}</View>
      </LinearGradient>
    </TouchableOpacity>
  );
};

export default LinearButton;
