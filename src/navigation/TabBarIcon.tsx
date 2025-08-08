import { Text, StyleSheet, TouchableOpacity } from 'react-native';
import React from 'react';
import SvgIcon from '@src/components/SvgIcon';
import { AppIconName } from '@src/assets/icons/icon';
import { BottomTabBarButtonProps } from '@react-navigation/bottom-tabs';

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
    <TouchableOpacity onPress={onPress} style={styles.container}>
      <SvgIcon name={focusable ? icon.active : icon.inactive} color="#F97A00" />
      <Text style={{ color: focusable ? '#F97A00' : 'black', fontSize: 12 }}>
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
