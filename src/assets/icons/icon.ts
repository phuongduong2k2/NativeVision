import ActiveHomeIcon from './active_home.svg';
import InactiveHomeIcon from './inactive_home.svg';
import ActiveBellIcon from './active_bell.svg';
import InactiveBellIcon from './inactive_bell.svg';
import ActiveGearIcon from './active_gear.svg';
import InactiveGearIcon from './inactive_gear.svg';
import ActiveProfileIcon from './active_profile.svg';
import InactiveProfileIcon from './inactive_profile.svg';
import ScanIcon from './scan.svg';

const AppIcons = {
  'active-home': ActiveHomeIcon,
  'inactive-home': InactiveHomeIcon,
  'active-bell': ActiveBellIcon,
  'inactive-bell': InactiveBellIcon,
  'active-gear': ActiveGearIcon,
  'inactive-gear': InactiveGearIcon,
  'active-profile': ActiveProfileIcon,
  'inactive-profile': InactiveProfileIcon,
  scan: ScanIcon,
};

export default AppIcons;
export type AppIconName = keyof typeof AppIcons;
