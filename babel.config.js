module.exports = {
  presets: ['module:@react-native/babel-preset'],
  plugins: [
    [
      'module-resolver',
      {
        root: ['./'],
        alias: {
          '@src': './src', // 👈 Alias here
          '@assets': './src/assets',
        },
      },
    ],
  ],
};
