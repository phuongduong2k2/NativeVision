import {
  View,
  Text,
  FlatList,
  ListRenderItem,
  TouchableOpacity,
  ViewStyle,
} from 'react-native';
import React from 'react';

type Data = {
  label: string;
};

const data: Data[] = [
  {
    label: 'Recent',
  },
  {
    label: 'Top 50',
  },
  {
    label: 'Chill',
  },
  {
    label: 'R&B',
  },
  {
    label: 'Festival',
  },
];

const ItemSeparatorComponent = () => <View style={{ width: 30 }} />;

type Props = {
  containerStyle?: ViewStyle;
};

const Categories = (props: Props) => {
  const { containerStyle } = props;
  const renderItem: ListRenderItem<Data> = ({ item }) => {
    return (
      <TouchableOpacity
        style={{
          height: 48,
          borderWidth: 1,
          borderColor: 'white',
          alignItems: 'center',
          justifyContent: 'center',
        }}
      >
        <Text style={{ color: 'white' }}>{item.label}</Text>
      </TouchableOpacity>
    );
  };

  return (
    <View style={containerStyle}>
      <FlatList
        horizontal
        data={data}
        renderItem={renderItem}
        contentContainerStyle={{ paddingHorizontal: 24 }}
        ItemSeparatorComponent={ItemSeparatorComponent}
      />
    </View>
  );
};

export default Categories;
