/* eslint-disable react/no-unstable-nested-components */
import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import ProfileScreen from '../screens/profile/ProfileScreen';
import NotificationScreen from '../screens/notification/NotificationScreen';
import QrCodeScreen from '../screens/qrcode/QrCodeScreen';
import SettingsScreen from '../screens/settings/SettingsScreen';
import HomeScreen from '../screens/home/HomeScreen';
import { AppIconName } from '@src/assets/icons/icon';
import QrCodeTabBar from './components/QrCodeTabBar';
import TabBarButton from './TabBarButton';

type RootTabParamList = {
  Home: undefined;
  Profile: undefined;
  Notification: undefined;
  QrCode: undefined;
  Settings: undefined;
};

type Tabs = {
  name: keyof RootTabParamList;
  icon: {
    active: AppIconName;
    inactive: AppIconName;
  };
  label: string;
  component: () => React.JSX.Element;
};

const tabs: Tabs[] = [
  {
    name: 'Home',
    icon: {
      active: 'active-home',
      inactive: 'inactive-home',
    },
    label: 'Home',
    component: HomeScreen,
  },
  {
    name: 'Settings',
    icon: {
      active: 'active-bookmark',
      inactive: 'inactive-bookmark',
    },
    label: 'Bookmark',
    component: SettingsScreen,
  },
  {
    name: 'QrCode',
    icon: {
      active: 'active-home',
      inactive: 'inactive-home',
    },
    label: 'QrCode',
    component: QrCodeScreen,
  },
  {
    name: 'Notification',
    icon: {
      active: 'active-bell',
      inactive: 'inactive-bell',
    },
    label: 'Notification',
    component: NotificationScreen,
  },
  {
    name: 'Profile',
    icon: {
      active: 'active-profile',
      inactive: 'inactive-profile',
    },
    label: 'Profile',
    component: ProfileScreen,
  },
];

const Tab = createBottomTabNavigator<RootTabParamList>();

const BottomTabNavigation = () => {
  return (
    <Tab.Navigator
      screenOptions={{
        headerShown: false,
        tabBarActiveTintColor: 'orange',
      }}
    >
      {tabs.map(({ component, name, label, icon }, index) => (
        <Tab.Screen
          name={name}
          component={component}
          options={({ navigation }) => ({
            tabBarStyle: { height: 90 },
            tabBarItemStyle: {
              alignItems: 'center',
              justifyContent: 'center',
            },
            tabBarButton: props =>
              index === 2 ? (
                <QrCodeTabBar />
              ) : (
                <TabBarButton
                  {...props}
                  focusable={index === navigation.getState().index}
                  icon={icon}
                  label={label}
                />
              ),
            tabBarShowLabel: false,
          })}
        />
      ))}
    </Tab.Navigator>
  );
};

export default BottomTabNavigation;
