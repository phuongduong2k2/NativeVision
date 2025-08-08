import React from 'react';
import AppIcons, { AppIconName } from '@src/assets/icons/icon';

type Props = {
  name: AppIconName;
  color?: string;
};

const SvgIcon = (props: Props) => {
  const { name, color } = props;
  const SvgComponent = AppIcons[name];
  return <SvgComponent color={color} />;
};

export default SvgIcon;
