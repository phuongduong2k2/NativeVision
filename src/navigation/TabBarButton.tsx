import { Text, StyleSheet, TouchableOpacity } from 'react-native';
import React from 'react';
import SvgIcon from '@src/components/SvgIcon';
import { AppIconName } from '@src/assets/icons/icon';
import { BottomTabBarButtonProps } from '@react-navigation/bottom-tabs';
import AppColors from '@src/assets/colors';

type Props = {
  focused?: boolean;
  icon: {
    active: AppIconName;
    inactive: AppIconName;
  };
  label: string;
} & BottomTabBarButtonProps;

const TabBarButton = (props: Props) => {
  const { onPress, icon, label, focusable } = props;
  return (
    <TouchableOpacity
      activeOpacity={1}
      onPress={onPress}
      style={styles.container}
    >
      <SvgIcon
        name={focusable ? icon.active : icon.inactive}
        color={AppColors.primary}
      />
      <Text
        style={{ color: focusable ? AppColors.primary : 'black', fontSize: 12 }}
      >
        {label}
      </Text>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    width: '100%',
  },
});

export default TabBarButton;
