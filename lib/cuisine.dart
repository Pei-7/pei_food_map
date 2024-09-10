class Cuisine {
//型別
  final String englishName;
  final String chineseName;
  final String pronunciation;
  final String fileName;

//構造
  const Cuisine({
    required this.englishName,
    required this.chineseName,
    required this.pronunciation,
    required this.fileName,
  });

//創建
  static const Cuisine braisedPorkRice = Cuisine(
    englishName: 'Braised pork rice',
    chineseName: '魯肉飯',
    pronunciation: 'lǔ ròu fàn',
    fileName: 'braised_pork_rice',
  );

  static const Cuisine juteSoup = Cuisine(
    englishName: 'Jute soup',
    chineseName: '麻薏湯',
    pronunciation: 'má yì tang',
    fileName: 'jute_soup',
  );

  static const Cuisine dryNoodleWithSauce = Cuisine(
    englishName: 'Dry noodle with sauce',
    chineseName: '乾意麵',
    pronunciation: 'gan yì miàn',
    fileName: 'dry_noodle_with_sauce',
  );

  static const Cuisine drinks = Cuisine(
    englishName: 'Drinks',
    chineseName: '茶飲',
    pronunciation: 'chá yǐn',
    fileName: 'drinks',
  );

  static const Cuisine ice = Cuisine(
    englishName: 'Ice',
    chineseName: '冰品',
    pronunciation: 'bing pǐn',
    fileName: 'ice',
  );

  static const Cuisine vegetarian = Cuisine(
    englishName: 'Vegetarian',
    chineseName: '素食',
    pronunciation: 'sù shí',
    fileName: 'vegetarian',
  );

  static const Cuisine turnipCake = Cuisine(
    englishName: 'Turnip cake',
    chineseName: '菜頭粿',
    pronunciation: 'cài tóu guǒ',
    fileName: 'turnip_cake',
  );

  static const Cuisine buns = Cuisine(
    englishName: 'Buns',
    chineseName: '肉包',
    pronunciation: 'ròu bao',
    fileName: 'buns',
  );

  static const Cuisine taiwaneseMeatball = Cuisine(
    englishName: 'Taiwanese meatball',
    chineseName: '肉丸',
    pronunciation: 'ròu wán',
    fileName: 'taiwanese_meatball',
  );

  static const Cuisine dryRiceNoodle = Cuisine(
    englishName: 'Dry rice noodle',
    chineseName: '米苔目',
    pronunciation: 'mǐ tái mù',
    fileName: 'dry_rice_noodle',
  );

  static const Cuisine sushi = Cuisine(
    englishName: 'Sushi',
    chineseName: '壽司',
    pronunciation: 'shòu si',
    fileName: 'sushi',
  );

  static const Cuisine sashimi = Cuisine(
    englishName: 'Sashimi',
    chineseName: '生魚片',
    pronunciation: 'sheng yú piàn',
    fileName: 'sashimi',
  );

  static const Cuisine meatPuff = Cuisine(
    englishName: 'Meat puff',
    chineseName: '餡餅',
    pronunciation: 'xiàn bǐng',
    fileName: 'meat_puff',
  );

  static const Cuisine cookedSideDishes = Cuisine(
    englishName: 'Cooked side dishes',
    chineseName: '熟食小菜',
    pronunciation: 'shú shí xiǎo cài',
    fileName: 'cooked_side_dishes',
  );

  static const Cuisine wontonSoup = Cuisine(
    englishName: 'Wonton soup',
    chineseName: '餛飩湯',
    pronunciation: 'hún dùn tang',
    fileName: 'wonton_soup',
  );

  static const Cuisine stirFry = Cuisine(
    englishName: 'Stir-fry',
    chineseName: '現炒',
    pronunciation: 'xiàn chǎo',
    fileName: 'stir_fry',
  );
}
