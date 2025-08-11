import { TouchableOpacity, ViewStyle } from 'react-native';
import React from 'react';
import LinearGradient from 'react-native-linear-gradient';

type Props = {
  colors: string[];
  children: React.ReactNode;
  containerStyle?: ViewStyle;
  onPress?: () => void;
  contentStyle?: ViewStyle;
};

const LinearButton = (props: Props) => {
  const { colors, children, containerStyle, onPress, contentStyle } = props;
  return (
    <TouchableOpacity onPress={onPress} style={containerStyle}>
      <LinearGradient
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 0 }}
        colors={colors}
        useAngle={true}
        angle={45}
        angleCenter={{ x: 0.5, y: 0.5 }}
        style={contentStyle}
      >
        {children}
      </LinearGradient>
    </TouchableOpacity>
  );
};

export default LinearButton;
