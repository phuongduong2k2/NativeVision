import { View, TextInput, ViewStyle, TextInputProps } from 'react-native';
import React from 'react';
import { AppIconName } from '@src/assets/icons/icon';
import SvgIcon from './SvgIcon';

type Props = {
  containerStyle?: ViewStyle;
  leftIcon?: AppIconName;
  leftIconColor?: string;
} & TextInputProps;

const AppTextInput = (props: Props) => {
  const { containerStyle, leftIcon, leftIconColor } = props;
  return (
    <View
      style={[
        { flexDirection: 'row', alignItems: 'center', paddingHorizontal: 10 },
        containerStyle,
      ]}
    >
      {leftIcon && (
        <View
          style={{
            alignItems: 'center',
            justifyContent: 'center',
            borderColor: 'white',
            marginRight: 5,
          }}
        >
          <SvgIcon name={leftIcon} color={leftIconColor} />
        </View>
      )}
      <TextInput
        style={[{ flex: 1, height: '100%' }, props.style]}
        {...(props as TextInputProps)}
      />
    </View>
  );
};

export default AppTextInput;
